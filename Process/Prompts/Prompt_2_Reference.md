# Prompt 2 Reference Documentation

**Version:** 0.14.5
**Purpose:** Detailed examples, file templates, and troubleshooting

---

## Overview

This reference provides detailed workflows, templates, and troubleshooting for adding chapters. Load when:
- First time using Prompt 2
- Need file template details
- Troubleshooting chapter creation
- Understanding renumbering logic

**For core workflow:** See `Prompt_2_Add_Chapter.md`

---

## Interactive Add Example

### User Request
"Add Chapter 5: Case Studies after Chapter 4"

### Interaction

**Q1:** Chapter title?
> "Case Studies"

**Q2:** Position?
> "5" (or "after Chapter 4")

**Q3:** Estimated word count?
> "8000"

**Q4:** Key topics?
> "Real-world examples, success stories, lessons learned"

**Q5:** Rationale?
> "Need concrete examples to illustrate principles from Chapter 4"

**Q6:** Does this chapter need a different style than book-level?
> "Yes, Narrative Storyteller for the case study format"

### Execution

```
Creating chapter structure...
✓ Created: Manuscript/Chapters/Chapter_05/
✓ Created: Chapter_05.md
✓ Created: Chapter_05_chg.md
✓ Created: Chapter_05_style.md (Narrative Storyteller override)

Updating registry...
✓ Added to Style_Overrides.md

Updating TOC...
✓ Added Chapter 5 entry
✓ Renumbered Chapter 5 → 6 (existing)
✓ Renumbered Chapter 6 → 7 (existing)
...

Updating quotes registry...
✓ Added Chapter 5 entry to Chapter_Quotes.md (⏳ Pending)

Committing changes...
✓ Committed: Add Chapter 5: Case Studies
```

---

## From Inbox Example

### Scenario
User has `draft-case-studies.md` in Manuscript/Inbox/

### Interaction

**Q1:** Which file in Inbox?
> "draft-case-studies.md"

**Q2:** Position?
> "5"

**Q3:** Use content as-is or create placeholder?
> "As-is"

### Execution

```
Reading inbox file...
✓ Found: draft-case-studies.md (6,234 words)

Creating chapter structure...
✓ Created: Manuscript/Chapters/Chapter_05/
✓ Copied content to Chapter_05.md
✓ Created: Chapter_05_chg.md (with import note)

Archiving inbox file...
✓ Moved to: Manuscript/Inbox/Processed_2025-11-24/

[... rest of TOC update, renumbering ...]
```

---

## Chapter File Templates

### Chapter_XX.md (Full Template)

```markdown
# Chapter [X]: [Title]

**Status:** Draft
**Version:** 1.0.0
**Target Word Count:** [N]
**Created:** [CONFIRMED_DATE]

---

## Introduction

[Introduction content or placeholder]

---

## Section 1: [Topic]

[Content]

---

## Section 2: [Topic]

[Content]

---

## Summary

[Summary of key points]

---

## Key Takeaways

- [Takeaway 1]
- [Takeaway 2]
- [Takeaway 3]
```

### Chapter_XX_chg.md (Full Template)

```markdown
# Change Tracking: Chapter [X] - [Title]

**Current Version:** 1.0.0
**Last Modified:** [CONFIRMED_DATE]
**Status:** Draft

---

### [INSTRUCTIONS FOR THIS REVISION]

[Date: ]

**Changes requested:**
1. [Instruction]

**Priority:** [High/Medium/Low]
**Rationale:** [Why this change]
**Estimated scope:** [Major/Minor/Patch]

---

### Version History

#### v1.0.0 - [CONFIRMED_DATE] - Initial creation

**Type:** New chapter
**Scope:** Full chapter
**Priority:** High
**Rationale:** [User's rationale for adding chapter]

**Changes Made:**
- Created initial chapter structure
- Added placeholder sections
- Estimated word count: [N]
- Key topics: [topics if provided]
```

### Chapter_XX_style.md (Override Template)

```markdown
# Style Override: Chapter [X]

**Override Style:** [Style Name]
**Book-Level Style:** [Book's default style]
**Created:** [CONFIRMED_DATE]

---

## Rationale

[Why this chapter uses a different style]

---

## Style Characteristics

[Copied from Process/Styles/[Category]/[Style].md]

---

## Transition Strategy

**From Previous Chapter:**
[How to transition from previous chapter's style]

**To Next Chapter:**
[How to transition to next chapter's style]
```

---

## TOC Update Format

### Before (Example)

```markdown
# Table of Contents

⚠️ WARNING: This file is managed by Prompts 1 and 2...

## Chapters

1. Introduction
2. Background
3. Methodology
4. Analysis
5. Conclusions
```

### After (Adding Chapter 5: Case Studies)

```markdown
# Table of Contents

⚠️ WARNING: This file is managed by Prompts 1 and 2...

## Chapters

1. Introduction
2. Background
3. Methodology
4. Analysis
5. Case Studies          ← NEW
6. Conclusions           ← Renumbered from 5
```

---

## Renumbering Process

### Files Affected

When inserting Chapter 5 in a 10-chapter book:

**Directories to rename:**
```
Chapter_05/ → Chapter_06/
Chapter_06/ → Chapter_07/
Chapter_07/ → Chapter_08/
Chapter_08/ → Chapter_09/
Chapter_09/ → Chapter_10/
Chapter_10/ → Chapter_11/
```

**Files to update (internal references):**
- Each renamed Chapter_XX.md header
- Each renamed Chapter_XX_chg.md header
- Style_Overrides.md (if any affected chapters have overrides)
- Chapter_Quotes.md (quote assignments)
- Cross-references in all chapters

### Safety Order

Rename in reverse order (highest first) to prevent conflicts:
1. Chapter_10/ → Chapter_11/
2. Chapter_09/ → Chapter_10/
3. ...
4. Chapter_05/ → Chapter_06/
5. Create new Chapter_05/

---

## Impact Report

After adding chapter, display:

```
✅ Chapter added successfully

Chapter: 05 - Case Studies
Position: After Chapter 4 (Analysis)
Word Target: 8,000

Files Created:
- Manuscript/Chapters/Chapter_05/Chapter_05.md
- Manuscript/Chapters/Chapter_05/Chapter_05_chg.md
- Manuscript/Chapters/Chapter_05/Chapter_05_style.md

Files Updated:
- Manuscript/_TOC_/TOC.md
- Manuscript/_TOC_/TOC_chg.md
- Manuscript/Quotes/Chapter_Quotes.md
- Manuscript/Style/Style_Overrides.md

Chapters Renumbered: 6
- Chapter 5 → 6 (Conclusions)
- [etc.]

Style Override:
- Chapter 05: Narrative Storyteller
- Threshold: 2 of 6 chapters (33%) ⚠️ Above 30%

Quote Status:
- Chapter 05: ⏳ Pending

Cross-References Updated: 12

Git Commit: abc123
Tag: None (use Prompt 12 to tag milestones)

Next Steps:
1. Add content to Chapter 05
2. Find/verify quote for Chapter 05
3. Consider book-level style (override threshold high)
```

---

## Troubleshooting

### "Lock conflict"

**Cause:** Another chapter operation in progress

**Solution:**
1. Wait for lock to clear
2. Override if stale (>15 min)
3. Check `.locks/locks.json`

### "Position out of range"

**Cause:** Requested position > total chapters + 1

**Solution:**
- Use valid position (1 to N+1)
- Or specify "after Chapter X"

### "Inbox file not found"

**Cause:** File doesn't exist or wrong path

**Solution:**
- Check `Manuscript/Inbox/` for exact filename
- Verify file extension (.md)

### "Renumbering failed"

**Cause:** File permission or path issue

**Solution:**
1. Check directory permissions
2. Ensure no files are open in editor
3. Verify clean git status

### "Style override conflict"

**Cause:** Style name doesn't match catalog

**Solution:**
- Check `Process/Styles/Style_Catalog.md`
- Use exact style name (case-sensitive)

---

## Related Prompts

| Prompt | Relationship |
|--------|--------------|
| Prompt 1 | Creates initial project with chapters |
| Prompt 3 | Modifies chapter content |
| Prompt 11 | Manages style overrides |

---

**Version:** 0.14.5
**For Core Workflow:** See `Prompt_2_Add_Chapter.md`
