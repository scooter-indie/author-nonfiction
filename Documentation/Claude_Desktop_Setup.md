# Claude Desktop Setup Guide

**Version:** 0.16.0
**Purpose:** Complete guide for using the AI-Assisted Nonfiction Authoring Framework with Claude Desktop.

---

## Prerequisites

Before setting up Claude Desktop, you need:

1. **Claude Desktop installed** - Download from https://claude.ai/download
2. **Framework installed** - Run `configure.bat/sh` to set up PROJECT_ROOT (see Quick Start in README.md)
3. **Your PROJECT_ROOT path ready:**
   - e.g., `E:\My-Writing` (Windows)
   - e.g., `~/My-Writing` (macOS/Linux)

---

## Architecture Overview (v0.16.0+)

The framework uses a unified PROJECT_ROOT structure:

```
PROJECT_ROOT/
├── .config/              # CONFIG_ROOT - where Claude starts
│   ├── fw-location.json  # FW_ROOT path
│   ├── settings.json     # BOOKS_ROOT path
│   ├── books-registry.json
│   ├── CLAUDE.md
│   └── .claude/          # Commands and agents
├── FW_ROOT/              # Framework (cloned, gitignored)
├── BOOKS_ROOT/           # Your books
│   ├── [Book-Name]/
│   └── Archive/
├── start-authoring.*     # Startup scripts
└── .gitignore
```

**Key Point:** Claude Desktop needs access to the entire PROJECT_ROOT to read all components.

---

## Step 1: Configure MCP Filesystem Access

Claude Desktop uses the Model Context Protocol (MCP) to access files. You must grant access to PROJECT_ROOT.

### Windows

1. **Open Claude Desktop settings:**
   - Click the menu icon (three lines) in top-left
   - Select "Settings"
   - Navigate to "Developer" section

2. **Edit claude_desktop_config.json:**

   The file is located at:
   ```
   %APPDATA%\Claude\claude_desktop_config.json
   ```

   Or typically:
   ```
   C:\Users\[YourUsername]\AppData\Roaming\Claude\claude_desktop_config.json
   ```

3. **Add filesystem server configuration:**

   ```json
   {
     "mcpServers": {
       "filesystem": {
         "command": "npx",
         "args": [
           "-y",
           "@modelcontextprotocol/server-filesystem",
           "E:\\My-Writing"
         ]
       }
     }
   }
   ```

   **Important:**
   - Replace path with your actual PROJECT_ROOT path
   - Use double backslashes (`\\`) for Windows paths in JSON
   - Single entry provides access to FW_ROOT, BOOKS_ROOT, and .config/

4. **Restart Claude Desktop** for changes to take effect.

### macOS

1. **Open configuration file:**
   ```
   ~/Library/Application Support/Claude/claude_desktop_config.json
   ```

2. **Add filesystem server:**

   ```json
   {
     "mcpServers": {
       "filesystem": {
         "command": "npx",
         "args": [
           "-y",
           "@modelcontextprotocol/server-filesystem",
           "/Users/yourname/My-Writing"
         ]
       }
     }
   }
   ```

3. **Restart Claude Desktop.**

### Linux

1. **Open configuration file:**
   ```
   ~/.config/Claude/claude_desktop_config.json
   ```

2. **Add filesystem server** (same format as macOS with Linux paths).

3. **Restart Claude Desktop.**

---

## Step 2: Create a Claude Desktop Project

Using Claude Desktop Projects gives you persistent custom instructions.

### Create New Project

1. **Open Claude Desktop**
2. **Click "Projects"** in the left sidebar
3. **Click "Create Project"**
4. **Name it:** "Nonfiction Authoring" (or your preference)

### Add System Instructions

1. **Open your new project**
2. **Click the gear icon** (Project Settings)
3. **Find "Custom Instructions"** or "System Prompt"
4. **Copy and paste** the contents from:
   ```
   [PROJECT_ROOT]/FW_ROOT/Process/Templates/Claude_Desktop_System_Instructions.md
   ```

   **Before pasting:**
   - Replace all `[PROJECT_ROOT]` with your actual PROJECT_ROOT path

   Example replacement:
   - `[PROJECT_ROOT]` → `E:\My-Writing` (Windows)
   - `[PROJECT_ROOT]` → `/Users/yourname/My-Writing` (macOS)

5. **Save** the project settings.

---

## Step 3: Verify Setup

### Test MCP Access

In your new project, send this message:
```
Please read the file: [PROJECT_ROOT]/.config/fw-location.json

(Replace [PROJECT_ROOT] with your actual path)
```

If working correctly, Claude will read and display the fw-location.json contents.

### Test Full Initialization

Send this message:
```
Please initialize following the system instructions.
```

Claude should:
1. Read fw-location.json to find FW_ROOT
2. Read settings.json to find BOOKS_ROOT
3. Read books-registry.json
4. Read FRAMEWORK_CORE.md
5. Check for updates
6. Show available books
7. Ask which book to work on
8. Confirm the date

---

## Step 4: Daily Usage

### Starting a Session

1. **Open Claude Desktop**
2. **Select your "Nonfiction Authoring" project**
3. **Start a new conversation**
4. Claude automatically initializes and asks which book to work on

### Working on a Book

After selecting a book:
- Use standard prompts (2, 3, 4, 5, 6, 10, 11)
- Say "switch to [Book Name]" to change books
- Ask "show dashboard" (Prompt 10) for status

### CLI-Only Operations

For operations requiring Claude Code CLI, Claude will inform you:
```
This operation requires Claude Code CLI.

In your terminal, run:
[PROJECT_ROOT]/start-authoring.bat  (Windows)
[PROJECT_ROOT]/start-authoring.sh   (macOS/Linux)

Then say: "Execute Prompt [X]"
```

**CLI-Only prompts:**
- Prompt 7: Compile Manuscript
- Prompt 8: Consistency Checker
- Prompt 9: Export (DOCX/PDF/EPUB)
- Prompt 12: Git Operations
- Prompt 13: AI Detection Analysis
- Prompt 14: Citation Finder
- Prompt 15: Visual Content Suggester
- Prompt 16: Image Manager
- Prompt 17: Backup & Export

---

## Troubleshooting

### "Cannot read file" errors

**Cause:** MCP filesystem not configured or path incorrect.

**Solution:**
1. Verify `claude_desktop_config.json` has correct PROJECT_ROOT path
2. Restart Claude Desktop after changes
3. Ensure Node.js is installed (`npx` command requires it)

### "Framework not found" errors

**Cause:** fw-location.json points to wrong FW_ROOT path.

**Solution:**
1. Check `[PROJECT_ROOT]/.config/fw-location.json`
2. Verify `frameworkRoot` path is correct
3. Ensure the path uses your OS's path format

### System instructions not loading

**Cause:** Custom instructions not saved in project.

**Solution:**
1. Open project settings
2. Verify custom instructions are present
3. Check that PROJECT_ROOT was replaced correctly

### Update check fails

**Cause:** Network connectivity or GitHub access issues.

**Solution:**
- This is informational only - framework still works
- Manually update: `cd [PROJECT_ROOT]/FW_ROOT && git pull`

---

## Best Practices

### 1. Use Projects Consistently

Always use your configured project rather than starting fresh conversations without project context.

### 2. Confirm Date

Always verify the date at session start. Incorrect dates affect:
- Chapter creation timestamps
- Dashboard reports
- Git commit metadata

### 3. Use CLI for Bulk Operations

Claude Desktop works best for:
- Interactive editing (Prompts 3, 4)
- Adding chapters (Prompt 2)
- Quick status checks (Prompt 10)
- Style management (Prompt 11)

Use Claude Code CLI for:
- Compilation and export
- Consistency checking
- Git operations
- Bulk file operations

### 4. Regular Backups

Even with Claude Desktop, periodically use Claude Code CLI to:
- Run Prompt 17 for ZIP backup
- Push to GitHub remote (if configured)

---

## Reference: Project Structure

```
PROJECT_ROOT/
├── .config/                          # CONFIG_ROOT
│   ├── fw-location.json              # Points to FW_ROOT
│   ├── settings.json                 # Points to BOOKS_ROOT
│   ├── books-registry.json           # All books list
│   ├── CLAUDE.md                     # Claude instructions
│   └── .claude/
│       ├── commands/                 # fw-init, switch-book, manage-book
│       └── agents/                   # book-writing-assistant
├── FW_ROOT/                          # Framework (gitignored)
│   ├── Process/
│   │   ├── FRAMEWORK_CORE.md         # Essential knowledge
│   │   ├── Prompts/                  # All prompt files
│   │   ├── Styles/                   # Style library
│   │   └── Templates/
│   │       └── Claude_Desktop_System_Instructions.md
│   └── VERSION                       # Framework version
├── BOOKS_ROOT/                       # Your books
│   ├── Book-Title-One/
│   │   ├── Manuscript/               # Book content
│   │   ├── .config/                  # Book config
│   │   └── PROJECT_CONTEXT.md        # Book context
│   ├── Book-Title-Two/
│   │   └── ...
│   └── Archive/                      # Archived books
├── start-authoring.bat/.sh           # Startup scripts
├── bp-start-authoring.bat/.sh        # Bypass permissions
└── .gitignore                        # Excludes FW_ROOT/
```

---

## Quick Reference Card

| Task | Claude Desktop | Claude Code CLI |
|------|---------------|-----------------|
| Select book | Automatic at startup | `/fw-init` |
| Switch books | "switch to [Name]" | "switch to [Name]" |
| Create chapter | Prompt 2 | Prompt 2 |
| Edit content | Prompt 3, 4 | Prompt 3, 4 |
| Check status | Prompt 10 | Prompt 10 |
| Compile manuscript | Use CLI | Prompt 7 |
| Export formats | Use CLI | Prompt 9 |
| Git operations | Use CLI | Prompt 12 |
| Backup | Use CLI | Prompt 17 |

---

*Framework Version: 0.16.0*
*Last Updated: 2025-11-28*
