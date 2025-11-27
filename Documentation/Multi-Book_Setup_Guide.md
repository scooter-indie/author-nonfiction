# Multi-Book Setup Guide

Quick setup for the separated framework and books architecture (v0.15.0+).

---

## Architecture Overview

```
FW_ROOT/                    # Framework (read-only, updatable)
├── Process/
├── VERSION
└── CLAUDE.md

BOOKS_ROOT/                 # Your books (git-tracked)
├── .config/
│   ├── books-registry.json
│   ├── fw-location.json
│   └── settings.json
├── Book-One/
├── Book-Two/
├── Archive/
└── CLAUDE.md
```

---

## Quick Start (Automated)

Run `configure.md` in Claude Code CLI - it handles everything:

1. **Start Claude Code CLI** in any directory
2. **Say:** "Run configure.md" or paste the contents of `configure.md`
3. **Follow the prompts** - configure.md will:
   - Ask for FW_ROOT location and clone the framework
   - Ask for BOOKS_ROOT location and create the directory
   - Create all configuration files automatically
   - Set up git repository
   - Generate startup scripts (optional)
   - Configure remote repository (optional)

**That's it!** After configure.md completes, run `/fw-init` to start working.

---

## Claude Desktop Setup

After running configure.md, set up Claude Desktop:

### MCP Filesystem

Add both directories to allowed paths in Claude Desktop settings:
- `[FW_ROOT]` (e.g., `E:\author-nonfiction-framework`)
- `[BOOKS_ROOT]` (e.g., `E:\My-Books`)

### System Instructions

See `[FW_ROOT]/Process/Templates/Claude_Desktop_System_Instructions.md` for the template.

For detailed setup: See `Documentation/Claude_Desktop_Setup.md`

---

## Daily Usage

1. Start session → Run `/fw-init`
2. Select book (or create new with Prompt 1)
3. Work using standard prompts
4. Switch books: say "switch to [Book Name]"

---

## Framework Updates

Check: Compare `[FW_ROOT]/VERSION` with latest release

Update:
```bash
cd [FW_ROOT] && git pull
```

---

## Backup Options

**GitHub (recommended):**
```bash
cd [BOOKS_ROOT]
git remote add origin [your-repo-url]
git push -u origin main
```

**ZIP backup:**
- Use Prompt 17 to create `books-backup-YYYY-MM-DD.zip`
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

---

## Manual Setup (Reference)

If you need to set up manually without configure.md:

### 1. Clone Framework

```bash
git clone https://github.com/scooter-indie/author-nonfiction-dist.git [FW_ROOT]
```

### 2. Create Books Root

```bash
mkdir [BOOKS_ROOT]
mkdir [BOOKS_ROOT]/.config
cd [BOOKS_ROOT] && git init
```

### 3. Create Configuration Files

**`[BOOKS_ROOT]/.config/fw-location.json`:**
```json
{
  "frameworkRoot": "[FW_ROOT path]",
  "frameworkVersion": "0.15.0",
  "lastUpdateCheck": "[YYYY-MM-DD]"
}
```

**`[BOOKS_ROOT]/.config/books-registry.json`:**
```json
{
  "version": "1.0",
  "activeBook": null,
  "books": []
}
```

**`[BOOKS_ROOT]/.config/settings.json`:**
```json
{
  "github": { "enabled": false, "repository": null, "autoPush": false },
  "backup": { "zipLocation": null, "autoBackup": false },
  "preferences": { "defaultStyle": "Conversational Expert", "confirmDate": true }
}
```

### 4. Copy CLAUDE.md

```bash
cp [FW_ROOT]/Process/Templates/BOOKS_ROOT_CLAUDE_template.md [BOOKS_ROOT]/CLAUDE.md
```

### 5. Create Startup Script (Optional)

**Windows (`start-authoring.bat`):**
```batch
@echo off
cd /d [BOOKS_ROOT]
claude
```

**macOS/Linux (`start-authoring.sh`):**
```bash
#!/bin/bash
cd [BOOKS_ROOT]
claude
```

### 6. Initial Commit

```bash
cd [BOOKS_ROOT] && git add . && git commit -m "Initialize books repository"
```

---

*Framework Version: 0.15.0*
