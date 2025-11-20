# AI-Assisted Nonfiction Book Authoring Process

**Version:** 0.10.1
**Last Updated:** 2025-11-19
**Purpose:** A comprehensive, systematic approach to authoring nonfiction books with AI assistance using Git version control

---

## Table of Contents

1. [Overview](#overview)
2. [Directory Structure](#directory-structure)
3. [File Naming Conventions](#file-naming-conventions)
4. [Change Tracking System](#change-tracking-system)
5. [Writing Style System](#writing-style-system)
6. [Core Prompts](#core-prompts)
7. [Workflow States](#workflow-states)
8. [Quality Control](#quality-control)
9. [Backup and Safety](#backup-and-safety)
10. [Getting Started](#getting-started)

---

## Overview

This process provides a structured framework for creating nonfiction books using AI assistance. All content is maintained in Markdown format for maximum portability and version control compatibility.

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

```
[working-title]/
├── README.md                          # Project overview and current status
├── Project_Config.md                  # Project settings and metadata
├── Project_Metadata.md                # Book details, audience, goals
├── USAGE_GUIDE.md                     # Step-by-step instructions
├── .gitignore                         # Git configuration (if using version control)
│
├── TOC/
│   ├── TOC.md                         # Table of contents
│   └── TOC_chg.md                     # TOC change tracking
│
├── FrontMatter/
│   ├── Title_Page.md
│   ├── Title_Page_chg.md
│   ├── Dedication.md
│   ├── Dedication_chg.md
│   ├── Acknowledgments.md
│   ├── Acknowledgments_chg.md
│   ├── Foreword.md
│   ├── Foreword_chg.md
│   ├── Preface.md
│   └── Preface_chg.md
│
├── Chapters/
│   ├── README.md                      # Chapter guidelines
│   ├── Chapter_01_[Title-Slug].md
│   ├── Chapter_01_[Title-Slug]_chg.md
│   ├── Chapter_02_[Title-Slug].md
│   ├── Chapter_02_[Title-Slug]_chg.md
│   └── ... (through Chapter_NN)
│
├── BackMatter/
│   ├── Appendix_A.md
│   ├── Appendix_A_chg.md
│   ├── Glossary.md
│   ├── Glossary_chg.md
│   ├── Bibliography.md
│   ├── Bibliography_chg.md
│   ├── Index.md
│   └── Index_chg.md
│
├── Assets/
│   ├── Images/
│   ├── Diagrams/
│   ├── Tables/
│   └── Charts/
│
├── Research/
│   ├── Sources/
│   ├── Notes/
│   └── References/
│
├── Quotes/
│   ├── Chapter_Quotes.md                # Chapter epigraphs with verification status
│   └── Chapter_Quotes_chg.md            # Quote change tracking
│
├── Style/
│   ├── Style_Guide.md                   # Active writing style configuration
│   └── Custom_Styles.md                 # Optional: Custom style definitions
│
├── Inbox/
│   └── (New content awaiting integration)
│
└── Drafts/
    ├── Full_Draft_[YYYY-MM-DD].md
    └── (Compiled manuscript versions)
```

---

## File Naming Conventions

### Chapters

**Format:** `Chapter_[NN]_[Title-Slug].md`

- **NN**: Zero-padded chapter number (01-99)
- **Title-Slug**: Kebab-case chapter title (lowercase, hyphens)

**Examples:**
- `Chapter_01_Introduction-to-the-Topic.md`
- `Chapter_12_Advanced-Techniques.md`

### Change Files

**Format:** `[Original-Filename]_chg.md`

**Examples:**
- `Chapter_01_Introduction-to-the-Topic_chg.md`
- `TOC_chg.md`

### Draft Compilations

**Format:** `Full_Draft_[YYYY-MM-DD]_v[N.M.P].md`

**Examples:**
- `Full_Draft_2025-11-17_v1.0.0.md`
- `Full_Draft_2025-12-01_v1.2.5.md`

---

## Change Tracking System

### Version Numbering: N.M.P (Semantic Versioning)

- **Major (N)**: Structural changes affecting multiple chapters or TOC reorganization
- **Minor (M)**: Significant content revisions within a single chapter
- **Patch (P)**: Minor edits, typos, formatting corrections, copy edits

**Examples:**
- `1.0.0` → `2.0.0`: Added three new chapters and reorganized Part II
- `1.3.0` → `1.4.0`: Rewrote Chapter 5 with new examples
- `1.4.2` → `1.4.3`: Fixed typos in Chapter 5

### Change File Template

```markdown
# Change Tracking: [Target Filename]

**Document Version:** N.M.P  
**Target File:** [e.g., Chapter_01_Introduction.md]  
**Last Modified:** [YYYY-MM-DD HH:MM:SS]  
**Current Word Count:** [count] (Delta: +/- [change])  
**Status:** [Draft | Review | Revised | Final]

---

## Version History (Most Recent First)

### Version N.M.P - [YYYY-MM-DD] - [Brief Description]

**Type:** [Content Addition | Content Revision | Reorganization | Correction | Style Edit]  
**Scope:** [Full Chapter | Section X | Paragraph Y-Z | Specific Element]  
**Priority:** [Critical | High | Medium | Low]  
**Rationale:** [Why this change was made]

**Changes Made:**
- [Specific change 1]
- [Specific change 2]
- [Specific change 3]

**Impact on Other Files:**
- [None | List affected files and required updates]

**Review Notes:**
- [Any concerns or items needing attention]

---

### Version N.M.P-1 - [YYYY-MM-DD] - [Brief Description]

[Previous version details...]

---

## Pending Revisions

### Revision ID: [REV-001]

**Priority:** [High | Medium | Low]  
**Proposed Change:** [Description of proposed revision]  
**Proposed By:** [Author | Editor | AI Suggestion | Reviewer Name]  
**Date Proposed:** [YYYY-MM-DD]  
**Status:** [Proposed | Approved | Rejected | In Progress | Implemented]  
**Target Completion:** [YYYY-MM-DD]

**Details:**
[More detailed description if needed]

**Dependencies:**
[Any other changes that must happen first or simultaneously]

---

## Style Guide References

[Link to style guide sections relevant to this document]

---

## Cross-References

**This file references:**
- [List of other chapters/sections referenced]

**This file is referenced by:**
- [List of other chapters/sections that reference this file]

---

## REWRITE INSTRUCTIONS

**[WORKFLOW NOTE FOR AUTHORS]**

This section is your primary interface for requesting content modifications. When you want to revise the target file:

1. **Write your instructions** in the section below
2. **Commit this _chg file** to git
3. **Execute Prompt 3** (copy Process/Prompts/Prompt_3_Modify_File.md into Claude Code)
4. **AI reads your instructions** from this section automatically
5. **AI executes the changes** and auto-archives these instructions to Version History above

**Important**: After execution, this section will be cleared and ready for your next set of instructions.

---

### [INSTRUCTIONS FOR THIS REVISION]

[Add your modification instructions here]

**Example format:**
```
Rewrite the introduction section to:
- Lead with the remote work adoption statistic
- Add context about post-pandemic changes
- Strengthen connection to main thesis
- Improve transition to first section

Priority: High
Rationale: Current intro doesn't hook the reader effectively
```

[Ready for next revision - add instructions above]

---

**[AI ASSISTANT NOTE]**

When executing Prompt 3:
1. Read instructions from the [INSTRUCTIONS FOR THIS REVISION] section above
2. Apply the modifications to the target file
3. Create a new Version History entry with appropriate version increment
4. Move completed instructions to that Version History entry
5. Clear this [INSTRUCTIONS FOR THIS REVISION] section
6. Leave message: "[Ready for next revision - add instructions above]"
7. Update file metadata (word count, last modified, status if changed)
8. Create git commit with version information
```

---

### Automatic Change Tracking Synchronization

**Overview:**

The framework includes automatic synchronization between content files and their `_chg` tracking files to ensure version history stays current even when manual edits are made outside the Prompt 3 workflow.

**Synchronization Points:**

1. **Session Start (book-writing-assistant agent)**
   - Automatically scans for out-of-sync files when user begins writing session
   - Reports findings and updates _chg files before proceeding
   - User acknowledges updates before continuing

2. **Pre-Commit (book-writing-assistant agent)**
   - Blocks commits if files are out of sync with _chg tracking
   - Auto-updates _chg files before allowing commit
   - Includes updated _chg files in the commit

3. **Manual Invocation (Prompt 10)**
   - Run `Prompt_10_Update_Change_Tracking.md` anytime
   - Useful for maintenance, before milestones, or after pulling from remote

**Detection Scope:**

The system checks for changes in three contexts:
- **Uncommitted changes**: Local edits not yet staged (`git diff`)
- **Staged changes**: Changes ready for commit (`git diff --cached`)
- **Unpushed commits**: Commits made locally but not pushed (`git diff origin/main..HEAD`)

**Auto-Generation Process:**

For each out-of-sync file:
1. Extract combined git diff from all three contexts
2. Analyze diff to infer change type:
   - "Content Addition" → primarily new lines added
   - "Content Deletion" → primarily lines removed
   - "Structural Change" → headings/organization modified
   - "Refinement" → mostly line-by-line edits
   - "Content Update" → general modifications (default)
3. Apply semantic versioning based on change type:
   - Structural Change → increment major version (X.0.0)
   - Content Addition/Deletion → increment minor version (0.X.0)
   - Refinement/Content Update → increment patch version (0.0.X)
4. Generate version history entry with:
   - Version number and current date
   - Inferred change type and scope
   - Summary of changes from diff analysis
   - Rationale: "[Auto-generated from git diff]"
5. Insert entry at top of "Version History (Most Recent First)" section
6. Update "Last Modified" date in file header

**Benefits:**

- Ensures change tracking never falls behind content changes
- Maintains audit trail for manual edits
- Reduces friction in workflow (no manual _chg updates needed)
- Provides meaningful version history even for quick edits
- Blocks commits that would lose change tracking context

**When Manual Updates Are Still Needed:**

Auto-sync generates accurate technical summaries but cannot capture:
- Strategic rationale for changes
- Editorial feedback that prompted revisions
- User preferences or specific context

Consider manually editing auto-generated entries to add:
- More detailed rationale beyond "[Auto-generated from git diff]"
- Context about why changes were made
- Notes about editorial feedback or review comments
- Dependencies or related changes

---

## Writing Style System

### Overview

The Writing Style System helps authors define, maintain, and apply consistent voice, tone, and structure throughout their book. It provides:
- **Framework library** of 9 professionally curated styles
- **Project configuration** for active style
- **Custom style creation** for specialized needs
- **Automatic style checking** during writing and revision
- **Style-aware AI assistance** via book-writing-assistant agent

### File Locations

**Framework Level (Process/):**
- `Process/Style_Examples.md` - 9 curated framework styles with complete examples
- `Process/Templates/Style_Guide_Template.md` - Template for project configuration
- `Process/Templates/Custom_Styles_Template.md` - Template for custom styles

**Project Level (Style/):**
- `Style/Style_Guide.md` - Active style configuration for this book
- `Style/Custom_Styles.md` - Optional custom style definitions (project-specific)

### Framework Styles

The framework provides 9 professionally curated styles:

1. **Academic Authority** - Scholarly, research-based, third-person formal
2. **Conversational Expert** - Business/professional, second-person accessible
3. **Narrative Storyteller** - Memoir-adjacent, first-person with scenes
4. **Business Professional** - Management/leadership, action-oriented
5. **Technical Precision** - Technical guides, detailed and systematic
6. **Investigative Journalist** - Exposés, evidence-based revelation
7. **Practical Guide** - How-to, step-by-step instructional
8. **Inspirational Teacher** - Personal development, motivational
9. **Scientific Communicator** - Popular science, wonder with rigor

Each style includes:
- Voice characteristics (person, formality, sentence structure, vocabulary)
- Tone description with sample phrases
- Pacing guidelines (density, examples, breaks)
- Structural approach (deductive/inductive/dialectical)
- 150-200 word example passage
- DO/DON'T lists

### Style Selection Process

**During Initialization (Prompt 1):**

1. AI presents 3-4 relevant styles based on target audience
2. Shows example passage from each style
3. Author chooses or customizes
4. Style/Style_Guide.md created with configuration
5. Selection committed to git

**Options available:**
- Choose framework style as-is
- Customize framework style
- Mix characteristics from multiple styles
- Define entirely custom style
- Skip (configure later)

### Style Configuration Structure

**Style/Style_Guide.md contains:**
- Selected style name (e.g., FW_Conversational_Expert)
- Source (Framework Library or Custom)
- Complete style characteristics
- Quick reference DO/DON'T lists
- Example passage
- Style evolution tracking (version history of style changes)

**Internal naming (not shown to users):**
- Framework styles: FW_[Name] (e.g., FW_Academic_Authority)
- Custom styles: CUSTOM_[Name] (e.g., CUSTOM_Medical_Journal)
- Display: Clean descriptive names only (e.g., "Academic Authority")

### Custom Styles

**When to create custom styles:**
- Framework styles don't fit specialized domain (medical, legal, technical)
- Mixing characteristics from multiple framework styles
- Industry-specific writing conventions
- Unique voice not covered by framework

**How to create:**
1. Start with Process/Templates/Custom_Styles_Template.md
2. Define style characteristics following same format as framework
3. Save as Style/Custom_Styles.md
4. Reference in Style/Style_Guide.md

**Approaches:**
- **From scratch**: Define all characteristics
- **Extend framework**: Base on framework style + modifications
- **Mix styles**: Combine voice/tone/structure from different styles

### Integration with Prompts

**Prompt 1 (Initialize):**
- Interactive style selection during project setup
- Shows relevant framework styles
- Creates Style/ directory and Style_Guide.md

**Prompt 3 (Modify File):**
- Automatic style consistency check after modifications
- Analyzes person, formality, paragraph length, terminology
- Compares against DO/DON'T lists
- Offers corrections or flags for review
- Optional - can skip if needed

**Prompt 6 (Consistency Check):**
- Comprehensive style analysis across all chapters
- Chapter-by-chapter alignment report
- Identifies drift from configured style
- Priority recommendations (High/Medium/Low)
- Tracks formality, person, pacing, tone consistency

**Book-Writing-Assistant Agent:**
- Loads style at session start
- Applies style to all writing assistance
- Matches voice, tone, formality automatically
- Gentle drift detection (not prescriptive)
- Helps with style changes or custom creation

### Style Checking

**What gets checked:**
- Person consistency (first/second/third)
- Formality level alignment
- Paragraph length vs. guidelines
- Passive voice density (if style discourages)
- Technical term usage vs. accessibility requirements
- DO/DON'T guideline violations
- Sentence complexity patterns
- Tense consistency

**When checked:**
- During file modifications (Prompt 3)
- Cross-chapter analysis (Prompt 6)
- Real-time during agent writing sessions
- Compilation consistency review

**Response options:**
- Apply automatic corrections
- Review manually and fix
- Skip - mark as intentional variation
- Update style guide if preference evolved

### Style Evolution

**Tracking changes:**
- Document in Style Evolution section of Style_Guide.md
- Version style changes (1.0 → 2.0)
- Note rationale for changes
- Create migration plan for existing content

**When style changes mid-project:**
1. Update Style/Style_Guide.md
2. Add version entry explaining change
3. Run Prompt 6 to analyze existing content
4. Decide: harmonize all chapters or keep variation
5. Use Prompt 3 to apply style to priority chapters

### Best Practices

**Initial setup:**
- Choose style during initialization (Prompt 1)
- Review framework examples carefully
- Pick style that matches natural writing voice
- Test with sample paragraph before committing

**During writing:**
- Let style guide, not dictate
- Intentional variations are okay
- Document exceptions when needed
- Update guide as voice evolves

**Maintenance:**
- Run Prompt 6 at 25%, 50%, 75% completion
- Check style consistency before major milestones
- Adjust guide to match reality (not vice versa)
- Use style as aspiration, not rigid rules

**With collaborators:**
- Share Style/Style_Guide.md for alignment
- Document project-specific conventions in Custom_Styles.md
- Use style checking to maintain consistency across authors

---

## Core Prompts

The AI-Assisted Nonfiction Authoring Process includes 10 core prompts for different aspects of book development. Each prompt is a conversational interface stored in `Process/Prompts/`.

**How to use:** Copy a prompt file and paste into Claude Code. The AI will guide you through the process interactively.

---

### Prompt 1: Initialize Project Structure

Creates complete project structure from scratch, including directory tree, configuration files, TOC, chapter placeholders, quote management setup, and git repository initialization.

**When to use:** Starting a new book project

**Key features:**
- Flexible TOC input (manual or from existing file)
- Parses multiple TOC formats (numbered lists, outlines, informal notes)
- Complete directory structure generation with all placeholders
- Quote management setup with ⏳ Pending status for all chapters
- Git initialization with v1.0.0 tag
- Configuration files (Project_Config.md, Project_Metadata.md, USAGE_GUIDE.md)

**Interaction:** Fully interactive - AI asks about title, author, word count, TOC source, etc.

**Output:** Complete ready-to-use project with git repo, all placeholders, and configuration

**See:** `Process/Prompts/Prompt_1_Initialize.md` for execution

---

### Prompt 2: Add New Chapter

Inserts a new chapter into existing book structure with automatic reorganization, renumbering, cross-reference updates, and quote entry creation.

**When to use:** Adding a new chapter to your book

**Key features:**
- Interactive chapter creation or from Inbox content
- Automatic file renumbering (increments affected chapters)
- Cross-reference validation and updates
- Quote entry creation (Status: ⏳ Pending)
- Impact analysis and reporting
- AI-managed TOC updates (user should not edit TOC_chg.md manually)

**Interaction:** Choose interactive mode (quick questions) or Inbox-based integration

**Output:** New chapter files, renumbered existing chapters, updated TOC, quote entry, git commits with clear trail

**See:** `Process/Prompts/Prompt_2_Add_Chapter.md` for execution

---

### Prompt 3: Modify Target File

Applies revisions to any content file based on instructions from corresponding _chg file, with automatic version history archiving.

**When to use:** PRIMARY workflow for all content revisions (chapters, quotes, front/back matter)

**Key features:**
- Reads instructions from _chg file automatically
- Auto-archives completed instructions to Version History
- Version number incrementation (semantic versioning)
- Validation checks (cross-references, style, consistency)
- Git commit with version information
- Works with all content files including Chapter_Quotes.md

**Interaction:**
1. User writes instructions in _chg file
2. User commits _chg file
3. Execute Prompt 3
4. AI reads, confirms, executes, archives

**Output:** Modified content file, updated _chg file with archived instructions, git commit

**See:** `Process/Prompts/Prompt_3_Modify_File.md` for execution

---

### Prompt 4: Integrate Content from Inbox

Processes files from Inbox/ directory and integrates them into appropriate project locations with special handling for TOC files.

**When to use:** Have content, references, or assets to integrate into project

**Key features:**
- Scans Inbox/ and categorizes files (content, TOC, assets, references)
- Special TOC handling (merge, replace, or create parallel outline)
- Flexible TOC parsing for various formats
- Integration options (new chapter, append, merge, move to research)
- Post-init TOC rejection (complete TOC files not allowed after initialization)
- Archive processed files with timestamps

**Interaction:** AI scans Inbox/, presents findings, asks about each file's destination and integration method

**Output:** Integrated content, updated files, archived inbox items, git commits

**See:** `Process/Prompts/Prompt_4_Integrate_Inbox.md` for execution

---

### Prompt 5: Compile Complete Manuscript

Generates single Markdown file from all current content with verified quote insertion, statistics, and formatting options.

**When to use:** Want to review entire book, prepare for editing, or create milestone draft

**Key features:**
- Assembles all content in order (front matter, TOC, chapters, back matter)
- Inserts verified (✓) quotes as chapter epigraphs with proper formatting
- Auto-generates table of contents from headings
- Multiple format options (basic, formatted, publication-ready)
- Statistics (word count, completion %, quote status)
- Placeholder handling options

**Interaction:** AI asks for version number and settings (or uses defaults from Project_Config.md)

**Output:** `Drafts/Full_Draft_[date]_v[version].md` with statistics report and quote completion metrics

**See:** `Process/Prompts/Prompt_5_Compile.md` for execution

---

### Prompt 6: Consistency Checker

Scans all content for consistency issues, style problems, cross-reference validity, and quote verification status.

**When to use:** Weekly during active writing, at milestones (25%, 50%, 75%, 100%), before compilation/export

**Key features:**
- Terminology consistency analysis (variations, capitalization, acronyms)
- Cross-reference validation (broken links, ambiguous references)
- Style consistency (headings, lists, quotes, numbers, dates)
- Fact consistency (contradictions, statistics, citations)
- Tone/voice analysis (formality, perspective, tense)
- Quote/epigraph verification (pending quotes, missing attributions, incomplete citations)

**Interaction:** AI asks what scope (all chapters vs. specific) and which check types to run

**Output:** Comprehensive report organized by priority (Critical/Warning/Suggestion) with quote verification status

**See:** `Process/Prompts/Prompt_6_Consistency.md` for execution

---

### Prompt 7: Export and Format

Generates output files in various formats (DOCX, PDF, EPUB, LaTeX) from source Markdown with proper formatting and asset handling.

**When to use:** Preparing for publication, submission, or distribution

**Key features:**
- Multiple export formats with format-specific processing
- Pre-export validation (consistency, cross-references, placeholders)
- Bibliography formatting (APA, MLA, Chicago, custom)
- Asset handling (images, diagrams, optimization)
- Style mapping and typography settings
- Export package generation

**Interaction:** AI asks about format and settings (or uses defaults from Project_Config.md)

**Output:** Formatted files in `Exports/[date]/` directory with assets and export report

**See:** `Process/Prompts/Prompt_7_Export.md` for execution

---

### Prompt 8: Progress Dashboard

Generates comprehensive status report showing word counts, completion metrics, git activity, quote verification status, and recommendations.

**When to use:** Weekly check-ins, after major changes, at milestones

**Key features:**
- Chapter-by-chapter status and word counts
- Git repository statistics (commits, branches, tags, recent activity)
- Pending revisions summary by priority
- Quote completion metrics (✓/⚠/⏳ status for all chapters)
- Milestone tracking (25%, 50%, 75%, 100%)
- Recommended next steps based on current state

**Interaction:** AI asks Summary or Detailed report type

**Output:** Comprehensive dashboard with all metrics, git status, quote status, and actionable recommendations

**See:** `Process/Prompts/Prompt_8_Dashboard.md` for execution

---

### Prompt 9: Git Operations

Performs git version control operations (commit, tag, branch, log, status, push, pull) with safety checks and guided workflows.

**When to use:** Manual git operations (commits, tagging milestones, branching, viewing history, remote sync)

**Key features:**
- Interactive commit workflow with staging and message suggestions
- Tag creation for milestones (v1.0.0, first-draft, etc.)
- Branch management (create, switch, merge, delete)
- History viewing (commits, diffs, file-specific logs)
- Remote operations (push, pull) with safety checks
- Status reports (branch, uncommitted changes, unpushed commits)

**Interaction:** AI asks which operation, then operation-specific questions with confirmation for significant actions

**Output:** Git operation result, status confirmation, next recommended steps

**See:** `Process/Prompts/Prompt_9_Git.md` for execution

---

### Prompt 10: Update Change Tracking

Synchronizes `_chg.md` (change tracking) files with content file modifications detected via git, auto-generating version history entries.

**When to use:** After manual edits, before milestones, weekly maintenance, after pulling from remote

**Key features:**
- Scans for changes in three contexts: uncommitted, staged, and unpushed commits
- Auto-detects all file pairs (content file + corresponding `_chg.md` file)
- Analyzes git diffs to infer change type (Content Addition, Structural Change, Refinement, etc.)
- Applies semantic versioning rules (major.minor.patch)
- Generates properly formatted version history entries
- Updates "Last Modified" dates in file headers

**Interaction:** Minimal - AI runs automatic scan and shows summary of updates made

**Output:** Updated `_chg` files with new version history entries documenting all changes

**Note:** The book-writing-assistant agent automatically runs this check at session start and before commits, so manual execution is only needed for maintenance or when working outside the agent

**See:** `Process/Prompts/Prompt_10_Update_Change_Tracking.md` for execution

---

## Quote Management Workflow

### Overview

The quote management system provides a centralized approach to selecting, verifying, and managing chapter epigraphs (opening quotes). Each chapter can have one epigraph that will be automatically inserted during manuscript compilation.

### Quote Files Location

```
Quotes/
├── Chapter_Quotes.md          # Centralized quote repository
└── Chapter_Quotes_chg.md      # Quote change tracking
```

### Quote Verification Status Codes

Each quote entry has a status code indicating its verification state:

- **⏳ Pending**: Quote needs to be selected/researched for this chapter
- **⚠ Needs Citation**: Quote selected but requires complete attribution verification
- **✓ Verified**: Quote fully verified with complete bibliographic information

### Quote Entry Structure

Each quote entry in `Quotes/Chapter_Quotes.md` follows this format:

```markdown
## Chapter XX: [Chapter Title]

**Status:** [⏳|⚠|✓]

**Quote:**
> [Quote text - exact wording from original source]

**Attribution:**
- **Author:** [Full name]
- **Source:** [Book title, article, speech, etc.]
- **Year:** [Publication/delivery year]
- **Page:** [Page number if applicable]
- **Context:** [Brief context about the quote]

**Bibliography Reference:** [Full citation in project's chosen style]

**Notes:** [Verification notes, permissions, fair use justification]
```

### Workflow Integration

**During Project Initialization (Prompt 1):**
- `Chapter_Quotes.md` created with placeholder entries for all chapters
- All quotes start with Status: ⏳ Pending
- Entries ready for quote selection

**When Adding Chapters (Prompt 2):**
- New quote entry automatically added to `Chapter_Quotes.md`
- Initial status: ⏳ Pending
- Change note added to `Chapter_Quotes_chg.md`

**During Content Development:**
- Author updates quotes as chapters are written
- Progress through statuses: ⏳ → ⚠ → ✓
- Track changes in `Chapter_Quotes_chg.md`

**During Compilation (Prompt 5):**
- Verified (✓) quotes automatically inserted at chapter start
- Quotes needing citation (⚠) included with warning note
- Pending quotes (⏳) skipped with note in compilation report

**During Consistency Check (Prompt 6):**
- Quote verification status reported
- Missing attributions flagged
- Formatting inconsistencies identified
- Bibliography references validated

**In Progress Dashboard (Prompt 8):**
- Quote completion statistics displayed
- Chapters needing quote work identified
- Overall quote verification progress tracked

### Quote Verification Process

**Step 1: Select Appropriate Quote (⏳ → ⚠)**

1. Choose quote relevant to chapter theme
2. Ensure quote is authentic and properly attributed
3. Avoid commonly misattributed quotes (see Anti-Hallucination Guidelines)
4. Add quote to entry with basic attribution
5. Update status to ⚠ Needs Citation

**Step 2: Verify and Complete Attribution (⚠ → ✓)**

1. Locate original source (book, article, recording)
2. Verify exact wording matches original
3. Add complete bibliographic information:
   - Full author name
   - Complete source title
   - Publication year
   - Page number (for print sources)
   - Publisher information
4. Add corresponding entry to `BackMatter/Bibliography.md`
5. Link bibliography reference in quote entry
6. Add verification notes (date verified, source consulted)
7. Confirm fair use applicability for epigraph use
8. Update status to ✓ Verified

### Best Practices

**Quote Selection:**
- Choose quotes that illuminate chapter themes
- Prefer well-documented, easily verifiable quotes
- Avoid quotes found only on quote websites
- Be skeptical of quotes without page numbers or specific sources
- Check multiple sources for wording consistency

**Attribution Requirements:**
- Always provide complete source information
- Include page numbers for print sources
- For speeches/videos, include date and venue/platform
- For translations, note translator and edition
- Document where original was verified

**Common Pitfalls to Avoid:**
- Misattributions to famous figures (Einstein, Twain, Churchill)
- Quotes that only appear on quote aggregator sites
- Paraphrased quotes presented as exact quotations
- Missing or incomplete source information
- Using quotes without verification

**Fair Use Considerations:**
- Epigraphs typically qualify as fair use
- Use brief quotes (1-2 sentences preferred)
- Always attribute properly
- Document fair use justification in Notes field
- Consult legal guidance for longer quotes or restricted sources

### Managing Quote Changes

**Method 1: Using Prompt 3 (Traditional Workflow):**

1. Open `Quotes/Chapter_Quotes_chg.md`
2. Add instructions in [INSTRUCTIONS FOR THIS REVISION] section
3. Commit the _chg file
4. Execute Prompt 3, specifying Chapter_Quotes.md as target
5. AI updates quotes and auto-archives instructions

**Method 2: Using Book-Writing-Assistant Agent (Enhanced Workflow):**

The book-writing-assistant agent provides comprehensive quote management through natural language:

**SEARCH MODE - Web-Based Quote Discovery:**
- Agent asks context-aware questions based on book themes
- Searches 3 websites per iteration
- Tracks examined websites to avoid redundancy
- User can specify particular websites to search
- Continues with new criteria as long as needed
- Auto-saves approved quotes with ⚠ status

**ADD MODE - Manual Quote Entry:**
- User provides quote text and attribution
- Agent formats properly and adds to Chapter_Quotes.md
- Updates change tracking automatically

**VALIDATE MODE - Quote Verification:**
- User provides quote and claimed attribution
- Agent performs web search to verify accuracy
- Reports: ✓ Verified, ⚠ Partial match, or ✗ Not found
- Offers to add verified quotes with ✓ status

**DELETE MODE - Quote Removal:**
- Shows current quote before deletion
- Requires confirmation
- Updates both quote file and change tracking

**STATUS MODE - Progress Overview:**
- Shows completion statistics by status
- Identifies chapters needing work
- Offers to work on pending quotes

**Trigger phrases:**
- "Find quotes for Chapter 3"
- "Search for quotes about [theme]"
- "I have a quote to add"
- "Validate this quote: [text]"
- "Delete quote from Chapter 5"
- "Show quote status"

**Example Change Instructions:**

```markdown
Update quote for Chapter 05:

Current Status: ⏳ Pending
New Status: ✓ Verified

Add the following verified quote:

Quote: "The scientific method is really a way of thinking about and testing
our understanding of nature through experiment and observation."

Attribution:
- Author: Carl Sagan
- Source: The Demon-Haunted World: Science as a Candle in the Dark
- Year: 1995
- Page: 27
- Context: Introduction to scientific thinking

Bibliography: Sagan, C. (1995). The Demon-Haunted World: Science as a
Candle in the Dark. New York: Random House.

Notes: Verified from original text, page 27. Fair use as chapter epigraph.

Priority: Medium
Rationale: Perfect thematic introduction for chapter on empirical research methods
```

### Compilation Formatting

When compiling the manuscript (Prompt 5), verified quotes are formatted as:

```markdown
# Chapter 5: Research Methods

> The scientific method is really a way of thinking about and testing our
> understanding of nature through experiment and observation.
>
> — Carl Sagan, *The Demon-Haunted World* (1995)

[Chapter content begins here...]
```

**Formatting Rules:**
- Quote appears immediately after chapter heading
- Blockquote formatting (> prefix)
- Attribution line: — Author, *Source* (Year)
- Blank line separates quote from chapter content
- Source title in italics

### Anti-Hallucination Compliance

**CRITICAL RULES:**

1. **NEVER fabricate quotes** - If uncertain about exact wording, mark as ⏳ Pending
2. **NEVER guess attributions** - Research thoroughly before marking ✓ Verified
3. **ALWAYS verify against original sources** - Quote sites are NOT sufficient
4. **ALWAYS document verification** - Note where and when quote was verified
5. **Flag uncertainty** - Use ⚠ status if ANY doubt exists about attribution

See `Process/Anti-Hallucination_Guidelines.md` for comprehensive quote verification rules and common misattribution examples.

### Quote Statistics and Monitoring

**Track these metrics (visible in Prompt 8 Dashboard):**

- Total quotes: [N] chapters
- Verified (✓): [N] quotes ([XX]%)
- Needs Citation (⚠): [N] quotes ([XX]%)
- Pending (⏳): [N] quotes ([XX]%)
- Overall completion: [XX]%

**Quality Targets:**
- Before first compilation: At least 50% verified (✓)
- Before major review: At least 80% verified (✓)
- Before final draft: 100% verified (✓)
- Never include ⏳ Pending quotes in final manuscript

### Troubleshooting

**Problem:** Can't verify exact quote wording
**Solution:** Mark as ⏳ Pending, research further, or select different quote

**Problem:** Quote attributed to famous person but no source found
**Solution:** Likely misattributed - see Anti-Hallucination Guidelines for common examples

**Problem:** Quote only appears on quote websites
**Solution:** Not sufficiently verified - find original source or choose different quote

**Problem:** Need longer quote than typical epigraph length
**Solution:** Consider fair use implications, consult legal guidance, or excerpt shorter portion

**Problem:** Source is out of print or inaccessible
**Solution:** Use library archives, digital databases, or select alternative quote with accessible source

---

## Workflow States

Each content file progresses through defined states:

### 1. **Draft**
- Initial content creation
- Rough organization
- Placeholder sections allowed
- Focus: Getting ideas down

### 2. **Review**
- Content complete (no major placeholders)
- Ready for structural assessment
- May have minor gaps
- Focus: Big picture structure

### 3. **Revised**
- Structural changes implemented
- Content refined
- Ready for copy editing
- Focus: Polish and clarity

### 4. **Final**
- All edits complete
- Proofread and approved
- No further changes expected
- Focus: Publication ready

### State Transitions

Track state changes in the change file:

```markdown
### Version 1.5.0 - 2025-11-17 - Status Change: Draft → Review

**Type:** Status Change  
**Rationale:** All major sections complete, ready for structural review
```

---

## Quality Control

### Automated Checks

1. **File Integrity:**
   - All expected files exist
   - No orphaned change tracking files
   - Proper file naming

2. **Cross-Reference Validation:**
   - All internal links valid
   - Chapter references correct
   - Asset references valid

3. **Consistency:**
   - Use Prompt 6 regularly
   - Term usage
   - Style adherence

4. **Completeness:**
   - Word count targets
   - All placeholders addressed
   - Required sections present

### Manual Review Checkpoints

1. **After Initial TOC (Milestone 1):**
   - Structure makes sense
   - Logical flow
   - Appropriate scope

2. **At 25% Completion (Milestone 2):**
   - Writing style established
   - Tone consistent
   - Early chapters strong

3. **At 50% Completion (Milestone 3):**
   - Structure still working
   - May need reorganization
   - Bibliography growing

4. **At 75% Completion (Milestone 4):**
   - All chapters drafted
   - Consistency check
   - Cross-reference audit

5. **First Complete Draft (Milestone 5):**
   - Full manuscript review
   - Structural edit
   - Major revisions identified

6. **Pre-Final (Milestone 6):**
   - Copy edit complete
   - Proofreading
   - Final consistency check

---

## Backup and Safety

### Git Version Control (Required)

All projects must use Git for version control. This replaces the previous snapshot system and provides superior tracking, branching, and rollback capabilities.

### Git Workflow Best Practices

**Commit before major operations:**
- TOC reorganization
- Chapter addition/deletion
- Major content modifications
- Bulk operations
- Starting experimental edits

**Commit strategy:**
- Commit frequently (after each logical change)
- Use descriptive commit messages
- Include version numbers in messages when updating change files
- Tag major milestones (v1.0.0, v2.0.0, etc.)

**Example commit messages:**
- "Update Chapter 03 v1.5.0: Add case study examples"
- "Reorganize TOC: Move Chapter 07 to Chapter 05"
- "Add Chapter 12: Future Trends"
- "Copy edit: Chapters 01-05"

### Repository Setup

1. **Initialize Repository:**
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   ```

2. **.gitignore Template:**
   ```
   # Temporary files
   *.tmp
   *.bak
   ~*
   
   # Editor files
   .vscode/
   .idea/
   *.swp
   
   # OS files
   .DS_Store
   Thumbs.db
   
   # Build artifacts
   build/
   dist/
   
   # Optional: Compiled drafts (if too large)
   # Drafts/Full_Draft_*.md
   ```

3. **Branching Strategy:**
   - `main`: Stable, reviewed content
   - `draft-[chapter-name]`: Experimental chapter drafts
   - `restructure`: Major reorganization work
   - Merge branches when content is reviewed and stable

4. **Tagging Strategy:**
   - Tag major milestones: `v1.0.0`, `v2.0.0`
   - Tag completed drafts: `first-draft`, `revised-draft`, `final-draft`
   - Tag submission versions: `submission-v1`, `submission-v2`

5. **Useful Git Commands:**
   ```bash
   # View recent activity
   git log --oneline -10

   # See what changed in a specific commit
   git show <commit-hash>

   # Restore a file from a previous commit
   git checkout <commit-hash> -- path/to/file

   # Create a branch for experimental work
   git checkout -b experiment-chapter-reorg

   # View uncommitted changes
   git diff

   # View changes in a specific file over time
   git log -p -- path/to/file
   ```

### Remote Backup (Highly Recommended)

1. **GitHub/GitLab/Bitbucket:**
   - Create private repository
   - Push regularly: `git push origin main`
   - Provides cloud backup and access from multiple devices
   - Enable issues for tracking revision tasks

2. **Additional Backups:**
   - Weekly: Export to cloud storage (Dropbox, Google Drive, etc.)
   - Monthly: Archive entire project folder to external drive
   - Before major milestones: Create ZIP archive of entire project

---

## Getting Started

### Quick Start Guide

1. **Prepare Your Concept:**
   - Working title
   - Core thesis/purpose
   - Target audience
   - Estimated chapter list
   - Target word count

2. **Run Prompt 1: Initialize Project**
   - Provide required information
   - Review generated structure
   - Customize as needed

3. **Review Generated Files:**
   - Check `Project_Config.md`
   - Review `TOC/TOC.md`
   - Examine chapter placeholders

4. **Start Writing:**
   - Choose a chapter to begin
   - Update status in change file
   - Write content in chapter file
   - Track changes in change file

5. **Regular Maintenance:**
   - Run Prompt 8 weekly (Progress Dashboard)
   - Run Prompt 6 at milestones (Consistency Checker)
   - Commit changes frequently with descriptive messages
   - Push to remote repository regularly

6. **Compile and Review:**
   - Use Prompt 5 periodically
   - Review compiled manuscript
   - Identify issues and gaps

### Best Practices

1. **Change Tracking:**
   - Update change files immediately
   - Be specific about rationale
   - Track even small changes

2. **Version Numbers:**
   - Increment appropriately
   - Document in change file
   - Update Project_Config.md

3. **Cross-References:**
   - Use consistent format: `(see Chapter X)`
   - Update when reorganizing
   - Validate regularly

4. **Assets:**
   - Store in Assets/ directory
   - Use descriptive filenames
   - Reference with relative paths

5. **Bibliography:**
   - Add sources as you use them
   - Use consistent citation format
   - Keep separate notes in Research/

6. **Backups:**
   - Use Git for all version control
   - Push to remote repository regularly
   - Maintain additional backups to cloud storage
   - Archive complete project at major milestones

---

## Troubleshooting

### Common Issues

**Problem:** Chapter numbers out of sync  
**Solution:** Use Prompt 2 to reorganize, or manually rename with proper sequencing

**Problem:** Broken cross-references after reorganization  
**Solution:** Run Prompt 6 with cross-reference check, then use Prompt 3 to fix

**Problem:** Inconsistent terminology  
**Solution:** Run Prompt 6, create style guide, use find-replace carefully

**Problem:** Lost changes or want to undo recent edits
**Solution:** Use `git log` to find the commit, then `git checkout <commit-hash> -- <file>` to restore, or `git revert <commit-hash>` to undo a commit

**Problem:** Placeholder content in final draft  
**Solution:** Run Prompt 8 to identify, then use Prompt 3 to complete sections

---

## Additional Resources

### Recommended Tools

- **Markdown Editors:** Typora, Obsidian, VS Code with Markdown extensions
- **Version Control:** Git (required) with GitHub/GitLab/Bitbucket (recommended)
- **Conversion:** Pandoc for format conversion
- **Bibliography:** Zotero, Mendeley
- **Writing:** Grammarly, ProWritingAid (for final polish)

### Style Guides

Include links to relevant style guides in `Project_Config.md`:
- Chicago Manual of Style
- AP Style
- MLA Style
- APA Style
- Custom organizational style guide

---

## Appendix: Configuration File Templates

### Project_Config.md Template

```markdown
# Project Configuration

**Project Name:** [Working Title]  
**Author:** [Author Name]  
**Version:** 1.0.0  
**Created:** [YYYY-MM-DD]  
**Last Updated:** [YYYY-MM-DD]

## Project Settings

- **Working Title:** [title]
- **Target Total Word Count:** [number]
- **Target Completion Date:** [YYYY-MM-DD]
- **Primary Format:** Markdown
- **Export Formats:** [list]

## Structure Settings

- **Chapter Prefix:** Chapter_
- **Zero Padding:** 2 (01-99)
- **Chapter Title Format:** Kebab-case
- **Change File Suffix:** _chg

## Versioning

- **Current Version:** 1.0.0
- **Versioning Scheme:** Semantic (Major.Minor.Patch)
- **Change Tracking:** Enabled

## Style Guide

- **Citation Style:** [APA/MLA/Chicago/Other]
- **Heading Style:** [ATX/Setext]
- **List Style:** [Dash/Asterisk]
- **Emphasis:** [Asterisk/Underscore]

## Git Settings

- **Git Integration:** Required
- **Remote Repository:** [URL to GitHub/GitLab/Bitbucket]
- **Default Branch:** main
- **Auto-Commit:** Enabled (via Prompt 3)

## Default Compilation Settings (Prompt 5)

- **Format:** Formatted
- **Include Placeholders:** Yes
- **Include Change Tracking Metadata:** No
- **Auto-Generate TOC:** Yes

## Default Export Settings (Prompt 7)

- **Export Format:** DOCX
- **Citation Style:** Chicago
- **Include Cover Page:** Yes
- **Include TOC:** Yes
- **Include Page Numbers:** Yes
- **Image Resolution:** High (print quality)
- **Image Handling:** Include all, optimize for target format

## Custom Settings

[Add any project-specific settings]
```

### Project_Metadata.md Template

```markdown
# Project Metadata

## Book Information

**Working Title:** [title]  
**Subtitle:** [subtitle]  
**Author:** [name]  
**Genre:** [nonfiction category]  
**Target Publication Date:** [YYYY-MM-DD]

## Target Audience

**Primary Audience:** [description]  
**Secondary Audience:** [description]  
**Assumed Knowledge Level:** [beginner/intermediate/advanced]

## Book Purpose

**Main Thesis:** [2-3 sentence summary]

**Key Objectives:**
- [Objective 1]
- [Objective 2]
- [Objective 3]

**Unique Value Proposition:** [What makes this book different/necessary]

## Scope

**Topics Included:**
- [Topic 1]
- [Topic 2]

**Topics Explicitly Excluded:**
- [Topic 1]
- [Topic 2]

## Target Specifications

**Total Word Count Target:** [number]  
**Estimated Page Count:** [number] (based on [words per page])  
**Number of Chapters:** [number]  
**Average Words per Chapter:** [number]

## Tone and Style

**Voice:** [First/Second/Third person]  
**Tone:** [Formal/Conversational/Academic/etc.]  
**Style Notes:** [Any specific stylistic choices]

## Market Positioning

**Comparable Titles:**
- [Title 1] by [Author]
- [Title 2] by [Author]

**Competitive Advantages:**
- [Advantage 1]
- [Advantage 2]

## Timeline

**Start Date:** [YYYY-MM-DD]  
**First Draft Target:** [YYYY-MM-DD]  
**Revision Completion:** [YYYY-MM-DD]  
**Final Manuscript:** [YYYY-MM-DD]

## Notes

[Any additional notes about the project]
```

---

## License and Usage

This process document is designed to be cloned and customized for individual book projects. Modify as needed to suit your specific requirements.

---

**End of Document**
