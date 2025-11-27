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

## Implementation Phases

### Phase 1: Core Architecture
- [ ] Create new directory structure
- [ ] Modify CLAUDE.md for BOOKS_ROOT
- [ ] Create books-registry.json schema
- [ ] Create fw-location.json schema
- [ ] Modify /fw-init for multi-book support

### Phase 2: Prompt Modifications
- [ ] Update Prompt 1 (no Process/, registry update)
- [ ] Update all prompts for path resolution
- [ ] Create book selection mechanism
- [ ] Create book switching command

### Phase 3: Update System
- [ ] Create VERSION file in dist repo
- [ ] Implement update checking
- [ ] Create migration framework
- [ ] Test update workflow

### Phase 4: Backup System
- [ ] Create ZIP backup prompt
- [ ] Implement GitHub integration
- [ ] Test backup/restore workflow

### Phase 5: Claude Desktop
- [ ] Create minimal system instructions
- [ ] Test MCP configuration
- [ ] Document setup process

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

## Open Questions

1. **Book Deletion:** How should book deletion work? Soft delete (archive) or hard delete?

2. **Book Export:** Should there be a way to export a single book to a standalone structure?

3. **Concurrent Editing:** Any considerations for editing same book from Desktop and CLI simultaneously?

4. **Offline Mode:** How should update checking behave when offline?

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
