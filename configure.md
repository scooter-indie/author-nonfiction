# Framework Configuration

**AI-Assisted Nonfiction Authoring Framework v0.15.4**

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

This configuration script handles multiple scenarios:

**Fresh Install (from FW_ROOT):**
1. Set up BOOKS_ROOT directory for your books
2. Create configuration files
3. Initialize git repository
4. Generate startup scripts

**Framework Update (from FW_ROOT):**
1. Check for available updates
2. Pull latest framework version
3. Apply migrations to BOOKS_ROOT

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
2. **jq** - JSON processing (optional but recommended)

**Check git:**
```bash
git --version
```

**Check jq (optional):**
```bash
jq --version
```

**If git not found:** Show installation instructions and wait for user.

---

### Step 1: Installation Mode Detection

**Detect which mode to use based on current directory:**

Check for these indicators:

1. **VERSION file exists?** → Running in FW_ROOT (framework directory)
2. **.config/fw-location.json exists?** → Running in BOOKS_ROOT

**Mode Detection Logic:**

```
if VERSION file exists:
    MODE = "FW_ROOT"
    if git fetch shows updates available:
        SUBMODE = "Update Available"
    else:
        SUBMODE = "Fresh Install" (need to create BOOKS_ROOT)

elif .config/fw-location.json exists:
    MODE = "BOOKS_ROOT"
    SUBMODE = "Reconfiguration"

else:
    ERROR = "Not a valid framework directory"
```

**Report detection result:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Installation Mode Detection
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[✓] VERSION file: [found/not found]
[✓] .config/fw-location.json: [found/not found]

Detected Mode: [FW_ROOT | BOOKS_ROOT]
Submode: [Update Available | Fresh Install | Reconfiguration]

Proceeding with [mode] workflow...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Based on detected mode, proceed to appropriate section:**
- **FW_ROOT + Update Available** → Step 2A (Update Workflow)
- **FW_ROOT + Fresh Install** → Step 2B (BOOKS_ROOT Setup)
- **BOOKS_ROOT** → Step 2C (Reconfiguration)

---

## Step 2A: Update Workflow (FW_ROOT with Updates Available)

**This step runs when configure.md detects it's in FW_ROOT with available updates.**

### 2A.1: Fetch Latest Version

```bash
git fetch origin
```

### 2A.2: Compare Versions

```bash
# Read local version
LOCAL_VERSION=$(cat VERSION)

# Read remote version
REMOTE_VERSION=$(git show origin/main:VERSION)

echo "Local: $LOCAL_VERSION"
echo "Remote: $REMOTE_VERSION"
```

### 2A.3: Show Changelog Preview

**⏸️ ASK USER:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Framework Update Available
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Current version: [LOCAL_VERSION]
Available version: [REMOTE_VERSION]

Changes in this update:
[Read and display relevant section from CHANGELOG.md]

Proceed with update? (yes/no)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**WAIT for user response.**

**If no:** Exit configuration.

### 2A.4: Pull Updates

```bash
git pull origin main
```

### 2A.5: Apply Migrations (if any)

1. Check `Process/migrations/` for applicable migrations
2. Read migrations between LOCAL_VERSION and REMOTE_VERSION
3. Execute each migration in order

### 2A.6: Update BOOKS_ROOT Configuration

**⏸️ ASK USER:**

```
Where is your BOOKS_ROOT directory?

This is where your books are stored.
Enter the path (or "skip" if you don't have BOOKS_ROOT set up yet):
```

**WAIT for user response.**

**If user provides path:**
1. Verify the path exists
2. Verify `.config/fw-location.json` exists there
3. Update `frameworkVersion` in that file
4. Update `lastUpdateCheck` to CONFIRMED_DATE

```bash
# Example update command (executed in BOOKS_ROOT)
cd [BOOKS_ROOT]
# Read and update fw-location.json with new version
```

### 2A.7: Report Completion

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ Framework Updated Successfully
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Updated: [LOCAL_VERSION] → [REMOTE_VERSION]
Migrations applied: [list or "None required"]
BOOKS_ROOT updated: [path or "Skipped"]

Next steps:
1. Start Claude Code CLI in BOOKS_ROOT: cd [BOOKS_ROOT] && claude
2. Run /fw-init to begin working
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**End of Update Workflow.**

---

## Step 2B: BOOKS_ROOT Setup (Fresh Install from FW_ROOT)

**This step runs when configure.md is in FW_ROOT and BOOKS_ROOT doesn't exist yet.**

### 2B.1: Get BOOKS_ROOT Location

**⏸️ ASK USER:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
BOOKS_ROOT Setup
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Where would you like to store your books?

This directory will contain:
  • All your book projects
  • Configuration files
  • Git repository for your content

Examples:
  • Windows: E:\My-Books
  • macOS: ~/Documents/My-Books
  • Linux: ~/books

Enter path for BOOKS_ROOT:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**WAIT for user response.** Store as `BOOKS_ROOT`.

### 2B.2: Create BOOKS_ROOT Directory

**If in Claude Code CLI:** Execute directly:
```bash
mkdir -p "[BOOKS_ROOT]"
mkdir -p "[BOOKS_ROOT]/.config"
```

**If in Claude Desktop:** Provide commands for user to execute.

### 2B.3: Create Configuration Files

**Create .config/fw-location.json:**

Read the current directory as FW_ROOT and VERSION file content:

```json
{
  "frameworkRoot": "[CURRENT_DIRECTORY]",
  "frameworkVersion": "[VERSION_FILE_CONTENT]",
  "lastUpdateCheck": "[CONFIRMED_DATE]"
}
```

Write to `[BOOKS_ROOT]/.config/fw-location.json`.

**Create .config/books-registry.json:**

```json
{
  "version": "1.0",
  "activeBook": null,
  "books": []
}
```

Write to `[BOOKS_ROOT]/.config/books-registry.json`.

**Create .config/settings.json:**

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

Write to `[BOOKS_ROOT]/.config/settings.json`.

### 2B.4: Create FW_ROOT Configuration

**Create FW_ROOT/.config directory and settings.json:**

```bash
mkdir -p "[FW_ROOT]/.config"
```

```json
{
  "booksRoot": "[BOOKS_ROOT]",
  "version": "[VERSION_FILE_CONTENT]",
  "configured": "[CONFIRMED_DATE]"
}
```

Write to `[FW_ROOT]/.config/settings.json`.

### 2B.5: Copy Start Scripts to FW_ROOT

Copy the start scripts from templates to FW_ROOT:

```bash
cp Process/Templates/start-authoring.bat "[FW_ROOT]/start-authoring.bat"
cp Process/Templates/start-authoring.sh "[FW_ROOT]/start-authoring.sh"
cp Process/Templates/bp-start-authoring.bat "[FW_ROOT]/bp-start-authoring.bat"
cp Process/Templates/bp-start-authoring.sh "[FW_ROOT]/bp-start-authoring.sh"
chmod +x "[FW_ROOT]/start-authoring.sh" "[FW_ROOT]/bp-start-authoring.sh"
```

**Note:** On Windows, only copy .bat files. On macOS/Linux, only copy .sh files.

### 2B.6: Copy CLAUDE.md to FW_ROOT

Copy `Process/Templates/FW_ROOT_CLAUDE_template.md` to `[FW_ROOT]/CLAUDE.md`.

**Note:** BOOKS_ROOT does not need a CLAUDE.md since users start Claude Code from FW_ROOT using the start scripts.

### 2B.7: Create Archive Directory

```bash
mkdir -p "[BOOKS_ROOT]/Archive"
```

Copy `Process/Templates/Archive_README_template.md` to `[BOOKS_ROOT]/Archive/README.md`.

### 2B.8: Initialize Git Repository

**⏸️ ASK USER:**

```
Initialize git repository in BOOKS_ROOT?

This enables version control for all your books.
Recommended: yes

(yes/no)
```

**WAIT for user response.**

**If yes:**
```bash
cd "[BOOKS_ROOT]"
git init
git branch -M main
```

### 2B.9: Remote Repository Setup (Optional)

**⏸️ ASK USER:**

```
Do you want to connect BOOKS_ROOT to a remote git repository?

This enables backup to GitHub/GitLab.

Options:
1. "no" or "skip" - Work locally only
2. "github" - Create/connect to GitHub
3. "url [your-url]" - I have a repository URL
```

**WAIT for user response.**

**If user provides URL or github:**
```bash
cd "[BOOKS_ROOT]"
git remote add origin [URL]
```

### 2B.10: Create Initial Commit

```bash
cd "[BOOKS_ROOT]"
git add .
git commit -m "Initialize books repository

Created by AI-Assisted Nonfiction Authoring Framework v[VERSION]

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

### 2B.11: Report Completion

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ BOOKS_ROOT Setup Complete
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Framework Location (FW_ROOT): [FW_ROOT path]
Books Location (BOOKS_ROOT): [BOOKS_ROOT path]
Framework Version: [VERSION]

Created in BOOKS_ROOT:
  ✓ .config/fw-location.json
  ✓ .config/books-registry.json
  ✓ .config/settings.json
  ✓ Archive/ directory
  ✓ Git repository initialized
  [✓ Remote repository connected (if configured)]

Created in FW_ROOT:
  ✓ .config/settings.json (points to BOOKS_ROOT)
  ✓ CLAUDE.md (framework instructions)
  ✓ start-authoring scripts (start-authoring.bat/.sh)
  ✓ bypass-permissions scripts (bp-start-authoring.bat/.sh)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📚 Next Steps:

1. Start Claude Code using the start script in FW_ROOT:
   Windows: Double-click start-authoring.bat (or bp-start-authoring.bat for bypass mode)
   macOS/Linux: ./start-authoring.sh (or ./bp-start-authoring.sh for bypass mode)

2. The script will:
   - Change to FW_ROOT directory
   - Launch Claude Code with /fw-init reminder
   - (bp- variants bypass permission prompts for trusted environments)

3. Claude will prompt you to run /fw-init

4. Create your first book:
   Say "Execute Prompt 1" or "Create new book"

For Claude Desktop users:
1. Configure MCP Filesystem with both directories:
   - [FW_ROOT]
   - [BOOKS_ROOT]
2. See Documentation/Claude_Desktop_Setup.md for details

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**End of BOOKS_ROOT Setup Workflow.**

---

## Step 2C: Reconfiguration (Running from BOOKS_ROOT)

**This step runs when configure.md is executed from an existing BOOKS_ROOT.**

### 2C.1: Read Current Configuration

Read `.config/fw-location.json` to get FW_ROOT path.
Read `.config/books-registry.json` to get book list.

### 2C.2: Present Options

**⏸️ ASK USER:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
BOOKS_ROOT Reconfiguration
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Current configuration:
  Framework: [FW_ROOT path]
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

### Not a Valid Framework Directory

```
❌ Configuration Failed: Invalid Directory

This directory doesn't appear to be a framework installation or books root.

Expected one of:
- VERSION file (FW_ROOT - framework directory)
- .config/fw-location.json (BOOKS_ROOT - books directory)

Solutions:
1. Clone the framework: git clone https://github.com/scooter-indie/author-nonfiction-dist.git
2. Navigate to an existing installation
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

### BOOKS_ROOT Path Invalid

```
❌ Invalid BOOKS_ROOT Path

The path you specified doesn't exist or isn't accessible:
[path]

Please verify:
1. The path is correct
2. You have write permissions
3. Parent directories exist

Try again with a valid path.
```

---

## Important Notes

### Directory Structure

**FW_ROOT (Framework Directory):**
- Framework in FW_ROOT (read-only, updateable)
- Contains Process/, scripts/, VERSION, etc.
- Start Claude Code from here using start scripts

**BOOKS_ROOT (Books Directory):**
- Your book content lives here
- Multiple books in one repository
- Centralized book registry in .config/

### What Gets Tracked in Git

**In BOOKS_ROOT:**
- ✅ All book content (Manuscript/, Research/)
- ✅ Configuration (.config/)
- ❌ Nothing from FW_ROOT (that's a separate repo)

**In FW_ROOT:**
- ✅ Framework files (Process/, VERSION, etc.)
- ❌ No user content

### Framework Updates

```bash
cd [FW_ROOT]
claude
# Then say: "Run configure.md"
```

---

**Ready to configure your framework installation?**

---

*Framework Version: 0.15.4*
*Configuration Script: configure.md*
