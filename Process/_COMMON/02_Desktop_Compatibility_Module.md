# Desktop Compatibility Module

**Framework Version:** 0.10.0
**Module:** Desktop Compatibility Specifications
**Purpose:** Standardized compatibility headers for Claude Desktop support

---

## Overview

This module defines the three compatibility levels for prompts when used with Claude Desktop vs. Claude Code CLI. Each prompt must declare its compatibility level.

---

## Compatibility Levels

### Level 1: DESKTOP-READY (100%)
**Percentage:** 100%

**Definition:** Works completely in Claude Desktop with zero CLI interaction required.

**Characteristics:**
- Pure file read/write operations via MCP Filesystem
- No git commands
- No bash commands
- No external tools required
- 100% self-contained

**Header Format:**
```markdown
**DESKTOP-READY:** 100% compatible with Claude Desktop (zero bash/git required)

**Claude Desktop Compatibility:**
- ✅ Pure file operations via MCP Filesystem
- ✅ No git commands required
- ✅ No bash commands required
- 📋 Works 100% in Desktop
```

**Use Cases:**
- Read-only analysis (Prompt 6: Consistency Checker)
- Report generation (partial - depends on git requirements)
- File compilation (REMOVED - Prompt 5 is now CLI-ONLY)

**Current Prompts:**
- Prompt 6: Consistency Checker

---

### Level 2: DESKTOP-FRIENDLY (95%)
**Percentage:** 95%

**Definition:** Works in Claude Desktop with single copy/paste git commit at the end.

**Characteristics:**
- All file operations via MCP Filesystem
- Single git commit command provided as copy/paste
- User executes git command in Claude Code CLI at end
- No bash commands during execution
- Minor manual step at completion

**Header Format (Standard):**
```markdown
**DESKTOP-FRIENDLY:** Works in Claude Desktop with MCP Filesystem + single copy/paste git commit at end

**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`

**Claude Desktop Compatibility:**
- ✅ All file operations via MCP Filesystem
- ✅ Single git commit command provided as copy/paste at end
- ✅ No bash commands required
- 📋 Works 95% in Desktop
```

**Header Format (With Pandoc/External Tools):**
```markdown
**DESKTOP-FRIENDLY:** Works in Claude Desktop with MCP Filesystem (external tools via Claude Code CLI)

**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`

**Claude Desktop Compatibility:**
- ✅ Core operations via MCP Filesystem
- ✅ External tool commands provided as copy/paste (pandoc, imagemagick, etc.)
- ✅ Git commands provided as copy/paste at end (if needed)
- 📋 Works 95% in Desktop
```

**Git Commit Format Section:**

For prompts that require git commits, include this section:

```markdown
## Git Commit Format (For Claude Desktop Users)

When providing the git commit command at the end, format it like this:

**For Claude Desktop users, provide:**

Go to Claude Code CLI and say:
```
Run: git add [files] && git commit -m '[message]'
```

**The instruction "Go to Claude Code CLI and say:" must be OUTSIDE the code block.**
```

**Current Prompts:**
- Prompt 2: Add New Chapter
- Prompt 3: Modify Target File
- Prompt 4: Integrate Content from Inbox
- Prompt 8: Progress Dashboard (optional git)
- Prompt 10: Update Change Tracking

---

### Level 3: HYBRID (50-80%)
**Percentage:** 50-80%

**Definition:** Works in both Claude Desktop and Claude Code CLI with mixed interaction throughout the process.

**Characteristics:**
- Substantial file operations via MCP Filesystem in Desktop
- Multiple CLI interactions required during execution (not just at end)
- User switches between Desktop and CLI multiple times
- Git operations interspersed throughout workflow
- More complex than DESKTOP-FRIENDLY, less restrictive than CLI-ONLY

**Header Format:**
```markdown
**HYBRID:** Works in both Claude Desktop and Claude Code CLI with mixed interaction.

{SPECIFIC_WORKFLOW_DESCRIPTION}

**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`

**Claude Desktop Compatibility:**
- ✅ Interactive questions work in Desktop
- ✅ File operations via MCP Filesystem
- ⚠️ Git operations via Claude Code CLI (multiple commands throughout)
- 📋 Works {PERCENTAGE}% in Desktop (hybrid workflow)
```

**Example (Prompt 1 - Initialize):**
```markdown
**HYBRID:** Works in both Claude Desktop and Claude Code CLI with mixed interaction.

This prompt performs substantial work in Desktop (creating all files and directories) but requires multiple CLI interactions for git operations throughout the initialization process.

**Claude Desktop Compatibility:**
- ✅ All interactive questions work in Desktop
- ✅ All file/directory creation via MCP Filesystem
- ⚠️ Git operations via Claude Code CLI (copy/paste multiple commands during setup)
- 📋 Works 70% in Desktop (hybrid workflow)
```

**Current Prompts:**
- Prompt 1: Initialize Project Structure (70% Desktop, multiple git operations throughout)

**When to Use HYBRID:**
- Process requires multiple git operations at different stages
- Mix of Desktop file work and CLI git/bash commands
- User needs flexibility to switch between environments
- Not suitable for pure Desktop or pure CLI workflow

---

### Level 4: CLI-ONLY (0%)
**Percentage:** 0%

**Definition:** MUST be run in Claude Code CLI. Does not work in Claude Desktop.

**Characteristics:**
- Requires extensive file I/O operations
- Multiple file reads and large file writes
- Batch processing of many files
- Performance-critical operations
- Not suitable for MCP Filesystem approach

**Header Format:**
```markdown
**CLI-ONLY:** This prompt MUST be run in Claude Code CLI, not Claude Desktop.

{RATIONALE}

**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`
```

**Rationale Examples:**

**Prompt 5 (Compile):**
```markdown
**CLI-ONLY:** This prompt MUST be run in Claude Code CLI, not Claude Desktop.

Compilation involves reading all manuscript files and writing a large compiled draft. Claude Code CLI is optimized for these bulk file operations, regardless of manuscript size.
```

**Detection and Response:**

If user attempts to execute CLI-ONLY prompt in Desktop, respond with:

```markdown
❌ This prompt requires Claude Code CLI.

{PROMPT_NAME} performs bulk file operations that are best handled
by Claude Code CLI, regardless of {PROJECT_CHARACTERISTIC}.

To {ACTION}:
1. Open terminal in your project directory
2. Run: claude
3. Say: "Execute Prompt {NUMBER}"

Claude Code CLI is optimized for file-heavy operations like {OPERATION_TYPE}.
```

**Current Prompts:**
- Prompt 5: Compile Complete Manuscript
- Prompt 7: Export and Format (requires pandoc for DOCX/PDF/EPUB)
- Prompt 9: Git Operations (direct git execution)

---

## Implementation Guidelines

### Choosing Compatibility Level

**Use DESKTOP-READY when:**
- No git commits required
- Pure read operations
- Report generation only
- No external tools

**Use DESKTOP-FRIENDLY when:**
- File modifications required
- Single git commit at end
- No external tool dependencies
- Most interactive workflows

**Use HYBRID when:**
- Multiple git operations at different stages
- Mix of Desktop file work and CLI commands
- User switches between Desktop and CLI throughout
- Setup/initialization workflows
- Complex multi-step processes

**Use CLI-ONLY when:**
- Reading 10+ files
- Writing large files (10,000+ words)
- Batch processing operations
- Performance-critical tasks
- Complex file I/O patterns
- Requires external tools (pandoc, imagemagick)
- Direct git command execution

### Compatibility Testing Checklist

For each prompt, verify:

**DESKTOP-READY:**
- [ ] No git commands anywhere
- [ ] No bash commands anywhere
- [ ] All file operations use MCP Filesystem patterns
- [ ] No external tool dependencies
- [ ] Works completely self-contained

**DESKTOP-FRIENDLY:**
- [ ] File operations use MCP Filesystem
- [ ] Git commands only at end (copy/paste format)
- [ ] No external tool dependencies
- [ ] No bash execution during workflow
- [ ] Single manual step at completion

**HYBRID:**
- [ ] Desktop portions use MCP Filesystem
- [ ] Multiple CLI interactions clearly marked
- [ ] Workflow description explains when to switch
- [ ] Percentage estimate provided (50-80%)
- [ ] User understands back-and-forth pattern

**CLI-ONLY:**
- [ ] Clear rationale provided
- [ ] Detection response implemented
- [ ] Redirect instructions clear
- [ ] Performance benefit explained

---

## Migration Notes

**Version 0.9.2 → 0.10.0 Changes:**

- **Prompt 5 changed:** DESKTOP-READY → CLI-ONLY
  - Rationale: Compilation is batch file operation, best handled by CLI
  - Affects documentation, user guide, installation guide

---

## Usage in Prompts

**Include appropriate header based on compatibility level.**

**Example (DESKTOP-FRIENDLY):**
```markdown
**DESKTOP-FRIENDLY:** Works in Claude Desktop with MCP Filesystem + single copy/paste git commit at end

**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`

**Claude Desktop Compatibility:**
- ✅ All file operations via MCP Filesystem
- ✅ Single git commit command provided as copy/paste at end
- ✅ No bash commands required
- 📋 Works 95% in Desktop
```

---

## Compatibility Summary Table

| Prompt | Level | Compatibility | Git | External Tools |
|--------|-------|---------------|-----|----------------|
| 1 | HYBRID | 70% | Multiple | No |
| 2 | DESKTOP-FRIENDLY | 95% | End | No |
| 3 | DESKTOP-FRIENDLY | 95% | End | No |
| 4 | DESKTOP-FRIENDLY | 95% | End | No |
| 5 | CLI-ONLY | 0% | N/A | N/A |
| 6 | DESKTOP-READY | 100% | No | No |
| 7 | CLI-ONLY | 0% | N/A | Yes (pandoc) |
| 8 | DESKTOP-FRIENDLY | 95% | Optional | No |
| 9 | CLI-ONLY | 0% | N/A | Yes (git) |
| 10 | DESKTOP-FRIENDLY | 95% | Optional | No |

---

**Module Version:** 0.10.0
**Last Updated:** 2025-11-19
**Status:** Active
