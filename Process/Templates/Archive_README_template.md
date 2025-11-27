# Archive Directory

This directory contains archived book projects.

---

## Purpose

When you archive a book project (instead of permanently deleting it), the book is moved here. Archived books:

- Are preserved with all content intact
- Don't appear in the active book selection list
- Can be restored at any time
- Don't count toward active project limits

---

## Structure

```
Archive/
├── README.md                      # This file
├── Archived-Book-One/             # First archived book
│   ├── Manuscript/
│   ├── Research/
│   ├── .config/
│   └── PROJECT_CONTEXT.md
└── Archived-Book-Two/             # Second archived book
    └── ...
```

Each archived book retains its complete directory structure.

---

## Archive vs Delete

| Action | Behavior |
|--------|----------|
| **Archive** | Moves book to `Archive/`, sets status to "archived" in registry |
| **Delete** | Permanently removes book directory and registry entry |

**Recommendation:** Use Archive unless you're certain you'll never need the content again.

---

## Restoring an Archived Book

To restore an archived book:

1. Say: "restore [Book Name] from archive"
2. Claude will:
   - Move the book directory from `Archive/` back to `BOOKS_ROOT/`
   - Update `books-registry.json` to set status back to previous state
   - Make the book available for selection

Or manually:
1. Move the book directory from `Archive/[Book-Name]/` to `BOOKS_ROOT/[Book-Name]/`
2. Update `.config/books-registry.json`:
   - Change `status` from `"archived"` to `"in-progress"` (or desired status)

---

## Registry Tracking

Archived books are tracked in `.config/books-registry.json` with `status: "archived"`:

```json
{
  "id": "my-old-book",
  "title": "My Old Book",
  "directory": "My-Old-Book",
  "status": "archived",
  "created": "2024-01-15",
  "lastAccessed": "2025-06-30"
}
```

---

## Notes

- Archived books are excluded from git commits by default (configurable)
- Backup operations include archived books
- Archive directory is created automatically when first book is archived

---

*This file is auto-generated during BOOKS_ROOT setup.*
