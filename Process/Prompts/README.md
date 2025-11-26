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
├── Prompt_3_Change_by_Chg.md
├── Prompt_4_Interactive_Change.md (NEW in v0.11.0)
├── Prompt_5_Scan_For_User_Edits.md
├── Prompt_6_Integrate_Inbox.md
├── Prompt_7_Compile.md
├── Prompt_8_Consistency.md
├── Prompt_9_Export.md
├── Prompt_10_Dashboard.md
├── Prompt_11_Style_Manager.md
├── Prompt_12_Git.md
├── Prompt_13_AI_Detection_Analysis.md (v0.11.0)
├── Prompt_14_Citation_Finder.md (v0.11.0)
├── Prompt_15_Visual_Content_Suggester.md (v0.11.0)
└── Prompt_16_Image_Manager.md (NEW in v0.12.7)
```

---

## Session Initialization (MANDATORY)

**Before executing ANY prompts in a new Claude Code CLI session, you MUST run:**

```
/fw-init
```

The `/fw-init` slash command:
- Loads all framework documentation (~20,000-30,000 tokens)
- Reads system-instructions.md, core Process/ files, and style library
- Activates Anti-Hallucination Protocol
- Checks for existing book project (PROJECT_CONTEXT.md)
- Provides verbose initialization report with framework version and available prompts

**See:** `.claude/commands/fw-init.md` for complete initialization sequence

**IMPORTANT:** Do NOT execute any prompts until `/fw-init` completes successfully. The framework will not function correctly without proper initialization.

**Note for Claude Desktop users:** Claude Desktop does not support slash commands. Instead, the Session Startup Protocol in `system-instructions.md` (Custom Instructions) automatically loads framework documentation at the start of each session.

---

## How to Use

### General Workflow

1. **Open the prompt file** you want to use
2. **Copy the entire contents**
3. **Paste into Claude Code**
4. **Answer the AI's questions** - The AI will guide you interactively
5. **AI executes** the workflow and reports back

### Example: Modifying a Chapter

**Option A: Write Instructions Yourself (Prompt 3)**

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
4. Open `Prompt_3_Change_by_Chg.md` and copy/paste into Claude Code
5. AI asks: "Which file should I modify?"
6. You: "Chapters/Chapter_03_Methods.md"
7. AI reads the _chg file, confirms the changes, and executes
8. AI auto-archives your instructions to Version History

**Option B: Interactive Conversation (Prompt 4)**

1. Open `Prompt_4_Interactive_Change.md` and copy/paste into Claude Code
2. AI asks: "Which file do you want to modify?"
3. You: "Chapter 3"
4. AI asks: "What changes would you like to make?"
5. You describe the changes conversationally
6. AI writes instructions to the _chg file
7. AI optionally executes the changes immediately

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

### 3. Prompt_3_Change_by_Chg.md
**Purpose**: Execute instructions from _chg files (automated workflow)

**When to use**: You've written instructions in _chg file and want them applied

**Interaction**:
- You write instructions in the `_chg.md` file first
- Commit the _chg file to git
- AI asks which file to modify
- AI reads instructions from _chg file automatically
- AI confirms and executes

**Key feature**: Auto-archives completed instructions to Version History

**Quote updates**: Use with `Quotes/Chapter_Quotes_chg.md` to add/update chapter quotes

**Note**: For interactive editing that writes instructions for you, use Prompt 4 instead

**Output**: Modified content file, updated _chg file, git commit

---

### 4. Prompt_4_Interactive_Change.md (NEW in v0.11.0)
**Purpose**: Conversational editing that writes instructions to _chg files

**When to use**: You want to discuss changes interactively before applying them

**Interaction**:
- AI asks which file to modify
- You describe changes conversationally
- AI writes instructions to the _chg file
- AI optionally executes Prompt 3 to apply changes immediately

**Key feature**: Alternative to manually writing _chg instructions

**Workflow modes**:
- Write instructions only (for review before execution)
- Write and execute immediately (one-step process)

**Note**: Instructions written by AI are stored in _chg files for traceability

**Output**: Instructions written to _chg file, optionally modified content file and git commit

---

### 5. Prompt_5_Scan_For_User_Edits.md
**Purpose**: Detect manual edits and synchronize _chg files

**When to use**: After manual edits, before milestones, weekly maintenance

**Interaction**: AI scans for out-of-sync files and auto-updates them

**Detection**: Checks uncommitted, staged, and unpushed changes

**Auto-generation**: Creates version history entries from git diffs with inferred change types

**Note**: The book-writing-assistant agent runs this automatically at session start and before commits

**Output**: Updated _chg files with new version history entries

---

### 6. Prompt_6_Integrate_Inbox.md
**Purpose**: Process files from Inbox/ directory

**When to use**: You have content, references, or assets to integrate

**Interaction**: AI scans Inbox/, shows findings, asks about each file

**Special rule**: After initial project setup, complete TOC files are rejected

**Output**: Integrated content, archived inbox files, git commits

---

### 7. Prompt_7_Compile.md
**Purpose**: Generate complete manuscript in single file

**When to use**: Want to review entire book, prepare for editing

**Interaction**: AI asks for version number and whether to use default settings

**Settings**: Stored in `.config/project.json`, can customize per compilation

**Quote insertion**: Verified (✓) quotes automatically inserted as chapter epigraphs; compilation report shows quote status

**Output**: `Drafts/[Project-Name]-[format]-vNN.md` with statistics and quote completion metrics

---

### 8. Prompt_8_Consistency.md
**Purpose**: Check for consistency issues across all content

**When to use**: Weekly, at milestones, before compilation/export

**Interaction**: AI asks what scope and which checks to run

**Checks**: Terminology, cross-references, style, facts, tone/voice, quote/epigraph verification

**Quote verification**: Flags pending quotes (⏳), missing attributions, incomplete citations, formatting issues

**Output**: Comprehensive report with Critical/Warning/Suggestion categories including quote status

---

### 9. Prompt_9_Export.md
**Purpose**: Export manuscript to DOCX, PDF, EPUB, LaTeX

**When to use**: Preparing for publication, submission, or distribution

**Interaction**: AI asks about format and settings (or uses defaults)

**Settings**: Stored in `.config/project.json`, can customize per export

**Output**: `Exports/[Project-Name]-vNN.[format]` files

---

### 10. Prompt_10_Dashboard.md
**Purpose**: Generate progress report and project status

**When to use**: Weekly check-ins, after major changes, at milestones

**Interaction**: AI asks Summary or Detailed

**Quote metrics**: Shows verification status (✓/⚠/⏳) for all chapters, completion percentage, chapters needing work

**Output**: Comprehensive dashboard with metrics, git status, quote status, recommendations

---

### 12. Prompt_12_Git.md
**Purpose**: Perform git version control operations

**When to use**: Commit, tag, branch, view history, push/pull, status

**Interaction**: AI asks which operation, then operation-specific questions

**Safety**: Never runs destructive operations without confirmation

**Output**: Git operation result and next recommendations

---

### 11. Prompt_11_Style_Manager.md
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

### 13. Prompt_13_AI_Detection_Analysis.md (v0.11.0)
**Purpose**: Analyze chapters for AI-generated text indicators

**When to use**: After drafting, before milestones, when concerned about authenticity

**Interaction**: AI asks which chapters to analyze or analyzes all chapters

**Analysis**: Checks for:
- Repetitive sentence structures
- Generic transitional phrases
- Over-formal language patterns
- Lack of personal voice
- Formulaic organization

**Note**: Helps ensure content sounds authentically yours, not generic AI output

**Output**: Authenticity scores per chapter, flagged passages, specific rewriting suggestions

---

### 14. Prompt_14_Citation_Finder.md (v0.11.0)
**Purpose**: Find and insert citations with WebSearch verification

**When to use**: Adding factual claims, statistics, or expert quotes; verifying existing citations

**Interaction**: AI asks which claims need citations or scans for uncited content

**Verification**:
- WebSearch for authoritative sources
- Validates source credibility
- Checks for accessible URLs
- Formats citations consistently

**Note**: Ensures accurate attribution and findable sources

**Output**: Properly formatted citations with verified sources, added to content and bibliography

---

### 15. Prompt_15_Visual_Content_Suggester.md (v0.11.0)
**Purpose**: Analyze chapters and create text-based visuals (tables, diagrams, flowcharts)

**When to use**: After drafting content, during revision, when explanations need visual support

**Interaction**: AI analyzes chapters and suggests visual enhancements

**Visual types**:
- Markdown tables (comparison, data)
- ASCII diagrams (flowcharts, timelines)
- Structured lists (process steps, hierarchies)
- Code blocks (formatted data displays)

**Location**: All visuals created in `Manuscript/images/` (unified directory, v0.12.7+)

**Note**: Enhances understanding without requiring graphics software; creates text-based placeholders

**Output**: Text-based visuals (📝 status) in Markdown format, ready to insert into content

---

### 16. Prompt_16_Image_Manager.md (NEW in v0.12.7)
**Purpose**: Manage professional images and visual assets

**When to use**: Adding photos/charts/graphics, upgrading text-based visuals, validating image references

**Interaction**: Four operating modes - Add, Upgrade, Scan, Validate

**Modes**:
- Mode 1: Add new professional image to chapter
- Mode 2: Upgrade text-based visual (📝 → 🖼️)
- Mode 3: Scan and register existing images
- Mode 4: Validate all image references

**Location**: All images in `Manuscript/images/` with `Image_Registry.md`

**Note**: Works with Prompt 15 for complete visual asset management (text-based + professional)

**Output**: Registered images in unified directory, updated registry, validated references

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

**Prompt 7 (Compile)** and **Prompt 9 (Export)** use defaults from `.config/project.json`:
- You can use defaults (quick)
- Or customize per operation
- Update defaults in `.config/project.json` anytime

---

## Common Workflows

**For complete workflow examples with detailed steps, see Process/Prompts/QUICK_REFERENCE.md**

**Quick workflow summaries:**

- **Daily Writing:** Work on content → Write _chg instructions → Run Prompt 3/4 → Push
- **Weekly Review:** Scan edits (P5) → Dashboard (P10) → Consistency (P8) → Compile (P7) → Fix issues (P3/4) → Push
- **Adding Chapters:** Interactive (P2) or from Inbox (P6)
- **Milestones:** Dashboard → Consistency → AI Detection → Visual Content → Citations → Fix → Compile → Tag
- **Publication:** Final checks (P5, P8, P13, P14, P15, P16) → Fixes (P3/4) → Compile (P7) → Export (P9) → Tag

### Quote Management Workflow

**Quote status codes:** ⏳ Pending | ⚠ Needs Citation | ✓ Verified

**Workflow:**
- Use Prompt 3 or 4 to update `Quotes/Chapter_Quotes.md`
- Prompt 10 (Dashboard) shows status for all chapters
- Prompt 8 (Consistency) validates quotes
- Prompt 7 (Compile) inserts verified quotes as epigraphs

**Quality Targets:**
- Before first compilation: 50% verified (✓)
- Before major review: 80% verified (✓)
- Before final draft: 100% verified (✓)

**For complete quote management details and examples, see Documentation/AI-Assisted_Nonfiction_Authoring_Process.md (Quote Management Workflow section)**

---

## Tips for Best Results

1. **Always reference Anti-Hallucination Guidelines**: All prompts do this automatically

2. **Choose your editing workflow**: Prompt 3 (manual instructions) or Prompt 4 (interactive)

3. **Commit _chg files before using Prompt 3**: This ensures you have a record of your instructions

4. **Use Prompt 10 (Dashboard) frequently**: Weekly check-ins help you stay on track

5. **Run Prompt 8 (Consistency) at milestones**: Catch issues early

6. **Run Prompt 13 (AI Detection) before reviews**: Ensure authentic voice

7. **Run Prompt 14 (Citation Finder) as needed**: Verify factual claims

8. **Run Prompt 15 (Visual Content) during revision**: Add text-based visuals

9. **Run Prompt 16 (Image Manager) to upgrade visuals**: Professional images where needed

9. **Push to remote regularly**: Your cloud backup via Prompt 12

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
- Prompt 3: Execute instructions from _chg files (manual workflow)
- Prompt 4: Interactive editing with AI writing instructions (conversational workflow)
- Prompt 10: Progress dashboard and status checks
- Prompt 8: Consistency checking at milestones
- Prompt 13: AI detection analysis for authenticity

CHANGE TRACKING WORKFLOW (Option A - Manual):
1. User writes instructions in [filename]_chg.md
2. User commits _chg file
3. Execute Prompt 3
4. Read instructions from _chg file
5. Apply changes to content file
6. Auto-archive instructions to Version History
7. Clear instruction section
8. Commit to git with version info

CHANGE TRACKING WORKFLOW (Option B - Interactive):
1. Execute Prompt 4
2. User describes changes conversationally
3. AI writes instructions to [filename]_chg.md
4. AI optionally executes Prompt 3 immediately
5. Changes applied and archived as above

EXECUTE PROMPTS:
When user says "Execute Prompt X" or "Run Prompt X":
- Read the appropriate file from Process/Prompts/
- Follow the prompt's workflow exactly
- Apply all anti-hallucination rules
- Update PROJECT_CONTEXT.md if changes are significant

FILE ACCESS:
All prompts and documentation are in Process/ and Documentation/ directories:
- Process/Prompts/Prompt_[1-16]_*.md
- Process/Anti-Hallucination_Guidelines.md
- Process/Styles/ (19 curated styles)
- Documentation/AI-Assisted_Nonfiction_Authoring_Process.md

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
- **Prompt 4** (after interactive changes)
- **Prompt 5** (after change tracking sync)
- **Prompt 10** (when running dashboard)

**Manual refresh:** Say "Update PROJECT_CONTEXT.md" or run Prompt 10

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

Claude: [Reads Prompt_3_Change_by_Chg.md]
I'll modify Chapter_05_Results.md based on the instructions in Chapter_05_Results_chg.md...
[Executes workflow]
[Updates PROJECT_CONTEXT.md with changes]
Done! Chapter 05 updated to version 1.3.0.
```

**Interactive editing:**
```
User: Execute Prompt 4 for Chapter 05

Claude: [Reads Prompt_4_Interactive_Change.md]
What changes would you like to make to Chapter 05?

User: Add a section about survey limitations and expand the demographics table.

Claude: I'll write those instructions to the _chg file and execute them...
[Writes to Chapter_05_Results_chg.md]
[Optionally executes Prompt 3]
Done! Instructions captured and changes applied to version 1.3.0.
```

---

## Getting Help

- **Process documentation**: `Documentation/AI-Assisted_Nonfiction_Authoring_Process.md`
- **Quick reference**: `Process/Prompts/QUICK_REFERENCE.md`
- **Anti-hallucination rules**: `Process/Anti-Hallucination_Guidelines.md`
- **Claude Desktop setup**: See "Using with Claude Desktop" section above

---

## Archived Materials

Old template and standalone prompt files have been archived to:
`Process/Archive/Old_Prompts_2025-11-17/`

They remain in git history if you need to reference them.
