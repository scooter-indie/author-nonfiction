Initialize the AI-Assisted Nonfiction Authoring Framework for this session.

## MANDATORY Session Initialization

This command loads essential framework documentation and prepares Claude for executing prompts. You MUST run `/fw-init` at the start of every session before executing any prompts.

---

## Initialization Sequence

Perform the following actions in order and report verbose progress:

### 1. Load FRAMEWORK_CORE.md (Instant Load)

Read `Process/FRAMEWORK_CORE.md` to load essential framework knowledge:
- Anti-Hallucination Protocol (CRITICAL rules)
- Prompt Compatibility Matrix (CLI/Desktop/Hybrid)
- Core directory structure
- Change tracking system overview
- Writing style system overview
- Quote management system
- Git integration essentials
- On-demand loading guide
- Quick workflows reference

Report: `✓ FRAMEWORK_CORE.md loaded`

### 2. Scan Available Prompts

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

### 3. Check for Book Project Context

Check if `PROJECT_CONTEXT.md` exists in the project root:
- **If exists:** Read it to understand the user's book project (title, author, chapters, style, metadata)
- **If not exists:** User hasn't initialized a book project yet (needs to run Prompt 1)

Report one of:
- `✓ PROJECT_CONTEXT.md found - Book project: [TITLE] by [AUTHOR]`
- `ℹ No PROJECT_CONTEXT.md found - No book project initialized yet`

### 4. Check for User Project Configuration

If a book project exists (PROJECT_CONTEXT.md found), check for `.config/` directory:
- `.config/init.json` - Initialization Q&A answers
- `.config/project.json` - Project settings
- `.config/metadata.json` - Book metadata
- `.config/manifest.json` - Framework tracking
- `.config/migrations.json` - Version migrations

Report configuration status if found.

### 5. Verify Working Directory

Confirm the current working directory using context information.

Report: `✓ Working directory: [PATH]`

### 6. Confirm Date with User

**⏸️ STOP AND ASK USER:**

```
Today's date from system: [DATE from <env>]

Is this correct? (yes / or provide correct date in YYYY-MM-DD format)
```

**WAIT for user response.**

- **If user says "yes":** Store as `CONFIRMED_DATE=[DATE]`
- **If user provides different date:** Store as `CONFIRMED_DATE=[user's date]`

Report: `✓ Date confirmed: [CONFIRMED_DATE]`

**IMPORTANT:** Use CONFIRMED_DATE for ALL date operations during this session (file timestamps, completion dates, etc.)

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
Confirmed Date: [CONFIRMED_DATE]

Compatibility Classification:
  • DESKTOP-FRIENDLY (6): Prompts 2, 3, 4, 5, 6, 10
  • HYBRID (2): configure.md, Prompts 1, 11
  • CLI-ONLY (8): Prompts 7, 8, 9, 12, 13, 14, 15, 16

Anti-Hallucination Protocol: ✓ Active
  → ASK FIRST before generating examples, anecdotes, statistics, or quotes
  → NEVER fabricate specific people, data, or unverified quotes
  → Use verification status codes: ⏳ Pending | ⚠ Needs Citation | ✓ Verified

On-Demand Loading Available:
  • Workflows: Process/Prompts/QUICK_REFERENCE.md
  • Styles: Process/Styles/README.md
  • Comprehensive: Documentation/AI-Assisted_Nonfiction_Authoring_Process.md
  • Prompt docs: Process/Prompts/README.md
  • Full anti-hallucination: Process/Anti-Hallucination_Guidelines.md

Ready! How can I help with your nonfiction authoring project?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## On-Demand Loading

**Additional documentation loads automatically when needed:**

- **User executes a prompt?** → Load that prompt file only
- **User asks workflow questions?** → Load QUICK_REFERENCE.md
- **User asks about styles?** → Load Styles/README.md
- **User needs comprehensive details?** → Load Documentation/AI-Assisted_Nonfiction_Authoring_Process.md
- **User asks about prompts?** → Load Prompts/README.md
- **User needs full anti-hallucination?** → Load Anti-Hallucination_Guidelines.md

---

## Notes

- Required at the start of every Claude Code session
- Can be re-run mid-session if context is lost or session becomes very long
- Additional docs load on-demand as needed
- Makes essential framework knowledge immediately available for prompt execution
