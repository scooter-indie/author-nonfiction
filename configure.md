# Framework Configuration

**HYBRID:** Works in Claude Desktop with copy/paste git commands throughout

**AI-Assisted Nonfiction Authoring Framework v0.11.1**

**Claude Desktop Compatibility:**
- ✅ All file verification via MCP Filesystem
- ✅ All file operations via MCP Filesystem
- ⚠️ Requires copy/paste git commands: init, add, commit, remote add
- 📋 Works 70% in Desktop

**Claude Code CLI users:**
- ✅ Full automation with direct git execution
- 📋 Works 100% in CLI

---

**CRITICAL INSTRUCTION FOR CLAUDE CODE:**

**BEFORE DOING ANYTHING ELSE:** Run `pwd` to verify your actual current working directory. Ignore any environment info about working directory - use only the result from `pwd` for all subsequent operations. All file paths and operations MUST be relative to the directory returned by `pwd`.

---

## What This Does

This configuration script will:

1. **Verify framework installation** - Check all required files are present
2. **Check git status** - Warn if uncommitted changes exist (for updates)
3. **Setup git repository** - Initialize if not present
4. **Connect to remote** (optional) - Help you set up GitHub/GitLab remote
5. **Create manifest/update version** - Track installation or update
6. **Verify Claude Code integration** - Ensure book-writing-assistant is ready
7. **Create initial commit** - Verify git is working
8. **Provide next steps** - Guide you to start writing

---

## Configuration Process

### Step 1: Verify Current Directory

I will:
1. Run `pwd` to determine actual working directory
2. Use that directory for all operations
3. Verify I'm in a suitable location for a book project

### Step 2: Check Framework Installation

I will verify these files exist:
- `.nonfiction-manifest.json`
- `Process/` directory
- `.claude/agents/book-writing-assistant.md`
- `INSTALLATION.md`
- `CLAUDE.md`
- `system-instructions.md`
- `.gitignore`

If any are missing, I'll report the issue and stop.

### Step 3: Detect Installation Type and Create/Update Manifest

I will:
1. Check if `.nonfiction-manifest.json` exists in project root
2. **If manifest does NOT exist:**
   - Read `Process/Templates/manifest_template.json`
   - Create `.nonfiction-manifest.json` from template
   - This is a **New Installation**
3. **If manifest DOES exist:**
   - Read existing `.nonfiction-manifest.json`
   - Preserve `installedVersion` and `installedDate` (installation history)
   - Update only `frameworkVersion` and `releaseDate` from template
   - Add current update to `updateHistory` array
   - This is an **Update Installation**
4. Proceed with appropriate workflow

**Manifest Structure:**
```json
{
  "framework": "AI-Assisted Nonfiction Authoring",
  "frameworkVersion": "0.10.1",          // Current framework version
  "installedVersion": "0.9.0",          // First installation version (preserved)
  "installedDate": "2025-11-15",        // First installation date (preserved)
  "releaseDate": "2025-11-19",          // Latest release date
  "releaseUrl": "https://...",
  "updateHistory": [                     // Track all updates
    {
      "from": "0.9.0",
      "to": "0.9.2",
      "date": "2025-11-19"
    }
  ],
  "appliedMigrations": [                 // Track applied migrations
    "migration_0.9.0_to_0.9.2",
    "migration_0.10.0_to_0.10.1"
  ]
}
```

**IMPORTANT:** The manifest file is NEVER included in release zips. It is created/updated by configure.md to preserve installation history.

### Step 4: Git Status Check (Updates Only)

For updates, I will:
1. Run `git status`
2. Check for uncommitted changes
3. **If found**: Stop and warn you to commit first
4. **If clean**: Proceed with update

### Step 4.5: Apply Migrations (Updates Only)

**This step only runs when updating from an older version.**

**Important: Migrations are applied in version order.** If you skip multiple versions (e.g., 0.10.0 → 0.11.1), all intermediate migrations will be applied sequentially:
- 0.10.0 → 0.10.1
- 0.10.1 → 0.11.0
- 0.11.0 → 0.11.1

This ensures your project structure is updated correctly through each version's changes.

I will:
1. Read `.nonfiction-migrations.json` to get available migrations
2. Read `.nonfiction-manifest.json` to check:
   - Current `installedVersion` or `frameworkVersion`
   - `appliedMigrations` array (list of already-applied migration IDs)
3. Determine which migrations need to be applied:
   - Find user's current version (from manifest)
   - Find all migrations from current version to new version
   - **Sort migrations in chronological order** (by version sequence)
   - Filter out already-applied migrations (check `appliedMigrations` array)
   - **Apply ALL pending migrations in order**
4. For each pending migration (in version order):
   - Display what will change and why
   - **AUTOMATICALLY apply the migration** (migrations are NOT optional)
   - Execute each change in the migration
5. For each change within a migration:
   - Attempt to apply automatically
   - **If fails**: Ask "Migration step failed. (retry/abort)"
     - retry: Try again
     - abort: Stop entire process (user must fix before continuing)
   - Track successful changes
6. Track applied migrations in `.nonfiction-manifest.json`
7. If any steps failed and user chose abort:
   - Display manual fix instructions immediately
   - Create `MANUAL_MIGRATION_STEPS.md` in project root
   - List all steps that need manual intervention
   - **STOP configuration** - user must fix issues before proceeding

**IMPORTANT: Migrations are NOT optional.** Framework upgrades require project structure updates to function correctly. If you encounter migration failures, you must resolve them before continuing.

**Supported Change Types:**

1. **`rename`**: Rename file or directory
   - Example: README.md → FW_README.md

2. **`delete`**: Delete file or directory
   - Example: Remove obsolete configuration file

3. **`gitignore_add`**: Add pattern to .gitignore
   - Example: Add FW_README.md to .gitignore

4. **`gitignore_remove`**: Remove pattern from .gitignore
   - Example: Remove README.md from .gitignore

5. **`add_to_config`**: Add/update setting in Project_Config.md
   - Example: Add `prompt_9_verbose: true`

6. **`update_content`**: Find and replace content in file
   - Example: Update deprecated setting names

**Example Migration Flow (Single Version Jump):**

```
User's current version: 0.10.0
Framework version: 0.10.1

Found 1 pending migration: migration_0.10.0_to_0.10.1

──────────────────────────────────────────
Applying Migration: Separate framework README from user README
Changes: 3 steps (rename, gitignore_add, gitignore_remove)

Step 1/3: Rename README.md → FW_README.md
✓ Success

Step 2/3: Add FW_README.md to .gitignore
✓ Success

Step 3/3: Remove README.md from .gitignore
✓ Success

✓ Migration applied successfully!
```

**Example Migration Flow (Multi-Version Jump):**

```
User's current version: 0.10.0
Framework version: 0.11.1

Found 3 pending migrations:
1. migration_0.10.0_to_0.10.1 (3 changes)
2. migration_0.10.1_to_0.11.0 (2 changes)
3. migration_0.11.0_to_0.11.1 (1 change)

Applying all migrations in order...

────────────────────────────────────────
Migration 1/3: migration_0.10.0_to_0.10.1
Description: Separate framework README from user README
Changes: 3 steps

Step 1/3: Rename README.md → FW_README.md
✓ Success

Step 2/3: Add FW_README.md to .gitignore
✓ Success

Step 3/3: Remove README.md from .gitignore
✓ Success

✓ Migration 1/3 completed

────────────────────────────────────────
Migration 2/3: migration_0.10.1_to_0.11.0
Description: Update Project_Config.md with new settings
Changes: 2 steps

Step 1/2: Add prompt_11_verbose setting to Project_Config.md
✓ Success

Step 2/2: Update gitignore with new patterns
✓ Success

✓ Migration 2/3 completed

────────────────────────────────────────
Migration 3/3: migration_0.11.0_to_0.11.1
Description: Minor configuration updates
Changes: 1 step

Step 1/1: Update deprecated setting name
✓ Success

✓ Migration 3/3 completed

────────────────────────────────────────
All migrations completed successfully!
Applied: 3 migrations (6 total changes)
```

**If Steps Fail:**

```
Step 1/3: Rename README.md → FW_README.md
❌ Failed: README.md not found

Migration step failed. (retry/abort)
You: retry

[Attempting again...]
❌ Failed: README.md not found

Migration step failed. (retry/abort)
You: abort

──────────────────────────────────────────
⚠️ MIGRATION ABORTED

Configuration cannot continue until migration issues are resolved.

Manual steps saved to: MANUAL_MIGRATION_STEPS.md

REQUIRED ACTIONS:

1. Check if README.md exists
   - If it contains framework docs, rename to FW_README.md
   - If it contains YOUR book docs, leave as README.md

2. After fixing, run configure.md again
   - Migrations will resume from where they failed

❌ Configuration stopped. Fix issues and re-run configure.md.
```

**Note:** Migrations are mandatory. If a migration fails, you must resolve the issue before the framework can continue. This ensures your project structure remains compatible with the new framework version.

### Step 5: Git Repository Setup

I will check if git is installed:

**Git Not Found:**
- Provide installation instructions for your platform:
  - **Windows**: Download from https://git-scm.com/ or use `winget install Git.Git`
  - **macOS**: Install via Homebrew: `brew install git` or download from https://git-scm.com/
  - **Linux**: Use package manager: `sudo apt install git` or `sudo yum install git`
- Stop and wait for you to install git

**Git Found:**
- Check if `.git` directory exists
- If not: Run `git init`
- Verify git repository is ready

### Step 6: Remote Repository Setup

I will ask you about remote repository:

**Question:** "Do you want to connect this project to a remote git repository?"

**Option 1: No remote repository**
- You'll work locally only
- You're responsible for your own backups
- Configuration continues

**Option 2: Create new remote repository**

I'll ask: "Which platform?"
- **GitHub** (most common)
- **GitLab**
- **Other** (Bitbucket, self-hosted, etc.)

Then I'll provide instructions for **both methods**:

**Method A: Web UI (Recommended for beginners)**
- Step-by-step instructions for creating repo via web browser
- How to get the repository URL
- Wait for you to provide URL

**Method B: Command Line (Faster for developers)**

For GitHub:
```bash
# Install GitHub CLI if needed: https://cli.github.com/
gh auth login
gh repo create my-book --private --source=. --remote=origin
```

For GitLab:
```bash
# Install GitLab CLI if needed
glab auth login
glab repo create my-book --private
git remote add origin [returned-url]
```

After you provide the URL or confirm CLI setup:
- Verify remote is configured: `git remote -v`

**Option 3: Already have empty remote repository**

I'll ask: "What is your repository URL?"
- Example: `https://github.com/username/my-book.git`
- Example: `git@github.com:username/my-book.git`

Then I'll:
1. Verify the current directory has content to preserve
2. Add the remote: `git remote add origin [your-url]`
3. Set up tracking: `git branch -M main`

**Note**: I will NOT push to remote at this stage. You'll use Prompt 9 when ready to push.

### Step 7: Update Manifest

**For New Installations:**
I will update `.nonfiction-manifest.json`:
```json
{
  "frameworkVersion": "3.5.0",
  "installedVersion": "3.5.0",
  "installedDate": "[current-date]",
  "lastUpdated": "[current-date]"
}
```

**For Updates:**
I will:
1. Read current `installedVersion` from manifest
2. Display changelog (read from `CHANGELOG.md` or `Process/AI-Assisted_Nonfiction_Authoring_Process_chg.md`)
3. Show what's changed between your version and 3.5.0
4. Update manifest:
```json
{
  "frameworkVersion": "3.5.0",
  "installedVersion": "3.5.0",
  "previousVersion": "[old-version]",
  "installedDate": "[original-date]",
  "lastUpdated": "[current-date]"
}
```

### Step 8: Create Git Commit

**For Claude Code CLI users:**

I will automatically execute the git commit with appropriate message.

**For Claude Desktop users:**

I will provide you with the git command to run in Claude Code CLI.

**For New Installations:**

Open Claude Code CLI and say:
```
Run: git add . && git commit -m 'Initialize nonfiction framework v0.10.0

🤖 Generated with Claude Desktop

Co-Authored-By: Claude <noreply@anthropic.com>'
```

**For Updates:**

Open Claude Code CLI and say:
```
Run: git add .nonfiction-manifest.json && git commit -m 'Update framework from v[old] to v0.10.0

See CHANGELOG.md for details.

🤖 Generated with Claude Desktop

Co-Authored-By: Claude <noreply@anthropic.com>'
```

After running the command, verify commit succeeded with `git log -1`

### Step 9: Verify Book Writing Assistant

I will:
1. Verify `.claude/agents/book-writing-assistant.md` exists
2. Confirm it will execute at Claude Code session startup
3. Inform you that this agent will assist with your writing sessions

### Step 10: Configuration Complete

I will provide:

**For New Installations:**
```
✅ Configuration Complete!

Framework v3.5.0 installed successfully.

📁 Current directory: [pwd-result]
🔧 Git repository: Initialized
🌐 Remote repository: [Connected to X / Not configured / Working locally]
✅ Book writing assistant: Ready

📚 Next Steps:

1. Execute Prompt 1 to initialize your book project:
   - Say: "Execute Prompt 1" or "Initialize my book project"
   - This will ask you about your book (title, audience, TOC, style, etc.)
   - Creates your complete project structure

2. Available Prompts:
   [Read and list all prompts from Process/Prompts/ directory]

3. Useful Documentation:
   - Quick Reference: Process/Prompts/QUICK_REFERENCE.md
   - Complete Guide: Process/AI-Assisted_Nonfiction_Authoring_Process.md
   - Style Library: Process/Style_Examples.md

💡 Tip: Run Prompt 8 (Dashboard) weekly to track your progress!
```

**For Updates:**
```
✅ Framework Updated Successfully!

Updated from v[old] to v3.5.0

📁 Current directory: [pwd-result]
🔧 Git repository: Update committed
📝 Your book content: Preserved
✅ Book writing assistant: Ready

📋 What Changed:
[Display relevant sections from CHANGELOG.md]

📚 Next Steps:

1. Review the changes above
2. Continue your writing workflow with Prompt 3 (Modify File)
3. Run Prompt 6 (Consistency) to check for any issues
4. Use Prompt 9 when ready to push to remote

📖 Available Prompts:
[Read and list all prompts from Process/Prompts/ directory]

💡 Check Process/Prompts/QUICK_REFERENCE.md for new features!
```

---

## Error Handling

### Missing Framework Files

**If any required files are missing:**
```
❌ Configuration Failed: Missing Framework Files

The following required files are missing:
- [list missing files]

This suggests the framework was not fully extracted.

Solutions:
1. Re-extract nonfiction-v3.5.0.zip to this directory
2. Ensure all files are extracted (not just some)
3. Check file permissions

See INSTALLATION.md for detailed extraction instructions.
```

### Git Not Installed

```
⚠️ Git Not Found

Git is recommended but not required for using this framework.

To install git:
- Windows: https://git-scm.com/ or run: winget install Git.Git
- macOS: brew install git
- Linux: sudo apt install git (or your package manager)

After installing git, run this configuration again.

Or continue without git (not recommended - you'll have no version control).
```

### Uncommitted Changes (Updates)

```
⚠️ Uncommitted Changes Detected

You have uncommitted changes in your repository:
[show git status output]

Before updating the framework, you MUST commit your work.
```

Open Claude Code CLI and say:
```
Run: git add . && git commit -m 'Save work before framework update'
```

Then run this configuration again.

### Remote Connection Failed

```
❌ Remote Connection Failed

Could not connect to remote repository: [url]

Common issues:
1. Repository doesn't exist - create it first
2. Authentication failed - set up SSH key or personal access token
3. URL is incorrect - verify the URL

See: https://docs.github.com/en/authentication

You can configure the remote later using Prompt 9 (Git Operations).
```

---

## Important Notes

### What Gets Tracked in Git

Your git repository will track:
- ✅ **Your book content**: Manuscript/ directory (Chapters/, _TOC_/, FrontMatter/, BackMatter/, Quotes/, Style/, Inbox/, Drafts/, Exports/)
- ✅ **Your configuration**: Project_Config.md, Project_Metadata.md, Style_Guide.md
- ✅ **Change tracking**: All _chg.md files
- ✅ **Manifest**: .nonfiction-manifest.json (version tracking)
- ✅ **Claude agents**: .claude/agents/book-writing-assistant.md
- ❌ **Framework files**: Process/, system-instructions.md, INSTALLATION.md, CLAUDE.md

Framework files are in `.gitignore` - they only update when you install a new framework version.

### Remote Repository Safety

This configuration does NOT automatically push to remote. You control when to push using Prompt 9 (Git Operations).

### Date Confirmation

When the book-writing-assistant agent starts, it will ask you to confirm the current date to ensure accurate content generation.

---

**Ready to configure your framework installation?**

---

*Framework Version: 0.11.1*
*Configuration Script: configure.md*
