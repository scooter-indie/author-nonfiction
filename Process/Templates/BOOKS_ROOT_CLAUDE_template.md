# AI-Assisted Nonfiction Authoring Framework

**Books Root Directory**

---

## MANDATORY FIRST ACTION

**At the start of EVERY Claude Code session, run:**

```
/fw-init
```

This command:
1. Reads framework location from `.config/fw-location.json`
2. Loads the framework from FW_ROOT
3. Shows available books from `.config/books-registry.json`
4. Prompts you to select a book to work on
5. Loads the selected book's `PROJECT_CONTEXT.md`
6. Confirms today's date

**Do NOT execute any prompts until `/fw-init` completes.**

---

## Quick Commands

After initialization, you can:

| Command | Action |
|---------|--------|
| `list books` | Show all registered books |
| `work on [Book Name]` | Switch to a different book |
| `create new book` | Initialize a new book project |
| `Execute Prompt X` | Run a framework prompt |

---

## Directory Structure

```
[This Directory - BOOKS_ROOT]/
├── .config/                    # Global configuration
│   ├── books-registry.json     # Registry of all books
│   ├── fw-location.json        # Path to framework
│   └── settings.json           # User preferences
├── [Book-One]/                 # First book project
│   ├── Manuscript/
│   ├── Research/
│   └── PROJECT_CONTEXT.md
├── [Book-Two]/                 # Second book project
│   └── ...
├── Archive/                    # Archived books
└── CLAUDE.md                   # This file
```

---

## Framework Location

The framework is installed separately at:
```
[Read from .config/fw-location.json]
```

Framework updates are managed independently via `git pull` in the framework directory.

---

## Support

- **Issues:** https://github.com/scooter-indie/author-nonfiction/issues
- **Releases:** https://github.com/scooter-indie/author-nonfiction/releases

---

*This file is auto-generated during BOOKS_ROOT setup.*
