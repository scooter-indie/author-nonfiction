# Execute Prompts for AI-Assisted Nonfiction Authoring

This directory contains simple, conversational prompt files for working with AI assistants on nonfiction book projects.

## Philosophy

**Single Source of Truth**: Content file `_chg.md` files contain all modification instructions. You write your instructions there, then execute the prompts.

**Conversational Interface**: Just copy a prompt file and paste into Claude Code. The AI will ask you questions and guide you through the process.

**No Templates**: No fill-in-the-blank forms. Just interactive conversations with the AI.

---

## Directory Contents

```
Prompts/
├── README.md (this file)
├── QUICK_REFERENCE.md (workflows and when to use each prompt)
├── Prompt_1_Initialize.md
├── Prompt_2_Add_Chapter.md
├── Prompt_3_Modify_File.md
├── Prompt_4_Integrate_Inbox.md
├── Prompt_5_Compile.md
├── Prompt_6_Consistency.md
├── Prompt_7_Export.md
├── Prompt_8_Dashboard.md
├── Prompt_9_Git.md
├── Prompt_10_Update_Change_Tracking.md
└── Prompt_11_Style_Manager.md
```

---

## How to Use

### General Workflow

1. **Open the prompt file** you want to use
2. **Copy the entire contents**
3. **Paste into Claude Code**
4. **Answer the AI's questions** - The AI will guide you interactively
5. **AI executes** the workflow and reports back

### Example: Modifying a Chapter

**Your workflow:**

1. Open `Chapters/Chapter_03_Methods_chg.md`
2. Add instructions to the `[INSTRUCTIONS FOR THIS REVISION]` section:
   ```markdown
   ### [INSTRUCTIONS FOR THIS REVISION]

   Rewrite the "Data Collection" section to:
   - Add example of survey design
   - Include reference to Johnson (2023) study
   - Clarify the sampling methodology
   ```
3. Commit the _chg file to git
4. Open `Prompt_3_Modify_File.md` and copy/paste into Claude Code
5. AI asks: "Which file should I modify?"
6. You: "Chapters/Chapter_03_Methods.md"
7. AI reads the _chg file, confirms the changes, and executes
8. AI auto-archives your instructions to Version History

---

## Available Prompts

### 1. Prompt_1_Initialize.md
**Purpose**: Create new book project from scratch

**When to use**: Starting a brand new book

**Interaction**: Fully interactive - AI asks about title, author, word count, TOC, etc.

**Quote setup**: Creates `Quotes/Chapter_Quotes.md` with placeholder entries for all chapters (Status: ⏳ Pending)

**Output**: Complete project structure, git repo, all placeholder files including quote management

---

### 2. Prompt_2_Add_Chapter.md
**Purpose**: Add a new chapter to existing book

**When to use**: Need to insert a new chapter into your book

**Interaction**: Choose interactive (quick questions) or from Inbox content

**Important**: TOC/TOC_chg.md is AI-managed only. Do not edit it manually.

**Quote handling**: Automatically adds quote entry to `Chapter_Quotes.md` (Status: ⏳ Pending)

**Output**: New chapter files, renumbered existing chapters, updated TOC, quote entry, git commits

---

### 3. Prompt_3_Modify_File.md
**Purpose**: Modify content based on _chg file instructions

**When to use**: This is your PRIMARY workflow for content revisions (including quote management)

**Interaction**:
- You write instructions in the `_chg.md` file first
- AI asks which file to modify
- AI reads instructions from _chg file automatically
- AI confirms and executes

**Key feature**: Auto-archives completed instructions to Version History

**Quote updates**: Use with `Quotes/Chapter_Quotes_chg.md` to add/update chapter quotes

**Output**: Modified content file, updated _chg file, git commit

---

### 4. Prompt_4_Integrate_Inbox.md
**Purpose**: Process files from Inbox/ directory

**When to use**: You have content, references, or assets to integrate

**Interaction**: AI scans Inbox/, shows findings, asks about each file

**Special rule**: After initial project setup, complete TOC files are rejected

**Output**: Integrated content, archived inbox files, git commits

---

### 5. Prompt_5_Compile.md
**Purpose**: Generate complete manuscript in single file

**When to use**: Want to review entire book, prepare for editing

**Interaction**: AI asks for version number and whether to use default settings

**Settings**: Stored in `Project_Config.md`, can customize per compilation

**Quote insertion**: Verified (✓) quotes automatically inserted as chapter epigraphs; compilation report shows quote status

**Output**: `Drafts/Full_Draft_[date]_v[version].md` with statistics and quote completion metrics

---

### 6. Prompt_6_Consistency.md
**Purpose**: Check for consistency issues across all content

**When to use**: Weekly, at milestones, before compilation/export

**Interaction**: AI asks what scope and which checks to run

**Checks**: Terminology, cross-references, style, facts, tone/voice, quote/epigraph verification

**Quote verification**: Flags pending quotes (⏳), missing attributions, incomplete citations, formatting issues

**Output**: Comprehensive report with Critical/Warning/Suggestion categories including quote status

---

### 7. Prompt_7_Export.md
**Purpose**: Export manuscript to DOCX, PDF, EPUB, LaTeX

**When to use**: Preparing for publication, submission, or distribution

**Interaction**: AI asks about format and settings (or uses defaults)

**Settings**: Stored in `Project_Config.md`, can customize per export

**Output**: Formatted files in `Exports/[date]/` directory

---

### 8. Prompt_8_Dashboard.md
**Purpose**: Generate progress report and project status

**When to use**: Weekly check-ins, after major changes, at milestones

**Interaction**: AI asks Summary or Detailed

**Quote metrics**: Shows verification status (✓/⚠/⏳) for all chapters, completion percentage, chapters needing work

**Output**: Comprehensive dashboard with metrics, git status, quote status, recommendations

---

### 9. Prompt_9_Git.md
**Purpose**: Perform git version control operations

**When to use**: Commit, tag, branch, view history, push/pull, status

**Interaction**: AI asks which operation, then operation-specific questions

**Safety**: Never runs destructive operations without confirmation

**Output**: Git operation result and next recommendations

---

### 10. Prompt_10_Update_Change_Tracking.md
**Purpose**: Synchronize _chg files with content file changes

**When to use**: After manual edits, before milestones, weekly maintenance

**Interaction**: AI scans for out-of-sync files and auto-updates them

**Detection**: Checks uncommitted, staged, and unpushed changes

**Auto-generation**: Creates version history entries from git diffs with inferred change types

**Note**: The book-writing-assistant agent runs this automatically at session start and before commits

**Output**: Updated _chg files with new version history entries

---

### 11. Prompt_11_Style_Manager.md (NEW in v0.10.1)
**Purpose**: Manage hierarchical style system (book/chapter/section overrides)

**When to use**: Adding/removing style overrides, analyzing distribution, validating registry

**Interaction**: Menu-driven with 7 operations:
1. Add chapter override
2. Remove chapter override
3. Scan section overrides
4. Validate override registry
5. View style distribution
6. Analyze transitions
7. Change book-level style

**Hierarchical system**: Book style → Chapter overrides → Section overrides (cascading inheritance)

**Registry**: Auto-maintains `Manuscript/Style/Style_Overrides.md` with distribution and transitions

**Threshold**: Warns when chapter overrides exceed 30%

**Compatibility**: HYBRID (Desktop for single-file ops, CLI for multi-file scans)

**Output**: Updated override registry, style analysis reports, validated consistency

---

## Important Concepts

### Single Source of Truth: _chg Files

**For content modifications:**
- Write your instructions in the `_chg.md` file
- Commit the _chg file
- Execute Prompt 3
- AI reads and executes your instructions
- AI auto-archives them to Version History

**Do NOT edit:**
- `TOC/TOC_chg.md` - This is AI-managed only

### Auto-Archive Workflow

When Prompt 3 completes:
1. Instructions are moved to Version History with version increment
2. `[INSTRUCTIONS FOR THIS REVISION]` section is cleared
3. Message left: "[Ready for next revision - add instructions above]"
4. File metadata updated (word count, date, etc.)
5. Git commit created

### Default Settings

**Prompt 5 (Compile)** and **Prompt 7 (Export)** use defaults from `Project_Config.md`:
- You can use defaults (quick)
- Or customize per operation
- Update defaults in Project_Config.md anytime

---

## Common Workflows

### Daily Writing Session
1. Work on content in your editor
2. Run **Prompt 9** → Status to check git state
3. Write revision instructions in _chg files
4. Run **Prompt 3** for each file (auto-commits)
5. Run **Prompt 9** → Push at end of session

### Weekly Review
1. **Prompt 8** → Progress Dashboard
2. **Prompt 6** → Consistency Check
3. **Prompt 5** → Compile manuscript for review
4. Fix issues using **Prompt 3**
5. **Prompt 9** → Commit and push

### Adding New Content
**Option A (Interactive):**
- **Prompt 2** → Add Chapter (answer questions)

**Option B (From Inbox):**
- Place content in Inbox/
- **Prompt 4** → Integrate Inbox

### Milestone Workflow (25%, 50%, 75%, 100%)
1. **Prompt 8** → Dashboard (verify progress)
2. **Prompt 6** → Full consistency check
3. Fix all issues using **Prompt 3**
4. **Prompt 5** → Compile final version
5. **Prompt 9** → Create tag (e.g., v1.0.0, first-draft)
6. **Prompt 9** → Push with tags

### Publication Preparation
1. **Prompt 8** → Verify 100% completion
2. **Prompt 6** → Final consistency check
3. **Prompt 3** → Fix all remaining issues
4. **Prompt 5** → Compile final manuscript
5. **Prompt 7** → Export to required format(s)
6. **Prompt 9** → Tag as publication-ready

### Quote Management Workflow
**Adding/Updating Chapter Quotes:**

1. Open `Quotes/Chapter_Quotes_chg.md`
2. Add instructions in `[INSTRUCTIONS FOR THIS REVISION]` section:
   ```markdown
   Update quote for Chapter 05:

   Current Status: ⏳ Pending
   New Status: ✓ Verified

   Add verified quote:
   Quote: "The scientific method is..."
   Author: Carl Sagan
   Source: The Demon-Haunted World
   Year: 1995
   Page: 27

   Bibliography: Sagan, C. (1995)...
   Notes: Verified from original text
   ```
3. Commit the _chg file
4. **Prompt 3** → Modify File → Select `Quotes/Chapter_Quotes.md`
5. AI updates quote and auto-archives instructions

**Quote Verification Progression:**
- ⏳ Pending → Quote needs to be selected
- ⚠ Needs Citation → Quote selected but needs complete attribution
- ✓ Verified → Quote fully verified with complete bibliographic info

**Checking Quote Status:**
- **Prompt 8** → Dashboard shows all quote statuses
- **Prompt 6** → Consistency check validates quotes
- **Prompt 5** → Compilation report shows which quotes will be inserted

**Quality Targets:**
- Before first compilation: 50% verified (✓)
- Before major review: 80% verified (✓)
- Before final draft: 100% verified (✓)

**See also**: `Process/Anti-Hallucination_Guidelines.md` for quote verification rules and common misattribution examples

---

## Tips for Best Results

1. **Always reference Anti-Hallucination Guidelines**: All prompts do this automatically

2. **Commit _chg files before using Prompt 3**: This ensures you have a record of your instructions

3. **Use Prompt 8 (Dashboard) frequently**: Weekly check-ins help you stay on track

4. **Run Prompt 6 (Consistency) at milestones**: Catch issues early

5. **Push to remote regularly**: Your cloud backup via Prompt 9

6. **Don't edit TOC_chg.md manually**: Let the AI manage it via Prompts 1, 2, and 4

7. **Use descriptive instructions in _chg files**: Clear instructions = better results

---

## Anti-Hallucination Guidelines

All prompts automatically reference `Process/Anti-Hallucination_Guidelines.md` to ensure:
- Factual accuracy
- Proper handling of uncertainty
- No fabricated statistics, quotes, or citations
- Clear markers for content needing verification
- Quote verification requirements (never fabricate attributions)
- Common misattribution warnings (Einstein, Twain, Churchill, etc.)

---

## Using with Claude Desktop

### PROJECT_CONTEXT.md File

After running **Prompt 1 (Initialize)**, a file called `PROJECT_CONTEXT.md` is created in your project root. This file contains complete framework and project context for seamless session resumption in Claude Desktop.

**When to use:**
- Starting a new Claude Desktop chat session
- Resuming work after a break
- Switching between different book projects

**How to use:**
1. Open Claude Desktop
2. Start a new chat
3. **Upload `PROJECT_CONTEXT.md` to the Files area** (drag-and-drop or click to browse)
4. Paste the System Instructions into the message area (see below)
5. Send the message
6. Claude will have complete context about your project and framework

**IMPORTANT:** Upload the file to the Files area, do NOT copy/paste its contents into the System Instructions.

### System Instructions for Claude Desktop

Copy and paste these instructions when starting a Claude Desktop session:

```
You are assisting with the AI-Assisted Nonfiction Authoring Framework.

IMPORTANT: The user has uploaded PROJECT_CONTEXT.md as a file. Read this file immediately to load complete framework and project context.

CRITICAL RULES:
1. Read and apply Process/Anti-Hallucination_Guidelines.md before every response
2. Never fabricate quotes, statistics, or citations
3. Mark uncertain content with ⚠️
4. Use quote verification status: ⏳ Pending | ⚠ Needs Citation | ✓ Verified
5. Use change tracking workflow for all content modifications
6. Commit to git before major operations
7. Update PROJECT_CONTEXT.md after significant changes (via Prompts 3, 8)

PRIMARY WORKFLOWS:
- Prompt 3: All content modifications (chapters, quotes, front/back matter)
- Prompt 8: Progress dashboard and status checks
- Prompt 6: Consistency checking at milestones

CHANGE TRACKING WORKFLOW:
1. User writes instructions in [filename]_chg.md
2. User commits _chg file
3. Execute Prompt 3
4. Read instructions from _chg file
5. Apply changes to content file
6. Auto-archive instructions to Version History
7. Clear instruction section
8. Commit to git with version info

EXECUTE PROMPTS:
When user says "Execute Prompt X" or "Run Prompt X":
- Read the appropriate file from Process/Prompts/
- Follow the prompt's workflow exactly
- Apply all anti-hallucination rules
- Update PROJECT_CONTEXT.md if changes are significant

FILE ACCESS:
All prompts and documentation are in Process/ directory:
- Process/Prompts/Prompt_[1-10]_*.md
- Process/Anti-Hallucination_Guidelines.md
- Process/Style_Examples.md
- Process/AI-Assisted_Nonfiction_Authoring_Process.md

IMPORTANT: PROJECT_CONTEXT.md contains your current book project state. Reference it for:
- Book title, author, and metadata
- Current table of contents
- Writing style configuration
- Recent changes and pending work
- Project-specific conventions
```

### Keeping PROJECT_CONTEXT.md Current

The file is automatically updated by:
- **Prompt 3** (after significant content changes)
- **Prompt 8** (when running dashboard)
- **Prompt 10** (after change tracking sync)

**Manual refresh:** Say "Update PROJECT_CONTEXT.md" or run Prompt 8

### Claude Desktop Workflow Example

**Starting a new session:**
```
User: [Uploads PROJECT_CONTEXT.md to Files area]
User: [Pastes System Instructions above in message]
User: What should I work on today?

Claude: [Reads PROJECT_CONTEXT.md file]
Based on your project status, you have 3 chapters with pending _chg instructions:
- Chapter_05_Results_chg.md
- Chapter_07_Discussion_chg.md
- Quotes/Chapter_Quotes_chg.md

Would you like me to execute Prompt 3 for any of these files?
```

**Continuing work:**
```
User: Execute Prompt 3 for Chapter 05

Claude: [Reads Prompt_3_Modify_File.md]
I'll modify Chapter_05_Results.md based on the instructions in Chapter_05_Results_chg.md...
[Executes workflow]
[Updates PROJECT_CONTEXT.md with changes]
Done! Chapter 05 updated to version 1.3.0.
```

---

## Getting Help

- **Process documentation**: `Process/AI-Assisted_Nonfiction_Authoring_Process.md`
- **Quick reference**: `Process/Prompts/QUICK_REFERENCE.md`
- **Anti-hallucination rules**: `Process/Anti-Hallucination_Guidelines.md`
- **Claude Desktop setup**: See "Using with Claude Desktop" section above

---

## Archived Materials

Old template and standalone prompt files have been archived to:
`Process/Archive/Old_Prompts_2025-11-17/`

They remain in git history if you need to reference them.
