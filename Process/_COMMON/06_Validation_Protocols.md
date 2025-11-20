# Validation Protocols

**Framework Version:** 0.10.0
**Module:** Safety Checks and Validation
**Purpose:** Standardized validation procedures across prompts

---

## Overview

This module defines validation procedures that ensure data integrity, prevent errors, and maintain consistency across the framework.

---

## Core Validations

### 1. File Existence Validation

**Check if file exists before operations:**

```markdown
Validating file existence: {path}
✅ File found
```

**Error if not found:**
```markdown
❌ File not found: {path}

Expected: {full_path}
Suggestions: {similar_files}

Troubleshooting:
- Verify path is correct
- Check if file was moved/renamed
- Run Prompt 8 (Dashboard) to see current structure
```

---

### 2. Directory Structure Validation

**Verify required directories exist:**

```markdown
Validating project structure...
✅ Manuscript/
✅ Manuscript/Chapters/
✅ Manuscript/_TOC_/
✅ Manuscript/Quotes/
✅ Manuscript/Style/
✅ Manuscript/FrontMatter/
✅ Manuscript/BackMatter/
✅ Manuscript/Inbox/
✅ Manuscript/Drafts/
✅ Manuscript/Exports/

Structure validation: PASS
```

**Error if missing:**
```markdown
❌ Project structure incomplete

Missing directories:
- {dir1}
- {dir2}

Action required: Run Prompt 1 (Initialize) to create proper structure
```

---

### 3. Cross-Reference Validation

**Check all internal links resolve:**

```markdown
Validating cross-references...

Scanning for references:
- Chapter references (Chapter X, Chapter_XX)
- Section references (Section X.Y)
- Figure references (Figure X.Y)
- See/cf. references

Results:
✅ {count} valid references
⚠️ {count} warnings (ambiguous)
❌ {count} broken references

Broken references:
- {file}: Line {X}: "see Chapter 5" → Chapter 5 does not exist
```

---

### 4. Placeholder Content Detection

**Scan for unfinished content markers:**

```markdown
Scanning for placeholders...

Found {count} markers:
[PLACEHOLDER]: {count} locations
[TODO]: {count} locations
[CITATION NEEDED]: {count} locations
[VERIFY]: {count} locations
[ADD EXAMPLE]: {count} locations

Locations:
- {file1}: Line {X}: [PLACEHOLDER: Add methodology details]
- {file2}: Line {Y}: [CITATION NEEDED]
```

---

### 5. Quote Verification Status

**Check quote/epigraph verification:**

```markdown
Validating quotes...

Total chapters with quotes: {X}/{Y}

Status breakdown:
✓ Verified: {count} ({percent}%)
⚠ Needs Citation: {count} ({percent}%)
⏳ Pending: {count} ({percent}%)

Quotes needing attention:
- Chapter {X}: {quote snippet} [Status: ⚠]
- Chapter {Y}: {quote snippet} [Status: ⏳]
```

---

### 6. Version Consistency

**Validate version numbers follow semantic versioning:**

```markdown
Validating version numbers...

Checking format (N.M.P):
✅ All versions follow semantic versioning

Checking increments:
✅ No version skips detected
✅ All increments logical

Current versions:
- Chapter_01: v{version}
- Chapter_02: v{version}
- ...
```

---

### 7. Git Status Validation

**Check for uncommitted changes before major operations:**

```markdown
Checking git status...

Uncommitted changes: {count} files
- {file1}
- {file2}

Recommendation: Commit current state before proceeding
```

**If clean:**
```markdown
Git status: Clean working tree
✅ Safe to proceed
```

---

### 8. _chg File Sync Validation

**Verify all content files have corresponding _chg files:**

```markdown
Validating change tracking files...

Scanning Manuscript/ for content files...
Found: {count} content files

Checking for _chg files:
✅ {count} _chg files present
❌ {count} _chg files missing

Missing _chg files:
- {file1}_chg.md
- {file2}_chg.md

Action: Run Prompt 10 (Update Change Tracking) to create missing files
```

---

### 9. Word Count Accuracy

**Validate word count metadata matches actual content:**

```markdown
Validating word counts...

Comparing metadata vs. actual counts:
Chapter_01: {metadata_count} vs {actual_count} ✅ Match
Chapter_02: {metadata_count} vs {actual_count} ⚠️ Mismatch ({diff} words)

Total: {metadata_total} vs {actual_total}
Accuracy: {percent}%

Recommendations:
- Update metadata for Chapter_02
```

---

### 10. TOC Consistency

**Validate TOC matches actual chapters:**

```markdown
Validating Table of Contents...

TOC entries: {count}
Chapter files: {count}

Checking consistency:
✅ All TOC entries have corresponding chapter files
✅ All chapter files have TOC entries
✅ Chapter numbering is sequential
✅ No gaps in numbering

Chapter status:
- {X} complete chapters
- {Y} in-progress chapters
- {Z} placeholder chapters
```

---

## Validation Triggers

### Pre-Operation Validations

**Before Prompt 2 (Add Chapter):**
- Git status (clean or commit first)
- Directory structure exists
- TOC file exists

**Before Prompt 3 (Modify File):**
- Target file exists
- _chg file exists
- Git status checked

**Before Prompt 5 (Compile):**
- All chapter files exist
- All referenced images exist
- No critical placeholders (unless user approves)

**Before Prompt 6 (Consistency):**
- Directory structure exists
- At least one chapter exists

**Before Prompt 7 (Export):**
- Compilation successful
- Consistency check passed (recommended)
- All citations verified (recommended)

---

## Validation Reporting

### Success Report

```markdown
**Validation Results: PASS**

All checks completed successfully:
✅ {check1}
✅ {check2}
✅ {check3}

Ready to proceed.
```

### Warning Report

```markdown
**Validation Results: PASS with Warnings**

Critical checks: PASS
Minor issues detected:

⚠️ {warning1}
⚠️ {warning2}

Recommendations:
- {recommendation1}
- {recommendation2}

Proceed? (Yes/No)
```

### Failure Report

```markdown
**Validation Results: FAIL**

Critical issues detected:

❌ {error1}
❌ {error2}

Cannot proceed until these are resolved.

Recommended actions:
1. {action1}
2. {action2}

After fixing, try again.
```

---

**Module Version:** 0.10.0
**Last Updated:** 2025-11-19
**Status:** Active
