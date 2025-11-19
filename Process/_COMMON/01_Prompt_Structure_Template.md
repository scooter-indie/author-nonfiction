# Prompt Structure Template

**Framework Version:** 0.10.0
**Module:** Common Structure Template
**Purpose:** Standardized template for all Execute Prompts

---

## Overview

This template provides the standardized structure that all Execute Prompts should follow. It ensures consistency, clarity, and complete functionality across the framework.

---

## Standard Prompt Structure

```markdown
# Execute Prompt {PROMPT_NUMBER}: {PROMPT_NAME}

**{COMPATIBILITY_TYPE}:** {COMPATIBILITY_DESCRIPTION}

**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`

**CRITICAL ENFORCEMENT:**
- **RULE 1:** All file modifications MUST update corresponding _chg files
- **RULE 2:** All Manuscript/ changes must go through appropriate prompts

See: `Process/ENFORCEMENT_RULES.md` for complete details

{ENFORCEMENT_NOTE}

{ADDITIONAL_HEADERS}

---

## What This Does

{WHAT_THIS_DOES}

---

{ANTI_HALLUCINATION_SECTION}

---

## How This Works

{HOW_THIS_WORKS_INTRO}

### Questions I'll ask:

{QUESTIONS_LIST}

### Then I'll:

{WORKFLOW_STEPS}

---

{ADDITIONAL_SECTIONS}

---

## Ready to Begin?

{READY_PROMPT}

---

*Reference: Process/AI-Assisted_Nonfiction_Authoring_Process.md (Prompt {PROMPT_NUMBER})*
```

---

## Variable Definitions

### {PROMPT_NUMBER}
- Number: 1-10
- Example: `1`, `3`, `10`

### {PROMPT_NAME}
- Clear, action-oriented description
- Examples:
  - "Initialize Project Structure"
  - "Modify Target File"
  - "Compile Complete Manuscript"

### {COMPATIBILITY_TYPE}
- Options:
  - **DESKTOP-READY:** 100% compatible with Claude Desktop (no CLI required)
  - **DESKTOP-FRIENDLY:** 95% compatible (single git commit copy/paste at end)
  - **CLI-ONLY:** Must be run in Claude Code CLI

### {COMPATIBILITY_DESCRIPTION}
- DESKTOP-READY: `100% compatible with Claude Desktop (zero bash/git required)`
- DESKTOP-FRIENDLY: `Works in Claude Desktop with MCP Filesystem + single copy/paste git commit at end`
- CLI-ONLY: `This prompt MUST be run in Claude Code CLI, not Claude Desktop.`

### {ENFORCEMENT_NOTE}
- For prompts that modify files (1, 2, 3, 4, 10):
  ```markdown
  **NOTE:** This prompt updates _chg files as part of the standard workflow
  ```

- For read-only prompts (5, 6, 7, 8, 9):
  ```markdown
  **NOTE:** This is a read-only/export operation. No _chg updates are required (does not modify source files)
  ```

### {ADDITIONAL_HEADERS}
- Optional section for prompt-specific headers
- Examples:
  - Claude Desktop Compatibility details
  - Special requirements
  - Prerequisites

### {WHAT_THIS_DOES}
- 2-4 sentence description of prompt's purpose
- Clear, user-focused language
- What files will be created/modified/analyzed
- What problem it solves

### {ANTI_HALLUCINATION_SECTION}
- Optional section for content-generating prompts
- See: `03_Anti_Hallucination_Protocols.md`
- Include appropriate level (1, 2, or 3)

### {HOW_THIS_WORKS_INTRO}
- Brief introduction to the workflow
- Set expectations
- Describe interaction pattern

### {QUESTIONS_LIST}
- Numbered list of questions the AI will ask
- Clear, specific
- Include conditional branches if applicable
- Example:
  ```markdown
  1. What is the working title of your book?
  2. What is your name (author)?

  **If Option A:**
  3. [Sub-question A]

  **If Option B:**
  3. [Sub-question B]
  ```

### {WORKFLOW_STEPS}
- Numbered list of actions the AI will perform
- Clear, sequential
- Include all major steps
- Highlight _chg file updates for file-modifying prompts
- Example:
  ```markdown
  1. Validate file exists
  2. Read current content
  3. Apply modifications
  4. **Update corresponding _chg file with version entry**
  5. Create git commit
  6. Generate report
  ```

### {ADDITIONAL_SECTIONS}
- Prompt-specific content
- May include:
  - Important Notes
  - Examples
  - Configuration Options
  - Git Commit Format
  - Special Cases
  - Troubleshooting

### {READY_PROMPT}
- Standard confirmation request
- Default: `Say "yes" or "ready" when you're ready to begin, or ask any questions first.`
- Can be customized per prompt

---

## Enforcement Rules Integration

**ALL prompts must include:**

1. **Enforcement notice** in header (after anti-hallucination reference)
2. **Enforcement note** explaining _chg behavior for this prompt
3. **_chg update steps** in workflow (if applicable)
4. **Git commit validation** (if applicable)

---

## Standard Sections Order

1. Title
2. Compatibility header
3. Anti-hallucination reference
4. Enforcement rules reference
5. Enforcement note
6. Additional headers (optional)
7. "What This Does"
8. Anti-hallucination section (if applicable)
9. "How This Works"
10. Questions list
11. Workflow steps
12. Additional sections (prompt-specific)
13. "Ready to Begin?"
14. Reference footer

---

## Usage Example

See: `Prompt_1_Initialize.md` for a complete implementation example.

---

**Module Version:** 0.10.0
**Last Updated:** 2025-11-19
**Status:** Active
