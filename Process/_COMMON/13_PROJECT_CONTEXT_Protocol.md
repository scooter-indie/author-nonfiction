# PROJECT_CONTEXT Protocol

**Framework Version:** 0.10.0
**Module:** Project Context File Management
**Purpose:** When and how to update PROJECT_CONTEXT.md

---

## Overview

PROJECT_CONTEXT.md is a generated file that provides complete project state for Claude Desktop session resumption. This module defines when it should be updated and what it should contain.

---

## When to Update

### Always Update

**Prompt 1 (Initialize):**
- Creates PROJECT_CONTEXT.md during initialization
- Includes initial project structure and configuration

**Prompt 8 (Dashboard):**
- Automatically updates PROJECT_CONTEXT.md with latest metrics
- Refreshes current state section
- Updates recent activity

### Conditional Update

**Prompt 3 (Modify File):**
- Updates if significant changes occur:
  - New chapters added/removed (via Prompt 2, but tracked here)
  - Major version bump (N.0.0)
  - User explicitly requests: "Update PROJECT_CONTEXT"
- Does NOT update for minor changes (patch/minor versions)

### Never Update

**Prompts 2, 4, 5, 6, 7, 9, 10:**
- Do not update PROJECT_CONTEXT.md
- User should run Prompt 8 if context update needed

---

## Update Triggers

### Automatic Triggers

1. **During initialization** (Prompt 1)
   - Always creates new file

2. **During dashboard generation** (Prompt 8)
   - Always updates existing file

3. **Major structural change** (Prompt 3 detects)
   - Chapter count changed
   - Major reorganization (version N.0.0)
   - Significant milestone reached

### Manual Triggers

**User requests:**
- "Update PROJECT_CONTEXT"
- "Refresh context file"
- "Regenerate PROJECT_CONTEXT.md"

**Response:** Run Prompt 8 to update

---

## File Structure

```markdown
# PROJECT CONTEXT
**Generated:** {YYYY-MM-DD HH:MM}
**Framework Version:** {VERSION}
**Project Version:** {VERSION}

---

## PART 1: FRAMEWORK OVERVIEW

{Brief framework summary - relatively static}

### Core Principles
{Modularity, traceability, flexibility, quality, safety}

### Directory Structure
{Brief overview of Manuscript/ structure}

### 10 Core Prompts
{List with brief descriptions}

---

## PART 2: THIS BOOK PROJECT

### Project Metadata

**Title:** {Book title}
**Author:** {Author name}
**Target Word Count:** {X}
**Target Audience:** {Audience description}
**Purpose:** {Main thesis}
**Target Completion:** {Date}

### Table of Contents

{Full TOC with chapter titles and status}

### Writing Style

{Configured style name and key characteristics}

---

## PART 3: CURRENT STATE

### Progress Metrics

{Word count, completion percentage, milestones}

### Chapter Status

{Breakdown by chapter with versions and status}

### Recent Activity

{Last 5-10 significant changes}

### Quote/Epigraph Status

{Verification status summary}

### Pending Work

{Known issues, placeholders, citations needed}

### Next Steps

{Recommended actions based on current state}

---

**For Claude Desktop Users:**
Upload this file to Claude Desktop's Files area (not pasted as text) along with System Instructions from Process/Prompts/README.md for seamless session resumption.

---

*Last Updated: {YYYY-MM-DD HH:MM}*
*Framework Version: {VERSION}*
```

---

## Update Procedure

### Step-by-Step

1. **Read current PROJECT_CONTEXT.md** (if exists)
   - Preserve Part 1 (framework overview) if unchanged
   - Prepare to update Part 2 and Part 3

2. **Gather latest project state:**
   - Read Project_Metadata.md
   - Read Manuscript/_TOC_/TOC.md
   - Read Manuscript/Style/Style_Guide.md
   - Scan all chapter files for word counts and versions
   - Read Manuscript/Quotes/Chapter_Quotes.md for quote status
   - Check git log for recent activity

3. **Calculate current metrics:**
   - Total word count (sum of all chapters)
   - Completion percentage (current/target)
   - Average words per chapter
   - Milestone progress (25%, 50%, 75%, 100%)
   - Quote verification status
   - File status counts

4. **Generate updated sections:**
   - Part 1: Usually static (copy from template)
   - Part 2: Update with current project metadata and structure
   - Part 3: Completely refresh with current state

5. **Write updated file:**
   - Overwrite PROJECT_CONTEXT.md
   - Update timestamp
   - Verify file written successfully

6. **Report in operation output:**
   ```markdown
   ✅ PROJECT_CONTEXT.md updated

   Last updated: {timestamp}
   Includes: Current state as of {date}

   For Claude Desktop: Upload this file to Files area for session resumption.
   ```

---

## Content Details

### Part 1: Framework Overview

**Relatively static content:**
- Framework description (from CLAUDE.md)
- Core principles
- Directory structure overview
- List of 10 prompts with brief descriptions
- Quick reference to key concepts

**Update frequency:** Only when framework version changes

### Part 2: This Book Project

**Project-specific but stable:**
- Project metadata (title, author, target, audience, etc.)
- Full table of contents with chapter titles
- Writing style configuration
- Project structure specifics

**Update frequency:**
- Initialize: Always
- Dashboard: Always (in case TOC changed)
- Modify: Only if major changes (chapter added/removed)

### Part 3: Current State

**Dynamic, frequently changing:**
- Current word count and progress
- Chapter-by-chapter status
- Recent git commits (last 5-10)
- Quote verification status
- Known issues and pending work
- Next recommended steps

**Update frequency:**
- Dashboard: Always (this is the point)
- Initialize: Initial snapshot
- Modify: Only if significant changes

---

## No _chg File Required

**PROJECT_CONTEXT.md does NOT have a _chg file.**

**Rationale:**
- It's a generated report, not authored content
- Changes are tracked in the content files it reports on
- Regenerated fresh each time from source data
- Not part of manuscript content

---

## Usage Notes

### For Claude Desktop Users

**Instructions to include in file:**

```markdown
**For Claude Desktop Users:**

To resume your session in Claude Desktop with full project context:

1. Locate this file: PROJECT_CONTEXT.md (in your project root)
2. Open Claude Desktop
3. Click the clip icon (Files area)
4. Upload PROJECT_CONTEXT.md (do NOT copy/paste text)
5. Also upload: Process/Prompts/README.md (System Instructions)
6. Start chatting - Claude will have full project context

**Note:** Upload as file, not pasted text, for optimal context handling.
```

### For Claude Code CLI Users

**Not needed:**
- Claude Code CLI has direct access to all files
- Reads framework documentation directly
- No session resumption needed (persistent access)

---

## Update Decision Tree

```
Is this Prompt 1 (Initialize)?
├─ YES → Create new PROJECT_CONTEXT.md
└─ NO
   │
   Is this Prompt 8 (Dashboard)?
   ├─ YES → Update PROJECT_CONTEXT.md
   └─ NO
      │
      Is this Prompt 3 (Modify)?
      ├─ YES
      │  │
      │  Did chapter count change?
      │  ├─ YES → Update PROJECT_CONTEXT.md
      │  └─ NO
      │     │
      │     Is this a major version (N.0.0)?
      │     ├─ YES → Update PROJECT_CONTEXT.md
      │     └─ NO
      │        │
      │        Did user explicitly request update?
      │        ├─ YES → Update PROJECT_CONTEXT.md
      │        └─ NO → Do NOT update
      │
      └─ NO → Do NOT update
```

---

## Performance Considerations

**Generating PROJECT_CONTEXT.md requires:**
- Reading 10-50+ files
- Calculating word counts
- Parsing git history
- Aggregating statistics

**Minimize unnecessary updates:**
- Only update when state actually changes significantly
- Don't update for every minor modification
- Use Prompt 8 for intentional context refresh

---

**Module Version:** 0.10.0
**Last Updated:** 2025-11-19
**Status:** Active
