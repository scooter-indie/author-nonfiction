Initialize the AI-Assisted Nonfiction Authoring Framework for this session.

## MANDATORY Session Initialization

This command loads all framework documentation and prepares Claude for executing prompts. You MUST run `/fw-init` at the start of every session before executing any prompts.

---

## Initialization Sequence

Perform the following actions in order and report verbose progress:

### 1. Read system-instructions.md

Read `system-instructions.md` from the project root to understand:
- Framework version and compatibility
- Session Startup Protocol
- Anti-hallucination enforcement rules
- Prompt compatibility classifications (CLI-ONLY vs DESKTOP-FRIENDLY vs HYBRID)

Report: `✓ system-instructions.md loaded (Framework v[VERSION])`

### 2. Load Core Framework Documentation

Read the following files from the `Process/` directory:

**a) Process/AI-Assisted_Nonfiction_Authoring_Process.md**
- Comprehensive framework guide (~1,692 lines)
- Directory structure, file naming conventions, change tracking system
- Writing style system, workflow states, quality control

Report: `✓ AI-Assisted_Nonfiction_Authoring_Process.md loaded`

**b) Process/Anti-Hallucination_Guidelines.md**
- Critical rules for accuracy and truthfulness
- ASK FIRST protocol (never assume user experiences)
- FORBIDDEN FABRICATIONS list
- Content labeling system (REAL vs HYPOTHETICAL vs GENERIC)
- Quote verification status codes (⏳/⚠/✓)

Report: `✓ Anti-Hallucination_Guidelines.md loaded`

**c) Process/Prompts/QUICK_REFERENCE.md**
- Common workflows and quick reference guide
- Daily writing sessions, weekly reviews, milestone workflows
- Prompt selection decision tree

Report: `✓ QUICK_REFERENCE.md loaded`

**d) Process/Prompts/README.md**
- Detailed documentation for all 16 prompts
- Compatibility information (Claude Code CLI vs Claude Desktop)
- Workflow examples and integration notes

Report: `✓ Prompts README.md loaded`

### 3. Load Writing Styles Library

Read `Process/Styles/README.md` to understand the modular style library structure.

Report: `✓ Styles library loaded (19 styles across 5 categories)`

### 4. Scan Available Prompts

Confirm awareness of all 16 core prompts in `Process/Prompts/`:
- Prompt_1_Initialize.md
- Prompt_2_Add_Chapter.md
- Prompt_3_Change_by_Chg.md
- Prompt_4_Interactive_Change.md
- Prompt_5_Scan_For_User_Edits.md
- Prompt_6_Integrate_Inbox.md
- Prompt_7_Compile.md
- Prompt_8_Consistency.md
- Prompt_9_Export.md
- Prompt_10_Dashboard.md
- Prompt_11_Style_Manager.md
- Prompt_12_Git_Operations.md
- Prompt_13_AI_Detection_Analysis.md
- Prompt_14_Citation_Finder.md
- Prompt_15_Visual_Content_Suggester.md
- Prompt_16_Image_Manager.md

Report: `✓ Scanned 16 core prompts`

### 5. Check for Book Project Context

Check if `PROJECT_CONTEXT.md` exists in the project root:
- **If exists:** Read it to understand the user's book project (title, author, chapters, style, metadata)
- **If not exists:** User hasn't initialized a book project yet (needs to run Prompt 1)

Report one of:
- `✓ PROJECT_CONTEXT.md found - Book project: [TITLE] by [AUTHOR]`
- `ℹ No PROJECT_CONTEXT.md found - No book project initialized yet`

### 6. Check for User Project Configuration

If a book project exists (PROJECT_CONTEXT.md found), check for `.config/` directory:
- `.config/init.json` - Initialization Q&A answers
- `.config/project.json` - Project settings
- `.config/metadata.json` - Book metadata
- `.config/manifest.json` - Framework tracking
- `.config/migrations.json` - Version migrations

Report configuration status if found.

### 7. Verify Working Directory

Confirm the current working directory using context information.

Report: `✓ Working directory: [PATH]`

---

## Initialization Complete

After completing all steps above, provide a summary report:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Framework Initialization Complete
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Framework Version: [VERSION]
Prompts Available: 16 core prompts
Book Project: [Found/Not Found]
Working Directory: [PATH]

Compatibility Classification:
  • DESKTOP-FRIENDLY (6): Prompts 2, 3, 4, 5, 6, 10
  • HYBRID (2): configure.md, Prompts 1, 11
  • CLI-ONLY (8): Prompts 7, 8, 9, 12, 13, 14, 15, 16

Anti-Hallucination Protocol: ✓ Active
  → ASK FIRST before generating examples, anecdotes, statistics, or quotes
  → NEVER fabricate specific people, data, or unverified quotes
  → Use verification status codes: ⏳ Pending | ⚠ Needs Citation | ✓ Verified

Ready! How can I help with your nonfiction authoring project?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Notes

- This initialization loads ~20,000-30,000 tokens of framework documentation
- Required at the start of every Claude Code session
- Can be re-run mid-session if context is lost or session becomes very long
- Makes all framework knowledge immediately available for prompt execution
