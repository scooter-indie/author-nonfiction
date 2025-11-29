Initialize the AI-Assisted Nonfiction Authoring Framework for this session.

## MANDATORY Session Initialization

This command loads essential framework documentation and prepares Claude for executing prompts. You MUST run `/fw-init` at the start of every session before executing any prompts.

---

## Step 0: Detect Operating Mode

**First, verify this is a valid CONFIG_ROOT (.config/):**

1. Check if `fw-location.json` exists in the current directory
2. If YES → Proceed with initialization
3. If NO → Error: "Not a valid configuration directory. Run from PROJECT_ROOT/.config/"

Report: `✓ CONFIG_ROOT detected`

---

## Initialization Sequence

If `fw-location.json` exists, follow this sequence:

### M1. Load Framework Location

Read `fw-location.json` to get:
- `frameworkRoot` → Store as `FW_ROOT`
- `frameworkVersion` → Store as `FW_VERSION`
- `lastUpdateCheck` → Store as `LAST_UPDATE_CHECK`
- `updateChannel` → Store as `UPDATE_CHANNEL` (default: "stable")

Report: `✓ Framework location: [FW_ROOT]`

### M1b. Load Settings (BOOKS_ROOT)

Read `settings.json` to get:
- `booksRoot` → Store as `BOOKS_ROOT`

Report: `✓ Books location: [BOOKS_ROOT]`

### M2. Verify Framework Installation

Check that `[FW_ROOT]/Process/FRAMEWORK_CORE.md` exists.
- If not found → Error: "Framework not found at [FW_ROOT]. Please verify installation."

### M3. Load FRAMEWORK_CORE.md

Read `[FW_ROOT]/Process/FRAMEWORK_CORE.md` to load essential framework knowledge.

Report: `✓ FRAMEWORK_CORE.md loaded from FW_ROOT`

### M4. Check for Framework Updates

**Only check if not already checked today:**

1. Compare `LAST_UPDATE_CHECK` with today's date
2. If already checked today → Skip to version report
3. If not checked today → Proceed with update check

**Update check procedure:**

1. Read `[FW_ROOT]/VERSION` to get current version
2. Fetch latest from remote:
   ```bash
   cd [FW_ROOT] && git fetch origin
   ```
3. Compare local VERSION with remote:
   ```bash
   git show origin/main:VERSION
   ```
4. Compare versions (semantic versioning)
5. Update `lastUpdateCheck` in `fw-location.json` to today's date

**If update available:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
ℹ Framework Update Available
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Current version: [current]
Latest version:  [latest]
Channel: [UPDATE_CHANNEL]

Would you like to update now? (yes/no)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**⏸️ WAIT for user response.**

**If user says yes:**
```bash
cd [FW_ROOT] && git pull origin main
```

Then:
1. Read new version from `[FW_ROOT]/VERSION`
2. Update `frameworkVersion` in `fw-location.json`
3. Report: `✓ Framework updated: [old] → [new]`
4. Proceed to M4b (migrations)

**If user says no:**
- Report: `ℹ Update skipped. Run /fw-init later to update.`
- Continue with current version

**If check fails (network error):** Silently continue (no blocking)

**If up to date:** Report `✓ Framework version: [VERSION] (up to date)`

### M4b. Check and Run Migrations

**After loading framework, check if migrations are needed:**

1. Read `[FW_ROOT]/VERSION` to get framework version
2. Read `fw-location.json` for `frameworkVersion`
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

Read `books-registry.json` to get:
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
1. Update `activeBook` in `books-registry.json`
2. Update `lastAccessed` date for selected book
3. Store variables in session:
   - `ACTIVE_BOOK=[book-id]`
   - `BOOK_PATH=[BOOKS_ROOT]/[directory]` (from settings.json booksRoot + book directory)

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

Config Root: [CONFIG_ROOT]
Framework Location: [FW_ROOT]
Framework Version: [VERSION] ([UPDATE_CHANNEL] channel)
Books Root: [BOOKS_ROOT]
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
| `CONFIG_ROOT` | Path to configuration directory (current working dir, .config/) |
| `FW_ROOT` | Path to framework installation (from fw-location.json) |
| `BOOKS_ROOT` | Path to books directory (from settings.json) |
| `ACTIVE_BOOK` | Currently selected book ID |
| `BOOK_PATH` | Full path to active book directory |
| `CONFIRMED_DATE` | Session date in YYYY-MM-DD format |
| `UPDATE_CHANNEL` | Framework update channel (stable/beta) |

**Path Resolution for Prompts:**
- Configuration files: `[CONFIG_ROOT]/...` (fw-location.json, settings.json, books-registry.json)
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

**Framework Version:** 0.16.1
**Last Updated:** 2025-11-28
