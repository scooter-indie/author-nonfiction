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
5. Smart merge: preserves user content on re-initialization

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
