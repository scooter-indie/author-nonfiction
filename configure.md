# Framework Configuration

**AI-Assisted Nonfiction Authoring Framework v0.16.1**

---

## Environment Support

This configuration supports both **Claude Desktop** and **Claude Code CLI**.

**Detect your environment:**
- **Claude Desktop:** File operations via MCP Filesystem, CLI commands via copy blocks
- **Claude Code CLI:** Direct execution of all commands

**How this works:**
1. Steps 0-1 work in both environments (detection and verification)
2. Steps 2+ require CLI commands → Desktop users get **copy blocks**
3. Desktop users paste copy blocks into Claude Code CLI for execution

---

## What This Does

This configuration script sets up the unified PROJECT_ROOT architecture:

**Fresh Install (from cloned FW_ROOT):**
1. Ask for PROJECT_ROOT location
2. Create PROJECT_ROOT directory structure
3. Set up books directory
4. Create CONFIG_ROOT (.config/) with all files
5. Generate startup scripts
6. Initialize git repository
7. Chain to start-authoring on exit

**Framework Update (from existing CONFIG_ROOT):**
1. Check for available updates
2. Pull latest framework version
3. Apply migrations

---

## Unified PROJECT_ROOT Architecture

```
PROJECT_ROOT/
├── .git/                    # Git repository (user content)
├── .gitignore               # Excludes FW_ROOT/
├── start-authoring.bat/.sh  # Startup scripts
├── bp-start-authoring.*     # Bypass-permissions startup
├── FW_ROOT/                 # Framework (cloned from -dist)
│   └── (framework files)
├── My-Books/                # Your books (default name)
│   ├── [Book-1]/
│   ├── [Book-2]/
│   └── Archive/
└── .config/                 # CONFIG_ROOT
    ├── fw-location.json
    ├── settings.json
    ├── books-registry.json
    ├── CLAUDE.md
    └── .claude/
        ├── agents/
        └── commands/
```

---

## Configuration Process

### Step 0: Confirm Date

**⏸️ STOP AND ASK USER:**

```
Today's date from system: [DATE from <env>]

Is this correct? (yes / or provide correct date in YYYY-MM-DD format)
```

**WAIT for user response.**

- **If user says "yes":** Store as `CONFIRMED_DATE=[DATE]`
- **If user provides different date:** Store as `CONFIRMED_DATE=[user's date]`

**IMPORTANT:** Use CONFIRMED_DATE for ALL date operations during this session.

---

### Step 0.5: Check Required Tools

**Required tools:**
1. **git** - Version control (required)

**Check git:**
```bash
git --version
```

**If git not found:** Show installation instructions and wait for user.

---

### Step 0.6: Bash Syntax for File/Directory Checks

**IMPORTANT:** When checking if files or directories exist, use **bash syntax** (not Windows CMD).

**Correct bash syntax:**
```bash
# Check if file exists
test -f "path/to/file" && echo "EXISTS" || echo "NOT_EXISTS"

# Check if directory exists
test -d "path/to/directory" && echo "EXISTS" || echo "NOT_EXISTS"

# Check if path exists (file or directory)
test -e "path" && echo "EXISTS" || echo "NOT_EXISTS"
```

**NEVER use Windows CMD syntax** like `if exist "path" (echo EXISTS)` - this will fail in bash.

---

### Step 1: Installation Mode Detection

**Detect which mode to use based on current directory:**

Check for these indicators using bash:

```bash
# Check for VERSION file (indicates FW_ROOT)
test -f "VERSION" && echo "VERSION_EXISTS" || echo "VERSION_NOT_FOUND"

# Check for fw-location.json (indicates CONFIG_ROOT)
test -f "fw-location.json" && echo "FW_LOCATION_EXISTS" || echo "FW_LOCATION_NOT_FOUND"
```

1. **VERSION file exists?** → Running from cloned FW_ROOT (Fresh Install)
2. **fw-location.json exists?** → Running from CONFIG_ROOT (Update/Reconfigure)

**Mode Detection Logic:**

```
if VERSION file exists:
    MODE = "FW_ROOT"
    SUBMODE = "Fresh Install" (create PROJECT_ROOT)

elif fw-location.json exists:
    MODE = "CONFIG_ROOT"
    # Read fw-location.json to get FW_ROOT path
    if git fetch shows updates in FW_ROOT:
        SUBMODE = "Update Available"
    else:
        SUBMODE = "Reconfiguration"

else:
    ERROR = "Not a valid framework or configuration directory"
```

**Report detection result:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Installation Mode Detection
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[✓] VERSION file: [found/not found]
[✓] fw-location.json: [found/not found]

Detected Mode: [FW_ROOT | CONFIG_ROOT]
Submode: [Fresh Install | Update Available | Reconfiguration]

Proceeding with [mode] workflow...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Based on detected mode, proceed to appropriate section:**
- **FW_ROOT (Fresh Install)** → Step 2A (PROJECT_ROOT Setup)
- **CONFIG_ROOT + Update Available** → Step 2B (Update Workflow)
- **CONFIG_ROOT + Reconfiguration** → Step 2C (Reconfiguration)

---

## Step 2A: PROJECT_ROOT Setup (Fresh Install from FW_ROOT)

**This step runs when configure.md is executed from a freshly cloned FW_ROOT.**

### 2A.1: Get PROJECT_ROOT Location

**⏸️ ASK USER:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PROJECT_ROOT Setup
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Where would you like to create your writing environment?

PROJECT_ROOT will contain:
  • FW_ROOT/ - Framework files (cloned from this location)
  • [Books directory]/ - All your book projects
  • .config/ - Configuration files
  • Git repository for your content

Examples:
  • Windows: E:\My-Writing
  • macOS: ~/Documents/My-Writing
  • Linux: ~/writing

Enter path for PROJECT_ROOT:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**WAIT for user response.** Store as `PROJECT_ROOT`.

**Validate using bash:**
```bash
# Check if PROJECT_ROOT already exists
test -e "[PROJECT_ROOT]" && echo "PATH_EXISTS" || echo "PATH_AVAILABLE"

# Check if parent directory exists (extract parent from path)
test -d "$(dirname "[PROJECT_ROOT]")" && echo "PARENT_EXISTS" || echo "PARENT_NOT_FOUND"
```

**Validation rules:**
- Path must not already exist (or must be empty)
- Parent directory must exist and be writable

**If validation fails:** Show appropriate error from Error Handling section.

### 2A.1.5: Books Directory Name

**⏸️ ASK USER:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Books Directory Name
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

What would you like to name your books directory?

This will be created at: [actual PROJECT_ROOT path]/[name]/

Enter name [My-Books]:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**WAIT for user response.**
- If empty/Enter: Use default "My-Books"
- Otherwise: Use provided name

**Validate name:**
- No spaces (suggest hyphens instead)
- No special characters except hyphens and underscores
- Not empty after trimming

Store as `BOOKS_DIR_NAME`. The full path will be `[PROJECT_ROOT]/[BOOKS_DIR_NAME]`.

### 2A.2: Create PROJECT_ROOT Directory Structure

```bash
mkdir -p "[PROJECT_ROOT]"
mkdir -p "[PROJECT_ROOT]/[BOOKS_DIR_NAME]"
mkdir -p "[PROJECT_ROOT]/[BOOKS_DIR_NAME]/Archive"
mkdir -p "[PROJECT_ROOT]/.config"
mkdir -p "[PROJECT_ROOT]/.config/.claude/agents"
mkdir -p "[PROJECT_ROOT]/.config/.claude/commands"
```

### 2A.3: Clone Framework into FW_ROOT

**⏸️ ASK USER:**

```
How should the framework be installed in PROJECT_ROOT?

1. Copy - Copy framework files from current location
2. Clone - Fresh clone from GitHub (recommended)

Option (1 or 2):
```

**WAIT for user response.**

**If Copy:**
```bash
# Copy entire framework directory
cp -r "[CURRENT_DIRECTORY]" "[PROJECT_ROOT]/FW_ROOT"
```

**If Clone:**
```bash
git clone https://github.com/scooter-indie/author-nonfiction-dist.git "[PROJECT_ROOT]/FW_ROOT"
```

Store FW_ROOT path: `FW_ROOT=[PROJECT_ROOT]/FW_ROOT`

Read VERSION from `[FW_ROOT]/VERSION` and store as `FW_VERSION`.

### 2A.4: Create .gitignore

Write to `[PROJECT_ROOT]/.gitignore`:

```
# Ignore framework directory (tracked in separate repo)
FW_ROOT/

# OS files
.DS_Store
Thumbs.db

# Editor files
*.swp
*~
```

### 2A.5: Create Configuration Files

**Create .config/fw-location.json:**

```json
{
  "frameworkRoot": "[FW_ROOT absolute path]",
  "frameworkVersion": "[FW_VERSION]",
  "lastUpdateCheck": "[CONFIRMED_DATE]",
  "updateChannel": "stable"
}
```

Write to `[PROJECT_ROOT]/.config/fw-location.json`.

**Create .config/settings.json:**

```json
{
  "booksRoot": "[PROJECT_ROOT]/[BOOKS_DIR_NAME]",
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

Write to `[PROJECT_ROOT]/.config/settings.json`.

**Create .config/books-registry.json:**

```json
{
  "version": "1.0",
  "activeBook": null,
  "books": []
}
```

Write to `[PROJECT_ROOT]/.config/books-registry.json`.

### 2A.6: Copy CLAUDE.md and Slash Commands

**Copy CONFIG_ROOT CLAUDE.md:**
```bash
cp "[FW_ROOT]/Process/Templates/CONFIG_ROOT_CLAUDE_template.md" "[PROJECT_ROOT]/.config/CLAUDE.md"
```

**Copy slash commands:**
```bash
cp "[FW_ROOT]/Process/Templates/.claude/commands/fw-init.md" "[PROJECT_ROOT]/.config/.claude/commands/"
cp "[FW_ROOT]/Process/Templates/.claude/commands/switch-book.md" "[PROJECT_ROOT]/.config/.claude/commands/"
cp "[FW_ROOT]/Process/Templates/.claude/commands/manage-book.md" "[PROJECT_ROOT]/.config/.claude/commands/"
```

**Copy agents:**
```bash
cp "[FW_ROOT]/Process/Templates/.claude/agents/book-writing-assistant.md" "[PROJECT_ROOT]/.config/.claude/agents/"
```

### 2A.7: Generate Startup Scripts

**Detect platform and generate appropriate scripts:**

**For Windows - Create start-authoring.bat:**
```batch
@echo off
cd /d "%~dp0.config"
claude --append-system-prompt "IMPORTANT: Run /fw-init immediately before doing anything else." "Start"
```

Write to `[PROJECT_ROOT]/start-authoring.bat`.

**For Windows - Create bp-start-authoring.bat:**
```batch
@echo off
cd /d "%~dp0.config"
claude --dangerously-skip-permissions --append-system-prompt "IMPORTANT: Run /fw-init immediately before doing anything else." "Start"
```

Write to `[PROJECT_ROOT]/bp-start-authoring.bat`.

**For macOS/Linux - Create start-authoring.sh:**
```bash
#!/bin/bash
cd "$(dirname "$0")/.config"
claude --append-system-prompt "IMPORTANT: Run /fw-init immediately before doing anything else." "Start"
```

Write to `[PROJECT_ROOT]/start-authoring.sh` and make executable:
```bash
chmod +x "[PROJECT_ROOT]/start-authoring.sh"
```

**For macOS/Linux - Create bp-start-authoring.sh:**
```bash
#!/bin/bash
cd "$(dirname "$0")/.config"
claude --dangerously-skip-permissions --append-system-prompt "IMPORTANT: Run /fw-init immediately before doing anything else." "Start"
```

Write to `[PROJECT_ROOT]/bp-start-authoring.sh` and make executable:
```bash
chmod +x "[PROJECT_ROOT]/bp-start-authoring.sh"
```

### 2A.8: Create Archive README

Copy `[FW_ROOT]/Process/Templates/Archive_README_template.md` to `[PROJECT_ROOT]/[BOOKS_DIR_NAME]/Archive/README.md`.

### 2A.9: Initialize Git Repository

**⏸️ ASK USER:**

```
Initialize git repository in PROJECT_ROOT?

This enables version control for all your books.
(FW_ROOT is excluded via .gitignore)

Recommended: yes

(yes/no)
```

**WAIT for user response.**

**If yes:**
```bash
cd "[PROJECT_ROOT]"
git init
git branch -M main
```

### 2A.10: Remote Repository Setup (Optional)

**⏸️ ASK USER:**

```
Do you want to connect PROJECT_ROOT to a remote git repository?

This enables backup to GitHub/GitLab.

Options:
1. "no" or "skip" - Work locally only
2. "github" - Create/connect to GitHub
3. "url [your-url]" - I have a repository URL
```

**WAIT for user response.**

**If user provides URL or github:**
```bash
cd "[PROJECT_ROOT]"
git remote add origin [URL]
```

Update `.config/settings.json` with GitHub info if provided.

### 2A.11: Create Initial Commit

```bash
cd "[PROJECT_ROOT]"
git add .
git commit -m "Initialize writing environment

Created by AI-Assisted Nonfiction Authoring Framework v[FW_VERSION]

Structure:
- [BOOKS_DIR_NAME]/ for book projects
- .config/ for configuration
- FW_ROOT/ excluded (separate repo)

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

### 2A.12: Report Completion

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ PROJECT_ROOT Setup Complete
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

PROJECT_ROOT: [PROJECT_ROOT path]
├── FW_ROOT/: [FW_ROOT path]
├── [BOOKS_DIR_NAME]/: [PROJECT_ROOT]/[BOOKS_DIR_NAME]
└── .config/: [PROJECT_ROOT]/.config

Framework Version: [FW_VERSION]

Created:
  ✓ .config/fw-location.json
  ✓ .config/settings.json
  ✓ .config/books-registry.json
  ✓ .config/CLAUDE.md
  ✓ .config/.claude/commands/ (fw-init, switch-book, manage-book)
  ✓ .config/.claude/agents/ (book-writing-assistant)
  ✓ [BOOKS_DIR_NAME]/Archive/
  ✓ .gitignore (excludes FW_ROOT/)
  ✓ start-authoring scripts
  ✓ Git repository initialized
  [✓ Remote repository connected (if configured)]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📚 NEXT STEP:

Type /exit to close this session.

The configure script will automatically launch start-authoring
to begin your first writing session.

If running manually (not via configure.bat/sh):
  Windows: Double-click [PROJECT_ROOT]\start-authoring.bat
  macOS/Linux: [PROJECT_ROOT]/start-authoring.sh

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**End of PROJECT_ROOT Setup Workflow.**

---

## Step 2B: Update Workflow (CONFIG_ROOT with Updates Available)

**This step runs when configure.md detects it's in CONFIG_ROOT with available updates.**

### 2B.1: Read Current Configuration

Read `fw-location.json` to get:
- `frameworkRoot` → FW_ROOT
- `frameworkVersion` → current version
- `updateChannel` → stable/beta

### 2B.2: Fetch Latest Version

```bash
cd "[FW_ROOT]"
git fetch origin
```

### 2B.3: Compare Versions

```bash
# Read local version
LOCAL_VERSION=$(cat "[FW_ROOT]/VERSION")

# Read remote version
REMOTE_VERSION=$(git -C "[FW_ROOT]" show origin/main:VERSION)

echo "Local: $LOCAL_VERSION"
echo "Remote: $REMOTE_VERSION"
```

### 2B.4: Show Update Preview

**⏸️ ASK USER:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Framework Update Available
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Current version: [LOCAL_VERSION]
Available version: [REMOTE_VERSION]
Channel: [updateChannel]

Changes in this update:
[Read and display relevant section from CHANGELOG.md]

Proceed with update? (yes/no)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**WAIT for user response.**

**If no:** Exit configuration.

### 2B.5: Pull Updates

```bash
cd "[FW_ROOT]"
git pull origin main
```

### 2B.6: Apply Migrations (if any)

1. Check `[FW_ROOT]/Process/migrations/` for applicable migrations
2. Read migrations between LOCAL_VERSION and REMOTE_VERSION
3. Execute each migration in order

### 2B.7: Update Configuration

Update `fw-location.json`:
- `frameworkVersion` → new version from VERSION file
- `lastUpdateCheck` → CONFIRMED_DATE

### 2B.8: Report Completion

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ Framework Updated Successfully
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Updated: [LOCAL_VERSION] → [REMOTE_VERSION]
Migrations applied: [list or "None required"]

Next steps:
1. Run /fw-init to reload framework
2. Continue working on your book
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**End of Update Workflow.**

---

## Step 2C: Reconfiguration (Running from CONFIG_ROOT)

**This step runs when configure.md is executed from an existing CONFIG_ROOT without updates.**

### 2C.1: Read Current Configuration

Read `fw-location.json` to get FW_ROOT path.
Read `settings.json` to get books directory path (booksRoot).
Read `books-registry.json` to get book list.

### 2C.2: Present Options

**⏸️ ASK USER:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Configuration Options
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Current configuration:
  PROJECT_ROOT: [parent of CONFIG_ROOT]
  FW_ROOT: [from fw-location.json]
  Books directory: [from settings.json booksRoot]
  Books: [N] registered

What would you like to do?

1. Update FW_ROOT path (if framework moved)
2. Regenerate startup scripts
3. Configure remote repository
4. Check for framework updates

Enter option (1-4):
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**WAIT for user response.**

Handle each option appropriately.

**End of Reconfiguration Workflow.**

---

## Error Handling

### Not a Valid Directory

```
❌ Configuration Failed: Invalid Directory

This directory doesn't appear to be a framework installation or configuration root.

Expected one of:
- VERSION file (cloned FW_ROOT - for fresh install)
- fw-location.json (CONFIG_ROOT - for updates/reconfiguration)

Solutions:
1. Clone the framework: git clone https://github.com/scooter-indie/author-nonfiction-dist.git
2. Navigate to an existing PROJECT_ROOT/.config/ directory
```

### Missing Framework Files

```
❌ Configuration Failed: Missing Framework Files

The following required files are missing:
- [list missing files]

This suggests the framework was not fully installed.

Solution: Re-clone the framework:
git clone https://github.com/scooter-indie/author-nonfiction-dist.git
```

### Git Not Installed

```
⚠️ Git Not Found

Git is required for this framework.

To install git:
- Windows: https://git-scm.com/ or run: winget install Git.Git
- macOS: brew install git
- Linux: sudo apt install git

After installing git, run this configuration again.
```

### PROJECT_ROOT Path Invalid

```
❌ Invalid PROJECT_ROOT Path

The path you specified has an issue:
[specific error]

Please verify:
1. Parent directory exists
2. You have write permissions
3. Path doesn't already contain files (must be empty or not exist)

Try again with a valid path.
```

### PROJECT_ROOT Already Exists

```
⚠️ Directory Already Exists

The path "[PROJECT_ROOT]" already exists.

Options:
1. Choose a different location
2. Use existing directory (must be empty)

What would you like to do?
```

---

## Important Notes

### Directory Structure Summary

**PROJECT_ROOT** contains everything:
- `.git/` - Git repository for your content
- `.gitignore` - Excludes FW_ROOT/
- `start-authoring.*` - Launch scripts
- `FW_ROOT/` - Framework (separate git repo, excluded from PROJECT_ROOT's git)
- `[BOOKS_DIR_NAME]/` - Your books (default: My-Books)
- `.config/` - Configuration (CONFIG_ROOT)

### What Gets Tracked in Git

**In PROJECT_ROOT git:**
- ✅ [BOOKS_DIR_NAME]/ (all book content)
- ✅ .config/ (configuration files)
- ✅ start-authoring scripts
- ❌ FW_ROOT/ (excluded via .gitignore - it's a separate repo)

**In FW_ROOT git:**
- ✅ Framework files (Process/, VERSION, etc.)
- ❌ No user content

### Framework Updates

From CONFIG_ROOT, framework updates are checked automatically by /fw-init.
Manual check: Run this configure.md from CONFIG_ROOT.

---

**Ready to configure your framework installation?**

---

*Framework Version: 0.16.1*
*Configuration Script: configure.md*
