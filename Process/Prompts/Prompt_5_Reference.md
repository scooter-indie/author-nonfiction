# Prompt 5 Reference Documentation

**Version:** 0.15.2
**Purpose:** Detailed examples, change detection, and troubleshooting

---

## Overview

This reference provides detailed scanning workflows, change detection logic, and troubleshooting. Load when:
- First time using Prompt 5
- Understanding change detection
- Troubleshooting sync issues
- Customizing version inference

**For core workflow:** See `Prompt_5_Scan_For_User_Edits.md`

---

## Scan Results Example

### Full Scan Output

```
📋 Scanning for user edits...

Checking uncommitted changes...
  Modified: Manuscript/Chapters/Chapter_03/Chapter_03.md
  Modified: Manuscript/Chapters/Chapter_05/Chapter_05.md

Checking staged changes...
  Staged: Manuscript/Quotes/Chapter_Quotes.md

Checking unpushed commits...
  Committed but unpushed: Manuscript/FrontMatter/Introduction.md

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Found 4 files with changes not reflected in _chg files
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Acquiring locks for affected chapters...
✓ Lock acquired: Chapter_03
✓ Lock acquired: Chapter_05
⚠️ Lock conflict: FrontMatter (skipping)

Processing 3 files...
```

---

## Change Type Inference

### Detection Rules

| Diff Pattern | Inferred Type | Version Bump |
|--------------|---------------|--------------|
| Lines added > deleted | Content Addition | Minor (0.X.0) |
| Lines deleted > added | Content Deletion | Minor (0.X.0) |
| Heading changes | Structural Change | Major (X.0.0) |
| Line-by-line edits | Refinement | Patch (0.0.X) |
| Mixed changes | Content Update | Minor (0.X.0) |

### Examples

**Content Addition:**
```diff
+ This new paragraph explains the concept further.
+ Additional examples include:
+ - Example A
+ - Example B
```
→ Type: Content Addition, Version bump: Minor

**Structural Change:**
```diff
- ## Section 2: Analysis
+ ## Section 2: Deep Analysis
+
+ ### 2.1 Quantitative Analysis
```
→ Type: Structural Change, Version bump: Major

**Refinement:**
```diff
- The results were significant.
+ The results were statistically significant (p<0.05).
```
→ Type: Refinement, Version bump: Patch

---

## Version History Entry Format

### Auto-Generated Entry

```markdown
### Version 1.3.0 - 2025-11-24 - Add case study examples

**Type:** Content Addition
**Scope:** Section 3 (Case Studies)
**Priority:** Medium
**Rationale:** [Auto-generated from git diff]

**Changes Made:**
- Added 3 new case study examples to Section 3
- Each case study follows the template format
- Approximately 1,200 words added
- New subsections: 3.1, 3.2, 3.3

**Verification Status:**
- Examples marked as [PROVIDE REAL EXAMPLE]
- Requires user verification before finalizing
```

### Entry Placement

New entries are always added at the TOP of Version History:

```markdown
### Version History

#### v1.3.0 - 2025-11-24 - Add case studies    ← NEW (top)
...

#### v1.2.0 - 2025-11-20 - Expand introduction
...

#### v1.1.0 - 2025-11-15 - Initial revision
...

#### v1.0.0 - 2025-11-10 - Initial creation
...
```

---

## Lock Handling During Scan

### Scenario: Chapter Locked

```
Processing Chapter_05...
⚠️ Chapter_05 is currently locked by another instance.

Lock details:
- Resource: Chapter_05
- Locked at: 2025-11-24T14:30:00Z (5 minutes ago)
- Instance: CLI-12345

Options:
1. Continue with other chapters (skip Chapter_05)
2. Wait for lock to clear
3. Cancel entire operation

Choose option (1-3):
```

### Scenario: Stale Lock

```
Processing Chapter_07...
⚠️ Chapter_07 has a stale lock (older than 15 minutes).

Lock details:
- Locked at: 2025-11-24T12:00:00Z (155 minutes ago)
- Instance: CLI-67890

Options:
1. Override stale lock and continue
2. Skip this chapter
3. Cancel entire operation

Choose option (1-3):
```

---

## Full Update Report

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ Change Tracking Synchronized
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Files Updated: 3

1. Chapter_03_chg.md
   - Previous version: 1.2.0
   - New version: 1.3.0
   - Type: Content Addition
   - Summary: Added methodology details to Section 2

2. Chapter_05_chg.md
   - Previous version: 1.0.0
   - New version: 1.1.0
   - Type: Refinement
   - Summary: Fixed terminology and citations

3. Chapter_Quotes_chg.md
   - Previous version: 1.0.0
   - New version: 1.1.0
   - Type: Content Update
   - Summary: Updated quote for Chapter 5

Skipped: 1
- FrontMatter/Introduction.md (locked by CLI-12345)

Locks Released: 2
- Chapter_03
- Chapter_05

Recommendations:
1. Review auto-generated entries for accuracy
2. Run scan again after FrontMatter lock clears
3. Commit changes to preserve tracking
```

---

## When to Run This Prompt

### Recommended Scenarios

| Scenario | Urgency | Notes |
|----------|---------|-------|
| Before milestone | High | Ensure all changes tracked |
| After manual edits | High | Sync framework with direct edits |
| Before Prompt 7 (Compile) | Medium | Clean tracking before compilation |
| Weekly maintenance | Low | Regular hygiene |
| After git pull | Medium | Sync changes from other machines |

### Automatic Checks

The book-writing-assistant agent runs this automatically:
- At session start
- Before any git commit

Manual runs may not be needed if using the agent regularly.

---

## Troubleshooting

### "No changes detected"

**Cause:** All files are in sync

**Solution:** No action needed - tracking is current

### "_chg file not found"

**Cause:** Content file exists without tracking file

**Solution:**
1. Create _chg file manually
2. Or run Prompt 3 to initialize tracking

### "Git not initialized"

**Cause:** No .git directory

**Solution:**
1. Run `git init`
2. Create initial commit
3. Re-run scan

### "Diff analysis failed"

**Cause:** Binary file or encoding issue

**Solution:**
1. Verify file is markdown
2. Check file encoding (UTF-8)
3. Manual entry may be needed

### "Version number conflict"

**Cause:** _chg file has higher version than detected

**Solution:**
1. Trust the _chg file version
2. Or manually adjust if incorrect

---

## File Pair Detection

### Standard Pairs

| Content File | Tracking File |
|--------------|---------------|
| Chapter_XX.md | Chapter_XX_chg.md |
| TOC.md | TOC_chg.md |
| Chapter_Quotes.md | Chapter_Quotes_chg.md |
| Style_Guide.md | Style_Guide_chg.md |

### Non-Tracked Files

These files don't have _chg pairs:
- README.md
- PROJECT_CONTEXT.md
- USAGE_GUIDE.md
- Image_Registry.md
- Style_Overrides.md (registry, not content)

---

## Related Prompts

| Prompt | Relationship |
|--------|--------------|
| Prompt 3 | Creates/updates _chg files during edits |
| Prompt 7 | Benefits from synced tracking before compile |
| Prompt 10 | Shows tracking status in dashboard |

---

**Version:** 0.15.2
**For Core Workflow:** See `Prompt_5_Scan_For_User_Edits.md`
