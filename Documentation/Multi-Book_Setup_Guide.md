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

## Installation

### 1. Clone Framework

```bash
git clone https://github.com/scooter-indie/author-nonfiction-dist.git [FW_ROOT]
```

Example: `E:\author-nonfiction-framework`

### 2. Create Books Root

```bash
mkdir [BOOKS_ROOT]
cd [BOOKS_ROOT]
git init
```

Example: `E:\My-Books`

### 3. Initialize Configuration

Create the config directory and files in BOOKS_ROOT:

```bash
mkdir [BOOKS_ROOT]/.config
```

Create `[BOOKS_ROOT]/.config/fw-location.json`:
```json
{
  "frameworkRoot": "[FW_ROOT path]",
  "frameworkVersion": "0.15.0"
}
```

Create `[BOOKS_ROOT]/.config/books-registry.json`:
```json
{
  "version": "1.0",
  "activeBook": null,
  "books": []
}
```

Create `[BOOKS_ROOT]/.config/settings.json`:
```json
{
  "github": { "enabled": false },
  "backup": { "zipLocation": null },
  "preferences": { "confirmDate": true }
}
```

### 4. Copy CLAUDE.md

Copy `[FW_ROOT]/Process/Templates/BOOKS_ROOT_CLAUDE_template.md` to `[BOOKS_ROOT]/CLAUDE.md`

---

## Claude Desktop Setup

### MCP Filesystem

Add both directories to allowed paths:
- `[FW_ROOT]`
- `[BOOKS_ROOT]`

### System Instructions

Use minimal instructions from `[FW_ROOT]/Process/Templates/Desktop_System_Instructions.md`

---

## Claude Code CLI Setup

### Startup Script (Windows)

Create `start-authoring.bat`:
```batch
@echo off
cd /d [BOOKS_ROOT]
claude
```

### Startup Script (macOS/Linux)

Create `start-authoring.sh`:
```bash
#!/bin/bash
cd [BOOKS_ROOT]
claude
```

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
- Use backup prompt to create `books-backup-YYYY-MM-DD.zip`
- Framework reinstallable from dist repo

---

## Book Management

| Action | Command |
|--------|---------|
| List books | "list books" |
| Switch book | "switch to [Name]" |
| Create book | Run Prompt 1 |
| Archive book | Move to `Archive/` |

---

*Framework Version: 0.15.0*
