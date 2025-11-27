# Framework Migrations

**Version:** 0.15.0
**Purpose:** Automatic configuration updates when framework version changes

---

## Overview

When the framework is updated (via `git pull`), configuration files in user book projects may need to be updated to match the new framework version. The migration system handles this automatically.

---

## How Migrations Work

### Detection

1. During `/fw-init`, the system compares:
   - `[FW_ROOT]/VERSION` (current framework version)
   - `fw-location.json:frameworkVersion` (version when last used)

2. If versions differ, migrations are needed

### Execution

1. Find all migration files between old and new version
2. Execute migrations in version order
3. Update `frameworkVersion` in fw-location.json

---

## Migration File Format

**Naming Convention:** `migrate-X.Y.Z-to-A.B.C.md`

**Example:** `migrate-0.14.5-to-0.15.0.md`

### Migration File Structure

```markdown
# Migration: X.Y.Z → A.B.C

**From Version:** X.Y.Z
**To Version:** A.B.C
**Date:** YYYY-MM-DD

---

## Summary

Brief description of what this migration does.

---

## Changes

### 1. [Change Category]

**File:** `[path to file]`
**Action:** [create/update/delete/rename]

**Details:**
- What changes are made
- Why they're needed

**Instructions:**
[Specific steps for Claude to execute]

### 2. [Another Change]

...

---

## Verification

After migration, verify:
- [ ] Check 1
- [ ] Check 2

---

## Rollback (if needed)

Instructions to undo the migration if something goes wrong.
```

---

## Creating a New Migration

When releasing a new framework version that requires config changes:

1. Create migration file: `migrate-[old]-to-[new].md`
2. Document all config file changes
3. Include clear instructions for Claude to execute
4. Add verification steps
5. Include rollback instructions

---

## Migration Types

### Schema Updates

When JSON config files gain new fields:
```markdown
**Action:** Add field to JSON

**Instructions:**
1. Read `[BOOK_PATH]/.config/project.json`
2. Add new field: `"newField": "defaultValue"`
3. Write updated file
```

### File Renames

When files are renamed:
```markdown
**Action:** Rename file

**Instructions:**
1. Check if `[old-path]` exists
2. If exists: `git mv [old-path] [new-path]`
3. Update references in other files
```

### Structure Changes

When directory structure changes:
```markdown
**Action:** Create new directory

**Instructions:**
1. Create directory: `mkdir -p [new-path]`
2. Move files: `git mv [old-location]/* [new-path]/`
```

---

## Version Numbering

Migrations follow semantic versioning:

- **Major (X.0.0):** Breaking changes requiring manual intervention
- **Minor (0.X.0):** New features, backward-compatible config changes
- **Patch (0.0.X):** Bug fixes, no config changes needed

---

## Migration History

| From | To | Date | Description |
|------|----|------|-------------|
| 0.14.5 | 0.15.0 | 2025-11-27 | Multi-book mode support |

---

**Last Updated:** 2025-11-27
