# Scripts Directory

**Framework Version:** 0.12.1+

This directory contains automation scripts for the framework.

---

## Scripts

### init.sh

**Purpose:** Fast project structure creation for Prompt 1

**Usage:**
```bash
bash scripts/init.sh .config/init.json
```

**What it does:**
1. Validates all preconditions (config exists, git installed, templates present)
2. Creates 10-directory Manuscript structure
3. Copies 5 template files (visual assets, EPUB templates, .gitignore)
4. Initializes git repository
5. Smart merge: preserves user content on re-initialization

**Note:** The `.config/` directory and JSON files are created by Claude in Prompt 1 Step 2b, NOT by this script.

**Execution time:** ~2 seconds

**Requirements:**
- Bash shell (included with Git Bash on Windows)
- Git installed
- Valid `.config/init.json` file

**Platform compatibility:**
- ✓ Linux
- ✓ macOS
- ✓ Windows (via Git Bash)

---

### detect-tools.sh

**Purpose:** Detect available export tools and update `.config/manifest.json`

**Usage:**
```bash
# Standalone usage (after Prompt 1)
bash scripts/detect-tools.sh

# Or specify manifest path
bash scripts/detect-tools.sh .config/manifest.json
```

**What it does:**
1. Detects git, pandoc, and typst installation
2. Reports version numbers for installed tools
3. Updates `.config/manifest.json` with tool availability
4. Provides installation instructions for missing tools
5. Can be run anytime to update tool status

**When to run:**
- Automatically called by `init.sh` during initialization
- After installing pandoc or typst
- To check current tool availability

**Detects:**
- **Git** - Version control (required)
- **Pandoc** - DOCX/PDF/EPUB export (optional, for Prompt 9)
- **Typst** - Fast PDF export (optional, alternative to LaTeX)

**Output:**
- Color-coded status for each tool
- Version numbers for detected tools
- Installation instructions for missing tools
- Updates `toolsAvailable` in manifest

**Requirements:**
- Bash shell
- Optional: jq for cleaner JSON updates (falls back to sed)

**Platform compatibility:**
- ✓ Linux
- ✓ macOS
- ✓ Windows (via Git Bash)

---

### generate-usage-guide.sh

**Purpose:** Generate USAGE_GUIDE.md from template with user-specific data

**Usage:**
```bash
bash scripts/generate-usage-guide.sh "Book Title" "Author Name" "2025-11-21" "10" "Conversational Expert"
```

**Parameters:**
1. `BOOK_TITLE` - Book title (from init.json)
2. `AUTHOR_NAME` - Author name (from init.json)
3. `INIT_DATE` - Initialization date (YYYY-MM-DD format)
4. `CHAPTER_COUNT` - Number of chapters (from init.json)
5. `STYLE_NAME` - Writing style name (from init.json)

**What it does:**
1. Validates that all 5 parameters are provided
2. Checks that template exists at `Process/Templates/USAGE_GUIDE_template.md`
3. Copies template to `USAGE_GUIDE.md` in project root
4. Escapes special characters in user data (handles /, &, etc.)
5. Substitutes placeholders: {{BOOK_TITLE}}, {{AUTHOR_NAME}}, {{INIT_DATE}}, {{CHAPTER_COUNT}}, {{STYLE_NAME}}

**When to run:**
- Automatically called by Prompt 1 during initialization
- Can be run manually to regenerate USAGE_GUIDE.md

**Benefits:**
- Faster than AI generation
- Consistent output format
- Handles special characters safely

**Requirements:**
- Bash shell
- Template file must exist

**Platform compatibility:**
- ✓ Linux
- ✓ macOS
- ✓ Windows (via Git Bash)

---

## Adding New Scripts

When adding new scripts:
1. Use `#!/usr/bin/env bash` shebang
2. Include version number in header
3. Add validation functions
4. Provide verbose output with colors
5. Handle errors gracefully
6. Document in this README

---

*Scripts directory introduced in v0.12.1*
