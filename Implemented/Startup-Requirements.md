# Startup Requirements

**Status:** IMPLEMENTED
**Created:** 2025-11-25
**Implemented:** 2025-11-25
**Purpose:** Define requirements for dual-platform (Claude Code + Claude Desktop) startup support

---

## Requirements

1. configure.md will support both Claude Code and Claude Desktop for its execution.
2. Prompt 1 will support both Claude Code and Claude Desktop until the handoff to Claude Code is required.
3. For Claude Desktop users, every action requiring interaction with external tools (i.e. git, bash, Pandoc, etc) MUST be presented as a "copy block" for the user to paste into Claude Code to execute.
4. At no time will the user be expected to paste directly into a bash shell, a cmd prompt, a Powershell prompt or any equivalent thereof.
5. Claude code and Claude Desktop will always assume that tools such as jq will be installed using the common prompt to that environment. For example, on Windows, winget would be used to install jq.

---

## Implementation Notes

### Requirement 1: configure.md Dual-Platform Support
- Updated header to remove CLI-only restriction
- Added "Environment Support" section explaining both environments
- All CLI commands now have conditional paths for Desktop vs CLI

### Requirement 2: Prompt 1 Dual-Platform Support
- Already implemented via Step 4 "Desktop Handoff"
- Desktop creates `.config/init.json` then instructs user to continue in CLI
- No changes required

### Requirement 3: Copy Block Pattern
- Added copy blocks throughout configure.md for:
  - Tool detection script (Step 0.5)
  - Git initialization (Step 5)
  - Remote repository setup (Step 6)
  - Export tool discovery (Step 7)
  - Git commit (Step 9)
  - Error handling (uncommitted changes)
- Copy blocks use visual box format for easy identification

### Requirement 4: No Direct Shell Interaction
- Removed all references to "Open PowerShell and run"
- All instructions now route through Claude Code CLI
- Copy blocks explicitly state "COPY THIS TO CLAUDE CODE CLI"

### Requirement 5: Standard Package Manager Assumptions
- Windows: winget for jq installation (documented in configure.md)
- macOS: brew for git/jq installation
- Linux: apt for git/jq installation
- All package manager commands execute via Claude Code CLI