# Execute Prompt 17: Backup & Export

**Version:** 0.15.3
**CLI-ONLY:** Requires zip command and git operations
**Purpose:** Create backups and export books for sharing

**FIRST ACTION - MANDATORY:**
Reference `Process/Prompts/Prompt_Essentials.md` for path resolution

---

## Quick Start

This prompt provides three backup/export options:

1. **Full Backup** - ZIP of entire BOOKS_ROOT (all books)
2. **Single Book Export** - Standalone ZIP of one book for sharing
3. **GitHub Setup** - Configure remote repository for all books

---

## Mode Detection

**Multi-book mode required for options 1 and 3.**
**Option 2 works in both multi-book and legacy mode.**

Check `MODE` from session context:
- `multi-book` → All options available
- `legacy` → Only Option 2 (Single Book Export) available

---

## Step 1: Present Options

**⏸️ ASK USER:**

### Multi-Book Mode

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Backup & Export Options
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. Full Backup
   Create ZIP of all books (excludes .git/)
   Output: books-backup-YYYY-MM-DD.zip

2. Single Book Export
   Export one book as standalone ZIP for sharing
   Output: [Book-Title]-standalone-YYYY-MM-DD.zip

3. GitHub Setup
   Configure remote repository for version control

Which option? (1-3)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Legacy Mode

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Backup & Export Options
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. Project Backup
   Create ZIP of entire project (excludes .git/)
   Output: [Project-Name]-backup-YYYY-MM-DD.zip

2. GitHub Setup
   Configure remote repository for version control

Which option? (1-2)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Option 1: Full Backup (Multi-Book Mode)

### Step 1.1: Get Backup Location

**⏸️ ASK USER:**

```
Where should the backup be saved?

Default: [BOOKS_ROOT parent directory]
Or enter a custom path:
```

### Step 1.2: Create Backup

```bash
# Change to BOOKS_ROOT parent
cd [BOOKS_ROOT]/..

# Create ZIP excluding .git and common excludes
zip -r "[backup-location]/books-backup-[CONFIRMED_DATE].zip" \
    "[BOOKS_ROOT basename]" \
    -x "*.git/*" \
    -x "*/.git/*" \
    -x "*/node_modules/*" \
    -x "*/__pycache__/*" \
    -x "*.DS_Store"
```

### Step 1.3: Verify and Report

```bash
# Get file size
ls -lh "[backup-location]/books-backup-[CONFIRMED_DATE].zip"
```

**Report:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ Full Backup Created
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

File: books-backup-[CONFIRMED_DATE].zip
Location: [backup-location]
Size: [size]
Books included: [N]

Contents:
  • [Book 1 Title]
  • [Book 2 Title]
  • .config/ (registry and settings)
  • CLAUDE.md

To restore:
  1. Unzip to desired location
  2. Clone framework: git clone [dist-url] [FW_ROOT]
  3. Update .config/fw-location.json with new FW_ROOT path
  4. Run /fw-init
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Option 2: Single Book Export

### Step 2.1: Select Book (Multi-Book Mode)

**⏸️ ASK USER:**

```
Which book to export?

[List books from registry with numbers]

Enter number or name:
```

### Step 2.2: Get Export Location

**⏸️ ASK USER:**

```
Where should the export be saved?

Default: [BOOKS_ROOT parent directory] (multi-book)
         [PROJECT_ROOT parent directory] (legacy)
Or enter a custom path:
```

### Step 2.3: Create Standalone Export

**Multi-Book Mode:**
```bash
# Create temp directory
mkdir -p "/tmp/[Book-Title]-export"

# Copy book contents (excluding .git)
cp -r "[BOOK_PATH]/Manuscript" "/tmp/[Book-Title]-export/"
cp -r "[BOOK_PATH]/Research" "/tmp/[Book-Title]-export/" 2>/dev/null || true
cp -r "[BOOK_PATH]/.config" "/tmp/[Book-Title]-export/"
cp "[BOOK_PATH]/PROJECT_CONTEXT.md" "/tmp/[Book-Title]-export/"
cp "[BOOK_PATH]/README.md" "/tmp/[Book-Title]-export/" 2>/dev/null || true
```

**Legacy Mode:**
```bash
# Create temp directory
mkdir -p "/tmp/[Project-Name]-export"

# Copy contents (excluding .git and Process/)
cp -r "Manuscript" "/tmp/[Project-Name]-export/"
cp -r "Research" "/tmp/[Project-Name]-export/" 2>/dev/null || true
cp -r ".config" "/tmp/[Project-Name]-export/"
cp "PROJECT_CONTEXT.md" "/tmp/[Project-Name]-export/"
cp "README.md" "/tmp/[Project-Name]-export/" 2>/dev/null || true
```

### Step 2.4: Create Export README

Create `STANDALONE_README.md` in export directory:

```markdown
# [Book Title] - Standalone Export

**Exported:** [CONFIRMED_DATE]
**Framework Version:** 0.15.0

---

## Contents

This ZIP contains a standalone export of "[Book Title]".

### Included:
- Manuscript/ - All book content and chapters
- Research/ - Research materials (if any)
- .config/ - Project configuration
- PROJECT_CONTEXT.md - Project overview

### Not Included:
- Framework files (Process/) - Must be installed separately
- Git history - Use version control on new location

---

## To Use This Export

### Option A: Add to Existing Multi-Book Installation

1. Unzip to your BOOKS_ROOT directory
2. Update .config/books-registry.json to add this book
3. Run /fw-init and select the book

### Option B: Use as Standalone Project

1. Unzip to desired location
2. Clone framework:
   ```
   git clone https://github.com/scooter-indie/author-nonfiction-dist.git
   ```
3. Copy Process/ from framework to this project
4. Initialize git: `git init`
5. Run /fw-init

---

## Original Project Info

**Title:** [Book Title]
**Author:** [Author]
**Chapters:** [N]
**Style:** [Style Name]

---

*Exported with AI-Assisted Nonfiction Authoring Framework v0.15.0*
```

### Step 2.5: Create ZIP

```bash
# Change to temp parent
cd /tmp

# Create ZIP
zip -r "[export-location]/[Book-Title]-standalone-[CONFIRMED_DATE].zip" \
    "[Book-Title]-export"

# Cleanup temp
rm -rf "/tmp/[Book-Title]-export"
```

### Step 2.6: Report

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ Single Book Export Created
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Book: [Book Title]
File: [Book-Title]-standalone-[CONFIRMED_DATE].zip
Location: [export-location]
Size: [size]

Contents:
  • Manuscript/ ([N] chapters)
  • Research/
  • .config/
  • PROJECT_CONTEXT.md
  • STANDALONE_README.md

This export can be:
  • Shared with collaborators
  • Added to another multi-book installation
  • Used as a standalone project (requires framework)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Option 3: GitHub Setup

### Step 3.1: Check Current Status

```bash
# Check if remote already configured
git remote -v
```

**If remote exists:**
```
GitHub remote already configured:
  origin: [URL]

Options:
  1. Keep current remote
  2. Change remote URL
  3. Remove remote

Which option?
```

### Step 3.2: Get Repository URL (If New Setup)

**⏸️ ASK USER:**

```
Enter your GitHub repository URL:

Example: https://github.com/username/my-books.git
         git@github.com:username/my-books.git

URL:
```

### Step 3.3: Configure Remote

```bash
# Add remote
git remote add origin [URL]

# Verify
git remote -v
```

### Step 3.4: Update Settings (Multi-Book Mode)

Update `.config/settings.json`:
```json
{
  "github": {
    "enabled": true,
    "repository": "[URL]",
    "autoPush": false
  }
}
```

### Step 3.5: Initial Push (Optional)

**⏸️ ASK USER:**

```
Push current content to GitHub now?

This will:
  • Push all commits to origin/main
  • Push all tags

(yes/no)
```

**If yes:**
```bash
git push -u origin main --tags
```

### Step 3.6: Report

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ GitHub Integration Configured
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Repository: [URL]
Status: [Pushed / Not yet pushed]

Quick commands:
  • Push changes: git push
  • Pull updates: git pull
  • Use Prompt 12 for advanced git operations

Backup strategy:
  • Local: Use Option 1 (Full Backup) periodically
  • Remote: Push to GitHub after major milestones
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Error Handling

### zip Command Not Found

```
Error: 'zip' command not found.

Install zip:
  • Windows: Install via Git Bash or WSL
  • macOS: brew install zip (usually pre-installed)
  • Linux: sudo apt install zip
```

### Insufficient Disk Space

```
Error: Insufficient disk space for backup.

Required: ~[estimated size]
Available: [available space]

Options:
  1. Free up disk space
  2. Choose different backup location
  3. Export single book instead (smaller)
```

### Git Remote Already Exists

```
Remote 'origin' already exists with URL: [current URL]

Options:
  1. Keep current: Do nothing
  2. Update URL: git remote set-url origin [new-url]
  3. Remove: git remote remove origin
```

---

## Related Prompts

| Prompt | Relationship |
|--------|--------------|
| Prompt 12 | Git operations (push, pull, tags) |
| Prompt 1 | Initialize new project (restore scenario) |

---

**Version:** 0.15.3
**Last Updated:** 2025-11-28
**CLI-ONLY:** Requires zip and git commands

---

## Session Cleanup

Tell user: "✓ Prompt 17 Backup & Export complete.

To free up tokens, say: **'Clear Prompt 17 from context'**"
