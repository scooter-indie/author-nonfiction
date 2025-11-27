# Installation Guide

**AI-Assisted Nonfiction Authoring Framework v0.14.4**

---

## Choose Your Installation Method

This framework works with **both Claude Code CLI and Claude Desktop**. Choose the method that fits your workflow:

- **Claude Code CLI** (Recommended): Full automation, git integration, terminal-based
- **Claude Desktop** (Alternative): Visual interface, drag-and-drop files, copy/paste git commands

---

## Prerequisites

Before you begin, ensure you have:

1. **Choose ONE:**
   - **Claude Code CLI** - Download from [Claude Code website](https://claude.com/claude-code)
   - **Claude Desktop** - Download from [Claude Desktop](https://claude.ai/download)
2. **Git installed** (optional but recommended) - Download from [git-scm.com](https://git-scm.com/)
3. **Empty target directory** for your book project (e.g., `E:\Projects\my-book`)

---

## Installation Steps

### Step 1: Download the Framework

Download `nonfiction-v0.14.4.zip` from:
- **GitHub Releases**: https://github.com/scooter-indie/author-nonfiction/releases/latest

Save the zip file to your target directory.

### Step 2: Extract the Framework

**⚠️ IMPORTANT:** The zip contains files at the root level (no parent folder). Extract directly to your project directory, NOT into a subdirectory.

#### For New Installations:

**Windows (File Explorer - Extract All):**
1. Navigate to your project directory in File Explorer (e.g., `E:\Projects\my-book`)
2. Copy `nonfiction-v0.14.4.zip` into this directory
3. Right-click `nonfiction-v0.14.4.zip`
4. Select "Extract All..."
5. **CRITICAL:** Delete the suggested folder name so it extracts to current directory:
   - Windows suggests: `E:\Projects\my-book\nonfiction-v0.14.4`
   - **Change to:** `E:\Projects\my-book` (remove the `\nonfiction-v0.14.4` part)
6. Click "Extract"
7. Files will extract directly into `my-book\` directory

**Windows (7-Zip - Recommended):**
1. Navigate to your project directory in File Explorer
2. Copy `nonfiction-v0.14.4.zip` into this directory
3. Right-click `nonfiction-v0.14.4.zip`
4. Select "7-Zip" → "Extract Here"
5. Files extract directly into current directory (no subdirectory created)

**Windows (Command Line):**
```cmd
cd E:\Projects\my-book
tar -xf nonfiction-v0.14.4.zip
```

**macOS/Linux:**
```bash
cd /path/to/my-book
unzip nonfiction-v0.14.4.zip
```

#### For Updates (Overlaying Existing Installation):

**⚠️ CRITICAL: Before updating, you MUST:**
1. **Commit all your work to git**: `git commit -am "Save work before framework update"`
2. **Create a backup** of your entire project directory

**Windows (File Explorer - Extract All):**
1. Navigate to your project directory in File Explorer
2. Copy `nonfiction-v0.14.4.zip` into this directory
3. Right-click `nonfiction-v0.14.4.zip`
4. Select "Extract All..."
5. **CRITICAL:** Delete the suggested folder name so it extracts to current directory:
   - Windows suggests: `E:\Projects\my-book\nonfiction-v0.14.4`
   - **Change to:** `E:\Projects\my-book` (remove the `\nonfiction-v0.14.4` part)
6. Click "Extract"
7. When prompted about overwriting files, select **"Replace the files in the destination"** or **"Yes to All"**

**Windows (7-Zip - Recommended):**
1. Navigate to your project directory in File Explorer
2. Copy `nonfiction-v0.14.4.zip` into this directory
3. Right-click `nonfiction-v0.14.4.zip`
4. Select "7-Zip" → "Extract Here"
5. When prompted, choose **"Overwrite All"** or **"Yes to All"**
6. Framework files update, your book content preserved

**Windows (Command Line with Force Overwrite):**
```cmd
cd E:\Projects\my-book
tar -xf nonfiction-v0.14.4.zip --force-local
```

**macOS/Linux (with overwrite):**
```bash
cd /path/to/my-book
unzip -o nonfiction-v0.14.4.zip
```

The `-o` flag forces overwrite without prompting.

### Step 3: Verify Extraction

After extraction, your directory should contain:
```
my-book/
├── configure.md                    # Configuration script
├── INSTALLATION.md                 # This file
├── CLAUDE.md                       # Framework context for Claude Code
├── README.md                       # Framework overview
├── system-instructions.md          # For Claude Desktop integration
├── CHANGELOG.md                    # Version history
├── .gitignore                      # Git ignore rules
├── Process/                        # Framework documentation & prompts
│   ├── Prompts/
│   ├── Templates/
│   └── ...
├── scripts/                        # Automation scripts
│   ├── init.sh                     # Fast project initialization
│   └── detect-tools.sh             # Tool detection
└── .claude/
    ├── agents/
    │   └── book-writing-assistant.md
    └── commands/
        └── fw-init.md              # Session initialization command

Note: .config/ directory created during initialization (Prompt 1 or configure.md)
```

### Step 4: Run Configuration

Choose your method:

---

#### METHOD A: Claude Code CLI (Recommended)

1. **Start Claude Code** in your project directory:
   ```bash
   cd E:\Projects\my-book
   claude
   ```

2. **Execute the configuration script**:
   - Type: `execute configure.md`
   - Claude will automatically read and execute the file

3. **Follow the prompts**:
   - Configuration will set up git (if needed)
   - Ask about remote repository connection
   - Verify the installation
   - Create initial commit

4. **Initialize the framework** (MANDATORY):
   - Type: `/fw-init`
   - This loads all framework documentation (~20,000-30,000 tokens)
   - Provides verbose initialization report
   - **Required before executing any prompts**

5. **Start writing**:
   - Execute `Prompt 1: Initialize` to set up your book project
   - Begin writing!

---

#### METHOD B: Claude Desktop

1. **Start Claude Desktop**:
   - Open Claude Desktop application
   - Start a new chat

2. **Configure MCP Filesystem** (if not already done):
   - Go to Settings → MCP Servers
   - Add Filesystem connector with access to your project directory
   - See: https://docs.anthropic.com/claude/docs/mcp-filesystem

3. **Execute the configuration script**:
   - In the chat, type: `execute "E:\Projects\my-book\configure.md"`
   - Replace `E:\Projects\my-book` with your actual project path
   - Claude will read and execute the file via MCP Filesystem

4. **Follow the prompts**:
   - Configuration will guide you through setup
   - When git commands are needed, Claude will provide them as copy/paste blocks
   - Copy each command and run in your terminal/command prompt
   - Return to Claude Desktop and report results

5. **Set up System Instructions**:
   - Go to Settings → Custom Instructions in Claude Desktop
   - Open `system-instructions.md` from your project directory
   - Copy the section between the code fences (lines 40-356)
   - Paste into Custom Instructions field
   - Save

6. **Start a new chat with framework context**:
   - **IMPORTANT:** Start a NEW chat after setting system instructions
   - Claude will automatically load the framework at session startup
   - Execute `Prompt 1: Initialize` to set up your book project

7. **Session resumption** (for future sessions):
   - After Prompt 1 completes, a file called `PROJECT_CONTEXT.md` is created
   - For subsequent sessions, start a new chat and say:
     - `execute "E:\Projects\my-book\PROJECT_CONTEXT.md"`
     - Replace with your actual path
   - Claude will load your project context instantly

---

## Working with Claude Desktop

### Execute Command Pattern

Claude Desktop can execute framework files using the `execute` command with MCP Filesystem:

```
execute "E:\Projects\my-book\configure.md"
execute "E:\Projects\my-book\PROJECT_CONTEXT.md"
execute "E:\Projects\my-book\Process\Prompts\Prompt_3_Change_by_Chg.md"
```

**Always use full absolute paths in quotes.**

### Git Operations in Claude Desktop

Claude Desktop cannot execute git commands directly. When git operations are needed:

1. Claude will provide commands like:
   ```
   git add .
   git commit -m "message"
   git push
   ```

2. **Copy the command** and run in your terminal/command prompt:
   ```bash
   cd E:\Projects\my-book
   git add .
   git commit -m "message"
   ```

3. **Return to Claude Desktop** and report the result

### PROJECT_CONTEXT.md - Session Resumption

After you initialize your book project (Prompt 1), a `PROJECT_CONTEXT.md` file is created at your project root.

**To resume work in a new session:**
1. Start new chat in Claude Desktop
2. Type: `execute "E:\Projects\my-book\PROJECT_CONTEXT.md"`
3. Claude loads complete framework + project context instantly
4. Continue working

**PROJECT_CONTEXT.md auto-updates when:**
- You run Prompt 3 (Modify File)
- You run Prompt 8 (Dashboard)
- You run Prompt 10 (Update Change Tracking)

### Updating System Instructions

**After framework updates (new versions):**
1. Extract new framework zip (overlay existing)
2. Open new `system-instructions.md`
3. Copy updated instructions (lines 40-356)
4. Update Custom Instructions in Claude Desktop Settings
5. **Start NEW chat** for changes to take effect

---

## Troubleshooting

### "Git not found" error

**Solution**: Install git from https://git-scm.com/

After installation, restart your terminal/command prompt and run `configure.md` again.

### Extraction overwrote my work

**Solution**: This is why we require git commits and backups before updating!

1. If you committed to git: `git checkout HEAD -- [filename]` to restore
2. If you have a backup: Restore from your backup directory
3. If neither: Check your OS recycle bin/trash

### Claude Code doesn't see the framework files

**Solution**: Verify you're in the correct directory:
1. Ask Claude: "What directory am I in?"
2. Verify it matches your project directory
3. If not, navigate to the correct directory

### configure.md execution failed

**Solution**:
1. Verify all files extracted correctly
2. Check that `.claude/agents/book-writing-assistant.md` exists
3. Ensure you have read/write permissions in the directory
4. Try copying the contents of `configure.md` and pasting directly into Claude

### Claude Desktop: "execute" command doesn't work

**Solution**:
1. Verify MCP Filesystem connector is configured (Settings → MCP Servers)
2. Use full absolute paths in quotes: `execute "E:\Projects\my-book\configure.md"`
3. Check path uses correct slashes for your OS (Windows: `\`, macOS/Linux: `/`)
4. Verify the file exists at that exact path

### Claude Desktop: System Instructions not taking effect

**Solution**:
1. Verify you copied the instructions from `system-instructions.md` (lines 40-356)
2. Saved the Custom Instructions in Settings
3. **Started a NEW chat** (existing chats don't reload instructions)
4. Try closing and reopening Claude Desktop

### Claude Desktop: PROJECT_CONTEXT.md not loading

**Solution**:
1. Verify file was created: Check if `PROJECT_CONTEXT.md` exists in your project root
2. Use correct execute syntax: `execute "E:\Projects\my-book\PROJECT_CONTEXT.md"`
3. Ensure MCP Filesystem has access to your project directory
4. Try reading the file first: Ask Claude "Can you read E:\Projects\my-book\PROJECT_CONTEXT.md?"

### Claude Desktop: Framework doesn't recognize it's Desktop mode

**Solution**: System instructions should include the critical section about Claude Desktop limitations.
1. Re-copy system instructions from `system-instructions.md`
2. Look for "## CRITICAL: Claude Desktop Limitations" section (lines 74-104)
3. Update Custom Instructions with complete text
4. Start new chat

---

## Support

- **Documentation**: `Process/AI-Assisted_Nonfiction_Authoring_Process.md`
- **Quick Reference**: `Process/Prompts/QUICK_REFERENCE.md`
- **Issues**: https://github.com/scooter-indie/author-nonfiction/issues
- **Releases**: https://github.com/scooter-indie/author-nonfiction/releases

---

**Version**: 0.14.4
**Last Updated**: 2025-11-26
