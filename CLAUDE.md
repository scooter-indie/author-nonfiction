# AI-Assisted Nonfiction Authoring Framework

**Framework Version:** 0.12.9
**Session Context Document for Claude Code**

---

## FIRST ACTION - MANDATORY

**Before proceeding with ANY other actions, questions, or responses:**

Use the Read tool to read `system-instructions.md` in full. This file contains critical framework rules, structure guidelines, and workflow instructions that must be understood before working with this framework.

**Why this is required:**
- system-instructions.md contains the complete, up-to-date framework rules
- It explains chapter structure (subdirectories vs flat files)
- It defines when to use each prompt
- It prevents common errors like creating files in wrong locations
- It includes the Session Startup Protocol (which tells you to read PROJECT_CONTEXT.md if it exists)

**After reading system-instructions.md, then proceed with this document.**

---

## Purpose of This Document

This document provides Claude Code with the necessary context about the AI-Assisted Nonfiction Authoring Framework at session startup. When you begin a Claude Code session in this directory, Claude will read this file to understand the framework and be ready to execute prompts immediately.

**For Claude Desktop Users:** After running Prompt 1 (Initialize), a `PROJECT_CONTEXT.md` file is created in your book project root. Upload that file to Claude Desktop's Files area (not pasted as text) along with the System Instructions from `Process/Prompts/README.md` for seamless session resumption with full project context.

---

## Framework Overview

This is the **AI-Assisted Nonfiction Authoring Framework** - a comprehensive system for writing nonfiction books with AI assistance using Git version control and structured workflows.

### Key Principles

- **Modularity**: Each chapter and section is a separate file
- **Traceability**: All changes are tracked with rationale
- **Flexibility**: Easy reorganization and restructuring
- **Quality**: Built-in validation and consistency checking
- **Safety**: Git version control with commits before major operations

### File Format

All content files are in Markdown (`.md`) format with accompanying change tracking files (`_chg.md`).

---

## Directory Structure

This installation contains the **Process/** directory with the complete framework:

```
Process/
├── AI-Assisted_Nonfiction_Authoring_Process.md    # Complete framework documentation
├── Anti-Hallucination_Guidelines.md                # Critical rules for AI accuracy
├── Style_Examples.md                                # 9 curated writing styles
├── Prompts/
│   ├── README.md                                    # Prompt usage guide
│   ├── QUICK_REFERENCE.md                           # Workflow quick reference
│   ├── Prompt_1_Initialize.md                       # Create new book project
│   ├── Prompt_2_Add_Chapter.md                      # Add chapters
│   ├── Prompt_3_Change_by_Chg.md                    # Automated revision workflow
│   ├── Prompt_4_Interactive_Change.md               # Conversational editing workflow
│   ├── Prompt_5_Scan_For_User_Edits.md              # Sync change tracking
│   ├── Prompt_6_Integrate_Inbox.md                  # Process inbox content
│   ├── Prompt_7_Compile.md                          # Generate full manuscript
│   ├── Prompt_8_Consistency.md                      # Check consistency
│   ├── Prompt_9_Export.md                           # Export to DOCX/PDF/EPUB
│   ├── Prompt_10_Dashboard.md                       # Progress dashboard
│   ├── Prompt_11_Style_Manager.md                   # Style override management
│   ├── Prompt_12_Git_Operations.md                  # Git operations
│   ├── Prompt_13_AI_Detection_Analysis.md           # Check authentic voice
│   ├── Prompt_14_Visual_Content_Suggester.md        # Text-based visuals
│   └── Prompt_15_Citation_Finder.md                 # Web-verified citations
└── Templates/
    ├── Style_Guide_Template.md                      # Style configuration template
    ├── Custom_Styles_Template.md                    # Custom style template
    ├── README_AUTHORS_template.md                   # Author README template
    ├── installer_template.md                        # Installer template
    ├── gitignore_template                           # Git ignore template
    └── manifest_template.json                       # Manifest template
```

---

## Critical: Anti-Hallucination Guidelines

**ALWAYS** read and apply `Process/Anti-Hallucination_Guidelines.md` before executing any prompt.

**MANDATORY VERIFICATION PROTOCOL:**
- **ASK BEFORE generating** examples, anecdotes, statistics, or quotes
- **NEVER assume** you can speak for user's experiences
- **NEVER fabricate** specific people, data, or quotes
- **ALWAYS use labels**: REAL vs HYPOTHETICAL vs GENERIC
- **ALWAYS verify**: ⏳ Pending | ⚠ Needs Citation | ✓ Verified

Key rules:
- Never fabricate quotes, statistics, or citations
- Mark uncertain content clearly with [VERIFY] or [CITATION NEEDED]
- Verify facts before stating them
- Use proper quote verification status (⏳/⚠/✓)
- Never guess attributions
- Ask user for real experiences before creating examples

---

## How to Use This Framework

### First Time Setup (New Book Project)

If this is your first time using the framework:

1. **Read the framework documentation:**
   - `Process/AI-Assisted_Nonfiction_Authoring_Process.md` (comprehensive guide)
   - `Process/Prompts/QUICK_REFERENCE.md` (quick workflows)

2. **Initialize your book project:**
   - Copy contents of `Process/Prompts/Prompt_1_Initialize.md`
   - Paste into Claude Code
   - Follow interactive setup

3. **Start writing:**
   - Use `Process/Prompts/Prompt_3_Change_by_Chg.md` (automated) or `Prompt_4_Interactive_Change.md` (conversational) for all content changes
   - Track progress with `Process/Prompts/Prompt_10_Dashboard.md`
   - Check consistency with `Process/Prompts/Prompt_8_Consistency.md`

### Continuing Existing Project

If you already have a book project initialized:

1. **Quick status check:**
   - Execute: `Process/Prompts/Prompt_10_Dashboard.md`

2. **Resume writing:**
   - Write instructions in your `_chg.md` files (or use interactive editing)
   - Execute: `Process/Prompts/Prompt_3_Change_by_Chg.md` (automated) or `Prompt_4_Interactive_Change.md` (conversational)

3. **Regular maintenance:**
   - Weekly: Run Prompt 10 (Dashboard)
   - At milestones: Run Prompt 8 (Consistency)

---

## Execute Prompts - How It Works

### Method 1: Copy and Paste (Recommended)

1. Open the prompt file (e.g., `Process/Prompts/Prompt_3_Change_by_Chg.md`)
2. Copy the entire contents
3. Paste into Claude Code
4. Answer any questions Claude asks
5. Claude executes the workflow

### Method 2: Direct Reference

Simply say to Claude:
- "Execute Prompt 1" or "Run Prompt 1"
- "Execute Prompt 3 to modify Chapter 5"
- "Run the consistency checker" (Prompt 8)
- "Show me the dashboard" (Prompt 10)

Claude will read the appropriate prompt file and execute it.

---

## 16 Core Prompts (v0.12.1+)

### Prompt 1: Initialize Project Structure
**Purpose:** Create new book project from scratch
**When:** Starting a brand new book
**Output:** Complete project structure with git repo

### Prompt 2: Add New Chapter
**Purpose:** Add chapter to existing book
**When:** Need to insert a new chapter
**Output:** New chapter files, renumbered existing chapters, updated TOC

### Prompt 3: Change by Chg
**Purpose:** Execute instructions from _chg files (automated workflow)
**When:** You've written instructions in _chg file and want them applied
**Output:** Modified content, updated change tracking, git commit
**Note:** For interactive editing, use Prompt 4 instead

### Prompt 4: Interactive Change (NEW in v0.11.0)
**Purpose:** Conversational editing that writes instructions to _chg files
**When:** You want to discuss changes interactively before applying
**Output:** Instructions written to _chg file, optionally execute Prompt 3
**Note:** Alternative to manually writing _chg instructions

### Prompt 5: Scan For User Edits
**Purpose:** Detect manual edits and synchronize _chg files
**When:** After manual edits, before milestones, weekly maintenance
**Output:** Updated _chg files with version history

### Prompt 6: Integrate Inbox
**Purpose:** Process files from Inbox/ directory
**When:** Have content, references, or assets to integrate
**Output:** Integrated content, archived inbox items

### Prompt 7: Compile Complete Manuscript
**Purpose:** Generate single file with entire manuscript
**When:** Review entire book, prepare for editing
**Output:** `Drafts/Full_Draft_[date]_v[version].md`

### Prompt 8: Consistency Checker
**Purpose:** Check for consistency issues across all content
**When:** Weekly, at milestones, before compilation/export
**Output:** Comprehensive report with Critical/Warning/Suggestion categories

### Prompt 9: Export and Format
**Purpose:** Export to DOCX, PDF, EPUB, LaTeX
**When:** Preparing for publication or submission
**Output:** Formatted files in `Exports/[date]/` directory

### Prompt 10: Progress Dashboard
**Purpose:** Generate progress report and project status
**When:** Weekly check-ins, after major changes
**Output:** Comprehensive dashboard with metrics and recommendations

### Prompt 11: Style Manager
**Purpose:** Manage hierarchical style system (book/chapter/section overrides)
**When:** Adding/removing style overrides, analyzing distribution, validating registry
**Output:** Updated override registry, style analysis reports, validated consistency

### Prompt 12: Git Operations
**Purpose:** Perform git version control operations
**When:** Commit, tag, branch, view history, push/pull
**Output:** Git operation result and next recommendations

### Prompt 13: AI Detection Analysis (NEW in v0.11.0)
**Purpose:** Analyze chapters for AI-generated text indicators
**When:** After drafting, before milestones, when concerned about authenticity
**Output:** Authenticity scores, flagged passages, rewriting suggestions
**Note:** Helps ensure content sounds authentically yours

### Prompt 14: Citation Finder (NEW in v0.11.0 Phase 2)
**Purpose:** Find and insert citations with WebSearch verification
**When:** Adding factual claims, statistics, or expert quotes; verifying existing citations
**Output:** Properly formatted citations with source verification
**Note:** Ensures accurate attribution and findable sources

### Prompt 15: Visual Content Suggester (NEW in v0.11.0 Phase 2)
**Purpose:** Analyze chapters and create text-based visuals (tables, diagrams, flowcharts)
**When:** After drafting content, during revision, when explanations need visual support
**Output:** Markdown tables, ASCII diagrams, structured data displays in Manuscript/images/
**Note:** Enhances understanding without requiring graphics software

### Prompt 16: Image Manager (NEW in v0.12.1)
**Purpose:** Manage actual image files (photos, screenshots, professional graphics)
**When:** Adding photos/screenshots, upgrading text-based visuals, validating image references
**Output:** Images in Manuscript/images/, updated Image_Registry.md, inserted references
**Note:** Semi-automated workflow with registry coordination

---

## Quick Compatibility Reference

**When asked "list prompts", use this accurate classification:**

### DESKTOP-FRIENDLY (95% - Single git command at end)
- **Prompt 2:** Add New Chapter - Uses MCP Filesystem for all operations including directory renaming
- **Prompt 3:** Change by Chg - Automated _chg file execution
- **Prompt 4:** Interactive Change - Conversational editing workflow (NEW)
- **Prompt 5:** Scan For User Edits - Detect manual changes
- **Prompt 6:** Integrate Inbox - Process inbox files
- **Prompt 10:** Progress Dashboard - Status reports

### HYBRID (50-80% - Mixed Desktop/CLI interaction)
- **Prompt 1:** Initialize Project Structure - File creation in Desktop, git via CLI throughout
- **Prompt 11:** Style Manager - Single-file ops in Desktop, multi-file scans better in CLI

### CLI-ONLY (0% - Must use Claude Code CLI)
- **Prompt 7:** Compile Complete Manuscript - Bulk file operations
- **Prompt 8:** Consistency Checker - Bulk file reads (30-50+ files across chapters, images, bibliography, styles)
- **Prompt 9:** Export and Format - Requires pandoc for DOCX/PDF/EPUB
- **Prompt 12:** Git Operations - Direct git command execution
- **Prompt 13:** AI Detection Analysis - Bulk chapter analysis (NEW)
- **Prompt 14:** Citation Finder - Requires WebSearch for verification (NEW Phase 2)
- **Prompt 15:** Visual Content Suggester - Bulk file operations and visual analysis (NEW Phase 2)
- **Prompt 16:** Image Manager - File operations, registry updates, semi-automated workflow (NEW v0.12.1)

**Key Points:**
- Prompts 3 & 4 are both **DESKTOP-FRIENDLY** workflows - choose based on preference
  - Prompt 3: You write instructions manually → Execute
  - Prompt 4: Interactive conversation → AI writes instructions → Optionally execute
- Prompt 2 is **DESKTOP-FRIENDLY** (not CLI-ONLY) - MCP Filesystem handles directory operations
- Prompt 8 is **CLI-ONLY** - scans 30-50+ files for full consistency analysis
- Prompt 11 is **HYBRID** - use Desktop for simple ops, CLI for validation/scanning
- Prompts 7, 8, 9, 12, 13, 14, 15, 16 are **CLI-ONLY** - require bulk operations, WebSearch, or system tools

---

## Writing Style System

### Hierarchical Style System (v0.10.1+)

The framework uses a three-level cascading style inheritance system:

```
Book Style (Global Default)
  ↓ inherits
Chapter Style (Optional Override)
  ↓ inherits
Section Style (Optional Override)
```

**Three Levels:**

1. **Book-Level Style** (configured in `Manuscript/Style/Style_Guide.md`)
   - Your global default style for the entire book
   - Selected during Prompt 1 (Initialize)
   - Applies to all content unless overridden

2. **Chapter-Level Overrides** (optional `Chapter_XX_style.md` files)
   - Override book style for specific chapters
   - Useful for technical appendices, narrative case studies, etc.
   - Created via Prompt 2 (Add Chapter) or Prompt 11 (Style Manager)

3. **Section-Level Overrides** (HTML comment markers in content)
   - Override for specific sections within chapters
   - Format: `<!-- STYLE_OVERRIDE: StyleName -->...</content>...<!-- END_STYLE_OVERRIDE -->`
   - Useful for code examples, interviews, anecdotes

**Central Registry:**
- `Manuscript/Style/Style_Overrides.md` tracks all overrides
- Shows style distribution across your book
- Monitors 30% override threshold (guideline for appropriate book-level choice)
- Documents style transitions for smooth reader experience

**9 Framework Styles Available:**

1. **Academic Authority** - Scholarly, research-based
2. **Conversational Expert** - Business/professional, accessible
3. **Narrative Storyteller** - Memoir-adjacent, first-person
4. **Business Professional** - Management/leadership focused
5. **Technical Precision** - Technical guides, systematic
6. **Investigative Journalist** - Evidence-based revelation
7. **Practical Guide** - How-to, step-by-step
8. **Inspirational Teacher** - Personal development, motivational
9. **Scientific Communicator** - Popular science, wonder with rigor

**How to Use:**
- **Prompt 1** (Initialize): Select book-level style, creates Style_Overrides.md
- **Prompt 2** (Add Chapter): Optionally set chapter-level override when creating chapter
- **Prompt 3** (Change by Chg): Automatically applies active style using cascading resolution
- **Prompt 8** (Consistency): Analyzes style distribution and transitions
- **Prompt 10** (Dashboard): Shows style distribution summary
- **Prompt 11** (Style Manager): Add/remove/analyze overrides, validate registry

**Location:** `Process/Style_Examples.md` contains complete style definitions with examples.

---

## Quote Management System

The framework includes centralized quote/epigraph management:

- **Status codes:** ⏳ Pending | ⚠ Needs Citation | ✓ Verified
- **Central file:** `Quotes/Chapter_Quotes.md` (created during Prompt 1)
- **Workflow:** Use Prompt 3 to add/update quotes
- **Compilation:** Verified (✓) quotes auto-inserted as chapter epigraphs
- **Verification:** Never fabricate quotes - see Anti-Hallucination Guidelines

---

## Change Tracking System

### Version Numbering: N.M.P (Semantic Versioning)

- **Major (N):** Structural changes affecting multiple chapters
- **Minor (M):** Significant content revisions within a chapter
- **Patch (P):** Minor edits, typos, formatting corrections

### Workflow

1. **Author writes instructions** in `[filename]_chg.md` file
2. **Author commits** the _chg file to git
3. **Execute Prompt 3** to modify the file
4. **AI reads instructions** from _chg file
5. **AI applies changes** to content file
6. **AI auto-archives** instructions to Version History
7. **AI clears** instruction section for next revision
8. **AI commits** to git with version information

---

## Git Integration

**All operations use Git for version control:**
- Commits before major operations
- Descriptive commit messages
- Tags for milestones
- Remote backup recommended

**Git operations via Prompt 12:**
- Commit, tag, branch, merge
- View history and diffs
- Push/pull to remote
- Status checks

---

## Quick Reference: Common Workflows

### Daily Writing Session
1. Run Prompt 10 → Dashboard
2. Work on content
3. Write revision instructions in _chg files (or use Prompt 4 for interactive editing)
4. Run Prompt 3 for each file (or Prompt 4 handles execution automatically)
5. Run Prompt 12 → Push

### Weekly Review
1. Prompt 10 → Dashboard
2. Prompt 8 → Consistency Check
3. Prompt 7 → Compile manuscript
4. Fix issues using Prompt 3 or Prompt 4
5. Prompt 12 → Commit and push

### Milestone Workflow (25%, 50%, 75%, 100%)
1. Prompt 10 → Verify progress
2. Prompt 8 → Full consistency check
3. Prompt 13 → AI Detection Analysis (check authenticity)
4. Fix all issues using Prompt 3 or Prompt 4
5. Prompt 7 → Compile final version
6. Prompt 12 → Create tag (e.g., v1.0.0)
7. Prompt 12 → Push with tags

---

## Important Files to Reference

### Must Read:
- `Process/Anti-Hallucination_Guidelines.md` - Critical rules for accuracy
- `Process/Prompts/QUICK_REFERENCE.md` - Workflow guide

### Comprehensive Documentation:
- `Process/AI-Assisted_Nonfiction_Authoring_Process.md` - Complete framework guide

### Style Library:
- `Process/Style_Examples.md` - 9 curated professional styles

---

## Session Startup Checklist

When Claude Code starts in this directory:

✅ **FIRST: Read system-instructions.md** - Complete framework rules, structure guidelines, and startup protocol
✅ **Read this file (CLAUDE.md)** - Framework context loaded
✅ **Load Anti-Hallucination Guidelines** - Critical rules ready
✅ **Anti-Hallucination Verification Active** - ASK before assuming user experiences
✅ **Framework documentation available** - Process/ directory accessible
✅ **CONFIRM DATE WITH USER** - See Date Confirmation Protocol below
✅ **Ready to execute prompts** - User can say "Execute Prompt X"

**Note:** system-instructions.md includes the Session Startup Protocol which tells you to read PROJECT_CONTEXT.md if it exists.

---

## Date Confirmation Protocol

**CRITICAL: Date must be confirmed at every session startup to prevent incorrect dates in files.**

### Session Startup Procedure

1. **At the start of every Claude Code session**, before any other interaction:
   - Display the date from `<env>`: "Today's date is [YYYY-MM-DD]. Is this correct?"
   - Wait for user confirmation

2. **If user confirms date is correct:**
   - Store confirmed date in session context as: `CONFIRMED_DATE=[YYYY-MM-DD]`
   - Use this date for ALL operations during the session

3. **If user says date is incorrect:**
   - Ask: "What is the correct date? (YYYY-MM-DD format)"
   - Store user-provided date as: `CONFIRMED_DATE=[YYYY-MM-DD]`
   - Use this date for ALL operations during the session

### Date Format

- **Always use ISO format:** `YYYY-MM-DD` (e.g., `2025-11-20`)
- This format is used for:
  - Filenames: `Full_Draft_2025-11-20_v1.0.0.md`
  - Directory names: `Exports/2025-11-20/`
  - Chapter creation metadata
  - Git commit messages
  - Dashboard reports

### Passing Date to Agents

**When spawning agents (using Task tool):**
- Agents automatically inherit the confirmed date from the parent session context
- Include explicit instruction in agent prompt: "Today's confirmed date is [CONFIRMED_DATE]. Use this date for all operations."
- Never allow agents to use unchecked `<env>` dates

### Prompts That Write Dates

The following prompts write dates to files and MUST use `CONFIRMED_DATE`:

- **Prompt 1 (Initialize):** Creates initial project structure with date metadata
- **Prompt 2 (Add Chapter):** Writes chapter creation date
- **Prompt 7 (Compile):** Creates `Full_Draft_[date]_v[version].md`
- **Prompt 9 (Export):** Creates `Exports/[date]/` directory

**All date-writing prompts have been updated with explicit reminders to use CONFIRMED_DATE.**

---

## Support

- **Documentation:** `Process/AI-Assisted_Nonfiction_Authoring_Process.md`
- **Quick Reference:** `Process/Prompts/QUICK_REFERENCE.md`
- **Issues/Bugs:** https://github.com/scooter-indie/author-nonfiction/issues
- **Releases:** https://github.com/scooter-indie/author-nonfiction/releases

---

**Framework Version:** 0.12.9
**Last Updated:** 2025-11-22

---

*This document ensures Claude Code has full framework context at session startup*
*User can immediately execute any prompt without additional context loading*
