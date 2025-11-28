# Switch Book

**Framework-only command for multi-book mode**

This command allows users to switch the active book in a multi-book installation.

---

## Prerequisites

This command only works in **multi-book mode**. Check:
- `.config/fw-location.json` exists (indicates BOOKS_ROOT)
- `.config/books-registry.json` exists

If neither exists, inform user: "This command requires a valid BOOKS_ROOT. Run /fw-init first."

---

## Usage

```
/switch-book [Book Name or ID]
```

**Examples:**
- `/switch-book My Amazing Book`
- `/switch-book my-amazing-book`
- `/switch-book` (no argument - show list and prompt)

---

## Workflow

### Step 1: Validate Multi-Book Mode

1. Check for `.config/fw-location.json`
2. If not found: Report "Multi-book mode required" and stop

### Step 2: Read Registry

1. Read `.config/books-registry.json`
2. Get list of all books
3. Get current `activeBook`

### Step 3: Handle User Input

**If book name/ID provided:**
1. Search registry for matching book (by title or id)
2. If found: Set as active book
3. If not found: Show list and ask user to select

**If no argument provided:**
1. Display all registered books with numbers
2. Show current active book (marked with `*`)
3. Ask user to select by number or name

### Step 4: Display Book List

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Switch Book
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Available books:
  1. [Book Title One] - [status] (last: [date])  * ACTIVE
  2. [Book Title Two] - [status] (last: [date])
  3. [Book Title Three] - [status] (last: [date])

Enter book number or name to switch:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Step 5: Update Registry

1. Update `activeBook` in books-registry.json to selected book's ID
2. Update `lastAccessed` date for selected book to CONFIRMED_DATE
3. Write updated registry

### Step 6: Load New Context

1. Read `[BOOKS_ROOT]/[Book-Directory]/PROJECT_CONTEXT.md`
2. Update session context with new BOOK_PATH
3. Store new `ACTIVE_BOOK` and `BOOK_PATH` in session

### Step 7: Confirmation

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Switched to: [Book Title]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Book: [Title]
Author: [Author]
Status: [status]
Chapters: [X]
Style: [style name]

Location: [BOOKS_ROOT]/[Book-Directory]/

Ready to work on [Book Title]!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Alternative Triggers

Users can also switch books by saying:
- "switch to [Book Name]"
- "work on [Book Name]"
- "change to [Book Name]"

These should be recognized and invoke this workflow.

---

## Edge Cases

### No Books Registered

```
No books registered yet.

To create a new book:
1. Say "create new book" or
2. Execute Prompt 1
```

### Book Not Found

```
Book "[search term]" not found.

Available books:
[list books]

Enter book number or name:
```

### Already Active

If user selects the already active book:
```
"[Book Title]" is already the active book.
```

---

## Session Variables Updated

After switching:
- `ACTIVE_BOOK` = new book ID
- `BOOK_PATH` = BOOKS_ROOT/[new book directory]

These are used by all prompts for path resolution.

---

**Version:** 0.15.4
**Last Updated:** 2025-11-28
