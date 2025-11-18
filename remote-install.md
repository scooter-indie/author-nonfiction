# Nonfiction Framework Remote Installer

**Version:** 3.5.0
**Release Date:** 2025-11-17

**BEFORE PROCEEDING:** This installer is designed for use with Claude Desktop or Claude Code with MCP Filesystem connector access. **Note:** Claude.com (web) does NOT support filesystem access and cannot use this installer.

---

## What This Does

I will install the AI-Assisted Nonfiction Authoring Framework in your target directory by:

1. Downloading the framework from GitHub releases
2. Extracting framework files to your specified directory
3. Setting up the Process/ directory
4. Creating configuration files for your Claude interface
5. Initializing git repository (optional)
6. Providing next steps for configuration

---

## Prerequisites

### System Requirements:
- Access to Claude Desktop, Claude.com, or Claude Code
- A target directory where you want to create your book project
- Internet connection to download from GitHub

### For Claude Desktop Users:
- MCP Filesystem connector must be configured (see configuration.md)
- The filesystem connector must have access to your target directory
- **Note:** Claude.com web does NOT support filesystem access - use Claude Desktop instead

### For Claude Code Users:
- Git installed (for version control)
- Write access to target directory

---

## Installation Steps

### Step 1: Confirm Target Directory

I will ask you:
- **"What is the full path to your target directory?"**
  - Example (Windows): `C:\Users\YourName\Documents\MyBook`
  - Example (Mac/Linux): `/Users/yourname/Documents/MyBook`
  - Example (Mac/Linux): `~/Documents/MyBook`

I will verify:
- Directory exists or can be created
- I have write access to the directory

### Step 2: Download Framework

I will:
1. Fetch the latest release (v3.5.0) from GitHub
2. Download URL: `https://github.com/scooter-indie/author-nonfiction/releases/download/v3.5.0/nonfiction-v3.5.0.zip`
3. Save to your target directory
4. Verify download succeeded

### Step 3: Extract Framework

I will:
1. Unzip `nonfiction-v3.5.0.zip` to your target directory
2. Verify `Process/` directory was created
3. Verify `.nonfiction-manifest.json` exists
4. List extracted contents for confirmation

**Extracted structure:**
```
[your-target-directory]/
├── Process/
│   ├── AI-Assisted_Nonfiction_Authoring_Process.md
│   ├── Anti-Hallucination_Guidelines.md
│   ├── Style_Examples.md
│   ├── Prompts/
│   │   ├── Prompt_1_Initialize.md
│   │   ├── Prompt_2_Add_Chapter.md
│   │   ├── ... (through Prompt_10)
│   │   ├── QUICK_REFERENCE.md
│   │   └── README.md
│   └── Templates/
├── .nonfiction-manifest.json
└── README.md
```

### Step 4: Create Interface-Specific Configuration

**For Claude Desktop users:**

I will create `system-instructions.md` in your target directory containing:
- Instructions to load the Process/ directory on session startup
- Guidance for executing prompts
- MCP Filesystem connector usage notes
- **Note:** Not applicable for Claude.com web (no filesystem support)

**For Claude Code users:**

I will create `CLAUDE.md` in your target directory containing:
- Session startup context loading instructions
- Framework overview
- Quick start guidance

### Step 5: Initialize Git Repository (Optional)

I will ask:
- **"Do you want to initialize a git repository?"**

If yes:
1. Run `git init` in your target directory
2. Create `.gitignore` file
3. Create initial commit
4. Ask for remote repository URL (optional)

If no:
- Skip git initialization
- You can set it up later manually

### Step 6: Clean Up

I will:
1. Delete the downloaded `nonfiction-v3.5.0.zip` file
2. Keep all extracted framework files

### Step 7: Provide Next Steps

I will show you:
- Confirmation of successful installation
- Location of key files
- Next steps based on your Claude interface:
  - **Claude Desktop/Web:** How to configure MCP Filesystem connector (see configuration.md)
  - **Claude Code:** How to start your first session with CLAUDE.md
- Link to run Prompt 1 (Initialize) to set up your book project

---

## After Installation

### For Claude Desktop Users:

**Next steps:**
1. Configure MCP Filesystem connector (see `configuration.md`)
2. Add system instructions from `system-instructions.md` to your Claude settings
3. Start a new chat session
4. The framework will load automatically
5. Execute: "Run Prompt 1" to initialize your book project

**Note:** Claude.com web does NOT support this workflow - please use Claude Desktop

### For Claude Code Users:

**Next steps:**
1. Navigate to your target directory in terminal
2. Start Claude Code session
3. CLAUDE.md will provide framework context
4. Copy and paste `Process/Prompts/Prompt_1_Initialize.md` to begin
5. Follow the interactive setup to create your book project

---

## What Gets Installed

### Framework Files:
- **Process/** - Complete framework with prompts, templates, guidelines
- **.nonfiction-manifest.json** - Version tracking
- **README.md** - Framework overview

### Configuration Files (created during installation):
- **system-instructions.md** (for Claude Desktop/Web) OR
- **CLAUDE.md** (for Claude Code)
- **.gitignore** (if git initialized)

### NOT Included (Created by Prompt 1):
- Your book project structure (Chapters/, TOC/, etc.)
- Project configuration files
- Git repository (unless you choose to initialize)

---

## Troubleshooting

### Error: Cannot download from GitHub
**Solution:**
- Check internet connection
- Verify GitHub is accessible
- Try accessing the release URL manually: https://github.com/scooter-indie/author-nonfiction/releases/tag/v3.5.0

### Error: Cannot extract zip file
**Solution:**
- Verify zip file downloaded completely
- Check write permissions on target directory
- Manually extract if needed

### Error: MCP Filesystem connector not configured
**Solution:**
- See `configuration.md` for setup instructions
- Ensure connector has access to your target directory

### Error: Process/ directory not found after extraction
**Solution:**
- Re-download the zip file (may be corrupted)
- Verify extraction completed successfully
- Check for error messages during extraction

---

## Version Information

**Framework Version:** 3.5.0
**Release Date:** 2025-11-17
**Release URL:** https://github.com/scooter-indie/author-nonfiction/releases/tag/v3.5.0
**Support:** https://github.com/scooter-indie/author-nonfiction/issues

---

## Ready to Install?

**I will now:**
1. Ask for your target directory path
2. Download the framework from GitHub
3. Extract to your directory
4. Create appropriate configuration files
5. Optionally initialize git
6. Provide next steps for your Claude interface

**Shall I proceed with installation?**

---

*This remote installer works with Claude Desktop and Claude Code*
*Claude.com web does NOT support filesystem access - use Claude Desktop instead*
*For local Claude Code installation with downloaded zip, use installer.md instead*
