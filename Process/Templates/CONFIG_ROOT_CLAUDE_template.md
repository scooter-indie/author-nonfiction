# AI-Assisted Nonfiction Authoring Framework

**This is the Configuration Root (CONFIG_ROOT)**

You are in the `.config/` directory which contains all configuration for your writing projects.

---

## MANDATORY FIRST ACTION

Run `/fw-init` at the start of every session.

This loads:
- Framework from fw-location.json path
- Book registry for book selection
- Selected book's PROJECT_CONTEXT.md
- Checks for framework updates (once per session)

---

## Book Commands

| Command | Description |
|---------|-------------|
| `/fw-init` | Initialize session (REQUIRED) |
| `/switch-book` | Switch to a different book |
| `/manage-book` | Archive, delete, or restore books |

---

## Directory Structure

```
PROJECT_ROOT/
├── .config/              # You are here (CONFIG_ROOT)
│   ├── fw-location.json  # Framework path + version
│   ├── books-registry.json
│   ├── settings.json
│   ├── CLAUDE.md         # This file
│   └── .claude/
│       ├── agents/
│       └── commands/
├── FW_ROOT/              # Framework (gitignored)
├── BOOKS_ROOT/           # Your books
│   ├── Book-One/
│   ├── Book-Two/
│   └── Archive/
├── start-authoring.bat/.sh
└── bp-start-authoring.bat/.sh
```

---

## Path Resolution

- **Framework:** Read `fw-location.json` → `frameworkRoot`
- **Books:** Read `settings.json` → `booksRoot`
- **Active Book:** Read `books-registry.json` → `activeBook`

---

## Support

- **Issues:** https://github.com/scooter-indie/author-nonfiction/issues
- **Releases:** https://github.com/scooter-indie/author-nonfiction/releases

---

*Run /fw-init to begin your writing session*
