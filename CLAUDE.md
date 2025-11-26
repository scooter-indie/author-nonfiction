# AI-Assisted Nonfiction Authoring Framework

**Framework Version:** 0.14.2
**Session Context Document for Claude Code**

---

## FIRST ACTION - MANDATORY

**At the start of EVERY Claude Code session, run:**

```
/fw-init
```

This slash command performs the Session Startup Protocol:
- Process/FRAMEWORK_CORE.md (essential framework knowledge)
- PROJECT_CONTEXT.md (if book project exists)
- Additional docs load on-demand when needed

**Why this is mandatory:**
- Loads essential framework rules
- Activates Anti-Hallucination Protocol (ASK FIRST verification)
- Loads prompt compatibility matrix (CLI vs Desktop)
- Checks for existing book project context
- Provides verbose initialization report

**IMPORTANT:** Do NOT execute any prompts until `/fw-init` completes successfully.

**After `/fw-init` completes, you are ready to work.**

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
- **Concurrency**: Lock management for multi-instance editing (v0.13.0+)

### File Format

All content files are in Markdown (`.md`) format with accompanying change tracking files (`_chg.md`).

---

## Directory Structure

This installation contains the **Process/** directory with the complete framework:

```
Process/
├── FRAMEWORK_CORE.md                                # NEW v0.13.0: Instant-load essentials
├── AI-Assisted_Nonfiction_Authoring_Process.md    # Complete framework documentation (on-demand)
├── Anti-Hallucination_Guidelines.md                # Critical rules for AI accuracy (on-demand)
├── Styles/                                          # Modular style library (v0.13.0+)
│   ├── Style_Catalog.md                             # Master catalog of 19 styles
│   ├── README.md                                    # Style library guide
│   ├── Academic/                                    # Academic & Research (4 styles)
│   ├── Professional/                                # Business & Professional (2 styles)
│   ├── Narrative/                                   # Narrative & Storytelling (4 styles)
│   ├── Personal/                                    # Personal Development (3 styles)
│   └── Cultural/                                    # Cultural & Social Commentary (6 styles)
├── Prompts/
│   ├── README.md                                    # Prompt usage guide (on-demand)
│   ├── QUICK_REFERENCE.md                           # Workflow quick reference (on-demand)
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

**The Anti-Hallucination Protocol is loaded from FRAMEWORK_CORE.md at session startup.**

**MANDATORY VERIFICATION PROTOCOL:**
- **ASK BEFORE generating** examples, anecdotes, statistics, or quotes
- **NEVER assume** you can speak for user's experiences
- **NEVER fabricate** specific people, data, or quotes
- **ALWAYS use labels**: REAL vs HYPOTHETICAL vs GENERIC
- **ALWAYS verify**: ⏳ Pending | ⚠ Needs Citation | ✓ Verified

**Full protocol details:** Loaded in FRAMEWORK_CORE.md (Section 1) or load `Process/Anti-Hallucination_Guidelines.md` on-demand

---

## Token Management Best Practices

### Why Token Management Matters

Claude Code sessions have a 200,000 token budget. Framework prompts can consume significant tokens, leaving less room for your actual content work.

### Clear Completed Prompts

After a prompt completes, clear it from context to reclaim tokens:

**Specific Prompt:**
- "Clear Prompt 1 from context" (saves ~25,000 tokens)
- "Clear Prompt 4 from context" (saves ~2,000 tokens in v0.14.1)
- "Remove Prompt 8 from session" (saves ~20,000 tokens)

**All Prompts:**
- "Clear all framework prompts"
- "Reset context, keep only my content"

### When to Clear Context

**✅ Always clear after:**
- **Prompt 1 (Initialize)** - One-time setup, no longer needed
- **Prompt 2 (Add Chapter)** - After adding chapter
- **Prompt 4 (Interactive Change)** - After writing instructions
- **Prompt 7 (Compile)** - After compilation complete
- **Prompt 8 (Consistency)** - After review complete
- **Prompt 9 (Export)** - After export complete
- **Prompt 10 (Dashboard)** - After viewing dashboard
- **Prompt 13 (AI Detection)** - After analysis complete
- **Prompt 14 (Citation Finder)** - After citations added
- **Prompt 15 (Visual Content)** - After visuals created
- **Prompt 16 (Image Manager)** - After images organized

**⚠️ Keep in context if:**
- **Prompt 3 (Change by Chg)** - If applying multiple _chg files in sequence
- **Prompt 5 (Scan Edits)** - If scanning multiple files
- **Prompt 6 (Integrate Inbox)** - If processing multiple inbox items
- **Prompt 11 (Style Manager)** - If managing multiple style overrides

### Token Budget Awareness

**Check remaining tokens:**
Ask: "How many tokens do I have remaining?"

**Typical session flow:**
1. Start: 200,000 tokens
2. Load Prompt: tokens consumed
3. Clear Prompt: tokens reclaimed
4. Work on content: most tokens available

**Best practice:** Clear prompts immediately after completion for maximum available tokens.

---

## How to Use This Framework

### First Time Setup (New Book Project)

If this is your first time using the framework:

1. **Read the framework documentation:**
   - `Documentation/AI-Assisted_Nonfiction_Authoring_Process.md` (comprehensive guide)
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
**Output:** `Drafts/[Project-Name]-[format]-vNN.md`

### Prompt 8: Consistency Checker
**Purpose:** Check for consistency issues across all content
**When:** Weekly, at milestones, before compilation/export
**Output:** Comprehensive report with Critical/Warning/Suggestion categories

### Prompt 9: Export and Format
**Purpose:** Export to DOCX, PDF, EPUB, LaTeX
**When:** Preparing for publication or submission
**Output:** `Exports/[Project-Name]-vNN.[format]`

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

**19 Framework Styles Available Across 5 Categories:**

**Academic & Research (4 styles):**
1. **Academic Authority** - Scholarly, research-based
2. **Scientific Communicator** - Popular science, wonder with rigor
3. **Technical Precision** - Technical guides, systematic
4. **Medical/Health Narrative** - Clinical knowledge + human experience

**Business & Professional (2 styles):**
5. **Business Professional** - Management/leadership focused
6. **Conversational Expert** - Business/professional, accessible

**Narrative & Storytelling (4 styles):**
7. **Narrative Storyteller** - Memoir-adjacent, first-person
8. **Historical Chronicler** - Narrative history, scholarly storytelling
9. **Investigative Journalist** - Evidence-based revelation
10. **Confessional Memoir** - Raw honesty, vulnerability

**Personal Development & How-To (3 styles):**
11. **Practical Guide** - How-to, step-by-step
12. **Inspirational Teacher** - Personal development, motivational
13. **Philosophical Contemplative** - Reflective inquiry, ethics

**Cultural & Social Commentary (6 styles):**
14. **Cultural Critic** - Sharp observation, essayistic
15. **Satirical Humorist** - Witty, ironic, comedic
16. **Activist Advocate** - Social justice, call to action
17. **Lyrical Nature Writer** - Poetic, sensory, ecological
18. **Spiritual/Religious Writer** - Contemplative, sacred traditions
19. **Sports Writer** - Athletic narratives, competitive drama

**How to Use:**
- **Prompt 1** (Initialize): Select book-level style, creates Style_Overrides.md
- **Prompt 2** (Add Chapter): Optionally set chapter-level override when creating chapter
- **Prompt 3** (Change by Chg): Automatically applies active style using cascading resolution
- **Prompt 8** (Consistency): Analyzes style distribution and transitions
- **Prompt 10** (Dashboard): Shows style distribution summary
- **Prompt 11** (Style Manager): Add/remove/analyze overrides, validate registry

**Location:** `Process/Styles/Style_Catalog.md` contains the master catalog. Individual style files are in category subdirectories (Academic/, Professional/, Narrative/, Personal/, Cultural/).

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

### Always Loaded at Startup:
- `Process/FRAMEWORK_CORE.md` - Essential framework knowledge (instant load)

### Load On-Demand When Needed:
- `Process/Anti-Hallucination_Guidelines.md` - Full accuracy protocol details
- `Process/Prompts/QUICK_REFERENCE.md` - Workflow guide
- `Documentation/AI-Assisted_Nonfiction_Authoring_Process.md` - Complete framework guide
- `Process/Prompts/README.md` - Detailed prompt documentation
- `Process/Styles/README.md` - Style library details

---

## Session Startup Checklist

When Claude Code starts in this directory:

✅ **MANDATORY: Run `/fw-init` command** - User types `/fw-init` at session start
✅ **CLAUDE.md auto-loaded** - Framework context from system
✅ **Initialization in progress** - `/fw-init` loads essential framework documentation:
   - Process/FRAMEWORK_CORE.md (essential knowledge)
   - PROJECT_CONTEXT.md (if book project exists)
   - Additional docs load on-demand when needed
✅ **Anti-Hallucination Protocol Active** - ASK before assuming user experiences
✅ **CONFIRM DATE WITH USER** - See Date Confirmation Protocol below
✅ **Initialization complete** - Verbose report displayed
✅ **Ready to execute prompts** - User can say "Execute Prompt X"

**Note:** The `/fw-init` command (in `.claude/commands/fw-init.md`) performs the complete Session Startup Protocol. Do NOT execute any prompts until `/fw-init` completes.

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
  - Chapter creation metadata
  - Git commit messages
  - Dashboard reports
  - Compiled file metadata headers

### Passing Date to Agents

**When spawning agents (using Task tool):**
- Agents automatically inherit the confirmed date from the parent session context
- Include explicit instruction in agent prompt: "Today's confirmed date is [CONFIRMED_DATE]. Use this date for all operations."
- Never allow agents to use unchecked `<env>` dates

### Prompts That Write Dates

The following prompts write dates to files and MUST use `CONFIRMED_DATE`:

- **Prompt 1 (Initialize):** Creates initial project structure with date metadata
- **Prompt 2 (Add Chapter):** Writes chapter creation date
- **Prompt 7 (Compile):** Writes compile timestamp in metadata header
- **Prompt 10 (Dashboard):** Reports with current date

**Note:** Compiled drafts and exports use sequential versioning (vNN) instead of date-based filenames.

---

## Support

- **Documentation:** `Documentation/AI-Assisted_Nonfiction_Authoring_Process.md`
- **Quick Reference:** `Process/Prompts/QUICK_REFERENCE.md`
- **Issues/Bugs:** https://github.com/scooter-indie/author-nonfiction/issues
- **Releases:** https://github.com/scooter-indie/author-nonfiction/releases

---

**Framework Version:** 0.14.2
**Last Updated:** 2025-11-26

---

*This document ensures Claude Code has full framework context at session startup*
