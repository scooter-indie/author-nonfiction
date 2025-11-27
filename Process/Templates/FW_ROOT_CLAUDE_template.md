# AI-Assisted Nonfiction Authoring Framework

**This is the Framework Root (FW_ROOT)**

You are viewing the framework installation directory. This contains:
- `Process/` - Framework files (prompts, styles, templates)
- `VERSION` - Current framework version
- `CLAUDE.md` - This file

---

## Quick Start

**If you want to write a book:**

1. Navigate to your BOOKS_ROOT directory (where your books are stored)
2. Start Claude Code there: `cd [BOOKS_ROOT] && claude`
3. Run `/fw-init` to begin

**If you need to set up BOOKS_ROOT:**

1. Stay in this directory
2. Run: `execute configure.md`
3. Follow the prompts to create BOOKS_ROOT

---

## Framework Updates

Check for updates:
```bash
git fetch origin
git status
```

Apply updates:
```bash
git pull
```

Then run `configure.md` in your BOOKS_ROOT to apply any migrations.

---

## Directory Structure

```
FW_ROOT (you are here)
├── Process/           # Framework files
│   ├── FRAMEWORK_CORE.md
│   ├── Prompts/
│   ├── Styles/
│   └── Templates/
├── VERSION            # Framework version
└── CLAUDE.md          # This file

BOOKS_ROOT (your books)
├── .config/
│   ├── fw-location.json  → points to this FW_ROOT
│   └── books-registry.json
├── Book-One/
├── Book-Two/
└── CLAUDE.md          # Books context
```

---

## Support

- **Issues:** https://github.com/scooter-indie/author-nonfiction/issues
- **Releases:** https://github.com/scooter-indie/author-nonfiction/releases

---

*This is the framework installation - navigate to BOOKS_ROOT to work on your books*
