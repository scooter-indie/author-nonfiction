# Quick Start Guide

**Book:** {{BOOK_TITLE}}
**Author:** {{AUTHOR_NAME}}
**Framework Version:** 0.13.0
**Initialized:** {{INIT_DATE}}

---

## Your Book Project is Ready!

This project has been initialized with:
- ✓ {{CHAPTER_COUNT}} chapter structure
- ✓ Writing style: {{STYLE_NAME}}
- ✓ Git repository (v1.0.0)
- ✓ Configuration files
- ✓ Change tracking system

---

## Next Steps

### 1. Create Your First Chapter

```
Execute Prompt 2 to add Chapter 1
```

Prompt 2 will create the chapter directory and files.

### 2. Start Writing

Use **Prompt 3** (automated) or **Prompt 4** (interactive) to write content:

**Prompt 3:** Write instructions in `_chg` files, execute Prompt 3
**Prompt 4:** Discuss changes interactively, AI writes instructions

### 3. Track Progress

```
Execute Prompt 10 for dashboard
```

Shows word counts, completion %, next steps.

### 4. Check Consistency

```
Execute Prompt 8
```

Validates terminology, style, cross-references.

---

## 16 Framework Prompts

**Core Writing:**
1. Initialize - ✓ COMPLETED
2. Add Chapter
3. Change by Chg (automated workflow)
4. Interactive Change (conversational workflow)
5. Scan For User Edits
6. Integrate Inbox

**Production:**
7. Compile Manuscript
8. Consistency Checker
9. Export (DOCX/PDF/EPUB)
10. Progress Dashboard

**Advanced:**
11. Style Manager
12. Git Operations
13. AI Detection Analysis
14. Citation Finder
15. Visual Content Suggester
16. Image Manager

---

## Export Tools (Optional)

Prompt 9 (Export) requires external tools for DOCX/PDF/EPUB generation. These are **optional** - only needed when you're ready to export.

### Check If Tools Are Installed

Run in Claude Code CLI:
```bash
bash scripts/detect-tools.sh
```

Or manually check:
```bash
pandoc --version
typst --version
```

### Installation Instructions

**Pandoc** (Required for DOCX/EPUB, optional for PDF):

| Platform | Command |
|----------|---------|
| Windows | `winget install JohnMacFarlane.Pandoc` |
| macOS | `brew install pandoc` |
| Linux | `sudo apt install pandoc` |

Official: https://pandoc.org/installing.html

**Typst** (Required for PDF):

| Platform | Command |
|----------|---------|
| Windows | `winget install Typst.Typst` |
| macOS | `brew install typst` |
| Linux | Download from [releases](https://github.com/typst/typst/releases) |

Official: https://github.com/typst/typst#installation

### Export Formats

| Format | Tools Required |
|--------|----------------|
| DOCX | Pandoc |
| EPUB | Pandoc |
| PDF | Pandoc + Typst |

---

## Configuration Files

All config files are in `.config/` directory:
- `init.json` - Initialization metadata
- `project.json` - Project settings
- `metadata.json` - Book metadata
- `manifest.json` - Framework tracking
- `migrations.json` - Version migrations

---

## Resources

- **Full Documentation:** `Process/AI-Assisted_Nonfiction_Authoring_Process.md`
- **Quick Reference:** `Process/Prompts/QUICK_REFERENCE.md`
- **Prompt Guide:** `Process/Prompts/README.md`
- **Anti-Hallucination Rules:** `Process/Anti-Hallucination_Guidelines.md`

---

**Happy writing!**
