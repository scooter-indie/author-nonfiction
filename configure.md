# Framework Configuration

**HYBRID:** Works in Claude Desktop with copy/paste git commands throughout

**AI-Assisted Nonfiction Authoring Framework v0.9.0**

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

### Step 3: Detect Installation Type

I will:
1. Read `.nonfiction-manifest.json`
2. Check if `installedVersion` exists:
   - **Not found or null** → New Installation
   - **Found** → Update Installation
3. Proceed with appropriate workflow

### Step 4: Git Status Check (Updates Only)

For updates, I will:
1. Run `git status`
2. Check for uncommitted changes
3. **If found**: Stop and warn you to commit first
4. **If clean**: Proceed with update

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

**For New Installations:**
```bash
git add .
git commit -m "Initialize nonfiction framework v3.5.0

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

**For Updates:**
```bash
git add .nonfiction-manifest.json
git commit -m "Update framework from v[old] to v3.5.0

See CHANGELOG.md for details.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

Verify commit succeeded with `git log -1`

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

Before updating the framework, you MUST commit your work:

git add .
git commit -m "Save work before framework update"

Then run this configuration again.
```

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

*Framework Version: 0.9.0*
*Configuration Script: configure.md*
