# Claude Configuration

This directory contains configuration files for Claude Code.

## Files

### `hooks.json`
Pre-configured permissions that automatically allow common commands without prompting.

**Automatically allowed git commands:**
- Safe operations: `status`, `add`, `commit`, `push`, `pull`, `fetch`
- Branching: `branch`, `checkout`, `merge`, `tag`, `stash`
- Information: `log`, `diff`, `show`, `reflog`, `describe`
- Repository: `clone`, `init`, `remote`, `config`
- Plumbing: `ls-files`, `ls-tree`, `rev-parse`, `rev-list`

**Automatically allowed file operations:**
- Navigation: `pwd`, `ls`, `dir`, `cd`
- Viewing: `cat`, `head`, `tail`
- Searching: `find`, `grep`, `rg`
- Management: `mkdir`, `rm`, `cp`, `mv`
- Archives: `tar`, `zip`, `unzip`, `sha256sum`
- Text processing: `wc`, `sort`, `uniq`
- Testing: `test`, `[` (bash test commands)
- GitHub CLI: `gh` (all operations)

**Automatically allowed file edits:**
- `.config/manifest.json` (framework version tracking, v0.12.1+)

**Denied commands (for safety):**
- Destructive: `rm -rf /`, `sudo`
- Dangerous git: `push --force`, `reset --hard`, `clean -fd`, `filter-branch`
- Interactive: `rebase -i`, `add -i` (require manual interaction)

This file is included in the framework distribution so users don't have to repeatedly approve git operations during normal workflow.

### `settings.local.json` (not tracked)
User-specific settings. This file is in `.gitignore` and won't be committed to your repository.

### `commands/`
Contains slash commands for framework operations.

- `fw-init.md` - **MANDATORY** session initialization command

**Usage:** Type `/fw-init` at the start of every Claude Code session to load all framework documentation and prepare for prompt execution.

This command:
- Loads ~20,000-30,000 tokens of framework documentation
- Reads all core framework files (Process/, system-instructions.md)
- Activates Anti-Hallucination Protocol
- Checks for existing book project (PROJECT_CONTEXT.md)
- Provides verbose initialization report
- **Required before executing any prompts**

See `commands/fw-init.md` for complete initialization sequence.

### `agents/`
Contains agent definitions for specialized AI assistants.

- `book-writing-assistant.md` - Primary agent for book authoring sessions

---

**Framework Version:** 0.15.0
**Last Updated:** 2025-11-27
