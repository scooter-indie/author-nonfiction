# MCP Filesystem Connector Configuration Guide

**For:** Claude Desktop and Claude.com (web interface)
**Framework Version:** 3.5.0

---

## What is the MCP Filesystem Connector?

The **MCP (Model Context Protocol) Filesystem** connector is a built-in extension that allows Claude Desktop and Claude.com to read and write files in directories you authorize on your local computer.

For the Nonfiction Authoring Framework, this connector enables Claude to:
- Read framework files from the Process/ directory
- Read and modify your book content files
- Create new chapters and supporting files
- Execute git operations
- Generate compiled manuscripts and exports

---

## Prerequisites

### For Claude Desktop:
- **Claude Desktop** installed (macOS, Windows, or Linux)
- **Version:** 0.7.0 or newer (check Help → About Claude Desktop)
- **MCP Filesystem connector** (included by default in recent versions)

### For Claude.com (Web):
- **Claude account** with access to Claude.com
- **Browser:** Chrome, Edge, Safari, or Firefox (latest versions)
- **MCP support:** May require Claude Pro subscription (verify current requirements)

---

## Configuration Steps for Claude Desktop

### Step 1: Locate the Configuration File

The MCP configuration file location varies by operating system:

**macOS:**
```
~/Library/Application Support/Claude/claude_desktop_config.json
```

**Windows:**
```
%APPDATA%\Claude\claude_desktop_config.json
```
Or:
```
C:\Users\[YourUsername]\AppData\Roaming\Claude\claude_desktop_config.json
```

**Linux:**
```
~/.config/Claude/claude_desktop_config.json
```

### Step 2: Open the Configuration File

**Option A: Using a text editor**
1. Navigate to the configuration file location
2. Open `claude_desktop_config.json` in your preferred text editor
3. If the file doesn't exist, create it

**Option B: Using terminal/command line**

**macOS/Linux:**
```bash
nano ~/Library/Application\ Support/Claude/claude_desktop_config.json
```

**Windows (PowerShell):**
```powershell
notepad "$env:APPDATA\Claude\claude_desktop_config.json"
```

### Step 3: Add Filesystem Connector Configuration

**If the file is empty or new**, add this configuration:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/path/to/your/book/project"
      ]
    }
  }
}
```

**If the file already has content**, add the filesystem entry to the existing `mcpServers` object:

```json
{
  "mcpServers": {
    "existing-server": {
      "command": "...",
      "args": ["..."]
    },
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/path/to/your/book/project"
      ]
    }
  }
}
```

### Step 4: Update the Path

**Replace `/path/to/your/book/project` with your actual project directory path:**

**macOS/Linux examples:**
```json
"args": ["-y", "@modelcontextprotocol/server-filesystem", "/Users/yourname/Documents/MyBook"]
```
```json
"args": ["-y", "@modelcontextprotocol/server-filesystem", "~/Documents/MyBook"]
```

**Windows examples:**
```json
"args": ["-y", "@modelcontextprotocol/server-filesystem", "C:\\Users\\YourName\\Documents\\MyBook"]
```
```json
"args": ["-y", "@modelcontextprotocol/server-filesystem", "C:/Users/YourName/Documents/MyBook"]
```

**Important for Windows:**
- Use double backslashes `\\` OR forward slashes `/`
- Both formats work in JSON

### Step 5: Configure Multiple Projects (Optional)

If you work on multiple book projects, you can add multiple paths:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/Users/yourname/Documents/BookProject1",
        "/Users/yourname/Documents/BookProject2",
        "/Users/yourname/Documents/BookProject3"
      ]
    }
  }
}
```

Or use separate named servers:

```json
{
  "mcpServers": {
    "book-project-1": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/Users/yourname/Documents/BookProject1"
      ]
    },
    "book-project-2": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/Users/yourname/Documents/BookProject2"
      ]
    }
  }
}
```

### Step 6: Save and Restart

1. **Save** the configuration file
2. **Quit** Claude Desktop completely (not just close the window)
3. **Restart** Claude Desktop
4. **Verify** the connector is active (see "Verifying Configuration" below)

---

## Configuration Steps for Claude.com (Web)

**Note:** MCP support for Claude.com may vary. Check current documentation at https://docs.anthropic.com/

### Step 1: Access MCP Settings

1. Log into Claude.com
2. Click your profile icon (top right)
3. Select **Settings**
4. Look for **MCP Servers** or **Extensions** section

### Step 2: Add Filesystem Connector

**If available in the web interface:**

1. Click **Add MCP Server** or **Connect Extension**
2. Select **Filesystem** from available options
3. Enter your project directory path
4. Grant permission when prompted
5. Save settings

**If not available in web interface:**

MCP Filesystem may only be available in Claude Desktop. Consider using Claude Desktop for full framework functionality.

---

## Verifying Configuration

### Test 1: Check MCP Status in Claude Desktop

1. Open Claude Desktop
2. Start a new chat
3. Look for an MCP indicator icon (typically near the input box)
4. Click the icon to see active MCP servers
5. Verify "filesystem" appears in the list

### Test 2: Test File Access

In a new chat session, say:
```
Can you read the file at [your-project-path]/Process/AI-Assisted_Nonfiction_Authoring_Process.md?
```

**Expected result:**
- Claude reads the file
- Shows you a summary or confirms it was read
- May display file contents

**If it fails:**
- Check configuration file syntax (valid JSON)
- Verify path is correct
- Ensure Claude Desktop was fully restarted
- Check permissions on the directory

### Test 3: Framework Loading

If you've added system instructions (see system-instructions.md):

1. Start a new chat session
2. Say: "Are you ready to work on my nonfiction book?"

**Expected result:**
- Claude confirms framework is loaded
- Lists available prompts
- Offers to help with project

---

## Troubleshooting

### Error: "MCP server failed to start"

**Possible causes:**
- `npx` not installed (Node.js required)
- Invalid JSON syntax in config file
- Path doesn't exist

**Solutions:**

1. **Install Node.js** (includes npx):
   - Download from: https://nodejs.org/
   - Install the LTS (Long Term Support) version
   - Restart Claude Desktop after installation

2. **Validate JSON syntax:**
   - Use an online JSON validator: https://jsonlint.com/
   - Check for missing commas, brackets, quotes
   - Ensure all backslashes are doubled on Windows

3. **Verify path exists:**
   - Navigate to the path in Finder/File Explorer
   - Ensure spelling is exact (case-sensitive on macOS/Linux)
   - Use absolute paths, not relative paths

### Error: "Permission denied"

**Solutions:**

**macOS:**
1. Open **System Settings** → **Privacy & Security**
2. Grant **Full Disk Access** to Claude Desktop
3. Restart Claude Desktop

**Windows:**
1. Right-click your project folder
2. Properties → Security tab
3. Ensure your user account has Read/Write permissions

**Linux:**
```bash
chmod -R u+rw /path/to/your/project
```

### Error: "File not found" when Claude tries to read

**Solutions:**

1. **Check path in config:**
   - Verify it matches actual directory location
   - Use full absolute path, not relative
   - Check for typos

2. **Verify framework was installed:**
   - Navigate to your project directory
   - Confirm Process/ directory exists
   - Confirm Process/AI-Assisted_Nonfiction_Authoring_Process.md exists

3. **Re-run remote installer:**
   - Execute remote-install.md again
   - Verify extraction succeeded

### Claude doesn't load framework automatically

**Solutions:**

1. **Verify system instructions are configured:**
   - See system-instructions.md
   - Check that instructions were saved
   - Try in a fresh chat session

2. **Check MCP filesystem is active:**
   - Look for MCP indicator in Claude Desktop
   - Verify filesystem server is running
   - Restart Claude Desktop

3. **Manually trigger loading:**
   - Say: "Please read the Process directory in my book project"
   - Specify full path if needed

### Multiple projects not working

**Solutions:**

1. **Specify which project at session start:**
   - Say: "I'm working on the project at [path]"
   - Claude will focus on that directory

2. **Use separate named servers:**
   - See "Configure Multiple Projects" above
   - Tell Claude which server to use: "Use the book-project-1 filesystem"

---

## Security & Privacy

### What Claude Can Access

**With MCP Filesystem configured:**
- ✅ Claude can read files in specified directories
- ✅ Claude can write/modify files in specified directories
- ✅ Claude can create new files and directories
- ✅ Claude can delete files (if you instruct it)

**Claude CANNOT access:**
- ❌ Files outside specified directories
- ❌ System files
- ❌ Other user directories
- ❌ Network locations (unless explicitly configured)

### Best Practices

1. **Only grant access to project directories:**
   - Don't point to entire home directory
   - Use specific book project paths
   - Avoid pointing to system directories

2. **Regular backups:**
   - Use git version control (framework does this)
   - Regular pushes to remote repository
   - Periodic manual backups to cloud storage

3. **Review operations:**
   - Claude will ask before destructive operations
   - Review changes before confirming
   - Use git to rollback if needed

---

## Advanced Configuration

### Custom MCP Server Port

If you need to specify a custom port:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/path/to/project"
      ],
      "env": {
        "PORT": "3000"
      }
    }
  }
}
```

### Read-Only Access

To grant read-only access (Claude cannot modify files):

```json
{
  "mcpServers": {
    "filesystem-readonly": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "--readonly",
        "/path/to/project"
      ]
    }
  }
}
```

**Note:** The framework requires write access for full functionality.

### Logging for Debugging

Enable logging to troubleshoot issues:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/path/to/project"
      ],
      "env": {
        "DEBUG": "*"
      }
    }
  }
}
```

Logs will appear in Claude Desktop's developer console.

---

## Complete Configuration Example

### Single Project (Recommended for Most Users)

**macOS/Linux:**
```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/Users/johnsmith/Documents/MyNonfictionBook"
      ]
    }
  }
}
```

**Windows:**
```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "C:/Users/JohnSmith/Documents/MyNonfictionBook"
      ]
    }
  }
}
```

### Multiple Projects

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/Users/johnsmith/Documents/Book1-TechGuide",
        "/Users/johnsmith/Documents/Book2-Memoir",
        "/Users/johnsmith/Documents/Book3-Business"
      ]
    }
  }
}
```

---

## Next Steps After Configuration

Once MCP Filesystem is configured:

1. ✅ **MCP Filesystem connector configured** (you are here)
2. **Add system instructions** (see system-instructions.md)
3. **Test framework loading** in new chat session
4. **Run remote installer** (remote-install.md) if not already done
5. **Execute Prompt 1** to initialize your book project
6. **Start writing!**

---

## Getting Help

### Official Documentation:
- **MCP Documentation:** https://modelcontextprotocol.io/
- **Claude Desktop Help:** https://support.anthropic.com/

### Framework Support:
- **Framework Docs:** Process/AI-Assisted_Nonfiction_Authoring_Process.md
- **Quick Reference:** Process/Prompts/QUICK_REFERENCE.md
- **GitHub Issues:** https://github.com/scooter-indie/author-nonfiction/issues

### Common Issues:
- Node.js not installed → https://nodejs.org/
- JSON syntax errors → https://jsonlint.com/
- Path problems → Use absolute paths, check spelling
- Permission errors → Grant Full Disk Access (macOS) or folder permissions (Windows)

---

## Updating MCP Configuration

### When to Update:

- Adding new book projects
- Changing project location
- Upgrading framework version (usually not needed)
- Troubleshooting access issues

### How to Update:

1. Quit Claude Desktop
2. Edit `claude_desktop_config.json`
3. Save changes
4. Restart Claude Desktop
5. Verify in new chat session

---

**Framework Version:** 3.5.0
**Last Updated:** 2025-11-17

---

*This configuration enables Claude Desktop and Claude.com to access your book project files*
*Required for full framework functionality with remote installation*
