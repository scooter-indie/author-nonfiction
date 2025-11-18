# AI-Assisted Nonfiction Authoring Framework

**Framework Version:** 3.5.0
**Session Context Document for Claude Code**

---

## Purpose of This Document

This document provides Claude Code with the necessary context about the AI-Assisted Nonfiction Authoring Framework at session startup. When you begin a Claude Code session in this directory, Claude will read this file to understand the framework and be ready to execute prompts immediately.

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
│   ├── Prompt_3_Modify_File.md                      # Primary revision workflow
│   ├── Prompt_4_Integrate_Inbox.md                  # Process inbox content
│   ├── Prompt_5_Compile.md                          # Generate full manuscript
│   ├── Prompt_6_Consistency.md                      # Check consistency
│   ├── Prompt_7_Export.md                           # Export to DOCX/PDF/EPUB
│   ├── Prompt_8_Dashboard.md                        # Progress dashboard
│   ├── Prompt_9_Git.md                              # Git operations
│   └── Prompt_10_Update_Change_Tracking.md          # Sync change tracking
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

Key rules:
- Never fabricate quotes, statistics, or citations
- Mark uncertain content clearly
- Verify facts before stating them
- Use proper quote verification status (⏳/⚠/✓)
- Never guess attributions

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
   - Use `Process/Prompts/Prompt_3_Modify_File.md` for all content changes
   - Track progress with `Process/Prompts/Prompt_8_Dashboard.md`
   - Check consistency with `Process/Prompts/Prompt_6_Consistency.md`

### Continuing Existing Project

If you already have a book project initialized:

1. **Quick status check:**
   - Execute: `Process/Prompts/Prompt_8_Dashboard.md`

2. **Resume writing:**
   - Write instructions in your `_chg.md` files
   - Execute: `Process/Prompts/Prompt_3_Modify_File.md`

3. **Regular maintenance:**
   - Weekly: Run Prompt 8 (Dashboard)
   - At milestones: Run Prompt 6 (Consistency)

---

## Execute Prompts - How It Works

### Method 1: Copy and Paste (Recommended)

1. Open the prompt file (e.g., `Process/Prompts/Prompt_3_Modify_File.md`)
2. Copy the entire contents
3. Paste into Claude Code
4. Answer any questions Claude asks
5. Claude executes the workflow

### Method 2: Direct Reference

Simply say to Claude:
- "Execute Prompt 1" or "Run Prompt 1"
- "Execute Prompt 3 to modify Chapter 5"
- "Run the consistency checker" (Prompt 6)
- "Show me the dashboard" (Prompt 8)

Claude will read the appropriate prompt file and execute it.

---

## 10 Core Prompts

### Prompt 1: Initialize Project Structure
**Purpose:** Create new book project from scratch
**When:** Starting a brand new book
**Output:** Complete project structure with git repo

### Prompt 2: Add New Chapter
**Purpose:** Add chapter to existing book
**When:** Need to insert a new chapter
**Output:** New chapter files, renumbered existing chapters, updated TOC

### Prompt 3: Modify Target File
**Purpose:** PRIMARY workflow for all content revisions
**When:** Any content changes (chapters, quotes, front/back matter)
**Output:** Modified content, updated change tracking, git commit

### Prompt 4: Integrate Content from Inbox
**Purpose:** Process files from Inbox/ directory
**When:** Have content, references, or assets to integrate
**Output:** Integrated content, archived inbox items

### Prompt 5: Compile Complete Manuscript
**Purpose:** Generate single file with entire manuscript
**When:** Review entire book, prepare for editing
**Output:** `Drafts/Full_Draft_[date]_v[version].md`

### Prompt 6: Consistency Checker
**Purpose:** Check for consistency issues across all content
**When:** Weekly, at milestones, before compilation/export
**Output:** Comprehensive report with Critical/Warning/Suggestion categories

### Prompt 7: Export and Format
**Purpose:** Export to DOCX, PDF, EPUB, LaTeX
**When:** Preparing for publication or submission
**Output:** Formatted files in `Exports/[date]/` directory

### Prompt 8: Progress Dashboard
**Purpose:** Generate progress report and project status
**When:** Weekly check-ins, after major changes
**Output:** Comprehensive dashboard with metrics and recommendations

### Prompt 9: Git Operations
**Purpose:** Perform git version control operations
**When:** Commit, tag, branch, view history, push/pull
**Output:** Git operation result and next recommendations

### Prompt 10: Update Change Tracking
**Purpose:** Synchronize _chg files with content changes
**When:** After manual edits, before milestones, weekly maintenance
**Output:** Updated _chg files with version history

---

## Writing Style System

The framework includes 9 professionally curated writing styles:

1. **Academic Authority** - Scholarly, research-based
2. **Conversational Expert** - Business/professional, accessible
3. **Narrative Storyteller** - Memoir-adjacent, first-person
4. **Business Professional** - Management/leadership focused
5. **Technical Precision** - Technical guides, systematic
6. **Investigative Journalist** - Evidence-based revelation
7. **Practical Guide** - How-to, step-by-step
8. **Inspirational Teacher** - Personal development, motivational
9. **Scientific Communicator** - Popular science, wonder with rigor

**During Prompt 1 (Initialize):** You'll select or customize a writing style for your book.

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

**Git operations via Prompt 9:**
- Commit, tag, branch, merge
- View history and diffs
- Push/pull to remote
- Status checks

---

## Quick Reference: Common Workflows

### Daily Writing Session
1. Run Prompt 8 → Dashboard
2. Work on content
3. Write revision instructions in _chg files
4. Run Prompt 3 for each file
5. Run Prompt 9 → Push

### Weekly Review
1. Prompt 8 → Dashboard
2. Prompt 6 → Consistency Check
3. Prompt 5 → Compile manuscript
4. Fix issues using Prompt 3
5. Prompt 9 → Commit and push

### Milestone Workflow (25%, 50%, 75%, 100%)
1. Prompt 8 → Verify progress
2. Prompt 6 → Full consistency check
3. Fix all issues using Prompt 3
4. Prompt 5 → Compile final version
5. Prompt 9 → Create tag (e.g., v1.0.0)
6. Prompt 9 → Push with tags

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

✅ **Read this file (CLAUDE.md)** - Framework context loaded
✅ **Load Anti-Hallucination Guidelines** - Critical rules ready
✅ **Framework documentation available** - Process/ directory accessible
✅ **Ready to execute prompts** - User can say "Execute Prompt X"

---

## Support

- **Documentation:** `Process/AI-Assisted_Nonfiction_Authoring_Process.md`
- **Quick Reference:** `Process/Prompts/QUICK_REFERENCE.md`
- **Issues/Bugs:** https://github.com/scooter-indie/author-nonfiction/issues
- **Releases:** https://github.com/scooter-indie/author-nonfiction/releases

---

**Framework Version:** 3.5.0
**Last Updated:** 2025-11-17

---

*This document ensures Claude Code has full framework context at session startup*
*User can immediately execute any prompt without additional context loading*
