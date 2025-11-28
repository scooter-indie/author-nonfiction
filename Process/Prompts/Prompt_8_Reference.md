# Prompt 8 Reference Documentation

**Version:** 0.16.0
**Purpose:** Detailed report examples, analysis criteria, and troubleshooting

---

## Overview

This reference provides detailed examples of consistency reports and analysis criteria. Load when:
- First time using Prompt 8
- Understanding report format
- Interpreting specific issue types
- Troubleshooting complex consistency issues

**For core workflow:** See `Prompt_8_Consistency.md`

---

## Complete Report Example

```markdown
# Consistency Report - 2025-11-24

**Scope:** Full book (Chapters 1-7)
**Check Types:** All

---

## Executive Summary

- **Critical Issues:** 3
- **Warnings:** 12
- **Suggestions:** 8
- **Overall Health:** ⚠️ Moderate - Fix critical issues before milestone

---

## Critical Issues

### 1. Broken Cross-Reference (Chapter 3)
**Location:** Manuscript/Chapters/Chapter_03/Chapter_03_Methods.md:45
**Issue:** Reference to "Chapter 8" but book only has 7 chapters
**Fix:** Update reference to correct chapter

### 2. Fact Contradiction (Chapter 2 vs Chapter 5)
**Location:** Chapter_02.md:145, Chapter_05.md:230
**Issue:** Chapter 2 states "30% of employees" but Chapter 5 states "25% of employees" for same metric
**Fix:** Determine correct figure and update both chapters

### 3. Missing Required Citation (Chapter 4)
**Location:** Chapter_04.md:312
**Issue:** Statistical claim "productivity increased by 47%" has no citation
**Fix:** Add citation using Prompt 14 or remove claim

---

## Warnings

### Terminology Variations (5 found)

| Term | Variations Found | Recommendation |
|------|-----------------|----------------|
| email | email (Ch 1,3,5), e-mail (Ch 2,4) | Standardize to "email" |
| work-from-home | work-from-home (Ch 1), WFH (Ch 3), remote work (Ch 5) | Choose one term |
| Covid-19 | COVID-19 (Ch 2), Covid (Ch 4), coronavirus (Ch 5) | Standardize to "COVID-19" |

### Style Drift (3 chapters)

**Chapter 4:** Moderate drift from Conversational Expert
- Person: 8 instances of first person (style uses second)
- Lines: 23, 45, 67, 89, 112, 134, 156, 178

**Chapter 5:** Long paragraphs
- 3 paragraphs exceed 200 words (guideline: 150 max)
- Lines: 89-110, 234-260, 345-380

### Heading Hierarchy Issues (2 found)

**Chapter 3, line 156:** H4 directly after H2 (missing H3)
**Chapter 6, line 89:** Duplicate H2 heading text

---

## Suggestions

### Quote Attribution
- Chapter 2 epigraph missing page number
- Chapter 5 quote needs year verification

### Visual Opportunities
- Chapter 2: Complex data (lines 145-230) would benefit from table
- Chapter 4: Process description could use flowchart

---

## Terminology Index

| Term | Chapters | First Use | Definition |
|------|----------|-----------|------------|
| API | 3, 5, 7 | Ch 3, line 23 | Application Programming Interface |
| UX | 2, 4, 6 | Ch 2, line 45 | User Experience |
| MVP | 3, 5 | Ch 3, line 89 | Minimum Viable Product |

---

## Cross-Reference Map

| Reference | Source | Target | Status |
|-----------|--------|--------|--------|
| "See Chapter 2" | Ch 5, line 34 | Chapter 2 | ✓ Valid |
| "Chapter 8" | Ch 3, line 45 | Chapter 8 | ❌ Invalid |
| "Section 3.2" | Ch 4, line 123 | Ch 3, Sec 2 | ✓ Valid |

---

## Hierarchical Writing Style Analysis

**Book-Level Style:** Conversational Expert
**Chapter Overrides:** 2 (29%)
**Section Overrides:** 3 sections across 2 chapters
**Override Threshold:** ✓ Below 30%

### Style Distribution Map

| Chapter | Active Style | Source | Alignment |
|---------|-------------|--------|-----------|
| 01 | Conversational Expert | Book | ✓ Excellent |
| 02 | Conversational Expert | Book (+ 1 section override) | ✓ Good |
| 03 | Technical Precision | Chapter Override | ✓ Excellent |
| 04 | Conversational Expert | Book | ⚠ Moderate drift |
| 05 | Conversational Expert | Book (+ 2 section overrides) | ⚠ Violations |
| 06 | Technical Precision | Chapter Override | ✓ Good |
| 07 | Conversational Expert | Book | ✓ Excellent |

### Style Transition Analysis

**Chapter-Level Transitions:** 4 detected

⚠️ Chapter 02 → 03: Conversational Expert → Technical Precision
- Documented strategy: Yes ✓
- Transition quality: Smooth

⚠️ Chapter 03 → 04: Technical Precision → Conversational Expert
- Documented strategy: No ❌
- Recommendation: Add transition strategy to Style_Overrides.md

### Chapter Detail: Chapter 4 Drift

**Active Style:** Conversational Expert (book-level)
**Issues Found:**

Person consistency:
- Line 23: "I believe this approach..." (should be "You might find...")
- Line 45: "In my experience..." (should be generic or hypothetical)
- Total: 8 instances

Recommendation: Review and convert to second person, or add chapter override if first person is intentional.

### Chapter Detail: Chapter 5 Violations

**Active Style:** Conversational Expert (with 2 section overrides)

Base style issues (Conversational sections):
- Paragraph 89-110: 215 words (guideline: 150 max)
- Paragraph 234-260: 198 words
- Paragraph 345-380: 225 words
- Technical terms without explanation: "microservices", "containerization"

Section overrides (Technical Precision, lines 150-200):
- ✓ No violations - technical terms appropriate

Recommendation: Break long paragraphs in Conversational sections only.

---

## Visual Content Status

### Registry Mode: Single (12 entries)

**Total Figures:** 12 across 5 chapters
- 📝 Text-based: 8 (67%)
- 🖼️ Professional images: 4 (33%)

### Chapter-by-Chapter

| Chapter | Figures | Status |
|---------|---------|--------|
| 01 | 3 | ✓ Good |
| 02 | 0 | ⚠ Needs visuals |
| 03 | 5 | ⚠ 2 high-priority upgrades |
| 04 | 2 | ✓ Good |
| 05 | 2 | ✓ Adequate |

### Recommendations

1. Run Prompt 15 for Chapter 2 (complex data needs visualization)
2. Upgrade fig-03-01 and fig-03-02 (high priority)
3. Add captions to fig-03-03 and fig-04-02

---

## Citation Status

**Total Citations:** 48 across 7 chapters
- ✓ Verified: 32 (67%)
- ⏳ Pending: 14 (29%)
- ❌ Rejected: 2 (4%)

### Chapter Summary

| Chapter | Verified | Pending | Issues |
|---------|----------|---------|--------|
| 01 | 8 | 4 | - |
| 02 | 5 | 2 | 3 uncited claims |
| 03 | 8 | 0 | ✓ Complete |
| 04 | 10 | 5 | 1 missing details |
| 05 | 9 | 1 | - |
| 06 | 4 | 2 | - |
| 07 | 6 | 0 | ✓ Complete |

### Uncited Statistical Claims (Chapter 2)

1. Line 145: "Remote work increased productivity by 13%"
2. Line 230: "65% of employees prefer hybrid model"
3. Line 367: "Studies show 40% reduction in commute time"

**Action:** Run Prompt 14 for Chapter 2

---

## Quote/Epigraph Status

**Total Quotes:** 7 (one per chapter)
- ✓ Verified: 5
- ⏳ Pending: 2

| Chapter | Quote | Status |
|---------|-------|--------|
| 01 | Anne Lamott, Bird by Bird | ✓ Verified |
| 02 | Unknown source | ⏳ Needs verification |
| 03 | Cal Newport, Deep Work | ✓ Verified |
| 04 | Seth Godin, The Practice | ✓ Verified |
| 05 | Missing page number | ⚠ Incomplete |
| 06 | Stephen King, On Writing | ✓ Verified |
| 07 | Austin Kleon, Show Your Work | ✓ Verified |

---

## Recommendations Summary

### High Priority (Fix Before Milestone)
1. Fix broken Chapter 8 reference in Chapter 3
2. Resolve 30% vs 25% contradiction (Chapter 2/5)
3. Add citation for 47% productivity claim (Chapter 4)

### Medium Priority
1. Standardize terminology (email, COVID-19, etc.)
2. Fix person consistency in Chapter 4
3. Break long paragraphs in Chapter 5
4. Document Chapter 3→4 style transition

### Low Priority
1. Add visuals to Chapter 2
2. Upgrade high-priority figures in Chapter 3
3. Complete quote attributions
```

---

## Analysis Criteria Details

### Terminology Consistency Criteria

**Flag as variation:**
- Same concept, different spelling (email/e-mail)
- Same concept, different terms (remote work/WFH/work-from-home)
- Inconsistent capitalization (Covid/COVID)
- Inconsistent acronym expansion

**Build index by:**
- First occurrence location
- All chapter appearances
- Definition if provided

### Cross-Reference Validation

**Valid reference patterns:**
- "See Chapter X"
- "As discussed in Section X.Y"
- "Refer to [Chapter Title]"
- Internal markdown links

**Check for:**
- Target exists
- Target is accessible from source
- Reference text matches target

### Style Consistency Checks

**Heading hierarchy:**
- H1 only at chapter title
- H2 for major sections
- H3 for subsections
- No skipping levels (H2→H4)

**List formatting:**
- Consistent bullet style (-, *, •)
- Consistent numbering (1., 1), (1))
- Nested list indentation

**Quote formatting:**
- Straight vs curly quotes
- Single vs double quotes
- Blockquote formatting

### Fact Consistency

**Track claims by:**
- Category (statistics, dates, names, quantities)
- First assertion location
- All subsequent mentions

**Flag contradictions:**
- Different numbers for same metric
- Different dates for same event
- Conflicting descriptions

### Hierarchical Style Analysis

**Resolution order:**
1. Section override markers in content
2. Chapter override file (Chapter_XX_style.md)
3. Book-level (Style_Guide.md)

**Per-section checks:**
- Person perspective (1st/2nd/3rd)
- Formality level
- Paragraph length
- Technical term usage
- Passive voice density

**Threshold monitoring:**
- Chapter overrides should be < 30% of chapters
- Higher suggests wrong book-level style choice

---

## Troubleshooting

### Issue: Report is Very Large

**Cause:** Many files, many issues
**Solution:** Run with narrower scope (specific chapters)

### Issue: Style Analysis Missing

**Cause:** No Style_Guide.md exists
**Solution:** Run Prompt 1 to create, or create manually

### Issue: Image Registry Not Found

**Cause:** No images directory or registry
**Solution:** Create with Prompt 15 or Prompt 16

### Issue: False Positive Terminology

**Cause:** Intentional variation (technical vs. casual sections)
**Solution:** Note in Style_Overrides.md as intentional

---

## Module References

- **Style System:** Process/_COMMON/10_Style_Consistency_Protocol.md
- **Quote Management:** Process/_COMMON/07_Quote_Management_System.md
- **Visual Assets:** Process/_COMMON/15_Visual_Asset_Management_Protocol.md
- **Citations:** Process/_COMMON/16_Citation_Management_Protocol.md
- **README Updates:** Process/_COMMON/17_README_Management_Module.md

---

**Version:** 0.16.0
**For Core Workflow:** See `Prompt_8_Consistency.md`
