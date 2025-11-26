# AI-Assisted Nonfiction Book Authoring Process

**Version:** 0.13.14
**Last Updated:** 2025-11-26
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

**Method 1: Manual Instructions (Prompt 3)**
1. **Write your instructions** in the section below
2. **Commit this _chg file** to git
3. **Execute Prompt 3** (copy Process/Prompts/Prompt_3_Change_by_Chg.md into Claude Code)
4. **AI reads your instructions** from this section automatically
5. **AI executes the changes** and auto-archives these instructions to Version History above

**Method 2: Interactive Change (Prompt 4)**
1. **Execute Prompt 4** (copy Process/Prompts/Prompt_4_Interactive_Change.md into Claude Code)
2. **Discuss changes conversationally** with AI
3. **AI writes instructions** to this section based on conversation
4. **Optionally execute immediately** or commit for later execution

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

When executing Prompt 3 (Change by Chg):
1. Read instructions from the [INSTRUCTIONS FOR THIS REVISION] section above
2. Apply the modifications to the target file
3. Create a new Version History entry with appropriate version increment
4. Move completed instructions to that Version History entry
5. Clear this [INSTRUCTIONS FOR THIS REVISION] section
6. Leave message: "[Ready for next revision - add instructions above]"
7. Update file metadata (word count, last modified, status if changed)
8. Create git commit with version information

When executing Prompt 4 (Interactive Change):
1. Engage in conversational discussion with user about desired changes
2. Write structured instructions to [INSTRUCTIONS FOR THIS REVISION] section
3. Optionally execute immediately (following Prompt 3 workflow) or save for later
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

3. **Manual Invocation (Prompt 5)**
   - Run `Prompt_5_Scan_For_User_Edits.md` anytime
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
- `Process/Styles/Style_Catalog.md` - Master catalog of 19 framework styles
- `Process/Styles/README.md` - Style library usage guide
- `Process/Styles/[Category]/[StyleName].md` - Individual style files organized by category
- `Process/Templates/Style_Guide_Template.md` - Template for project configuration
- `Process/Templates/Custom_Styles_Template.md` - Template for custom styles

**Project Level (Style/):**
- `Style/Style_Guide.md` - Active style configuration for this book
- `Style/Custom_Styles.md` - Optional custom style definitions (project-specific)

### Framework Styles

The framework provides 19 professionally curated styles organized into 5 categories:

**Academic & Research (4 styles):**
1. **Academic Authority** - Scholarly, research-based, third-person formal
2. **Scientific Communicator** - Popular science, wonder with rigor
3. **Technical Precision** - Technical guides, detailed and systematic
4. **Medical/Health Narrative** - Clinical knowledge + human experience, patient-centered

**Business & Professional (2 styles):**
5. **Business Professional** - Management/leadership, action-oriented
6. **Conversational Expert** - Business/professional, second-person accessible

**Narrative & Storytelling (4 styles):**
7. **Narrative Storyteller** - Memoir-adjacent, first-person with scenes
8. **Historical Chronicler** - Narrative history, scholarly storytelling
9. **Investigative Journalist** - Exposés, evidence-based revelation
10. **Confessional Memoir** - Raw honesty, vulnerability, unflinching self-examination

**Personal Development & How-To (3 styles):**
11. **Practical Guide** - How-to, step-by-step instructional
12. **Inspirational Teacher** - Personal development, motivational
13. **Philosophical Contemplative** - Reflective inquiry, ethics, big questions

**Cultural & Social Commentary (6 styles):**
14. **Cultural Critic** - Sharp observation, essayistic, analytical
15. **Satirical Humorist** - Witty, ironic, comedic truth-telling
16. **Activist Advocate** - Social justice, advocacy, call to action
17. **Lyrical Nature Writer** - Poetic, sensory, ecological, place-based
18. **Spiritual/Religious Writer** - Contemplative, sacred traditions, invitational
19. **Sports Writer** - Athletic narratives, competitive drama

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

**Prompt 3 (Change by Chg):**
- Automatic style consistency check after modifications
- Analyzes person, formality, paragraph length, terminology
- Compares against DO/DON'T lists
- Offers corrections or flags for review
- Optional - can skip if needed

**Prompt 4 (Interactive Change):**
- Conversational editing workflow
- Discusses style considerations during changes
- Writes style-aware instructions to _chg files
- Applies active style automatically to generated instructions

**Prompt 8 (Consistency Check):**
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
- During file modifications (Prompt 3, Prompt 4)
- Cross-chapter analysis (Prompt 8)
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
3. Run Prompt 8 to analyze existing content
4. Decide: harmonize all chapters or keep variation
5. Use Prompt 3 or Prompt 4 to apply style to priority chapters

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
- Run Prompt 8 at 25%, 50%, 75% completion
- Check style consistency before major milestones
- Adjust guide to match reality (not vice versa)
- Use style as aspiration, not rigid rules

**With collaborators:**
- Share Style/Style_Guide.md for alignment
- Document project-specific conventions in Custom_Styles.md
- Use style checking to maintain consistency across authors

---

## Concurrent Editing (v0.13.0+)

### Overview

**New in v0.13.0:** The framework now supports safe concurrent editing, allowing you to run multiple Claude instances (CLI or Desktop) simultaneously on different parts of your book.

**Key Features:**
- Work on different chapters at the same time
- Automatic conflict prevention via resource-level locking
- 15-minute stale lock timeout for crash recovery
- Manual lock management via Dashboard (Prompt 10)
- Works in both Claude Code CLI and Claude Desktop

### How Lock Management Works

The framework uses a **resource-level lock system** to coordinate between multiple Claude instances:

**Lock Process:**
1. When a prompt needs to modify a resource (e.g., Chapter 5), it checks for existing locks
2. If unlocked, the prompt acquires a lock on that resource
3. The prompt performs its work (reading, modifying, committing)
4. After completion, the lock is released automatically
5. Other instances can then access that resource

**Lock Storage:**
- Locks stored in `.locks/locks.json` (automatically created on first use)
- Added to `.gitignore` (locks are local, never committed)
- JSON format tracks resource name, timestamp, and instance identifier

### Lockable Resources

The system locks at the resource level, not the entire project:

| Resource Type | What It Locks | Example |
|---------------|---------------|---------|
| **Chapter** | Individual chapter files and change tracking | `Chapter_01`, `Chapter_05`, `Chapter_12` |
| **FrontMatter** | All front matter files | Title page, dedication, preface, etc. |
| **BackMatter** | All back matter files | Appendices, glossary, bibliography, index |
| **StyleSystem** | Style configuration files | Style_Guide.md, Style_Overrides.md |
| **QuoteRegistry** | Chapter quotes file | Chapter_Quotes.md |
| **ImageRegistry** | Image registry file(s) | Image_Registry.md (or split registries) |
| **ProjectConfig** | Project configuration files | .config/*.json files |

### Prompts That Acquire Locks

**Write-operation prompts** (acquire locks before modifying):

- **Prompt 1:** Initialize - Locks `ProjectConfig`
- **Prompt 2:** Add Chapter - Locks new `Chapter_XX` and `ProjectConfig`
- **Prompt 3:** Change by Chg - Locks `Chapter_XX` being modified
- **Prompt 4:** Interactive Change - Locks `Chapter_XX` being modified
- **Prompt 5:** Scan For User Edits - Locks each `Chapter_XX` being scanned
- **Prompt 6:** Integrate Inbox - Locks depend on content type
- **Prompt 11:** Style Manager - Locks `StyleSystem`
- **Prompt 14:** Citation Finder - Locks `Chapter_XX` and possibly `BackMatter`
- **Prompt 15:** Visual Content Suggester - Locks `Chapter_XX` and `ImageRegistry`
- **Prompt 16:** Image Manager - Locks `ImageRegistry` and possibly `Chapter_XX`

**Read-only prompts** (no locks needed):

- **Prompt 7:** Compile - Reads files, writes to `Drafts/` (not locked)
- **Prompt 8:** Consistency Checker - Read-only analysis
- **Prompt 9:** Export - Reads `Manuscript/`, writes to `Exports/`
- **Prompt 10:** Dashboard - Read-only, but displays lock status
- **Prompt 12:** Git Operations - Doesn't modify manuscript files directly
- **Prompt 13:** AI Detection Analysis - Read-only analysis

### Lock Conflict Resolution

**When a prompt encounters an active lock:**

**Scenario 1: Lock is recent (< 15 minutes old)**
```
⚠️ Chapter_05 is currently locked by another instance.

Lock details:
- Resource: Chapter_05
- Locked at: 2025-11-23 10:30:00 (5 minutes ago)
- Instance: Desktop-67890

Options:
1. Wait for lock to clear (checks every 5 seconds)
2. Cancel operation
3. Override lock (not recommended)

Choose option (1-3):
```

**User can:**
- **Wait** - Polls every 5 seconds until lock clears, then proceeds automatically
- **Cancel** - Exits without making changes
- **Override** - Forces lock acquisition (not recommended for active locks)

**Scenario 2: Lock is stale (>= 15 minutes old)**
```
⚠️ Chapter_05 has a stale lock (older than 15 minutes).

Lock details:
- Resource: Chapter_05
- Locked at: 2025-11-23 10:00:00 (23 minutes ago)
- Instance: CLI-12345

This lock may be from a crashed instance.

Options:
1. Override stale lock and continue
2. Cancel operation

Choose option (1-2):
```

**User can:**
- **Override** - Safe to proceed, likely from crashed instance
- **Cancel** - Exit if uncertain

### Working with Multiple Instances

**Best Practices:**

1. **Work on different chapters simultaneously**
   ```
   Terminal 1: Execute Prompt 3 for Chapter 3
   Terminal 2: Execute Prompt 4 for Chapter 7
   → No conflict, both work at the same time
   ```

2. **Check Dashboard before starting**
   ```
   Run Prompt 10 to see:
   - Which resources are currently locked
   - Any stale locks that need clearing
   - Overall system status
   ```

3. **Wait rather than override**
   ```
   If lock is active (< 15 minutes):
   → Choose "Wait" option
   → System polls and proceeds automatically when clear

   If lock is stale (>= 15 minutes):
   → Safe to override (likely crashed instance)
   ```

4. **Clear stale locks after crashes**
   ```
   Use Prompt 10 Dashboard → "Clear All Locks"
   → Removes all locks (with confirmation)
   → Fresh start for new work
   ```

### Dashboard Lock Management

**Prompt 10 (Dashboard) shows lock status:**

**Example output:**
```markdown
## Active Locks

**Current locks:**
- Chapter_03: Locked 5 minutes ago (CLI-12345)
- StyleSystem: Locked 12 minutes ago (Desktop-67890)

**Stale locks (>15 minutes):**
- Chapter_07: Locked 23 minutes ago (CLI-99999) ⚠️ STALE

Total: 2 active locks, 1 stale lock

---

To clear all locks manually, use the "Clear All Locks" operation.
```

**Clear All Locks operation:**
1. Shows current locks (active and stale)
2. Warns about clearing active locks
3. Requires confirmation
4. Clears all locks if confirmed

### Technical Implementation

**Lock File Format** (`.locks/locks.json`):
```json
{
  "locks": [
    {
      "resource": "Chapter_03",
      "timestamp": "2025-11-23T10:30:00Z",
      "instance": "CLI-12345"
    },
    {
      "resource": "StyleSystem",
      "timestamp": "2025-11-23T10:32:00Z",
      "instance": "Desktop-67890"
    }
  ]
}
```

**Instance Identifiers:**
- Format: `[Environment]-[RandomID]`
- Examples: `CLI-12345`, `Desktop-67890`
- Generated once per session, reused for all locks in that session

**Lock Lifecycle:**
1. **Acquire** - Check for existing lock, add new entry if clear
2. **Hold** - Lock remains while prompt works (typically 1-5 minutes)
3. **Release** - Remove lock entry when work completes (always, even on error)
4. **Timeout** - Locks older than 15 minutes become "stale" and can be overridden

### Error Handling

**Lock File Corruption:**
- Backup corrupted file to `.locks/locks.json.corrupt.[timestamp]`
- Create fresh lock file with empty locks array
- Warn user and proceed with operation

**Crash Recovery:**
- If instance crashes, lock remains in file
- After 15 minutes, becomes stale
- Next instance can safely override stale lock
- Or use "Clear All Locks" to manually clean up

**Concurrent Acquisition (rare):**
- Small window where two instances might both add locks
- Detection: Multiple locks for same resource
- Recovery: Clear All Locks and retry

### Limitations

1. **Local machine only** - Locks don't coordinate across different computers (same git repo, different machines)
2. **Small race condition window** - Rare possibility of concurrent acquisition
3. **Requires user discipline** - Users can override active locks (but warned)
4. **JSON-based** - Not industrial-strength, but sufficient for solo author with multiple instances

**Mitigation:** Git still protects against data loss. Locks prevent conflicts; git recovers from them if they occur.

### Use Cases

**Multiple terminals, same machine:**
```
Terminal 1: Draft Chapter 3 (Prompt 4)
Terminal 2: Revise Chapter 7 (Prompt 3)
Terminal 3: Check progress (Prompt 10)
→ All work simultaneously without conflicts
```

**CLI + Desktop together:**
```
Claude Code CLI: Run Consistency Check (Prompt 8) - read-only
Claude Desktop: Edit Chapter 5 (Prompt 4) - acquires lock
→ No conflict, both proceed
```

**Sequential editing of same chapter:**
```
Instance 1: Edit Chapter 5, holds lock
Instance 2: Tries to edit Chapter 5
→ Waits for lock to clear
→ Instance 1 finishes, releases lock
→ Instance 2 acquires lock automatically
→ Instance 2 proceeds with its edits
```

### Complete Documentation

For complete technical details on the lock management system, see:
- **Module documentation:** `Process/_COMMON/18_Lock_Management_Module.md`
- **Quick reference:** `Process/Prompts/QUICK_REFERENCE.md` (section: "Working with Multiple Instances")

---

## Core Prompts

The AI-Assisted Nonfiction Authoring Process includes 16 core prompts for different aspects of book development. Each prompt is a conversational interface stored in `Process/Prompts/`.

**How to use:** Copy a prompt file and paste into Claude Code. The AI will guide you through the process interactively.

**For complete details on each prompt, see Process/Prompts/README.md**

---

### Prompt 1: Initialize Project Structure
Creates complete project structure from scratch. **Interactive:** Fully guided setup.
**See:** `Process/Prompts/Prompt_1_Initialize.md` for execution

### Prompt 2: Add New Chapter
Inserts new chapter with automatic reorganization and renumbering. **Interactive:** Quick questions or Inbox integration.
**See:** `Process/Prompts/Prompt_2_Add_Chapter.md` for execution

### Prompt 3: Change by Chg
Automated workflow executing pre-written instructions from _chg files. **Interactive:** Minimal - reads _chg file and confirms.
**See:** `Process/Prompts/Prompt_3_Change_by_Chg.md` for execution

### Prompt 4: Interactive Change
Conversational editing that writes instructions to _chg files. **Interactive:** High - discuss changes, AI writes instructions, optionally execute.
**See:** `Process/Prompts/Prompt_4_Interactive_Change.md` for execution

### Prompt 5: Scan For User Edits
Synchronizes _chg files with manual edits detected via git. **Interactive:** Minimal - automatic scan.
**See:** `Process/Prompts/Prompt_5_Scan_For_User_Edits.md` for execution

### Prompt 6: Integrate Content from Inbox
Processes files from Inbox/ directory into project. **Interactive:** Medium - per-file decisions.
**See:** `Process/Prompts/Prompt_6_Integrate_Inbox.md` for execution

### Prompt 7: Compile Complete Manuscript
Generates single file with entire manuscript. **Interactive:** Low - use defaults or customize.
**See:** `Process/Prompts/Prompt_7_Compile.md` for execution

### Prompt 8: Consistency Checker
Scans all content for issues. **Interactive:** Medium - choose scope and check types.
**See:** `Process/Prompts/Prompt_8_Consistency.md` for execution

### Prompt 9: Export and Format
Exports to DOCX, PDF, EPUB, LaTeX. **Interactive:** Low - use defaults or customize.
**See:** `Process/Prompts/Prompt_9_Export.md` for execution

### Prompt 10: Progress Dashboard
Generates comprehensive status report. **Interactive:** Minimal - choose summary or detailed.
**See:** `Process/Prompts/Prompt_10_Dashboard.md` for execution

### Prompt 11: Style Manager
Manages hierarchical style system. **Interactive:** Medium - operation-specific questions.
**See:** `Process/Prompts/Prompt_11_Style_Manager.md` for execution

### Prompt 12: Git Operations
Performs git version control operations. **Interactive:** Medium - varies by operation.
**See:** `Process/Prompts/Prompt_12_Git.md` for execution

### Prompt 13: AI Detection Analysis
Analyzes chapters for AI-generated text indicators. **Interactive:** Minimal - automatic analysis.
**See:** `Process/Prompts/Prompt_13_AI_Detection_Analysis.md` for execution

### Prompt 14: Citation Finder
Finds and inserts citations with WebSearch verification. **Interactive:** Medium - source selection.
**See:** `Process/Prompts/Prompt_14_Citation_Finder.md` for execution

### Prompt 15: Visual Content Suggester
Creates text-based visuals (tables, diagrams, flowcharts). **Interactive:** Medium - visual placement.
**See:** `Process/Prompts/Prompt_15_Visual_Content_Suggester.md` for execution

### Prompt 16: Image Manager
Manages professional images and visual assets. **Interactive:** Medium - image operations.
**See:** `Process/Prompts/Prompt_16_Image_Manager.md` for execution

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

**During Compilation (Prompt 7):**
- Verified (✓) quotes automatically inserted at chapter start
- Quotes needing citation (⚠) included with warning note
- Pending quotes (⏳) skipped with note in compilation report

**During Consistency Check (Prompt 8):**
- Quote verification status reported
- Missing attributions flagged
- Formatting inconsistencies identified
- Bibliography references validated

**In Progress Dashboard (Prompt 10):**
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

**Method 1: Using Prompt 3 (Manual Instructions):**

1. Open `Quotes/Chapter_Quotes_chg.md`
2. Add instructions in [INSTRUCTIONS FOR THIS REVISION] section
3. Commit the _chg file
4. Execute Prompt 3, specifying Chapter_Quotes.md as target
5. AI updates quotes and auto-archives instructions

**Method 2: Using Prompt 4 (Interactive Change):**

1. Execute Prompt 4
2. Discuss quote changes conversationally (add, update, verify)
3. AI writes structured instructions to Chapter_Quotes_chg.md
4. Optionally execute immediately or commit for later

**Method 3: Using Book-Writing-Assistant Agent (Enhanced Workflow):**

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

When compiling the manuscript (Prompt 7), verified quotes are formatted as:

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

**Track these metrics (visible in Prompt 10 Dashboard):**

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
   - Use Prompt 8 regularly
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
   - Run Prompt 10 weekly (Progress Dashboard)
   - Run Prompt 8 at milestones (Consistency Checker)
   - Run Prompt 13 before milestones (AI Detection Analysis)
   - Commit changes frequently with descriptive messages
   - Push to remote repository regularly

6. **Compile and Review:**
   - Use Prompt 7 periodically
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
**Solution:** Run Prompt 8 with cross-reference check, then use Prompt 3 or Prompt 4 to fix

**Problem:** Inconsistent terminology
**Solution:** Run Prompt 8, create style guide, use find-replace carefully

**Problem:** Lost changes or want to undo recent edits
**Solution:** Use `git log` to find the commit, then `git checkout <commit-hash> -- <file>` to restore, or `git revert <commit-hash>` to undo a commit

**Problem:** Placeholder content in final draft
**Solution:** Run Prompt 10 to identify, then use Prompt 3 or Prompt 4 to complete sections

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

## Default Compilation Settings (Prompt 7)

- **Format:** Formatted
- **Include Placeholders:** Yes
- **Include Change Tracking Metadata:** No
- **Auto-Generate TOC:** Yes

## Default Export Settings (Prompt 9)

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
