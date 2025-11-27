# Framework Configuration

**AI-Assisted Nonfiction Authoring Framework v0.14.3**

---

## Environment Support

This configuration supports both **Claude Desktop** and **Claude Code CLI**.

**Detect your environment:**
- **Claude Desktop:** File operations via MCP Filesystem, CLI commands via copy blocks
- **Claude Code CLI:** Direct execution of all commands

**How this works:**
1. Steps 0-3 work in both environments (Q&A and verification)
2. Steps 4+ require CLI commands → Desktop users get **copy blocks**
3. Desktop users paste copy blocks into Claude Code CLI for execution
4. Users are NEVER expected to paste directly into bash/cmd/PowerShell

---

## What This Does

This configuration script will:

1. **Confirm date** - Verify system date is correct
2. **Check required tools** - Verify git and jq are installed
3. **Verify framework installation** - Check all required files are present
4. **Check git status** - Warn if uncommitted changes exist (for updates)
5. **Apply migrations** (updates only) - Update project structure for new version
6. **Clean outdated files** (updates only) - Remove obsolete framework files
7. **Setup git repository** - Initialize if not present
8. **Connect to remote** (optional) - Help you set up GitHub/GitLab remote
9. **Discover export tools** (optional) - Detect pandoc/typst for exports
10. **Create manifest/update version** - Track installation or update
11. **Create initial commit** - Commit framework files to git
12. **Provide next steps** - Guide you to start writing

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
2. **jq** - JSON processing (required for initialization scripts)

---

**Run the tool detection script:**

**If in Claude Code CLI:** Execute directly:
```bash
bash scripts/detect-tools.sh .config/manifest.json
```

**If in Claude Desktop:** Provide this command for user to paste into Claude Code CLI:
```
bash scripts/detect-tools.sh .config/manifest.json
```
Tell user: "Copy this command and paste it into Claude Code CLI. Return here with the output."

**Analyze the output:**
- `✓ Git detected` and `✓ jq detected` → Proceed to Step 1
- `✗ Git not found` or `✗ jq not found` → Show installation instructions below

---

#### Installation Instructions (only if tools are missing)

**Windows:**

**Git (if missing):**
1. Download from: https://git-scm.com/download/win
2. Run the installer, accept all defaults

**jq (if missing):**
In Claude Code CLI, run:
```
winget install jqlang.jq
```

Or manual download:
1. Go to: https://jqlang.org/download/
2. Download "jq-win64.exe"
3. Rename to "jq.exe"
4. Move to C:\Program Files\Git\usr\bin\

After installing: Close and reopen terminals, say "done"

**macOS (in Claude Code CLI):** `brew install git jq`

**Linux (in Claude Code CLI):** `sudo apt install git jq`

**WAIT for user to say "done" before continuing.**

---

**When all required tools are confirmed:** Proceed to Step 1.

---

### Step 1: Verify Current Directory

I will:
1. Run `pwd` to determine actual working directory
2. Use that directory for all operations
3. Verify I'm in a suitable location for a book project

### Step 2: Check Framework Installation

I will verify these framework files exist:
- `Process/` directory
- `.claude/agents/book-writing-assistant.md`
- `INSTALLATION.md`
- `CLAUDE.md`
- `system-instructions.md`
- `.gitignore`
- `Process/Templates/.config/manifest.json` (template for creating user manifest)

If any are missing, I'll report the issue and stop.

**Note:** `.config/manifest.json` is NOT checked here - it will be created in Step 3.

### Step 3: Detect Installation Type and Create/Update Manifest

I will:
1. **Create `.config/` directory if it doesn't exist:**
   ```bash
   mkdir -p .config
   ```
2. Check if `.config/manifest.json` exists in project
   - If not, check for legacy `.nonfiction-manifest.json` in root
3. **If manifest does NOT exist:**
   - Read `Process/Templates/.config/manifest.json`
   - Create `.config/manifest.json` from template
   - This is a **New Installation**
4. **If manifest DOES exist:**
   - Read existing `.config/manifest.json` (or migrate from `.nonfiction-manifest.json`)
   - Preserve `installedVersion` and `installedDate` (installation history)
   - Update only `frameworkVersion` and `releaseDate` from template
   - Add current update to `updateHistory` array
   - This is an **Update Installation**
5. **If migrating from v0.12.0 or earlier:**
   - Move `.nonfiction-manifest.json` → `.config/manifest.json`
   - Update structure to match new template
6. Proceed with appropriate workflow

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

**For NEW installations:** Skip to Step 5. Say:
```
Step 4: Skipped (new installation - no git status check needed)
```

**For UPDATES**, I will:
1. Run `git status`
2. Check for uncommitted changes
3. **If found**: Stop and warn you to commit first
4. **If clean**: Proceed with update

### Step 4.5: Apply Migrations (Updates Only)

**For NEW installations:** Skip to Step 5. Say:
```
Step 4.5: Skipped (new installation - no migrations needed)
```

**This step only runs when updating from an older version.**

**Important: Migrations are applied in version order.** If you skip multiple versions (e.g., 0.10.0 → 0.11.1), all intermediate migrations will be applied sequentially:
- 0.10.0 → 0.10.1
- 0.10.1 → 0.11.0
- 0.11.0 → 0.11.1

This ensures your project structure is updated correctly through each version's changes.

I will:
1. Read `.config/migrations.json` to get available migrations
2. Read `.config/manifest.json` to check:
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
   - **If fails**: **⏸️ STOP AND ASK USER:** "Migration step failed. (retry/abort)"
     - **WAIT for user response**
     - retry: Try again
     - abort: Stop entire process (user must fix before continuing)
   - Track successful changes
6. Track applied migrations in `.config/manifest.json`
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
Framework version: 0.12.1

Found 4 pending migrations:
1. migration_0.10.0_to_0.10.1 (3 changes)
2. migration_0.10.1_to_0.11.0 (2 changes)
3. migration_0.11.0_to_0.11.1 (1 change)
4. migration_0.11.1_to_0.12.1 (0 changes - documentation only)

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

### Step 4.7: Clean Outdated Framework Files (Updates Only)

**For NEW installations:** Skip to Step 5. Say:
```
Step 4.7: Skipped (new installation - no cleanup needed)
```

**This step only runs when updating from an older version.**

After applying migrations, I will clean up outdated framework files that are no longer part of the current version.

I will:

1. **Read framework files manifest:**
   ```bash
   cat Process/Templates/framework_files_manifest.json
   ```

2. **Identify files to remove:**
   - Scan `Process/` directory for all existing files
   - Compare against manifest's expected files list
   - Build list of files NOT in manifest (outdated)
   - Exclude user-created files (anything with `_chg.md` is framework)

3. **Create backup before deletion:**
   ```bash
   # Create backup directory with timestamp
   mkdir -p ".framework-cleanup-backup/[date]"

   # Copy files to be removed to backup
   for file in [files-to-remove]; do
     cp "$file" ".framework-cleanup-backup/[date]/"
   done
   ```

4. **Display files to be removed and ask user:**

   **⏸️ STOP AND ASK USER:**
   ```
   📦 Framework Cleanup

   The following outdated framework files will be removed:

   Process/Prompts/Old_Prompt_Name.md
   Process/_COMMON/Deprecated_Module.md
   Process/Templates/Obsolete_Template.md

   Total: 3 files

   ✅ Backup created: .framework-cleanup-backup/[date]/

   These files are from previous framework versions and are no longer used.
   Proceed with cleanup? (yes/no)
   ```

   **WAIT for user response before continuing.**

5. **Remove outdated files (if user says "yes"):**
   ```bash
   # Remove each outdated file
   for file in [files-to-remove]; do
     rm "$file"
   done
   ```

6. **Report results:**
   ```
   ✅ Cleanup Complete

   Removed: 3 outdated framework files
   Backup: .framework-cleanup-backup/[date]/

   Your Process/ directory is now clean and matches version [NEW_VERSION].
   ```

**Files NEVER removed:**
- Anything outside `Process/` directory (user content protected)
- `.claude/settings.local.json` (user-specific settings)
- `_chg.md` files in user's Manuscript/ (user change tracking)
- User's book content (Chapters/, FrontMatter/, BackMatter/, etc.)

**Example cleanup scenarios:**

**Scenario 1: Prompt renumbering**
- User upgrading from v0.9.2 (11 prompts) → v0.12.1 (16 prompts)
- Old: `Process/Prompts/Prompt_5_Compile.md`
- New: `Process/Prompts/Prompt_7_Compile.md`
- Result: Old `Prompt_5_Compile.md` removed (now at Prompt_7)

**Scenario 2: Module additions**
- User upgrading from v0.10.0 (14 modules) → v0.11.0 (16 modules)
- New modules added: `15_Visual_Asset_Management_Protocol.md`, `16_Citation_Management_Protocol.md`
- No old modules removed (only additions)
- Result: No cleanup needed

**Scenario 3: Deprecated templates**
- User upgrading from v0.9.0 → v0.11.0
- Old template renamed or removed
- Result: Old template file removed, new one already in place

**Safety features:**
- Backup created before ANY deletions
- User confirmation required before cleanup
- Detailed list of what will be removed
- Option to skip cleanup (advanced users)
- `.framework-cleanup-backup/` added to .gitignore automatically

### Step 5: Git Repository Setup

**Note:** Git was verified in Step 0.5.

**Check git status:**

1. Check if `.git` directory exists
2. If `.git` exists: Check if this was cloned from the distribution repo
3. If `.git` doesn't exist: Initialize new repository

---

**Case A: Cloned from Distribution Repo**

If `.git` exists, check if `origin` points to `author-nonfiction-dist`:

**If in Claude Code CLI:** Execute directly:
```bash
git remote get-url origin 2>/dev/null | grep -q "author-nonfiction-dist" && echo "DIST_CLONE=true" || echo "DIST_CLONE=false"
```

**If in Claude Desktop:** Provide this command for user to paste into Claude Code CLI:
```
git remote get-url origin 2>/dev/null | grep -q "author-nonfiction-dist" && echo "DIST_CLONE=true" || echo "DIST_CLONE=false"
```

**If `DIST_CLONE=true`:**

Rename `origin` to `upstream` and disable push (users can't push to dist repo):

**If in Claude Code CLI:** Execute directly:
```bash
git remote rename origin upstream && git remote set-url --push upstream no-push-access
```

**If in Claude Desktop:** Provide this command:
```
git remote rename origin upstream && git remote set-url --push upstream no-push-access
```

Report:
```
✓ Distribution repo detected
✓ Remote renamed: origin → upstream (fetch-only)

Result:
$ git remote -v
upstream  https://github.com/scooter-indie/author-nonfiction-dist.git (fetch)
upstream  no-push-access (push)

Framework updates: git pull upstream main
Your book repo: git remote add origin [your-repo-url]
```

Then **skip to Step 7** (Remote setup not needed - upstream is already configured).

---

**Case B: Existing Git Repo (not from dist)**

If `.git` exists but `DIST_CLONE=false`:
- This is an existing project being updated
- No remote changes needed
- Report: `✓ Existing git repository detected`

---

**Case C: No Git Repo**

If `.git` does NOT exist, initialize:

**If in Claude Code CLI:** Execute directly:
```bash
git init && git branch -M main
```

**If in Claude Desktop:** Provide this command for user to paste into Claude Code CLI:
```
git init && git branch -M main
```
Tell user: "Copy and paste into Claude Code CLI, then return with the result."

Report: `✓ Git repository initialized`

### Step 6: Remote Repository Setup

**Note:** If you cloned from the distribution repo (Case A in Step 5), `upstream` is already configured for framework updates. This step lets you add your own `origin` for backing up your book.

**⏸️ STOP AND ASK USER:**
```
Step 6: Remote Repository Setup

Do you want to connect this project to a remote git repository for your book (GitHub, GitLab, etc.)?

Options:
1. "no" or "skip" - Work locally only (you handle backups)
2. "github" - Create/connect to GitHub repository
3. "gitlab" - Create/connect to GitLab repository
4. "url [your-url]" - I already have a repository URL
```

**WAIT for user response before continuing.**

**If user says "no" or "skip":**
- Tell user: "Working locally. You're responsible for backups."
- Continue to Step 7.

**If user says "github" or "gitlab":**

**⏸️ ASK USER:** "Do you want to create a new repository or connect to an existing one?"
- "new" - Create new repository
- "existing" - Connect to existing repository URL

**WAIT for response.**

**For new repository:**

**If in Claude Code CLI:** Execute directly:

For GitHub:
```bash
gh auth login
gh repo create my-book --private --source=. --remote=origin
```

For GitLab:
```bash
glab auth login
glab repo create my-book --private
```

**If in Claude Desktop:** Provide these commands for user to paste into Claude Code CLI:

For GitHub:
```
gh auth login
```
Then after authentication:
```
gh repo create my-book --private --source=. --remote=origin
```

For GitLab:
```
glab auth login
```
Then after authentication:
```
glab repo create my-book --private
```

**For existing repository or "url [your-url]":**
1. Get the URL from user
2. Add remote and verify

**If in Claude Code CLI:** Execute directly:
```bash
git remote add origin [url]
git branch -M main
git remote -v
```

**If in Claude Desktop:** Provide these commands (replace [url] with actual URL):
```
git remote add origin [url]
git branch -M main
git remote -v
```

**Note**: I will NOT push to remote. Use Prompt 12 (Git Operations) when ready.

### Step 7: Export Tool Discovery (Optional)

**Note:** Git was already verified in Step 0.5. This step focuses on **optional** export tools.

**⏸️ STOP AND ASK USER:**

Ask the user:
```
Step 7: Export Tool Discovery (Optional)

Export tools (pandoc, typst) enable Prompt 9 to export your manuscript to DOCX, PDF, and EPUB formats.

Would you like to detect export tools now?
- "yes" or "detect" - Run tool detection
- "skip" - Skip this step (you can run detection later)
```

**WAIT for user response before continuing.**

**If user says "yes" or "detect":**

**If in Claude Code CLI:** Execute directly:
```bash
bash scripts/detect-tools.sh .config/manifest.json
```

**If in Claude Desktop:** Provide this command:
```
bash scripts/detect-tools.sh .config/manifest.json
```
Tell user: "Copy and paste into Claude Code CLI, then return with the result."

The script will confirm git (already verified) and check for pandoc/typst availability.

Display results and continue to Step 8.

**If user says "skip":**

Tell user: "Skipping tool detection. You can run tool detection later from Claude Code CLI."

Continue to Step 8.

### Step 8: Update Manifest

**For New Installations:**
I will update `.config/manifest.json`:
```json
{
  "frameworkVersion": "0.14.3",
  "installedVersion": "0.14.3",
  "installedDate": "[current-date]",
  "lastUpdated": "[current-date]",
  "installationMethod": "configure.md",
  "configureCompleted": true,
  "toolsAvailable": {
    "git": true,
    "pandoc": false,
    "typst": false
  }
}
```

**For Updates:**
I will:
1. Read current `installedVersion` from manifest
2. Display changelog (read from `CHANGELOG.md`)
3. Show what's changed between your version and the new version
4. Update manifest:
```json
{
  "frameworkVersion": "0.14.3",
  "installedVersion": "0.14.3",
  "installedDate": "[original-date-preserved]",
  "lastUpdated": "[current-date]",
  "installationMethod": "configure.md",
  "configureCompleted": true,
  "toolsAvailable": {
    "git": true,
    "pandoc": true,
    "typst": false
  }
}
```

### Step 9: Create Git Commit

**Note:** Git repository was initialized in Step 5. Now we create the initial commit.

**If in Claude Code CLI:** Execute directly:

**For New Installations:**
```bash
git add . && git commit -m "Initialize nonfiction framework v0.14.3

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

**For Updates:**
```bash
git add . && git commit -m "Update framework to v0.14.3

See CHANGELOG.md for details.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

**If in Claude Desktop:** Provide these commands:

**For New Installations:**
```
git add . && git commit -m "Initialize nonfiction framework v0.14.3

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

**For Updates:**
```
git add . && git commit -m "Update framework to v0.14.3

See CHANGELOG.md for details.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```
Tell user: "Copy and paste into Claude Code CLI to create the commit."

### Step 10: Verify Book Writing Assistant

I will:
1. Verify `.claude/agents/book-writing-assistant.md` exists
2. Confirm it will execute at Claude Code session startup
3. Inform you that this agent will assist with your writing sessions

### Step 11: Configuration Complete

I will provide:

**For New Installations:**
```
✅ Configuration Complete!

Framework v0.14.3 installed successfully.

📁 Current directory: [pwd-result]
🔧 Git repository: Initialized
🌐 Remote repository: [Connected to X / Not configured / Working locally]
⬆️ Framework updates: [If cloned from dist: "git pull upstream main" / Otherwise: omit this line]
✅ Book writing assistant: Ready

⚠️ IMPORTANT: At the start of every FUTURE Claude Code session, run:
   /fw-init
   This loads the framework and prepares Claude for prompt execution.
   For THIS session, you're already set up and ready to proceed.

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
💡 Tip: Update framework with "git pull upstream main" when new versions release!
```

**For Updates:**
```
✅ Framework Updated Successfully!

Updated from v[old] to v0.14.3

📁 Current directory: [pwd-result]
🔧 Git repository: Update committed
📝 Your book content: Preserved
✅ Book writing assistant: Ready

📋 What Changed:
[Display relevant sections from CHANGELOG.md]

⚠️ IMPORTANT: At the start of every FUTURE Claude Code session, run:
   /fw-init
   This loads the framework and prepares Claude for prompt execution.
   For THIS session, you're already set up and ready to proceed.

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
1. Re-extract nonfiction-v0.14.3.zip to this directory
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

**If in Claude Code CLI:** Execute directly:
```bash
git add . && git commit -m "Save work before framework update"
```

**If in Claude Desktop:** Provide this command:
```
git add . && git commit -m "Save work before update"
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
- ✅ **Manifest**: .config/manifest.json (version tracking)
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

*Framework Version: 0.14.3*
*Configuration Script: configure.md*
