# Manage Book

**Framework-only command for multi-book mode**

This command provides book lifecycle management: archive, delete, and restore operations.

---

## Prerequisites

This command only works from **CONFIG_ROOT** (.config/ directory). Check:
- `fw-location.json` exists (indicates valid CONFIG_ROOT)
- `books-registry.json` exists
- `settings.json` exists (contains BOOKS_ROOT path)

If not found, inform user: "This command requires a valid CONFIG_ROOT. Run /fw-init first."

**Path Resolution:**
- CONFIG_ROOT = current directory (.config/)
- BOOKS_ROOT = from settings.json → booksRoot
- PROJECT_ROOT = parent of CONFIG_ROOT

---

## Usage

```
/manage-book [operation] [book-name]
```

**Operations:**
- `archive` - Move book to Archive/ directory
- `delete` - Permanently delete book (with confirmation)
- `restore` - Restore archived book to active
- `list` - Show all books with status

**Examples:**
- `/manage-book archive My-Book`
- `/manage-book delete Old-Project`
- `/manage-book restore Archived-Book`
- `/manage-book list`
- `/manage-book` (no args - show menu)

---

## Step 1: Present Options

**⏸️ ASK USER (if no operation specified):**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Book Management
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. Archive Book
   Move book to Archive/ (preserves content, removes from active)

2. Delete Book
   Permanently remove book (CANNOT BE UNDONE)

3. Restore Book
   Restore archived book to active status

4. List All Books
   Show all books with their status

Which operation? (1-4)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Operation 1: Archive Book

### Step 1.1: Select Book to Archive

**⏸️ ASK USER:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Archive Book
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Active books:
  1. [Book Title One] - [status] (last: [date])
  2. [Book Title Two] - [status] (last: [date])

Which book to archive? (number or name)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Note:** Only show non-archived books (status != "archived")

### Step 1.2: Confirm Archive

**⏸️ ASK USER:**

```
Archive "[Book Title]"?

This will:
  • Move book to BOOKS_ROOT/Archive/[Book-Name]/
  • Update registry status to "archived"
  • Book will no longer appear in active list

The book can be restored later with /manage-book restore

Type "archive" to confirm:
```

### Step 1.3: Execute Archive

1. **Create Archive directory if needed:**
```bash
mkdir -p "[BOOKS_ROOT]/Archive"
```

2. **Move book directory (from PROJECT_ROOT):**
```bash
cd [CONFIG_ROOT]/..
git mv "BOOKS_ROOT/[Book-Directory]" "BOOKS_ROOT/Archive/[Book-Directory]"
```

3. **Update books-registry.json:**
   - Change book's `status` to `"archived"`
   - Update `directory` to `"Archive/[Book-Directory]"`
   - If this was activeBook, set `activeBook` to `null`

4. **Commit the change (from PROJECT_ROOT):**
```bash
cd [CONFIG_ROOT]/..
git add -A
git commit -m "Archive book: [Book Title]

Moved to BOOKS_ROOT/Archive/[Book-Directory]

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

### Step 1.4: Report

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ Book Archived
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Book: [Book Title]
New Location: Archive/[Book-Directory]/
Status: archived

To restore: /manage-book restore [Book-Name]
To delete permanently: /manage-book delete [Book-Name]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Operation 2: Delete Book

### Step 2.1: Select Book to Delete

**⏸️ ASK USER:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Delete Book (PERMANENT)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⚠️  WARNING: Deletion is PERMANENT and CANNOT BE UNDONE

All books:
  1. [Book Title One] - [status]
  2. [Book Title Two] - [status]
  3. [Archived Book] - archived (in Archive/)

Which book to delete? (number or name)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Step 2.2: Strong Confirmation

**⏸️ ASK USER:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️  PERMANENT DELETION WARNING
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

You are about to PERMANENTLY DELETE:

  Book: [Book Title]
  Location: [Book-Directory]/
  Chapters: [N]
  Last accessed: [date]

THIS ACTION CANNOT BE UNDONE.
All content, chapters, and history will be lost.

Consider using "archive" instead if you might need this later.

To confirm deletion, type the book title exactly:
"[Book Title]"
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Validation:** User must type the exact book title to confirm.

### Step 2.3: Execute Delete

1. **Remove from git and filesystem (from PROJECT_ROOT):**
```bash
cd [CONFIG_ROOT]/..
git rm -rf "BOOKS_ROOT/[Book-Directory]"
# OR for archived books:
git rm -rf "BOOKS_ROOT/Archive/[Book-Directory]"
```

2. **Update books-registry.json:**
   - Remove book entry from `books` array
   - If this was activeBook, set `activeBook` to `null`

3. **Commit the change (from PROJECT_ROOT):**
```bash
cd [CONFIG_ROOT]/..
git add -A
git commit -m "Delete book: [Book Title]

Permanently removed BOOKS_ROOT/[Book-Directory]/

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

### Step 2.4: Report

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ Book Deleted
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Book "[Book Title]" has been permanently deleted.

Remaining books: [N]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Operation 3: Restore Book

### Step 3.1: Select Book to Restore

**⏸️ ASK USER:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Restore Archived Book
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Archived books:
  1. [Archived Book One] - archived (since: [date])
  2. [Archived Book Two] - archived (since: [date])

Which book to restore? (number or name)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Note:** Only show books with status "archived"

**If no archived books:**
```
No archived books found.

To archive a book: /manage-book archive
```

### Step 3.2: Execute Restore

1. **Move book back to BOOKS_ROOT (from PROJECT_ROOT):**
```bash
cd [CONFIG_ROOT]/..
git mv "BOOKS_ROOT/Archive/[Book-Directory]" "BOOKS_ROOT/[Book-Directory]"
```

2. **Update books-registry.json:**
   - Change book's `status` to `"in-progress"`
   - Update `directory` to `"[Book-Directory]"` (remove Archive/ prefix)
   - Update `lastAccessed` to CONFIRMED_DATE

3. **Commit the change (from PROJECT_ROOT):**
```bash
cd [CONFIG_ROOT]/..
git add -A
git commit -m "Restore book: [Book Title]

Restored from BOOKS_ROOT/Archive/ to active

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

### Step 3.3: Ask About Active Book

**⏸️ ASK USER:**

```
Book "[Book Title]" restored.

Set as active book? (yes/no)
```

**If yes:** Update `activeBook` in registry and load PROJECT_CONTEXT.md

### Step 3.4: Report

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ Book Restored
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Book: [Book Title]
Location: [Book-Directory]/
Status: in-progress
[Active: Yes/No]

Ready to continue working on this book!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Operation 4: List All Books

### Step 4.1: Display Full List

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
All Registered Books
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

ACTIVE BOOKS:
  1. [Book Title One] - in-progress (last: [date]) * CURRENT
  2. [Book Title Two] - revision (last: [date])
  3. [Book Title Three] - complete (last: [date])

ARCHIVED BOOKS:
  4. [Old Book] - archived (since: [date])
  5. [Another Old Book] - archived (since: [date])

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Total: [N] books ([X] active, [Y] archived)

Commands:
  • /switch-book [name] - Switch to a book
  • /manage-book archive [name] - Archive a book
  • /manage-book restore [name] - Restore archived book
  • /manage-book delete [name] - Delete permanently
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Registry Updates

### Status Values

The `status` field in books-registry.json can be:
- `"planning"` - Initial planning phase
- `"in-progress"` - Actively writing
- `"revision"` - In revision/editing
- `"complete"` - Finished
- `"archived"` - Moved to Archive/

### Archive Directory Path

When a book is archived:
- Physical location: `BOOKS_ROOT/Archive/[Book-Directory]/`
- Registry `directory` field: `"Archive/[Book-Directory]"`

When restored:
- Physical location: `BOOKS_ROOT/[Book-Directory]/`
- Registry `directory` field: `"[Book-Directory]"`

---

## Error Handling

### Book Not Found

```
Book "[name]" not found.

Available books:
[list books]
```

### Cannot Archive Active Book (Warning Only)

```
Note: "[Book Title]" is currently the active book.
After archiving, no book will be active.

Continue? (yes/no)
```

### Archive Directory Conflict

```
Error: A directory already exists at Archive/[Book-Directory]/

Options:
  1. Rename existing archived book first
  2. Choose different name for this archive
  3. Cancel
```

### Delete Confirmation Failed

```
Deletion cancelled.

You typed: "[what user typed]"
Expected: "[Book Title]"

The book title must match exactly for safety.
```

---

## Alternative Triggers

Users can also manage books by saying:
- "archive [Book Name]"
- "delete [Book Name]"
- "restore [Book Name]"
- "list all books"
- "show archived books"

These should be recognized and invoke the appropriate operation.

---

**Version:** 0.16.1
**Last Updated:** 2025-11-28
