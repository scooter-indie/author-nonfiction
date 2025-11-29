# Prompt 11 Reference Documentation

**Version:** 0.16.1
**Purpose:** Detailed examples, report formats, and troubleshooting

---

## Overview

This reference provides detailed workflows, example reports, and troubleshooting for style management. Load when:
- First time using Prompt 11
- Need detailed report examples
- Troubleshooting validation issues
- Understanding transition analysis

**For core workflow:** See `Prompt_11_Style_Manager.md`

---

## Operation 1: Add Override - Full Example

### User Request
"Add Technical Precision style to Chapter 5 for the technical implementation details"

### Example Report

```
✅ Chapter override added successfully

Chapter: Chapter_05
New Style: Technical Precision
Previous Style: Conversational Expert (book-level)

Files Created:
- Manuscript/Chapters/Chapter_05/Chapter_05_style.md

Files Updated:
- Manuscript/Style/Style_Overrides.md

Override Analysis:
- Total Chapters: 10
- Chapters with Overrides: 3 (30%)
- Threshold: 30% ✓ At threshold

New Transitions:
⚠️ Chapter 04 → 05: Conversational Expert → Technical Precision
  Severity: Medium
  Recommendation: Add transition strategy in Style_Overrides.md

⚠️ Chapter 05 → 06: Technical Precision → Conversational Expert
  Severity: Medium
  Recommendation: Add bridging content at chapter boundary

Next Steps:
1. Document transition strategies in Style_Overrides.md
2. Consider adding transition paragraphs in affected chapters
3. Run Prompt 8 (Consistency) to validate style application
```

---

## Operation 2: Remove Override - Full Example

### Example Report

```
✅ Chapter override removed successfully

Chapter: Chapter_07
Style Removed: Narrative Storyteller
Reverted To: Conversational Expert (book-level)

Files Deleted:
- Manuscript/Chapters/Chapter_07/Chapter_07_style.md

Files Updated:
- Manuscript/Style/Style_Overrides.md

Override Analysis:
- Total Chapters: 10
- Chapters with Overrides: 1 (10%)
- Threshold: 30% ✓ Well below threshold

Transitions Eliminated:
✓ Chapter 06 → 07: Was Conversational → Narrative, now consistent
✓ Chapter 07 → 08: Was Narrative → Conversational, now consistent

Chapter 07 now uses: Conversational Expert (book-level)

Next Steps:
1. Run Prompt 3 to modify Chapter 07 if content needs adjustment
2. Run Prompt 8 to verify style consistency
```

---

## Operation 3: Scan Section Overrides - Full Example

### Example Report

```
📋 Section Override Scan Complete

Scanned: 10 chapters

Section Overrides Found: 5

Chapter_02:
✓ Lines 145-230: Technical Precision
  - Purpose: Database schema example
  - Valid: Properly closed, style exists

Chapter_05:
✓ Lines 89-156: Narrative Storyteller
  - Purpose: User story anecdote
  - Valid: Properly closed, style exists

✓ Lines 420-485: Conversational Expert
  - Purpose: Interview excerpt
  - Valid: Properly closed, style exists

Chapter_08:
❌ Lines 200-[EOF]: Business Professional
  - ERROR: Unclosed override marker
  - Action Required: Add <!-- END_STYLE_OVERRIDE --> before chapter end

Chapter_09:
⚠️ Lines 100-180: TechnicalPrecision
  - WARNING: Style name has typo (should be "Technical Precision")
  - Action Required: Fix style name in marker

Files Updated:
- Manuscript/Style/Style_Overrides.md (valid overrides added)

Issues Requiring Attention:
1. Chapter_08:200 - Unclosed marker
2. Chapter_09:100 - Invalid style name

Next Steps:
1. Fix issues in Chapter_08 and Chapter_09
2. Run scan again to verify fixes
3. Run Prompt 8 to analyze section style consistency
```

---

## Operation 4: Validate Registry - Full Example

### Example Report

```
🔍 Override Registry Validation Complete

Registry File: Manuscript/Style/Style_Overrides.md

Chapter-Level Overrides: 3 listed

✅ Chapter_03: Technical Precision
  - File exists: Chapter_03_style.md ✓
  - Style exists: Process/Styles/Academic/Technical_Precision.md ✓

✅ Chapter_07: Narrative Storyteller
  - File exists: Chapter_07_style.md ✓
  - Style exists: Process/Styles/Narrative/Narrative_Storyteller.md ✓

❌ Chapter_09: Business Authority
  - File missing: Chapter_09_style.md NOT FOUND
  - Registry entry without file
  - Action: Remove from registry or create file

⚠️ Orphaned Files Found: 1

Chapter_12_style.md exists but NOT in registry
  - File: Manuscript/Chapters/Chapter_12/Chapter_12_style.md
  - Style: Practical Guide
  - Action: Add to registry or delete file

Section Override Validation:

❌ Chapter_05:145 - Unclosed marker (Technical Precision)
⚠️ Chapter_08:200 - Unknown style "CustomStyle"

Auto-Fix Actions Taken:
1. ✅ Added Chapter_12 to registry (Practical Guide override)
2. ✅ Removed Chapter_09 from registry (file not found)

Manual Actions Required:
1. Fix unclosed marker in Chapter_05:145
2. Add "CustomStyle" to Custom_Styles.md or change marker

Updated Files:
- Manuscript/Style/Style_Overrides.md
```

---

## Operation 5: View Distribution - Full Example

### Detailed Report

```
📊 Style Distribution Report

Book: [Title]
Book-Level Style: Conversational Expert
Total Chapters: 10

Chapter-Level Distribution:

| Chapter | Active Style | Source | Notes |
|---------|-------------|--------|-------|
| 01 | Conversational Expert | Book | - |
| 02 | Conversational Expert | Book | + 1 section override |
| 03 | Technical Precision | Chapter Override | Full chapter |
| 04 | Conversational Expert | Book | - |
| 05 | Conversational Expert | Book | + 2 section overrides |
| 06 | Conversational Expert | Book | - |
| 07 | Narrative Storyteller | Chapter Override | Full chapter |
| 08 | Conversational Expert | Book | - |
| 09 | Conversational Expert | Book | - |
| 10 | Conversational Expert | Book | - |

Override Analysis:

Chapter Overrides: 2 of 10 (20%)
✅ Below 30% threshold

Section Overrides: 3 sections across 2 chapters

Style Usage Summary:

| Style | Chapters | Sections | Total Usage |
|-------|----------|----------|-------------|
| Conversational Expert | 8 (book) | 1 (section) | 80% + 1 section |
| Technical Precision | 1 (chapter) | 1 (section) | 10% + 1 section |
| Narrative Storyteller | 1 (chapter) | 1 (section) | 10% + 1 section |

Style Transition Map:

Ch 01: [Book: Conversational Expert]
Ch 02: [Book] → (Section: Technical) → [Book]
Ch 03: [CHAPTER OVERRIDE: Technical Precision] ← Transition point
Ch 04: [Book: Conversational Expert] ← Transition point
Ch 05: [Book] → (Section: Narrative) → (Section: Conversational) → [Book]
Ch 06: [Book: Conversational Expert]
Ch 07: [CHAPTER OVERRIDE: Narrative Storyteller] ← Transition point
Ch 08: [Book: Conversational Expert] ← Transition point
Ch 09: [Book: Conversational Expert]
Ch 10: [Book: Conversational Expert]

Transition Points: 4 chapter-level, 6 section-level

Recommendations:
✅ Override usage is healthy (20%)
⚠️ 4 chapter transitions may need documented strategies
✓ Style consistency looks good overall
```

---

## Operation 6: Analyze Transitions - Full Example

### Example Report

```
🔀 Style Transition Analysis

Chapter-Level Transitions: 4

⚠️ MEDIUM: Chapter 02 → Chapter 03
From: Conversational Expert (book-level)
To: Technical Precision (chapter override)

Severity: Medium
- Significantly different formality levels
- No documented transition strategy

Recommendations:
1. Add transition paragraph at end of Chapter 02:
   "Now that we've covered the conceptual framework, let's examine
   the technical implementation details..."

2. Open Chapter 03 with acknowledgment:
   "This chapter dives deep into the technical aspects. We'll use
   precise terminology and detailed examples..."

3. Document strategy in Style_Overrides.md

---

✅ LOW: Chapter 03 → Chapter 04
From: Technical Precision (chapter override)
To: Conversational Expert (book-level)

Severity: Low
- Documented transition strategy exists ✓
- Strategy: "Chapter 03 ends with summary that bridges back"

---

🔴 HIGH: Chapter 06 → Chapter 07
From: Conversational Expert (book-level)
To: Narrative Storyteller (chapter override)

Severity: High
- Major tone shift (analytical → personal narrative)
- No documented transition strategy
- Voice change (second-person → first-person)

Recommendations:
1. End Chapter 06: "Let me share a personal experience..."
2. Open Chapter 07 with context: "In this chapter, I'll take you
   through my journey..."
3. Document all transition points in Style_Overrides.md

---

Summary:

Total Transitions: 10 (4 chapter, 6 section)
High Severity: 1 (requires immediate attention)
Medium Severity: 5 (should address)
Low Severity: 4 (monitored, acceptable)

Undocumented Transitions: 3
```

---

## Operation 7: Change Book-Level Style - Full Example

### Impact Analysis Report

```
📝 Book-Level Style Change Impact Analysis

Current Book-Level Style: Conversational Expert
Proposed New Style: Academic Authority

Impact Analysis:

Chapters Affected: 8 (will change to Academic Authority)
- Chapter 01, 02, 04, 05, 06, 08, 09, 10

Chapters NOT Affected: 2 (have chapter overrides)
- Chapter 03: Technical Precision (override remains)
- Chapter 07: Narrative Storyteller (override remains)

Section Overrides: 3 (will inherit new book-level style as base)
- Chapter 02, Section 145-230: Technical Precision
- Chapter 05, Section 89-156: Narrative Storyteller
- Chapter 05, Section 420-485: Conversational Expert (becomes redundant)

Style Characteristics Changing:

From Conversational Expert:
- Voice: Second person ("you")
- Tone: Conversational, accessible
- Formality: Moderate
- Examples: Frequent, relatable

To Academic Authority:
- Voice: Third person / First person plural ("we")
- Tone: Scholarly, authoritative
- Formality: High
- Examples: Research-based, citations

Recommendations:

⚠️ This is a major change affecting 80% of your book
⚠️ Consider: Is Academic Authority the right choice?

Alternative Approach:
- Keep Conversational Expert as book-level
- Add Academic Authority overrides to specific chapters

Proceed with change? (Yes/No/Reconsider)
```

---

## Section Override Marker Format

**Opening marker:**
```markdown
<!-- STYLE_OVERRIDE: StyleName -->
```

**Closing marker:**
```markdown
<!-- END_STYLE_OVERRIDE -->
```

**Valid style names:**
- Must match exactly (case-sensitive with spaces)
- Framework styles from `Process/Styles/`
- Custom styles from `Manuscript/Style/Custom_Styles.md`

**Invalid examples:**
- `TechnicalPrecision` (missing space)
- `technical precision` (wrong case)
- `Technical-Precision` (hyphen instead of space)

---

## Troubleshooting

### Issue: "Style not found"

**Cause:** Style name doesn't match catalog exactly
**Fix:** Check `Process/Styles/Style_Catalog.md` for exact names

### Issue: "Registry out of sync"

**Cause:** Manual file operations bypassed registry
**Fix:** Run Operation 4 (Validate) with auto-fix enabled

### Issue: "Orphaned override file"

**Cause:** Chapter deleted but style file remains
**Fix:** Delete orphaned file or add to registry

### Issue: "High override percentage"

**Cause:** >30% chapters have overrides
**Fix:** Consider changing book-level style (Operation 7)

### Issue: "Lock conflict"

**Cause:** Another style operation in progress
**Fix:** Wait or override stale lock (>15 min)

---

## Framework Styles (19 Total)

**Academic & Research (4):**
1. Academic Authority
2. Scientific Communicator
3. Technical Precision
4. Medical/Health Narrative

**Business & Professional (2):**
5. Business Professional
6. Conversational Expert

**Narrative & Storytelling (4):**
7. Narrative Storyteller
8. Historical Chronicler
9. Investigative Journalist
10. Confessional Memoir

**Personal Development (3):**
11. Practical Guide
12. Inspirational Teacher
13. Philosophical Contemplative

**Cultural & Social (6):**
14. Cultural Critic
15. Satirical Humorist
16. Activist Advocate
17. Lyrical Nature Writer
18. Spiritual/Religious Writer
19. Sports Writer

---

**Version:** 0.16.1
**For Core Workflow:** See `Prompt_11_Style_Manager.md`
