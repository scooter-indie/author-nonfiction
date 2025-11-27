# Claude Desktop Setup Guide

**Version:** 0.15.0
**Purpose:** Complete guide for using the AI-Assisted Nonfiction Authoring Framework with Claude Desktop.

---

## Prerequisites

Before setting up Claude Desktop, you need:

1. **Claude Desktop installed** - Download from https://claude.ai/download
2. **Framework installed** - Either via `configure.md` or manual setup (see `Multi-Book_Setup_Guide.md`)
3. **Your paths ready:**
   - `FW_ROOT` - Where the framework is installed (e.g., `E:\author-nonfiction-framework`)
   - `BOOKS_ROOT` - Where your books are stored (e.g., `E:\My-Books`)

---

## Step 1: Configure MCP Filesystem Access

Claude Desktop uses the Model Context Protocol (MCP) to access files. You must grant access to both framework and books directories.

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
           "E:\\author-nonfiction-framework",
           "E:\\My-Books"
         ]
       }
     }
   }
   ```

   **Important:**
   - Replace paths with your actual `FW_ROOT` and `BOOKS_ROOT` paths
   - Use double backslashes (`\\`) for Windows paths in JSON
   - Both directories must be listed as separate arguments

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
           "/Users/yourname/author-nonfiction-framework",
           "/Users/yourname/My-Books"
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
   [FW_ROOT]/Process/Templates/Claude_Desktop_System_Instructions.md
   ```

   **Before pasting:**
   - Replace all `[FW_ROOT]` with your actual framework path
   - Replace all `[BOOKS_ROOT]` with your actual books path

   Example replacements:
   - `[FW_ROOT]` → `E:\author-nonfiction-framework`
   - `[BOOKS_ROOT]` → `E:\My-Books`

5. **Save** the project settings.

---

## Step 3: Verify Setup

### Test MCP Access

In your new project, send this message:
```
Please read the file: [FW_ROOT]/VERSION

(Replace [FW_ROOT] with your actual path)
```

If working correctly, Claude will read and display the version number.

### Test Full Initialization

Send this message:
```
Please initialize following the system instructions.
```

Claude should:
1. Read fw-location.json
2. Read FRAMEWORK_CORE.md
3. Check for updates
4. Show available books
5. Ask which book to work on
6. Confirm the date

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
cd [BOOKS_ROOT]
claude

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

**Cause:** MCP filesystem not configured or paths incorrect.

**Solution:**
1. Verify `claude_desktop_config.json` has correct paths
2. Check that both directories are listed
3. Restart Claude Desktop after changes
4. Ensure Node.js is installed (`npx` command requires it)

### "Framework not found" errors

**Cause:** fw-location.json points to wrong path.

**Solution:**
1. Check `[BOOKS_ROOT]/.config/fw-location.json`
2. Verify `frameworkRoot` path is correct
3. Ensure the path uses your OS's path format

### System instructions not loading

**Cause:** Custom instructions not saved in project.

**Solution:**
1. Open project settings
2. Verify custom instructions are present
3. Check that paths were replaced correctly

### Update check fails

**Cause:** Network connectivity or GitHub access issues.

**Solution:**
- This is informational only - framework still works
- Manually check releases at: https://github.com/scooter-indie/author-nonfiction-dist/releases

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
FW_ROOT/                              # Framework (read-only)
├── Process/
│   ├── FRAMEWORK_CORE.md             # Essential framework knowledge
│   ├── Prompts/                      # All prompt files
│   ├── Styles/                       # Style library
│   └── Templates/
│       └── Claude_Desktop_System_Instructions.md
├── VERSION                           # Framework version
└── CLAUDE.md                         # Framework CLAUDE.md

BOOKS_ROOT/                           # Your books
├── .config/
│   ├── fw-location.json              # Points to FW_ROOT
│   ├── books-registry.json           # All books list
│   └── settings.json                 # Preferences
├── Book-Title-One/
│   ├── Manuscript/                   # Book content
│   ├── .config/                      # Book config
│   └── PROJECT_CONTEXT.md            # Book context
├── Book-Title-Two/
│   └── ...
├── Archive/                          # Archived books
└── CLAUDE.md                         # Books CLAUDE.md
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

*Framework Version: 0.15.0*
*Last Updated: 2025-11-27*
