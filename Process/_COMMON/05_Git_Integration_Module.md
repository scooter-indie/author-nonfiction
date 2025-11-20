# Git Integration Module

**Framework Version:** 0.10.0
**Module:** Git Operations and Commit Formatting
**Purpose:** Standardized git workflows and commit message formats

---

## Overview

This module defines standardized git operations and commit message formats used across prompts. All git commits involving Manuscript/ files MUST include both content and _chg files (Enforcement Rule 1).

---

## Git Commit Message Templates

### Template 1: New Chapter

```
Add Chapter {XX}: {Title}

- Created chapter structure and placeholder content
- Added to Table of Contents
- Added quote entry (Status: ⏳ Pending)
- Renumbered affected chapters ({old} → {new})
- Updated cross-references

Version: 1.0.0

Co-Authored-By: Claude <noreply@anthropic.com>
```

**Files to include:**
```bash
git add \
  Manuscript/Chapters/Chapter_{XX}/ \
  Manuscript/_TOC_/TOC.md \
  Manuscript/_TOC_/TOC_chg.md \
  Manuscript/Quotes/Chapter_Quotes.md \
  Manuscript/Quotes/Chapter_Quotes_chg.md
```

---

### Template 2: Content Modification

```
Update {filename} v{version}

{Brief description of changes}

Type: {Content Addition | Content Deletion | Structural Change | Refinement}
Scope: {Affected sections}

Changes:
- {Change 1}
- {Change 2}
- {Change 3}

Co-Authored-By: Claude <noreply@anthropic.com>
```

**Files to include:**
```bash
git add \
  {content_file_path} \
  {content_file_path}_chg.md
```

---

### Template 3: Initialization

```
Initialize book project: {Book Title}

- Created complete directory structure
- Initialized {X} chapter placeholders
- Generated TOC, quotes management, style guide
- Set up front/back matter structure
- Created PROJECT_CONTEXT.md for session resumption

Framework Version: 0.10.0
Project Version: 1.0.0

Co-Authored-By: Claude <noreply@anthropic.com>
```

**Files to include:**
```bash
git add .
```

---

### Template 4: Change Tracking Sync

```
Sync change tracking files

Updated {count} _chg files with version history:
- {file1}: v{old} → v{new}
- {file2}: v{old} → v{new}
- {file3}: v{old} → v{new}

Reconstructed version history from git log.
All files now in sync with content.

Co-Authored-By: Claude <noreply@anthropic.com>
```

**Files to include:**
```bash
git add {list of _chg.md files}
```

---

### Template 5: Dashboard Update

```
Update PROJECT_CONTEXT.md ({date})

Current Status:
- Total word count: {X}/{Y} words ({Z}%)
- Chapters: {completed}/{total}
- Last modified: {files}

Next milestone: {milestone} ({date})

Co-Authored-By: Claude <noreply@anthropic.com>
```

**Files to include:**
```bash
git add PROJECT_CONTEXT.md
```

---

## Git Operations

### Safety Commit (Before Major Operations)

**Purpose:** Create snapshot before risky operations

**Prompts:** 2, 4

**Procedure:**
```bash
git add .
git commit -m "Safety commit before {operation}

Preserving current state before:
- {operation description}
- {affected files/areas}

This commit can be used for rollback if needed.

Co-Authored-By: Claude <noreply@anthropic.com>"
```

### Standard Commit (After Operations)

**Purpose:** Commit completed work with proper tracking

**Prompts:** 1, 2, 3, 4, 8, 10

**Procedure:**
```bash
# Verify both files staged (if Manuscript/ files)
git status

# Stage files
git add {files}

# Verify staging
git diff --cached --name-only

# Commit with descriptive message
git commit -m "{template message}"

# Verify commit
git log -1 --name-only
```

### Tagging (Milestones)

**Purpose:** Mark significant versions

**Prompts:** 1, 9

**Procedure:**
```bash
# Create annotated tag
git tag -a v{version} -m "{Book Title} - {Milestone}

Milestone: {25% | 50% | 75% | 100% | First Draft | Final Draft}
Total Words: {X}
Completion: {Y}%
Date: {YYYY-MM-DD}

Co-Authored-By: Claude <noreply@anthropic.com>"

# Verify tag
git tag -l -n9 v{version}
```

---

## Claude Desktop Git Command Format

**For prompts that require git at the end, provide commands in this format:**

```markdown
## Git Commit (For Claude Desktop Users)

All changes have been made. Now commit to git:

Go to Claude Code CLI and say:
```
Run: git add {files} && git commit -m "{message}"
```

**Important:** The instruction "Go to Claude Code CLI and say:" must be OUTSIDE the code block.
```

**Example:**

```markdown
Go to Claude Code CLI and say:
```
Run: git add Manuscript/Chapters/Chapter_03/Chapter_03.md Manuscript/Chapters/Chapter_03/Chapter_03_chg.md && git commit -m "Update Chapter 3 with case studies v1.3.0"
```
```

---

## Pre-Commit Validation

**Before every git commit involving Manuscript/ files:**

```markdown
**Pre-Commit Validation:**

Verifying both files are staged:
- Content file: {path}
- Change tracking: {path}_chg.md

✅ Both files ready for commit
```

**If validation fails:**
```markdown
❌ Missing _chg file update

The following files were modified but _chg files were not updated:
- {file1}
- {file2}

This violates Enforcement Rule 1. Updating _chg files now...
```

---

## Post-Commit Report

**After every commit:**

```markdown
**Git Commit Summary:**

Commit: {hash}
Files: {count} files changed
- {file1}
- {file2}
- ...

Message: {first line of commit message}
Version: {version (if applicable)}

Next: {suggested next steps}
```

---

**Module Version:** 0.10.0
**Last Updated:** 2025-11-19
**Status:** Active
