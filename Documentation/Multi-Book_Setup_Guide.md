# Multi-Book Setup Guide

Quick setup for the unified PROJECT_ROOT architecture (v0.16.0+).

---

## Architecture Overview

```
PROJECT_ROOT/                    # Your writing environment
├── .git/                        # Git repository (versions your content)
├── .gitignore                   # Excludes FW_ROOT/
├── start-authoring.bat/.sh      # Normal startup scripts
├── bp-start-authoring.bat/.sh   # Bypass permissions startup
│
├── FW_ROOT/                     # Framework (cloned, gitignored)
│   ├── Process/                 # Prompts, styles, templates
│   ├── scripts/                 # Automation scripts
│   ├── VERSION                  # Framework version
│   └── configure.md             # Configuration prompt
│
├── BOOKS_ROOT/                  # All your books
│   ├── Book-One/
│   │   ├── Manuscript/
│   │   └── PROJECT_CONTEXT.md
│   ├── Book-Two/
│   │   └── ...
│   └── Archive/                 # Archived/completed books
│
└── .config/                     # CONFIG_ROOT
    ├── fw-location.json         # FW_ROOT path + version
    ├── settings.json            # BOOKS_ROOT path + preferences
    ├── books-registry.json      # Book list + active book
    ├── CLAUDE.md                # Claude instructions
    └── .claude/
        ├── commands/            # fw-init, switch-book, manage-book
        └── agents/              # book-writing-assistant
```

**Key Concept:** Everything is under PROJECT_ROOT. Claude starts in `.config/` (CONFIG_ROOT).

---

## Quick Start (Automated)

### 1. Clone the Framework

```bash
git clone https://github.com/scooter-indie/author-nonfiction-dist.git ~/Downloads/author-nonfiction
```

### 2. Run Setup Script

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

### 3. Follow the Prompts

configure.md will:
- Ask for PROJECT_ROOT location
- Create BOOKS_ROOT/ and .config/ directories
- Clone or copy framework into FW_ROOT/
- Create all configuration files
- Initialize git repository
- Generate startup scripts
- Auto-chain to start-authoring on `/exit`

### 4. Create Your First Book

After setup completes, say: **"Execute Prompt 1"**

**That's it!** The framework is ready for multi-book management.

---

## Daily Usage

### Starting a Session

**Windows:** Double-click `start-authoring.bat` in PROJECT_ROOT
**macOS/Linux:** Run `./start-authoring.sh` in PROJECT_ROOT

Claude starts in `.config/` and automatically prompts for `/fw-init`.

### Working with Books

1. `/fw-init` shows available books
2. Select a book (or create new with Prompt 1)
3. Work using standard prompts (2-16)
4. Switch books: say "switch to [Book Name]"

### Book Selection on Startup

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Book Selection
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Available books:
  1. My First Book - in-progress (last: 2025-11-28)
  2. Another Project - planning (last: 2025-11-25)

  N. Create new book

Currently active: My First Book

Which book would you like to work on?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Claude Desktop Setup

After running configure.bat/sh, set up Claude Desktop:

### MCP Filesystem

Add PROJECT_ROOT to allowed paths in Claude Desktop settings:
- Single entry: `[PROJECT_ROOT]` (e.g., `E:\My-Writing`)
- This provides access to FW_ROOT, BOOKS_ROOT, and .config/

### System Instructions

1. Open `[PROJECT_ROOT]/FW_ROOT/Process/Templates/Claude_Desktop_System_Instructions.md`
2. Replace `[PROJECT_ROOT]` with your actual path
3. Copy to Claude Desktop project settings

For detailed setup: See `Documentation/Claude_Desktop_Setup.md`

---

## Framework Updates

### Automatic Check

`/fw-init` checks for updates once per day. When update available:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
ℹ Framework Update Available
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Current version: 0.16.0
Latest version:  0.16.1

Would you like to update now? (yes/no)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Manual Update

```bash
cd [PROJECT_ROOT]/FW_ROOT
git pull origin main
```

Then run `/fw-init` to apply any migrations.

**Note:** Your books are never touched during updates - only FW_ROOT changes.

---

## Backup Options

### GitHub (Recommended)

```bash
cd [PROJECT_ROOT]
git remote add origin [your-repo-url]
git push -u origin main
```

The `.gitignore` excludes FW_ROOT/, so only your books and config are backed up.

### ZIP Backup

Use Prompt 17 to create `project-backup-YYYY-MM-DD.zip`:
- Includes BOOKS_ROOT/ and .config/
- Framework reinstallable from dist repo

---

## Book Management

| Action | Command |
|--------|---------|
| List books | "list books" |
| Switch book | "switch to [Name]" |
| Create book | Run Prompt 1 |
| Archive book | `/manage-book archive` |
| Restore book | `/manage-book restore` |
| Delete book | `/manage-book delete` |

### Archive vs Delete

- **Archive:** Moves to BOOKS_ROOT/Archive/, can be restored
- **Delete:** Permanent removal (requires typing book title to confirm)

---

## Manual Setup (Reference)

If you need to set up manually without configure.bat/sh:

### 1. Create PROJECT_ROOT Structure

```bash
mkdir -p [PROJECT_ROOT]
mkdir -p [PROJECT_ROOT]/BOOKS_ROOT/Archive
mkdir -p [PROJECT_ROOT]/.config/.claude/commands
mkdir -p [PROJECT_ROOT]/.config/.claude/agents
```

### 2. Clone Framework

```bash
git clone https://github.com/scooter-indie/author-nonfiction-dist.git [PROJECT_ROOT]/FW_ROOT
```

### 3. Create Configuration Files

**`[PROJECT_ROOT]/.config/fw-location.json`:**
```json
{
  "frameworkRoot": "[PROJECT_ROOT]/FW_ROOT",
  "frameworkVersion": "0.16.0",
  "lastUpdateCheck": "[YYYY-MM-DD]",
  "updateChannel": "stable"
}
```

**`[PROJECT_ROOT]/.config/settings.json`:**
```json
{
  "booksRoot": "[PROJECT_ROOT]/BOOKS_ROOT",
  "github": { "enabled": false, "repository": null, "autoPush": false },
  "backup": { "zipLocation": null, "autoBackup": false },
  "preferences": { "defaultStyle": "Conversational Expert", "confirmDate": true }
}
```

**`[PROJECT_ROOT]/.config/books-registry.json`:**
```json
{
  "version": "1.0",
  "activeBook": null,
  "books": []
}
```

### 4. Copy Templates

```bash
# CLAUDE.md
cp [PROJECT_ROOT]/FW_ROOT/Process/Templates/CONFIG_ROOT_CLAUDE_template.md [PROJECT_ROOT]/.config/CLAUDE.md

# Commands
cp [PROJECT_ROOT]/FW_ROOT/Process/Templates/.claude/commands/*.md [PROJECT_ROOT]/.config/.claude/commands/

# Agents
cp [PROJECT_ROOT]/FW_ROOT/Process/Templates/.claude/agents/*.md [PROJECT_ROOT]/.config/.claude/agents/
```

### 5. Create .gitignore

**`[PROJECT_ROOT]/.gitignore`:**
```
FW_ROOT/
.DS_Store
Thumbs.db
*.swp
*~
```

### 6. Create Startup Scripts

**Windows (`[PROJECT_ROOT]/start-authoring.bat`):**
```batch
@echo off
cd /d "%~dp0.config"
claude --append-system-prompt "IMPORTANT: Run /fw-init immediately before doing anything else." "Start"
```

**macOS/Linux (`[PROJECT_ROOT]/start-authoring.sh`):**
```bash
#!/bin/bash
cd "$(dirname "$0")/.config"
claude --append-system-prompt "IMPORTANT: Run /fw-init immediately before doing anything else." "Start"
```

### 7. Initialize Git

```bash
cd [PROJECT_ROOT]
git init
git add .
git commit -m "Initialize writing environment"
```

---

## Troubleshooting

### "Not a valid configuration directory"

You're not in CONFIG_ROOT. Run from `.config/` or use start-authoring script.

### "Framework not found"

Check `fw-location.json` → `frameworkRoot` path is correct.

### Books not showing

Check `books-registry.json` has entries. Run Prompt 1 to create a book.

### Can't switch books

Verify book exists in `books-registry.json` and directory exists in BOOKS_ROOT.

---

*Framework Version: 0.16.0*
*Last Updated: 2025-11-28*
