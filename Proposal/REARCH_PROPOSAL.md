# Re-Architecture Proposal: Separated Framework and Books

**Proposal Version:** 1.0
**Date:** 2025-11-27
**Status:** Draft

---

## Executive Summary

This proposal defines a new deployment architecture where the AI-Assisted Nonfiction Authoring Framework is installed separately from user book projects. This separation enables:

- Single framework installation serving multiple books
- Simplified framework updates without touching book content
- Multi-book management from both Claude Desktop and Claude Code CLI
- Optional GitHub backup or local ZIP backup for users

---

## Architecture Overview

### Directory Structure

```
[User-Configured Location]
├── FW_ROOT/                              # Framework installation
│   ├── Process/                          # Framework files (read-only)
│   │   ├── FRAMEWORK_CORE.md
│   │   ├── Prompts/
│   │   ├── Styles/
│   │   └── Templates/
│   ├── .git/                             # Framework repo (from dist)
│   ├── VERSION                           # Current framework version
│   └── CLAUDE.md                         # Framework-level instructions

[User-Configured Location]
├── BOOKS_ROOT/                           # All user books
│   ├── .config/                          # Global configuration
│   │   ├── books-registry.json           # Registry of all books
│   │   ├── settings.json                 # User preferences
│   │   └── fw-location.json              # Path to FW_ROOT
│   ├── Book-Title-One/                   # First book project
│   │   ├── Manuscript/
│   │   ├── Research/
│   │   ├── .config/                      # Book-specific config
│   │   └── PROJECT_CONTEXT.md
│   ├── Book-Title-Two/                   # Second book project
│   │   ├── Manuscript/
│   │   ├── Research/
│   │   ├── .config/
│   │   └── PROJECT_CONTEXT.md
│   ├── .git/                             # Single repo for all books
│   ├── .gitignore
│   └── CLAUDE.md                         # Books-level instructions
```

### Key Design Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Git Strategy | Subdirectories | Easiest for novices - folders are universal |
| MCP Configuration | Two directory entries | Explicit access, minimal exposure |
| Book Independence | Fully isolated | Each book self-contained |
| FW_ROOT Location | User-configurable | Flexibility for different setups |
| Claude Desktop Projects | Single project with book selection | Simpler than multiple projects |
| Backup (no GitHub) | ZIP of BOOKS_ROOT | Framework reinstallable from dist |

---

## Detailed Design

### 1. Framework Installation (FW_ROOT)

**Source:** `https://github.com/scooter-indie/author-nonfiction-dist`

**Installation Process:**
```bash
# User chooses location, then:
git clone https://github.com/scooter-indie/author-nonfiction-dist.git [FW_ROOT]
```

**Contents:**
- `Process/` - All framework files (prompts, styles, templates)
- `VERSION` - Semantic version file for update checking
- `CLAUDE.md` - Minimal instructions pointing to FRAMEWORK_CORE.md

**Characteristics:**
- Read-only for normal operations
- Updated via `git pull` from dist repo
- No user-specific configuration stored here

---

### 2. Books Root (BOOKS_ROOT)

**Purpose:** Container for all user book projects and global configuration.

#### 2.1 Global Configuration (`BOOKS_ROOT/.config/`)

**books-registry.json:**
```json
{
  "version": "1.0",
  "activeBook": "Book-Title-One",
  "books": [
    {
      "id": "book-title-one",
      "title": "Book Title One",
      "author": "Author Name",
      "directory": "Book-Title-One",
      "created": "2025-11-27",
      "lastAccessed": "2025-11-27",
      "status": "in-progress"
    },
    {
      "id": "book-title-two",
      "title": "Book Title Two",
      "author": "Author Name",
      "directory": "Book-Title-Two",
      "created": "2025-11-20",
      "lastAccessed": "2025-11-25",
      "status": "in-progress"
    }
  ]
}
```

**fw-location.json:**
```json
{
  "frameworkRoot": "E:\\author-nonfiction-framework",
  "frameworkVersion": "0.14.5",
  "lastUpdateCheck": "2025-11-27"
}
```

**settings.json:**
```json
{
  "github": {
    "enabled": true,
    "repository": "username/my-books",
    "autoPush": false
  },
  "backup": {
    "zipLocation": "E:\\Backups",
    "autoBackup": false
  },
  "preferences": {
    "defaultStyle": "Conversational Expert",
    "confirmDate": true
  }
}
```

#### 2.2 Book Project Structure

Each book under BOOKS_ROOT follows the existing structure:

```
Book-Title-One/
├── Manuscript/
│   ├── Chapters/
│   ├── FrontMatter/
│   ├── BackMatter/
│   ├── Style/
│   ├── Quotes/
│   ├── Inbox/
│   ├── Drafts/
│   └── Exports/
├── Research/
├── .config/
│   ├── init.json
│   ├── project.json
│   ├── metadata.json
│   └── manifest.json
├── PROJECT_CONTEXT.md
└── README.md
```

**Note:** No `Process/` directory in book projects - framework files read from FW_ROOT.

---

### 3. Claude Desktop Integration

#### 3.1 MCP Filesystem Configuration

**Allowed Directories:**
```
[FW_ROOT path]        # e.g., E:\author-nonfiction-framework
[BOOKS_ROOT path]     # e.g., E:\My-Books
```

#### 3.2 System Instructions (Minimal, Version-Independent)

The Claude Desktop Project system instructions should be minimal and force Claude to read framework documents:

```markdown
# AI-Assisted Nonfiction Authoring Framework

You are assisting with nonfiction book authoring.

## MANDATORY FIRST ACTION

At the start of EVERY conversation:

1. Read the framework location from: [BOOKS_ROOT]/.config/fw-location.json
2. Read: [FW_ROOT]/Process/FRAMEWORK_CORE.md
3. Read the book registry: [BOOKS_ROOT]/.config/books-registry.json
4. Check for framework updates (see Update Check section)
5. Ask user which book to work on (show list from registry)
6. Read the selected book's PROJECT_CONTEXT.md
7. Confirm today's date with the user

## Update Check

Compare [FW_ROOT]/VERSION with latest at:
https://github.com/scooter-indie/author-nonfiction-dist

If update available, inform user:
"Framework update available: [current] → [latest]
To update, run this in Claude Code CLI:
```
cd [FW_ROOT] && git pull
```"

## Book Selection

Ask: "Which book would you like to work on?"
- [List books from registry]
- "Create new book"

After selection, set activeBook in registry and load PROJECT_CONTEXT.md.

## Anti-Hallucination Protocol

ALWAYS loaded from FRAMEWORK_CORE.md - never skip.
```

#### 3.3 Book Selection Workflow

1. User opens Claude Desktop project
2. Claude reads registry, shows book list
3. User selects book (or creates new)
4. Claude updates `activeBook` in registry
5. Claude loads that book's PROJECT_CONTEXT.md
6. Session continues with selected book context

**Switching Books Mid-Session:**
User says: "Switch to [Book Name]"
Claude: Updates registry, loads new PROJECT_CONTEXT.md, confirms switch

---

### 4. Claude Code CLI Integration

#### 4.1 Startup Script (OS-Specific)

**Windows (start-authoring.bat):**
```batch
@echo off
cd /d [BOOKS_ROOT]
claude
```

**macOS/Linux (start-authoring.sh):**
```bash
#!/bin/bash
cd [BOOKS_ROOT]
claude
```

#### 4.2 CLAUDE.md in BOOKS_ROOT

```markdown
# AI-Assisted Nonfiction Authoring Framework

## MANDATORY FIRST ACTION

Run `/fw-init` at the start of every session.

This loads:
- Framework from: [path from .config/fw-location.json]
- Book registry from: .config/books-registry.json
- Selected book's PROJECT_CONTEXT.md

## Book Selection

After initialization, select a book:
- "work on [Book Name]"
- "list books"
- "create new book"
```

#### 4.3 Modified /fw-init Command

The `/fw-init` slash command needs modification to:

1. Read `BOOKS_ROOT/.config/fw-location.json` to find FW_ROOT
2. Read `FW_ROOT/Process/FRAMEWORK_CORE.md`
3. Check for framework updates
4. Read `BOOKS_ROOT/.config/books-registry.json`
5. Prompt user to select a book
6. Read selected book's PROJECT_CONTEXT.md
7. Confirm date

---

### 5. Framework Update System

#### 5.1 Version Checking

**FW_ROOT/VERSION file:**
```
0.14.5
```

**Check Process:**
1. Read local `FW_ROOT/VERSION`
2. Fetch `https://raw.githubusercontent.com/scooter-indie/author-nonfiction-dist/main/VERSION`
3. Compare versions
4. If update available, notify user

#### 5.2 Update Execution

**Claude Desktop:** Provide copy-paste command for Claude Code CLI
```
cd [FW_ROOT] && git pull
```

**Claude Code CLI:** Can execute directly via Prompt 12 or direct command

#### 5.3 Post-Update Migrations

If framework update requires configuration changes:

1. `FW_ROOT/migrations/` contains migration scripts
2. Each migration named: `migrate-X.Y.Z-to-A.B.C.md`
3. After `git pull`, check if migrations needed
4. Execute migrations against BOOKS_ROOT config files
5. Update `fw-location.json` with new version

---

### 6. New Book Creation (Modified Prompt 1)

#### 6.1 Changes to Prompt 1

Current Prompt 1 creates the entire structure including Process/.

**Modified behavior:**
1. Ask for book title, author, style (same as current)
2. Create book directory under BOOKS_ROOT (not Process/)
3. Create Manuscript/, Research/, .config/ structure
4. Create PROJECT_CONTEXT.md
5. Update `BOOKS_ROOT/.config/books-registry.json`
6. Set new book as `activeBook`
7. Initialize git (if not already initialized in BOOKS_ROOT)

#### 6.2 Book Directory Naming

Convert title to directory name:
- "My Amazing Book" → `My-Amazing-Book/`
- Spaces to hyphens
- Remove special characters
- Check for conflicts with existing directories

---

### 7. Backup System

#### 7.1 GitHub Backup (Opt-In)

**Setup:**
1. User provides GitHub repository URL
2. Store in `BOOKS_ROOT/.config/settings.json`
3. Configure remote: `git remote add origin [url]`

**Operations:**
- Push: `git push origin main`
- Pull: `git pull origin main`
- All books in single repo

**Tagging Convention:**
```
[book-id]-v1.0.0    # e.g., my-amazing-book-v1.0.0
```

#### 7.2 ZIP Backup (Opt-Out of GitHub)

**New Prompt: Prompt_XX_Backup.md**

**Functionality:**
1. Read ZIP destination from settings or ask user
2. Create ZIP of entire BOOKS_ROOT (excluding .git/)
3. Name: `books-backup-YYYY-MM-DD.zip`
4. Place in user-specified directory

**Contents:**
- All book directories
- `.config/` with registry and settings
- `CLAUDE.md`

**Recovery:**
1. Unzip to desired BOOKS_ROOT location
2. Clone framework to FW_ROOT
3. Update `fw-location.json` with new FW_ROOT path
4. Ready to use

---

### 8. Prompt Modifications Required

| Prompt | Modification |
|--------|--------------|
| Prompt 1 | Don't create Process/, update books-registry.json |
| Prompt 2 | Read styles from FW_ROOT, not local Process/ |
| Prompt 3 | Path resolution for framework files |
| Prompt 7 | Compile from selected book only |
| Prompt 9 | Export from selected book only |
| Prompt 10 | Dashboard for selected book |
| Prompt 12 | Git ops on BOOKS_ROOT repo |
| /fw-init | Multi-book initialization, book selection |
| NEW | Backup prompt for ZIP creation |
| NEW | Book management (list, switch, delete) |

---

### 9. File Path Resolution

#### 9.1 Framework Files (Read from FW_ROOT)

All prompts must resolve framework paths:
```
[FW_ROOT]/Process/FRAMEWORK_CORE.md
[FW_ROOT]/Process/Prompts/Prompt_X.md
[FW_ROOT]/Process/Styles/[style].md
[FW_ROOT]/Process/Templates/[template].md
```

#### 9.2 Book Files (Read/Write in BOOKS_ROOT)

Book content paths:
```
[BOOKS_ROOT]/[active-book]/Manuscript/...
[BOOKS_ROOT]/[active-book]/Research/...
[BOOKS_ROOT]/[active-book]/.config/...
[BOOKS_ROOT]/[active-book]/PROJECT_CONTEXT.md
```

#### 9.3 Path Resolution Helper

Each prompt should start with:
```
1. Read BOOKS_ROOT/.config/fw-location.json → get FW_ROOT
2. Read BOOKS_ROOT/.config/books-registry.json → get activeBook
3. Set BOOK_PATH = BOOKS_ROOT/[activeBook directory]
4. All framework reads: FW_ROOT/...
5. All book reads/writes: BOOK_PATH/...
```

---

### 10. Release Process Modifications (PREPARE_RELEASE.md)

The re-architecture requires updates to the maintainer release process.

#### 10.1 New VERSION File Management

**Add to Step 2 (Critical Files):**
```markdown
17. `VERSION` (root level) ← NEW for re-architecture
    - Single line containing version number (e.g., `0.15.0`)
    - No trailing newline
    - Used by update checking mechanism (Section 5.1)
```

**Verification step:** Ensure VERSION file is created/updated during release.

#### 10.2 Modified CLAUDE.md Handling

The FW_ROOT CLAUDE.md changes from "full framework context" to "minimal instructions":

```markdown
3. `CLAUDE.md` ← MODIFIED for re-architecture
   - Now minimal instructions for FW_ROOT
   - Points to BOOKS_ROOT for book selection
   - References FRAMEWORK_CORE.md (not inline content)
   - Template: Process/Templates/FW_ROOT_CLAUDE_template.md
```

#### 10.3 Dist Repo Clarification Section

**Add new section to PREPARE_RELEASE.md:**

```markdown
### Dist Repo vs Main Repo (v0.15.0+)

**What goes in author-nonfiction-dist (user releases):**
- `Process/` - All framework files (prompts, styles, templates)
- `VERSION` - Semantic version for update checking
- `CLAUDE.md` - Minimal FW_ROOT instructions
- `LICENSE` - MIT license

**What stays in author-nonfiction (maintainer only):**
- `Documentation/` - Maintainer documentation
- `Proposal/` - Development proposals
- `scripts/` - Build/release scripts
- `.github/` - CI/CD workflows
- `.claude/` - Maintainer slash commands
- `PREPARE_RELEASE.md` - This file
- `CHANGELOG.md` - Release history
```

#### 10.4 Updated Manifest Structure

**Update Step 4.6 to include new templates:**

New files to track in `framework_files_manifest.json`:
- `VERSION` (root)
- `Process/Templates/FW_ROOT_CLAUDE_template.md`
- `Process/Templates/BOOKS_ROOT_CLAUDE_template.md`
- `Process/Templates/.config/books-registry_template.json`
- `Process/Templates/.config/fw-location_template.json`
- `Process/Templates/.config/settings_template.json`
- `Process/Templates/Archive_README_template.md`

#### 10.5 Release Asset Verification

**Update Step 8 checklist:**

```markdown
### Step 8: Verify Release Assets (v0.15.0+)

Check that the release includes:
- ✅ `VERSION` file at root (contains version string only)
- ✅ Minimal `CLAUDE.md` (points to BOOKS_ROOT)
- ✅ All BOOKS_ROOT templates in Process/Templates/
- ✅ No Documentation/, Proposal/, or .github/ directories
- ✅ No scripts/ directory (maintainer-only)
- ✅ No .claude/ directory (maintainer-only)
```

#### 10.6 GitHub Actions Workflow Updates

**Modify `.github/workflows/release.yml`:**

1. Add VERSION file to build output
2. Ensure new templates are included
3. Verify CLAUDE.md is the minimal FW_ROOT version (not full version)
4. Add validation step to confirm dist structure

---

### 11. Configure.md Modifications Required

The existing `configure.md` handles single-book (legacy) setup. For multi-book mode, it needs significant updates.

#### 11.1 Mode Detection

**At startup, configure.md must detect:**

1. **Fresh Install** - No FW_ROOT or BOOKS_ROOT exists
2. **FW_ROOT Only** - Framework installed, need to create BOOKS_ROOT
3. **Complete Setup** - Both FW_ROOT and BOOKS_ROOT exist (reconfiguration)

```
Step 0: Installation Mode Detection

Checking installation type...

[ ] FW_ROOT exists at configured location?
[ ] BOOKS_ROOT/.config/fw-location.json exists?
[ ] BOOKS_ROOT/.config/books-registry.json exists?

Result: [Fresh Install | FW_ROOT Only | Complete Setup]
```

#### 11.2 Fresh Install Workflow

**Steps for brand new users:**

1. **Ask for FW_ROOT location**
   ```
   Where would you like to install the framework?
   Example: E:\author-nonfiction-framework
   ```

2. **Clone framework from dist**
   ```bash
   git clone https://github.com/scooter-indie/author-nonfiction-dist.git [FW_ROOT]
   ```

3. **Ask for BOOKS_ROOT location**
   ```
   Where would you like to store your books?
   Example: E:\My-Books
   ```

4. **Create BOOKS_ROOT structure**
   ```bash
   mkdir [BOOKS_ROOT]
   mkdir [BOOKS_ROOT]/.config
   cd [BOOKS_ROOT] && git init
   ```

5. **Create configuration files** (see Section 11.3)

6. **Copy CLAUDE.md template**
   ```bash
   cp [FW_ROOT]/Process/Templates/BOOKS_ROOT_CLAUDE_template.md [BOOKS_ROOT]/CLAUDE.md
   ```

7. **Generate startup scripts** (see Section 11.4)

8. **Initial git commit**
   ```bash
   cd [BOOKS_ROOT] && git add . && git commit -m "Initialize books repository"
   ```

#### 11.3 Configuration Files Creation

**Create `[BOOKS_ROOT]/.config/fw-location.json`:**
```json
{
  "frameworkRoot": "[FW_ROOT path]",
  "frameworkVersion": "[version from FW_ROOT/VERSION]",
  "lastUpdateCheck": "[CONFIRMED_DATE]"
}
```

**Create `[BOOKS_ROOT]/.config/books-registry.json`:**
```json
{
  "version": "1.0",
  "activeBook": null,
  "books": []
}
```

**Create `[BOOKS_ROOT]/.config/settings.json`:**
```json
{
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

#### 11.4 Startup Scripts Generation

**Ask user:**
```
Would you like to generate startup scripts for Claude Code CLI?
- "yes" - Generate scripts for your OS
- "no" - Skip (you can create them manually later)
```

**Windows (`start-authoring.bat`):**
```batch
@echo off
cd /d [BOOKS_ROOT]
claude
```
Location: User's choice (Desktop, BOOKS_ROOT, or custom)

**macOS/Linux (`start-authoring.sh`):**
```bash
#!/bin/bash
cd [BOOKS_ROOT]
claude
```
Then: `chmod +x start-authoring.sh`

#### 11.5 FW_ROOT Only Workflow

**For users who already have FW_ROOT but need BOOKS_ROOT:**

1. **Verify FW_ROOT location**
   - Check VERSION file exists
   - Read current framework version

2. **Ask for BOOKS_ROOT location** (Step 3 from Fresh Install)

3. **Create BOOKS_ROOT structure** (Steps 4-8 from Fresh Install)

4. **Skip framework clone** (already exists)

#### 11.6 Reconfiguration Workflow

**For users with existing setup needing changes:**

Options:
- Update FW_ROOT location (if moved)
- Update BOOKS_ROOT settings
- Regenerate startup scripts
- Reconfigure GitHub remote

#### 11.7 Environment-Specific Handling

**Claude Desktop:**
- Provide copy blocks for all CLI commands
- Guide user through MCP filesystem configuration
- Cannot auto-generate startup scripts (provide as copyable text)

**Claude Code CLI:**
- Execute commands directly
- Can write startup scripts to filesystem
- Full automation possible

#### 11.8 Updated configure.md Structure

```markdown
# Framework Configuration (v0.15.0+)

## Step 0: Confirm Date
## Step 0.5: Check Required Tools (git, jq)
## Step 1: Installation Mode Detection (NEW)
## Step 2: FW_ROOT Setup (NEW - or verify existing)
## Step 3: BOOKS_ROOT Setup (NEW)
## Step 4: Configuration Files Creation (NEW)
## Step 5: CLAUDE.md Setup (NEW)
## Step 6: Git Repository Setup (updated for BOOKS_ROOT)
## Step 7: Remote Repository Setup (optional)
## Step 8: Startup Scripts Generation (NEW)
## Step 9: Export Tool Discovery (optional)
## Step 10: Verify Installation
## Step 11: Configuration Complete
```

---

## Implementation Phases

### Phase 1: Core Architecture (#90) ✓
- [x] Create new directory structure (VERSION file, templates)
- [x] Modify CLAUDE.md for BOOKS_ROOT (BOOKS_ROOT_CLAUDE_template.md)
- [x] Create books-registry.json schema (books-registry_template.json)
- [x] Create fw-location.json schema (fw-location_template.json)
- [x] Modify /fw-init for multi-book support (supports both modes)
- [x] Create Archive/ directory structure (Archive_README_template.md)

### Phase 2: Prompt Modifications (#91) ✓
- [x] Update Prompt 1 (no Process/, registry update)
- [x] Update all prompts for path resolution (Prompt_Essentials.md)
- [x] Create book selection mechanism (in /fw-init from Phase 1)
- [x] Create book switching command (/switch-book)
- [x] Update lock mechanism for new paths (Prompt_Essentials.md)

### Phase 3: Update System (#92) ✓
- [x] Create VERSION file in dist repo (created in Phase 1)
- [x] Implement update checking (in /fw-init for both modes)
- [x] Create migration framework (Process/migrations/)
- [x] Test update workflow (documented in migration README)

### Phase 4: Backup System (#93) ✓
- [x] Create full BOOKS_ROOT ZIP backup prompt (Prompt 17 Option 1)
- [x] Create single-book standalone ZIP export (Prompt 17 Option 2)
- [x] Implement GitHub integration (Prompt 17 Option 3)
- [x] Test backup/restore workflow (documented in prompt)

### Phase 5: Book Management (#94) ✓
- [x] Create book archive functionality (/manage-book archive)
- [x] Create book delete functionality with confirmation (/manage-book delete)
- [x] Update registry for archived status tracking (status: "archived")
- [x] Create book restore from archive (/manage-book restore)

### Phase 6: Claude Desktop (#95) ✓
- [x] Create minimal system instructions (Claude_Desktop_System_Instructions.md)
- [x] Test MCP configuration (documented in Claude_Desktop_Setup.md)
- [x] Document setup process (Claude_Desktop_Setup.md)

### Phase 7: Release Process Updates (#96) ✓
- [x] Update PREPARE_RELEASE.md with Section 10 requirements
- [x] Add VERSION file to release workflow (release.yml)
- [x] Update release.yml for new dist structure
- [x] Update deploy-dist.yml for new files (VERSION, validation)
- [x] Update framework_files_manifest.json structure
- [x] Create FW_ROOT CLAUDE.md template (FW_ROOT_CLAUDE_template.md)

### Phase 8: Configure.md Updates (#97)
- [ ] Add BOOKS_ROOT initialization workflow
- [ ] Create .config/ directory with all required JSON files
- [ ] Copy CLAUDE.md from template to BOOKS_ROOT
- [ ] Generate startup scripts (OS-specific)
- [ ] Update existing FW_ROOT configuration for multi-book mode
- [ ] Add mode detection (fresh install vs adding to existing FW_ROOT)

---

## Requirements Traceability

| Req # | Requirement | Addressed In |
|-------|-------------|--------------|
| 1 | User uses Claude Desktop and CLI | Section 3, 4 |
| 2 | Claude Desktop uses Filesystem MCP | Section 3.1 |
| 3 | Books have common parent (BOOKS_ROOT) | Section 2 |
| 4 | Git repo in BOOKS_ROOT | Section 2 |
| 5 | Book registry for Claude Desktop | Section 2.1, 3.3 |
| 6 | Book registry for Claude Code CLI | Section 2.1, 4.3 |
| 7 | PROJECT_CONTEXT per book | Section 2.2 |
| 8 | Re-init after compaction | Section 4.2 |
| 9 | Single GitHub repo for all books | Section 7.1 |
| 10 | ZIP backup for opt-out users | Section 7.2 |
| 11 | Minimal system instructions | Section 3.2 |
| 12 | MCP access to FW_ROOT | Section 3.1 |
| 13 | Claude Code CLI start location | Section 4.1 |
| 14 | Change Projects for different book | N/A - Single project design |
| 15 | Switch books in CLI | Section 4.3 |
| 16 | Deploy from dist repo | Section 1 |
| 17 | Update check in Desktop | Section 3.2, 5.1 |
| 18 | Update check in CLI | Section 4.3, 5.1 |
| 19 | Update mechanism | Section 5 |
| 20 | Automated BOOKS_ROOT setup via configure.md | Section 11 |

**Note on Requirement 14:** The decision was made to use a single Claude Desktop Project with book selection instead of separate Projects per book, for simplicity.

---

## Resolved Questions

### 1. Dist Repo Structure (RESOLVED)

**Question:** Should author-nonfiction-dist mirror current structure or be reorganized?

**Answer:** No major reorganization required. Minor additions only.

**Current structure is suitable:**
```
author-nonfiction-dist/
├── Process/
│   ├── FRAMEWORK_CORE.md      ✓ exists
│   ├── Prompts/               ✓ exists
│   ├── Styles/                ✓ exists
│   ├── Templates/             ✓ exists
│   ├── DISCLAIMER.md          ✓ exists
│   └── Anti-Hallucination_Guidelines.md  ✓ exists
├── CLAUDE.md                  ⚠ needs modification
└── LICENSE                    ✓ exists
```

**Additions needed:**
| Item | Purpose |
|------|---------|
| `VERSION` | New file - contains semantic version (e.g., `0.15.0`) for update checking |
| `CLAUDE.md` | Modify - minimal instructions for FW_ROOT that point to BOOKS_ROOT for book selection |

**Not included in dist (maintainer-only in main repo):**
- `Documentation/` - maintainer documentation
- `Proposal/` - development proposals
- `scripts/` - build/release scripts
- `.github/` - CI/CD workflows
- `.claude/` - maintainer slash commands

---

### 2. Book Deletion (RESOLVED)

**Question:** How should book deletion work? Soft delete (archive) or hard delete?

**Answer:** User is given the option:
- **Archive:** Move book to `BOOKS_ROOT/Archive/[Book-Name]/`
- **Delete:** Permanently remove book directory

```
BOOKS_ROOT/
├── .config/
├── Active-Book-One/
├── Active-Book-Two/
└── Archive/                    # Archived books
    └── Old-Book-Name/
```

The `books-registry.json` should track archived books separately with `status: "archived"`.

---

### 3. Book Export (RESOLVED)

**Question:** Should there be a way to export a single book to a standalone structure?

**Answer:** Yes. Support standalone ZIP export for individual books.

**Use case:** User wants to share one book with a collaborator without exposing other books.

**Export creates:**
```
Book-Title-standalone-YYYY-MM-DD.zip
├── Book-Title/
│   ├── Manuscript/
│   ├── Research/
│   ├── .config/
│   └── PROJECT_CONTEXT.md
└── README.md                   # Instructions for recipient
```

This is separate from the full BOOKS_ROOT backup - it's a single-book portable package.

---

### 4. Concurrent Editing (RESOLVED)

**Question:** Any considerations for editing same book from Desktop and CLI simultaneously?

**Answer:** Existing lock mechanism already handles this. Update lock paths to be aware of new structure:

- Lock file location: `BOOKS_ROOT/[Book-Name]/.config/.lock`
- Lock contains: session ID, timestamp, client type (Desktop/CLI)
- Same behavior as current implementation, just updated paths

---

### 5. Offline Mode (RESOLVED)

**Question:** How should update checking behave when offline?

**Answer:** Not a concern. If the user has no internet connection, Claude Desktop and Claude Code CLI cannot function at all. Update checking is moot without connectivity.

**Implementation:** If update check fails (network error), silently skip and continue. No special offline handling needed.

---

## Appendix A: Example User Journey

### New User Setup

1. User clones framework:
   ```
   git clone https://github.com/scooter-indie/author-nonfiction-dist.git E:\author-nonfiction-framework
   ```

2. User creates BOOKS_ROOT:
   ```
   mkdir E:\My-Books
   ```

3. User runs initial setup (new prompt or script):
   - Creates `.config/` in BOOKS_ROOT
   - Creates `fw-location.json` pointing to FW_ROOT
   - Creates empty `books-registry.json`
   - Creates `CLAUDE.md`
   - Initializes git repo

4. User configures Claude Desktop:
   - Adds FW_ROOT to MCP allowed directories
   - Adds BOOKS_ROOT to MCP allowed directories
   - Creates Project with minimal system instructions

5. User opens Claude Desktop:
   - Claude reads framework, shows "No books yet"
   - User says "Create new book"
   - Prompt 1 runs, creates first book

### Daily Writing Session

1. User opens Claude Desktop (or starts Claude Code CLI)
2. Claude: "Which book? 1) Book One 2) Book Two"
3. User selects book
4. Claude loads PROJECT_CONTEXT.md
5. User works on book using standard prompts

### Switching Books

1. User: "Switch to Book Two"
2. Claude updates registry, loads new context
3. User continues with different book

---

## Appendix B: Configuration File Schemas

### books-registry.json Schema

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "required": ["version", "books"],
  "properties": {
    "version": { "type": "string" },
    "activeBook": { "type": "string" },
    "books": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["id", "title", "directory", "created"],
        "properties": {
          "id": { "type": "string" },
          "title": { "type": "string" },
          "author": { "type": "string" },
          "directory": { "type": "string" },
          "created": { "type": "string", "format": "date" },
          "lastAccessed": { "type": "string", "format": "date" },
          "status": { "enum": ["planning", "in-progress", "revision", "complete"] }
        }
      }
    }
  }
}
```

### fw-location.json Schema

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "required": ["frameworkRoot"],
  "properties": {
    "frameworkRoot": { "type": "string" },
    "frameworkVersion": { "type": "string" },
    "lastUpdateCheck": { "type": "string", "format": "date" }
  }
}
```

---

*End of Proposal*
