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
2. Creates 11-directory Manuscript structure
3. Copies 9 template files
4. Initializes git repository
5. Runs tool detection (calls detect-tools.sh)
6. Smart merge: preserves user content on re-initialization

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
