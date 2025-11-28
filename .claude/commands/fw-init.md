Initialize the AI-Assisted Nonfiction Authoring Framework for this session.

## MANDATORY Session Initialization

This command loads essential framework documentation and prepares Claude for executing prompts. You MUST run `/fw-init` at the start of every session before executing any prompts.

---

## Step 0: Detect Operating Mode

**First, determine which mode to use:**

1. Check if `.config/fw-location.json` exists in the current directory
2. If YES → **Multi-Book Mode** (BOOKS_ROOT)
3. If NO → Check if `Process/FRAMEWORK_CORE.md` exists
4. If YES → **Legacy Mode** (single-book)
5. If NEITHER exists → Error: "Not a valid framework directory"

Report one of:
- `✓ Multi-Book Mode detected (BOOKS_ROOT)`
- `✓ Legacy Mode detected (single-book)`

**Store mode in session context:** `MODE=[multi-book|legacy]`

---

## Multi-Book Mode Initialization

If `.config/fw-location.json` exists, follow this sequence:

### M1. Load Framework Location

Read `.config/fw-location.json` to get:
- `frameworkRoot` → Store as `FW_ROOT`
- `frameworkVersion` → Store as `FW_VERSION`

Report: `✓ Framework location: [FW_ROOT]`

### M2. Verify Framework Installation

Check that `[FW_ROOT]/Process/FRAMEWORK_CORE.md` exists.
- If not found → Error: "Framework not found at [FW_ROOT]. Please verify installation."

### M3. Load FRAMEWORK_CORE.md

Read `[FW_ROOT]/Process/FRAMEWORK_CORE.md` to load essential framework knowledge.

Report: `✓ FRAMEWORK_CORE.md loaded from FW_ROOT`

### M4. Check for Framework Updates

1. Read `[FW_ROOT]/VERSION` to get current version
2. Compare with `frameworkVersion` in fw-location.json
3. Attempt to fetch remote version: `https://raw.githubusercontent.com/scooter-indie/author-nonfiction-dist/main/VERSION`
4. Compare versions (semantic versioning)

**If update available:**
```
ℹ Framework update available: [current] → [latest]
  To update: cd [FW_ROOT] && git pull
```

**If check fails (network error):** Silently continue (no blocking)

**If up to date:** Report `✓ Framework version: [VERSION] (up to date)`

### M4b. Check and Run Migrations

**After loading framework, check if migrations are needed:**

1. Read `[FW_ROOT]/VERSION` to get framework version
2. Read `[BOOKS_ROOT]/.config/fw-location.json` for `frameworkVersion`
3. If versions differ:
   a. Check `[FW_ROOT]/Process/migrations/` for migration files
   b. Find migrations between old and new version
   c. Execute migrations in order
   d. Update `frameworkVersion` in fw-location.json

**Migration file naming:** `migrate-X.Y.Z-to-A.B.C.md`

**If migrations run:**
```
✓ Migrations applied: [old] → [new]
  - [migration 1 description]
  - [migration 2 description]
```

**If no migrations needed:** Continue silently

### M5. Load Books Registry

Read `.config/books-registry.json` to get:
- List of all registered books
- Currently active book (if any)

### M6. Book Selection

**⏸️ STOP AND ASK USER:**

Display available books:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Book Selection
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Available books:
  1. [Book Title One] - [status] (last accessed: [date])
  2. [Book Title Two] - [status] (last accessed: [date])
  ...

  N. Create new book

Currently active: [activeBook or "None"]

Which book would you like to work on? (number or name)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**WAIT for user response.**

- If user selects existing book → Set as active, load PROJECT_CONTEXT.md
- If user selects "Create new book" → Note that Prompt 1 should be run
- If no books exist → Inform user to run Prompt 1

**After selection:**
1. Update `activeBook` in books-registry.json
2. Update `lastAccessed` date for selected book
3. Store `ACTIVE_BOOK=[book-id]` and `BOOK_PATH=[BOOKS_ROOT]/[directory]` in session

Report: `✓ Active book: [TITLE]`

### M7. Load Book Context

If a book was selected:
1. Read `[BOOK_PATH]/PROJECT_CONTEXT.md`
2. Check for book-specific `.config/` files

Report: `✓ PROJECT_CONTEXT.md loaded for [TITLE]`

### M8. Confirm Date with User

**⏸️ STOP AND ASK USER:**

```
Today's date from system: [DATE from <env>]

Is this correct? (yes / or provide correct date in YYYY-MM-DD format)
```

**WAIT for user response.**

Store as `CONFIRMED_DATE=[DATE]`

Report: `✓ Date confirmed: [CONFIRMED_DATE]`

---

## Legacy Mode Initialization

If `Process/FRAMEWORK_CORE.md` exists (no fw-location.json), follow this sequence:

### L1. Load FRAMEWORK_CORE.md (Instant Load)

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

### L2. Check for Framework Updates

**Check for updates even in legacy mode:**

1. Read `VERSION` file to get current version
2. Attempt to fetch remote version: `https://raw.githubusercontent.com/scooter-indie/author-nonfiction-dist/main/VERSION`
3. Compare versions (semantic versioning)

**If update available:**
```
ℹ Framework update available: [current] → [latest]
  To update: git pull origin main
```

**If check fails (network error):** Silently continue (no blocking)

**If up to date:** Report `✓ Framework version: [VERSION] (up to date)`

### L3. Scan Available Prompts

Confirm awareness of all 16 core prompts in `Process/Prompts/`:
- Prompt_1_Initialize.md through Prompt_16_Image_Manager.md

Report: `✓ Scanned 16 core prompts`

### L4. Check for Book Project Context

Check if `PROJECT_CONTEXT.md` exists in the project root:
- **If exists:** Read it to understand the user's book project (title, author, chapters, style, metadata)
- **If not exists:** User hasn't initialized a book project yet (needs to run Prompt 1)

Report one of:
- `✓ PROJECT_CONTEXT.md found - Book project: [TITLE] by [AUTHOR]`
- `ℹ No PROJECT_CONTEXT.md found - No book project initialized yet`

### L5. Check for User Project Configuration

If a book project exists (PROJECT_CONTEXT.md found), check for `.config/` directory:
- `.config/init.json` - Initialization Q&A answers
- `.config/project.json` - Project settings
- `.config/metadata.json` - Book metadata
- `.config/manifest.json` - Framework tracking
- `.config/migrations.json` - Version migrations

Report configuration status if found.

### L6. Verify Working Directory

Confirm the current working directory using context information.

Report: `✓ Working directory: [PATH]`

### L7. Confirm Date with User

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

### Multi-Book Mode Summary

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Framework Initialization Complete (Multi-Book Mode)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Mode: Multi-Book (BOOKS_ROOT)
Framework Location: [FW_ROOT]
Framework Version: [VERSION]
Books Root: [BOOKS_ROOT path]
Active Book: [TITLE] ([status])
Book Path: [BOOK_PATH]
Confirmed Date: [CONFIRMED_DATE]

Registered Books: [N] total
  • [N] in-progress
  • [N] complete
  • [N] archived

Prompts Available: 16 core prompts (loaded from FW_ROOT)

Compatibility Classification:
  • DESKTOP-FRIENDLY (6): Prompts 2, 3, 4, 5, 6, 10
  • HYBRID (2): Prompts 1, 11
  • CLI-ONLY (8): Prompts 7, 8, 9, 12, 13, 14, 15, 16

Anti-Hallucination Protocol: ✓ Active
  → ASK FIRST before generating examples, anecdotes, statistics, or quotes
  → NEVER fabricate specific people, data, or unverified quotes
  → Use verification status codes: ⏳ Pending | ⚠ Needs Citation | ✓ Verified

Quick Commands:
  • "list books" - Show all registered books
  • "switch to [Book Name]" - Change active book
  • "create new book" - Run Prompt 1 for new book

Ready! Working on: [BOOK TITLE]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Legacy Mode Summary

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Framework Initialization Complete (Legacy Mode)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Mode: Legacy (single-book)
Framework Version: [VERSION]
Prompts Available: 16 core prompts
Book Project: [Found/Not Found]
Working Directory: [PATH]
Confirmed Date: [CONFIRMED_DATE]

Compatibility Classification:
  • DESKTOP-FRIENDLY (6): Prompts 2, 3, 4, 5, 6, 10
  • HYBRID (2): Prompts 1, 11
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

## Session Context Variables

After initialization, these variables are available for the session:

| Variable | Multi-Book Mode | Legacy Mode |
|----------|-----------------|-------------|
| `MODE` | `multi-book` | `legacy` |
| `FW_ROOT` | Path to framework | Same as working dir |
| `BOOKS_ROOT` | Current working dir | N/A |
| `ACTIVE_BOOK` | Book ID | N/A |
| `BOOK_PATH` | Path to active book | Working dir |
| `CONFIRMED_DATE` | YYYY-MM-DD | YYYY-MM-DD |

**Path Resolution for Prompts:**
- Framework files: `[FW_ROOT]/Process/...`
- Book content: `[BOOK_PATH]/Manuscript/...`

---

## On-Demand Loading

**Additional documentation loads automatically when needed:**

- **User executes a prompt?** → Load from `[FW_ROOT]/Process/Prompts/`
- **User asks workflow questions?** → Load `[FW_ROOT]/Process/Prompts/QUICK_REFERENCE.md`
- **User asks about styles?** → Load `[FW_ROOT]/Process/Styles/README.md`
- **User asks about prompts?** → Load `[FW_ROOT]/Process/Prompts/README.md`
- **User needs full anti-hallucination?** → Load `[FW_ROOT]/Process/Anti-Hallucination_Guidelines.md`

---

## Notes

- Required at the start of every Claude Code session
- Can be re-run mid-session if context is lost or session becomes very long
- Supports both multi-book (v0.15.0+) and legacy (single-book) installations
- In multi-book mode, use "switch to [Book Name]" to change active book mid-session

---

**Framework Version:** 0.15.2
**Last Updated:** 2025-11-27
