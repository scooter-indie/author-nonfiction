# Migration: 0.14.5 → 0.15.0

**From Version:** 0.14.5
**To Version:** 0.15.0
**Date:** 2025-11-27

---

## Summary

This migration updates configuration files to support the new multi-book architecture introduced in v0.15.0. For legacy (single-book) installations, minimal changes are required.

---

## Applicability

**Multi-Book Mode:** Full migration required
**Legacy Mode:** Minimal updates (manifest version only)

---

## Changes

### 1. Update Manifest Version (Both Modes)

**File:** `[BOOK_PATH]/.config/manifest.json`
**Action:** Update version field

**Instructions:**
1. Read `.config/manifest.json`
2. Update `frameworkVersion` from `"0.14.5"` to `"0.15.0"`
3. Write updated file

**Example:**
```json
{
  "frameworkVersion": "0.15.0",
  ...
}
```

### 2. Update fw-location.json (Multi-Book Mode Only)

**File:** `[BOOKS_ROOT]/.config/fw-location.json`
**Action:** Update version field

**Instructions:**
1. Read `.config/fw-location.json`
2. Update `frameworkVersion` from `"0.14.5"` to `"0.15.0"`
3. Update `lastUpdateCheck` to current date
3. Write updated file

**Example:**
```json
{
  "frameworkRoot": "...",
  "frameworkVersion": "0.15.0",
  "lastUpdateCheck": "2025-11-27"
}
```

### 3. Add New Fields to Project Config (Optional)

**File:** `[BOOK_PATH]/.config/project.json`
**Action:** Add optional new fields if not present

**Instructions:**
1. Read `.config/project.json`
2. If `mode` field doesn't exist, add: `"mode": "legacy"` or `"mode": "multi-book"`
3. Write updated file

---

## Verification

After migration, verify:
- [ ] `.config/manifest.json` shows `frameworkVersion: "0.15.0"`
- [ ] (Multi-book) `.config/fw-location.json` shows `frameworkVersion: "0.15.0"`
- [ ] No errors when running `/fw-init`

---

## Rollback (if needed)

To rollback to 0.14.5:

1. In FW_ROOT: `git checkout v0.14.5`
2. Manually revert version numbers in config files
3. Re-run `/fw-init`

**Note:** Multi-book features will not be available after rollback.

---

## Breaking Changes

**None.** This migration is backward-compatible. Existing single-book projects continue to work without changes.

---

## New Features Available After Migration

- Multi-book mode support
- `/switch-book` command
- Centralized books registry
- Framework/books separation

---

**Migration Created:** 2025-11-27
