# Unified Project Architecture Proposal

**Proposal Version:** 1.0
**Date:** 2025-11-28
**Status:** Draft
**Supersedes:** REARCH_PROPOSAL.md (implemented)
**Reference:** Proposed Architectural Change.md (source requirements)

---

## Executive Summary

This proposal defines a new unified project architecture that consolidates the framework, books, and configuration under a single PROJECT_ROOT container. This architecture replaces the current separated FW_ROOT/BOOKS_ROOT implementation.

**Key Benefits:**
- **Unified container:** Single PROJECT_ROOT simplifies mental model
- **Multi-book support:** Manage multiple books from one installation
- **Clean separation:** FW_ROOT (gitignored), BOOKS_ROOT, CONFIG_ROOT as siblings
- **Simplified git:** Single repository at PROJECT_ROOT level
- **Dual-platform:** Full support for Claude Code CLI and Claude Desktop
- **Automated updates:** Framework updates via automated git fetch

**Architecture at a Glance:**
```
PROJECT_ROOT/
├── .git/                    # Single repo for user content
├── .gitignore               # Ignores FW_ROOT/
├── start-authoring.bat/.sh  # Normal startup (with permission prompts)
├── bp-start-authoring.bat/.sh # Bypass permissions startup
├── FW_ROOT/                 # Framework (cloned from -dist, gitignored)
├── BOOKS_ROOT/              # All book projects + Archive/
└── .config/                 # CONFIG_ROOT - all configuration
```

---

## Architecture Overview

### Directory Structure

```
PROJECT_ROOT/
├── .git/                              # Git repository (versions BOOKS_ROOT + .config/)
├── .gitignore                         # Ignores FW_ROOT/
├── start-authoring.bat                # Windows: Normal startup
├── start-authoring.sh                 # macOS/Linux: Normal startup
├── bp-start-authoring.bat             # Windows: Bypass permissions mode
├── bp-start-authoring.sh              # macOS/Linux: Bypass permissions mode
│
├── FW_ROOT/                           # Framework installation (gitignored)
│   ├── Process/                       # Framework files (read-only)
│   │   ├── FRAMEWORK_CORE.md
│   │   ├── Prompts/
│   │   ├── Styles/
│   │   ├── Templates/
│   │   ├── _COMMON/
│   │   └── migrations/
│   ├── scripts/                       # Framework scripts
│   ├── configure.bat                  # Windows: Initial setup bootstrap
│   ├── configure.sh                   # macOS/Linux: Initial setup bootstrap
│   ├── configure.md                   # Setup instructions for Claude
│   ├── .git/                          # Framework repo (from -dist)
│   └── VERSION                        # Framework version file
│
├── BOOKS_ROOT/                        # All user books
│   ├── Book-Title-One/                # Active book
│   │   ├── Manuscript/
│   │   ├── Research/
│   │   ├── .config/
│   │   └── PROJECT_CONTEXT.md
│   ├── Book-Title-Two/                # Another active book
│   │   └── ...
│   └── Archive/                       # Archived books (completed or paused)
│       ├── Old-Book/
│       └── README.md
│
└── .config/                           # CONFIG_ROOT
    ├── fw-location.json               # FW_ROOT path + metadata
    ├── books-registry.json            # Registry of all books
    ├── settings.json                  # User preferences + BOOKS_ROOT path
    ├── CLAUDE.md                      # Instructions for Claude
    └── .claude/
        ├── agents/
        │   └── book-writing-assistant.md
        └── commands/
            ├── fw-init.md
            ├── manage-book.md
            └── switch-book.md
```

### Key Design Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Container model | PROJECT_ROOT parent | Single mental model, simplified setup |
| Git location | PROJECT_ROOT level | Versions all user content together |
| FW_ROOT handling | Gitignored | Framework reinstallable, keeps repo clean |
| CONFIG_ROOT location | .config/ at PROJECT_ROOT | Siblings with FW_ROOT and BOOKS_ROOT |
| Book switching | Slash command + session prompt | Flexibility for different workflows |
| Claude Desktop | System instructions | No MCP server required |
| Framework updates | Automated fetch | Check once per session via /fw-init |
| Bypass mode | bp- prefix scripts | Skip permission prompts for experienced users |
| Archive purpose | Completed + paused books | Flexible archive usage |
| Migration | None | New installations only |

---

## Detailed Design

### 1. Startup Scripts

Scripts are located at PROJECT_ROOT level and manage Claude Code CLI startup.

#### 1.1 Normal Startup (start-authoring)

**Windows (start-authoring.bat):**
```batch
@echo off
cd /d "[PROJECT_ROOT]\.config"
claude --append-system-prompt "IMPORTANT: Run /fw-init immediately before doing anything else." "Start"
```

**macOS/Linux (start-authoring.sh):**
```bash
#!/bin/bash
cd "[PROJECT_ROOT]/.config"
claude --append-system-prompt "IMPORTANT: Run /fw-init immediately before doing anything else." "Start"
```

**Behavior:**
1. Changes directory to CONFIG_ROOT (.config/)
2. Launches Claude Code CLI with system prompt injection
3. System prompt instructs Claude to run /fw-init immediately
4. /fw-init checks for framework updates (once per session)
5. /fw-init activates book-writing-assistant agent
6. /fw-init prompts for book selection
7. User sees permission prompts for file operations

#### 1.2 Bypass Permissions Startup (bp-start-authoring)

**Windows (bp-start-authoring.bat):**
```batch
@echo off
cd /d "[PROJECT_ROOT]\.config"
claude --permission-mode "bypassPermissions" --append-system-prompt "IMPORTANT: Run /fw-init immediately before doing anything else." "Start"
```

**macOS/Linux (bp-start-authoring.sh):**
```bash
#!/bin/bash
cd "[PROJECT_ROOT]/.config"
claude --permission-mode "bypassPermissions" --append-system-prompt "IMPORTANT: Run /fw-init immediately before doing anything else." "Start"
```

**Behavior:**
- Same as normal startup, but with `--permission-mode "bypassPermissions"`
- Skips permission prompts for file read/write operations
- /fw-init still runs (same system prompt)
- For experienced users who trust the framework operations

#### 1.3 Initial Setup (configure.bat/sh)

Located in FW_ROOT (included in dist repo). Used for first-time setup.

**Key Features:**
- Verifies Claude Code CLI is installed
- Validates VERSION file exists (confirms FW_ROOT)
- Uses temp file to track PROJECT_ROOT path for auto-chain
- Automatically launches start-authoring after setup completes

**Windows (configure.bat):**
```batch
@echo off
setlocal EnableDelayedExpansion

echo AI-Assisted Nonfiction Authoring Framework - Configuration
set "FW_ROOT=%~dp0"
set "FW_ROOT=%FW_ROOT:~0,-1%"

REM Check Claude Code CLI
where claude >nul 2>&1 || (echo ERROR: Claude Code CLI not found. && pause && exit /b 1)

REM Check VERSION file
if not exist "%FW_ROOT%\VERSION" (echo ERROR: VERSION file not found. && pause && exit /b 1)

REM Temp file for PROJECT_ROOT path
set "TEMP_FILE=%TEMP%\fw_project_root.txt"
if exist "%TEMP_FILE%" del "%TEMP_FILE%"

cd /d "%FW_ROOT%"
claude --append-system-prompt "IMPORTANT: Execute configure.md immediately. After setup, write PROJECT_ROOT path to %TEMP_FILE% before /exit." "Run configure.md"

REM Chain to start-authoring if PROJECT_ROOT was created
if exist "%TEMP_FILE%" (
    set /p PROJECT_ROOT=<"%TEMP_FILE%"
    del "%TEMP_FILE%"
    if exist "!PROJECT_ROOT!\start-authoring.bat" call "!PROJECT_ROOT!\start-authoring.bat"
)
endlocal
```

**macOS/Linux (configure.sh):**
```bash
#!/bin/bash
FW_ROOT="$(cd "$(dirname "$0")" && pwd)"

# Check Claude Code CLI
command -v claude &> /dev/null || { echo "ERROR: Claude Code CLI not found."; exit 1; }

# Check VERSION file
[ -f "$FW_ROOT/VERSION" ] || { echo "ERROR: VERSION file not found."; exit 1; }

TEMP_FILE="/tmp/fw_project_root.txt"
rm -f "$TEMP_FILE"

cd "$FW_ROOT"
claude --append-system-prompt "IMPORTANT: Execute configure.md immediately. After setup, write PROJECT_ROOT path to $TEMP_FILE before /exit." "Run configure.md"

# Chain to start-authoring if PROJECT_ROOT was created
if [ -f "$TEMP_FILE" ]; then
    PROJECT_ROOT=$(cat "$TEMP_FILE")
    rm -f "$TEMP_FILE"
    [ -f "$PROJECT_ROOT/start-authoring.sh" ] && exec "$PROJECT_ROOT/start-authoring.sh"
fi
```

**Initial Setup Workflow:**
1. User clones framework to any location
2. User runs `configure.bat` or `configure.sh` from cloned FW_ROOT
3. Claude starts and runs configure.md
4. configure.md asks for PROJECT_ROOT location
5. configure.md creates PROJECT_ROOT structure:
   - BOOKS_ROOT/ directory with Archive/
   - .config/ with all JSON files, CLAUDE.md, and .claude/ commands/agents
   - .git repository (with FW_ROOT in .gitignore)
   - start-authoring and bp-start-authoring scripts
   - FW_ROOT/ (cloned or copied from setup location)
6. configure.md writes PROJECT_ROOT path to temp file
7. User types `/exit`
8. Script reads temp file and chains to `start-authoring.bat/sh`

**After Setup - Creating First Book:**
1. start-authoring launches Claude in .config/
2. Claude runs /fw-init automatically
3. /fw-init shows "No books registered" and offers to create one
4. User runs Prompt 1 to initialize first book
5. Book created in BOOKS_ROOT/

**Note:** Original clone location can be deleted after setup - framework now exists in PROJECT_ROOT/FW_ROOT/

---

### 2. Configuration Files (CONFIG_ROOT)

#### 2.1 fw-location.json

Stores framework location and update metadata.

```json
{
  "frameworkRoot": "[PROJECT_ROOT]/FW_ROOT",
  "frameworkVersion": "0.15.4",
  "lastUpdateCheck": "2025-11-28",
  "updateChannel": "stable"
}
```

| Field | Description |
|-------|-------------|
| frameworkRoot | Absolute path to FW_ROOT |
| frameworkVersion | Installed framework version |
| lastUpdateCheck | Date of last update check |
| updateChannel | Update channel (stable, beta) |

#### 2.2 books-registry.json

Registry of all book projects (schema unchanged from current implementation).

```json
{
  "version": "1.0",
  "activeBook": "my-first-book",
  "books": [
    {
      "id": "my-first-book",
      "title": "My First Book",
      "author": "Author Name",
      "directory": "My-First-Book",
      "created": "2025-11-28",
      "lastAccessed": "2025-11-28",
      "status": "in-progress"
    },
    {
      "id": "archived-book",
      "title": "Archived Book",
      "author": "Author Name",
      "directory": "Archive/Archived-Book",
      "created": "2025-10-01",
      "lastAccessed": "2025-11-15",
      "status": "archived"
    }
  ]
}
```

**Status Values:**
- `planning` - Initial planning phase
- `in-progress` - Actively writing
- `revision` - In revision/editing
- `complete` - Finished
- `archived` - Moved to Archive/

#### 2.3 settings.json

User preferences and global settings.

```json
{
  "booksRoot": "[PROJECT_ROOT]/BOOKS_ROOT",
  "github": {
    "enabled": false,
    "repository": null,
    "autoPush": false
  },
  "backup": {
    "zipLocation": null,
    "autoBackup": false
  },
  "preferences": {
    "defaultStyle": "Conversational Expert",
    "confirmDate": true
  }
}
```

| Field | Description |
|-------|-------------|
| booksRoot | Absolute path to BOOKS_ROOT |
| github.enabled | Whether GitHub backup is configured |
| github.repository | GitHub repo URL if enabled |
| github.autoPush | Auto-push commits to GitHub |
| backup.zipLocation | Directory for ZIP backups |
| backup.autoBackup | Enable automatic backups |
| preferences.defaultStyle | Default writing style for new books |
| preferences.confirmDate | Require date confirmation at session start |

#### 2.4 CLAUDE.md (CONFIG_ROOT)

Instructions loaded when Claude Code CLI starts in .config/ directory.

```markdown
# AI-Assisted Nonfiction Authoring Framework

## MANDATORY FIRST ACTION

Run `/fw-init` at the start of every session.

This loads:
- Framework from fw-location.json path
- Book registry for book selection
- Selected book's PROJECT_CONTEXT.md

## Book Commands

- `/fw-init` - Initialize session (REQUIRED)
- `/switch-book` - Switch to different book
- `/manage-book` - Archive, delete, restore books

## Framework Location

Framework files are in: [path from fw-location.json]
Books are in: [path from settings.json booksRoot]
```

---

### 3. Framework Installation (FW_ROOT)

#### 3.1 Initial Installation

```bash
cd [PROJECT_ROOT]
git clone https://github.com/scooter-indie/author-nonfiction-dist.git FW_ROOT
```

#### 3.2 Framework Updates

Checked automatically by /fw-init once per session:

1. Read current version from `FW_ROOT/VERSION`
2. Fetch latest from remote: `git fetch origin`
3. Compare with `origin/main:VERSION`
4. If update available, notify user
5. User approves → `git pull origin main`
6. Update `fw-location.json` with new version

#### 3.3 Gitignore Configuration

**PROJECT_ROOT/.gitignore:**
```
# Framework (reinstallable from -dist)
FW_ROOT/
```

---

### 4. Book Selection and Switching

#### 4.1 Session Start (via /fw-init)

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Book Selection
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Active books:
  1. My First Book - in-progress (last: 2025-11-28) * CURRENT
  2. Second Book - planning (last: 2025-11-25)

Archived books: 1

Which book? (number, name, or "new")
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

#### 4.2 Mid-Session Switch (/switch-book)

User can switch books during a session:
- `/switch-book [book-name]`
- `/switch-book` (show selection menu)

Updates `activeBook` in registry and loads new PROJECT_CONTEXT.md.

---

### 5. Claude Desktop Integration

#### 5.1 System Instructions

Claude Desktop uses system instructions (not MCP server) to work with this architecture.

**System Instructions Template:**
```markdown
# AI-Assisted Nonfiction Authoring Framework

You are assisting with nonfiction book authoring.

## MANDATORY FIRST ACTION

At the start of EVERY conversation:

1. Read: [PROJECT_ROOT]/.config/fw-location.json
2. Read: [FW_ROOT]/Process/FRAMEWORK_CORE.md
3. Read: [PROJECT_ROOT]/.config/books-registry.json
4. Read: [PROJECT_ROOT]/.config/settings.json
5. Check for framework updates
6. Ask user which book to work on
7. Read selected book's PROJECT_CONTEXT.md
8. Confirm today's date

## Update Check

Compare [FW_ROOT]/VERSION with latest at:
https://github.com/scooter-indie/author-nonfiction-dist

If update available, inform user.

## Book Selection

Ask: "Which book would you like to work on?"
- [List from registry]
- "Create new book"

## Anti-Hallucination Protocol

ALWAYS loaded from FRAMEWORK_CORE.md - never skip.
```

#### 5.2 MCP Filesystem Configuration

**Required allowed directories:**
```
[PROJECT_ROOT]    # Access to .config/, BOOKS_ROOT/, FW_ROOT/
```

---

### 6. Book Management (/manage-book)

Retains all capabilities from current implementation:

| Operation | Description |
|-----------|-------------|
| archive | Move book to Archive/ directory |
| restore | Restore archived book to active |
| delete | Permanently delete book (with confirmation) |
| list | Show all books with status |

---

### 7. Book-Writing-Assistant Agent

#### 7.1 Agent Activation

The book-writing-assistant agent is activated by /fw-init (not auto-loaded at session start).

**Activation sequence:**
1. User runs start-authoring script
2. Claude loads .config/CLAUDE.md
3. CLAUDE.md instructs to run /fw-init
4. /fw-init activates book-writing-assistant agent
5. Agent provides writing assistance for selected book

#### 7.2 Agent Location

```
.config/.claude/agents/book-writing-assistant.md
```

---

## Assertion Validation

This section validates the 6 assertions from the original requirements document.

### Assertion 1: Scripts CD to CONFIG_ROOT and Start Claude Code

> The bat/sh scripts will CD to PROJECT_ROOT/CONFIG_ROOT/ and start Claude Code CLI in the .config directory. Claude Code will load CLAUDE.md and will have access to /fw-init.

**VALIDATED:**
- `start-authoring.bat/.sh` changes directory to `PROJECT_ROOT/.config/`
- Claude Code CLI loads `.config/CLAUDE.md` automatically
- CLAUDE.md instructs to run `/fw-init`
- `/fw-init` slash command is available in `.config/.claude/commands/`

### Assertion 2: Claude Knows FW_ROOT from fw-location.json

> Claude Code will know the location of FW_ROOT from fw-location.json

**VALIDATED:**
- `fw-location.json` contains `frameworkRoot` field with absolute path
- `/fw-init` reads this file first to locate framework
- All prompts resolve framework paths from this configuration

### Assertion 3: Claude Knows BOOKS_ROOT from settings.json

> Claude Code will know location of BOOKS_ROOT from books-registry.json

**CLARIFICATION:** BOOKS_ROOT path is stored in `settings.json`, not `books-registry.json`.

**VALIDATED:**
- `settings.json` contains `booksRoot` field with absolute path
- `books-registry.json` contains book entries with relative paths under BOOKS_ROOT
- This separation allows registry to be portable

### Assertion 4: Git at PROJECT_ROOT Versions Non-Ignored Content

> Having a new .git repo in the PROJECT_ROOT will allow everything not in .gitignore to be versioned.

**VALIDATED:**
- `.git/` is at PROJECT_ROOT level
- `.gitignore` excludes `FW_ROOT/`
- Git versions: BOOKS_ROOT/, .config/, scripts
- Framework is excluded (reinstallable from -dist)

### Assertion 5: BOOKS_ROOT Contains Only Book-Related Content

> The BOOKS_ROOT directory will contain only Book related files and directories and the Archive directory of Book related files and directories.

**VALIDATED:**
- BOOKS_ROOT contains:
  - Active book directories (Book-Title-One/, Book-Title-Two/, etc.)
  - Archive/ directory for archived books
  - No configuration files (moved to .config/)
  - No framework files (in FW_ROOT/)

### Assertion 6: Claude Desktop Awareness

> Claude Desktop must be made aware of this directory structure via system-instructions and/or other required configuration.

**VALIDATED:**
- System instructions template provided (Section 5.1)
- Instructions include path resolution steps
- MCP filesystem must allow PROJECT_ROOT access
- No custom MCP server required

---

## Implementation Phases

### Phase 1: Core Structure Setup

**Objective:** Create the new PROJECT_ROOT structure and configuration files.

| Task | Description |
|------|-------------|
| 1.1 | Define PROJECT_ROOT directory structure |
| 1.2 | Create fw-location.json template with metadata fields |
| 1.3 | Update settings.json template to include booksRoot |
| 1.4 | Create .config/CLAUDE.md template |
| 1.5 | Update .gitignore to exclude FW_ROOT/ |
| 1.6 | Create start-authoring scripts (bat/sh) |
| 1.7 | Create bp-start-authoring scripts (bat/sh) |

### Phase 2: Configuration System

**Objective:** Implement configuration file handling.

| Task | Description |
|------|-------------|
| 2.1 | Modify /fw-init to read from .config/ at PROJECT_ROOT level |
| 2.2 | Implement fw-location.json reading for FW_ROOT path |
| 2.3 | Implement settings.json reading for BOOKS_ROOT path |
| 2.4 | Add update metadata tracking (lastUpdateCheck, updateChannel) |
| 2.5 | Update path resolution in all prompts |

### Phase 3: Book Management Updates

**Objective:** Update book commands for new structure.

| Task | Description |
|------|-------------|
| 3.1 | Update /switch-book for new path resolution |
| 3.2 | Update /manage-book for new structure |
| 3.3 | Update book-writing-assistant agent activation |
| 3.4 | Test archive/restore with new paths |

### Phase 4: Framework Update System

**Objective:** Implement automated framework updates.

| Task | Description |
|------|-------------|
| 4.1 | Implement update check in /fw-init |
| 4.2 | Add once-per-session update check logic |
| 4.3 | Implement git fetch/pull for updates |
| 4.4 | Update fw-location.json after successful update |
| 4.5 | Test bypass mode (bp- scripts) |

### Phase 5: Claude Desktop Support

**Objective:** Create Claude Desktop integration.

| Task | Description |
|------|-------------|
| 5.1 | Create Claude Desktop system instructions template |
| 5.2 | Document MCP filesystem configuration |
| 5.3 | Test book selection from Desktop |
| 5.4 | Test update notification in Desktop |

### Phase 6: Installation and Setup

**Objective:** Create installation workflow.

| Task | Description |
|------|-------------|
| 6.1 | Update configure.md for new architecture |
| 6.2 | Add PROJECT_ROOT creation workflow |
| 6.3 | Add FW_ROOT cloning step |
| 6.4 | Add BOOKS_ROOT initialization |
| 6.5 | Add .config/ setup with all JSON files |
| 6.6 | Generate startup scripts |

### Phase 7: Documentation and Release

**Objective:** Update documentation and release process.

| Task | Description |
|------|-------------|
| 7.1 | Update PREPARE_RELEASE.md for new structure |
| 7.2 | Update README for new installation steps |
| 7.3 | Update Claude Desktop setup guide |
| 7.4 | Archive REARCH_PROPOSAL.md (superseded) |
| 7.5 | Update deploy-dist.yml if needed |

---

## File Changes Summary

### New Files in Dev Repo (Process/Templates/)

| Template File | Destination | Purpose |
|---------------|-------------|---------|
| configure.bat | FW_ROOT/ (dist root) | Windows initial setup bootstrap |
| configure.sh | FW_ROOT/ (dist root) | macOS/Linux initial setup bootstrap |
| start-authoring.bat | FW_ROOT/ (template) → PROJECT_ROOT/ | Windows normal startup |
| start-authoring.sh | FW_ROOT/ (template) → PROJECT_ROOT/ | macOS/Linux normal startup |
| bp-start-authoring.bat | FW_ROOT/ (template) → PROJECT_ROOT/ | Windows bypass permissions startup |
| bp-start-authoring.sh | FW_ROOT/ (template) → PROJECT_ROOT/ | macOS/Linux bypass permissions startup |
| CONFIG_ROOT_CLAUDE_template.md | .config/CLAUDE.md | Claude instructions for CONFIG_ROOT |
| PROJECT_ROOT_gitignore_template | PROJECT_ROOT/.gitignore | Excludes FW_ROOT/ |
| .claude/commands/fw-init.md | .config/.claude/commands/ | Framework init command |
| .claude/commands/switch-book.md | .config/.claude/commands/ | Book switching command |
| .claude/commands/manage-book.md | .config/.claude/commands/ | Book lifecycle management |
| .claude/agents/book-writing-assistant.md | .config/.claude/agents/ | Writing assistant agent |

### Generated at Runtime (by configure.md)

| File | Location | Content |
|------|----------|---------|
| fw-location.json | .config/ | FW_ROOT path, version, update channel |
| settings.json | .config/ | BOOKS_ROOT path, preferences |
| books-registry.json | .config/ | Book list, active book |
| start-authoring.bat/sh | PROJECT_ROOT/ | Generated from template |
| bp-start-authoring.bat/sh | PROJECT_ROOT/ | Generated from template |
| .gitignore | PROJECT_ROOT/ | Excludes FW_ROOT/ |

### Modified Files

| File | Changes |
|------|---------|
| fw-location.json template | Add updateChannel field |
| settings.json template | Add required booksRoot field |
| configure.md | New unified PROJECT_ROOT installation workflow |
| .claude/commands/fw-init.md | Updated for CONFIG_ROOT detection, BOOKS_ROOT from settings.json |
| .claude/commands/switch-book.md | Updated for CONFIG_ROOT prerequisites |
| .claude/commands/manage-book.md | Updated git operations for PROJECT_ROOT |
| .claude/agents/book-writing-assistant.md | Added path resolution documentation |
| Claude_Desktop_System_Instructions.md | Rewritten for PROJECT_ROOT architecture |
| Prompt_Essentials.md | Updated path resolution for v0.16.0 |
| Prompt_1_Initialize.md | Updated session context verification |
| Prompt_17_Backup_Export.md | Updated for PROJECT_ROOT backup |

### Deprecated

| File | Reason |
|------|--------|
| BOOKS_ROOT/.config/ | Moved to PROJECT_ROOT/.config/ |
| BOOKS_ROOT/CLAUDE.md | Moved to .config/CLAUDE.md |
| FW_ROOT/.config/settings.json | No longer needed (CONFIG_ROOT handles all config) |

---

## Appendix A: Complete Installation Workflow

### Step 1: Clone Framework

Clone the framework to any location:

```bash
git clone https://github.com/scooter-indie/author-nonfiction-dist.git ~/Downloads/author-nonfiction
```

### Step 2: Run Setup Script

**Windows:**
```batch
cd %USERPROFILE%\Downloads\author-nonfiction
configure.bat
```

**macOS/Linux:**
```bash
cd ~/Downloads/author-nonfiction
./configure.sh
```

The configure script:
1. Verifies Claude Code CLI is installed
2. Checks VERSION file exists (confirms valid FW_ROOT)
3. Launches Claude Code with configure.md

### Step 3: Follow configure.md Prompts

Claude runs configure.md which:
1. **Confirms date** - Verifies system date is correct
2. **Checks git** - Ensures git is installed
3. **Asks for PROJECT_ROOT** - Where to create the writing environment
4. **Creates PROJECT_ROOT structure:**
   - `BOOKS_ROOT/` directory with Archive/
   - `.config/` (CONFIG_ROOT) with all JSON files
   - `.config/CLAUDE.md` and `.config/.claude/` commands/agents
5. **Installs framework:**
   - Option 1: Copy from current location
   - Option 2: Fresh clone from GitHub (recommended)
6. **Creates .gitignore** - Excludes FW_ROOT/
7. **Generates startup scripts** - start-authoring.bat/.sh at PROJECT_ROOT
8. **Initializes git** - Optional git repository at PROJECT_ROOT
9. **Configures remote** - Optional GitHub/GitLab connection
10. **Creates initial commit** - Records setup completion
11. **Reports completion** - Shows PROJECT_ROOT path

### Step 4: Exit and Auto-Chain

When Claude reports completion:
1. Type `/exit` to close the session
2. configure.bat/sh detects PROJECT_ROOT was created
3. Automatically launches `start-authoring.bat/.sh`

**If auto-chain fails:**
Navigate to PROJECT_ROOT and run start-authoring manually:
```bash
# Windows
E:\My-Writing\start-authoring.bat

# macOS/Linux
~/My-Writing/start-authoring.sh
```

### Step 5: Initial Session

start-authoring launches Claude Code in .config/:
1. /fw-init runs (prompted by system message)
2. Framework version displayed
3. "No books registered" - prompts to create first book

### Step 6: Create First Book

1. Say "Create new book" or "Execute Prompt 1"
2. Follow Prompt 1 workflow to set up book structure
3. Book created in BOOKS_ROOT/
4. Ready to write!

### Optional: Delete Clone Location

After setup completes, the original clone location (e.g., `~/Downloads/author-nonfiction`) can be deleted. The framework now exists at `PROJECT_ROOT/FW_ROOT/`.

---

## Appendix B: Path Resolution Reference

### From CONFIG_ROOT (.config/)

```
FW_ROOT      = fw-location.json → frameworkRoot
BOOKS_ROOT   = settings.json → booksRoot
ACTIVE_BOOK  = books-registry.json → activeBook
BOOK_PATH    = BOOKS_ROOT / books[activeBook].directory
```

### Framework File Access

```
[FW_ROOT]/Process/FRAMEWORK_CORE.md
[FW_ROOT]/Process/Prompts/Prompt_X.md
[FW_ROOT]/Process/Styles/[style].md
[FW_ROOT]/Process/Templates/[template].md
```

### Book File Access

```
[BOOK_PATH]/Manuscript/
[BOOK_PATH]/Research/
[BOOK_PATH]/.config/
[BOOK_PATH]/PROJECT_CONTEXT.md
```

---

*End of Proposal*
