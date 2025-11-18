# Installation Guide

**AI-Assisted Nonfiction Authoring Framework v0.9.0**

---

## Prerequisites

Before you begin, ensure you have:

1. **Claude installed** (Claude Code CLI) - Download from [Claude Code website](https://claude.com/claude-code)
   - Launch with `claude` command
2. **Git installed** (optional but recommended) - Download from [git-scm.com](https://git-scm.com/)
3. **Empty target directory** for your book project (e.g., `E:\Projects\my-book`)

---

## Installation Steps

### Step 1: Download the Framework

Download `nonfiction-v0.9.0.zip` from:
- **GitHub Releases**: https://github.com/scooter-indie/author-nonfiction/releases/latest

Save the zip file to your target directory.

### Step 2: Extract the Framework

**⚠️ IMPORTANT:** The zip contains files at the root level (no parent folder). Extract directly to your project directory, NOT into a subdirectory.

#### For New Installations:

**Windows (File Explorer - Extract All):**
1. Navigate to your project directory in File Explorer (e.g., `E:\Projects\my-book`)
2. Copy `nonfiction-v0.9.0.zip` into this directory
3. Right-click `nonfiction-v0.9.0.zip`
4. Select "Extract All..."
5. **CRITICAL:** Delete the suggested folder name so it extracts to current directory:
   - Windows suggests: `E:\Projects\my-book\nonfiction-v0.9.0`
   - **Change to:** `E:\Projects\my-book` (remove the `\nonfiction-v0.9.0` part)
6. Click "Extract"
7. Files will extract directly into `my-book\` directory

**Windows (7-Zip - Recommended):**
1. Navigate to your project directory in File Explorer
2. Copy `nonfiction-v0.9.0.zip` into this directory
3. Right-click `nonfiction-v0.9.0.zip`
4. Select "7-Zip" → "Extract Here"
5. Files extract directly into current directory (no subdirectory created)

**Windows (Command Line):**
```cmd
cd E:\Projects\my-book
tar -xf nonfiction-v0.9.0.zip
```

**macOS/Linux:**
```bash
cd /path/to/my-book
unzip nonfiction-v0.9.0.zip
```

#### For Updates (Overlaying Existing Installation):

**⚠️ CRITICAL: Before updating, you MUST:**
1. **Commit all your work to git**: `git commit -am "Save work before framework update"`
2. **Create a backup** of your entire project directory

**Windows (File Explorer - Extract All):**
1. Navigate to your project directory in File Explorer
2. Copy `nonfiction-v0.9.0.zip` into this directory
3. Right-click `nonfiction-v0.9.0.zip`
4. Select "Extract All..."
5. **CRITICAL:** Delete the suggested folder name so it extracts to current directory:
   - Windows suggests: `E:\Projects\my-book\nonfiction-v0.9.0`
   - **Change to:** `E:\Projects\my-book` (remove the `\nonfiction-v0.9.0` part)
6. Click "Extract"
7. When prompted about overwriting files, select **"Replace the files in the destination"** or **"Yes to All"**

**Windows (7-Zip - Recommended):**
1. Navigate to your project directory in File Explorer
2. Copy `nonfiction-v0.9.0.zip` into this directory
3. Right-click `nonfiction-v0.9.0.zip`
4. Select "7-Zip" → "Extract Here"
5. When prompted, choose **"Overwrite All"** or **"Yes to All"**
6. Framework files update, your book content preserved

**Windows (Command Line with Force Overwrite):**
```cmd
cd E:\Projects\my-book
tar -xf nonfiction-v0.9.0.zip --force-local
```

**macOS/Linux (with overwrite):**
```bash
cd /path/to/my-book
unzip -o nonfiction-v0.9.0.zip
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
├── .nonfiction-manifest.json       # Framework version tracking
├── Process/                        # Framework documentation & prompts
│   ├── Prompts/
│   ├── Templates/
│   └── ...
└── .claude/
    └── agents/
        └── book-writing-assistant.md
```

### Step 4: Run Configuration

1. **Start Claude** in your project directory:
   ```bash
   cd E:\Projects\my-book
   claude
   ```

2. **Execute the configuration script**:
   - Type: `execute configure.md`
   - Or paste the contents of `configure.md` into the chat

3. **Follow the prompts**:
   - The configuration will set up git (if needed)
   - Ask about remote repository connection
   - Verify the installation
   - Create initial commit

### Step 5: Start Writing

After configuration completes:
1. Review the available prompts listed by the assistant
2. Execute `Prompt 1: Initialize` to set up your book project
3. Begin writing!

---

## Optional: Claude Desktop Integration

If you also use Claude Desktop (in addition to Claude Code):

1. **Copy system instructions**:
   - Open `system-instructions.md` from your project directory
   - Copy the entire contents

2. **Create a new project in Claude Desktop**:
   - Click "Projects" in Claude Desktop
   - Create a new project for your book
   - Paste the system instructions into the project settings

3. **Use both interfaces**:
   - Claude Code: For file operations, git, and automation
   - Claude Desktop: For conversational writing and brainstorming

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
4. Try copying the contents of `configure.md` and pasting directly into Claude Code

---

## Support

- **Documentation**: `Process/AI-Assisted_Nonfiction_Authoring_Process.md`
- **Quick Reference**: `Process/Prompts/QUICK_REFERENCE.md`
- **Issues**: https://github.com/scooter-indie/author-nonfiction/issues
- **Releases**: https://github.com/scooter-indie/author-nonfiction/releases

---

**Version**: 0.9.0
**Last Updated**: 2025-11-18
