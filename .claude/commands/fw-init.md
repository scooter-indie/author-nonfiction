Initialize the AI-Assisted Nonfiction Authoring Framework for this session.

## MANDATORY Session Initialization

This command loads essential framework documentation and prepares Claude for executing prompts. You MUST run `/fw-init` at the start of every session before executing any prompts.

---

## Step 0: Detect Operating Mode

**First, verify this is a valid BOOKS_ROOT:**

1. Check if `.config/fw-location.json` exists in the current directory
2. If YES → Proceed with initialization
3. If NO → Error: "Not a valid framework directory. Run from BOOKS_ROOT."

Report: `✓ BOOKS_ROOT detected`

---

## Initialization Sequence

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

## Initialization Complete

After completing all steps above, provide a summary report:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Framework Initialization Complete
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

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

---

## Session Context Variables

After initialization, these variables are available for the session:

| Variable | Description |
|----------|-------------|
| `FW_ROOT` | Path to framework installation |
| `BOOKS_ROOT` | Path to books directory (current working dir) |
| `ACTIVE_BOOK` | Currently selected book ID |
| `BOOK_PATH` | Full path to active book directory |
| `CONFIRMED_DATE` | Session date in YYYY-MM-DD format |

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
- Use "switch to [Book Name]" to change active book mid-session

---

**Framework Version:** 0.15.4
**Last Updated:** 2025-11-28
