# Claude Configuration

This directory contains configuration files for Claude Code.

## Files

### `hooks.json`
Pre-configured permissions that automatically allow common commands without prompting.

**Automatically allowed commands:**
- All `git` commands (commit, push, pull, tag, etc.)
- All `gh` CLI commands (for GitHub operations)
- Common file operations (ls, cat, mkdir, cp, mv, rm)
- Archive operations (tar, zip, unzip)
- Checksum calculation (sha256sum)

**Denied commands (for safety):**
- `rm -rf /` (root filesystem deletion)
- `sudo` commands (privilege escalation)

This file is included in the framework distribution so users don't have to repeatedly approve git operations during normal workflow.

### `settings.local.json` (not tracked)
User-specific settings. This file is in `.gitignore` and won't be committed to your repository.

### `agents/`
Contains agent definitions for specialized AI assistants.

- `book-writing-assistant.md` - Primary agent for book authoring sessions
