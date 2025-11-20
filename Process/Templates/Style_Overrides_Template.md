# Style Overrides Registry

**Book:** [Book Title]
**Book-Level Style:** [Style name from Manuscript/Style/Style_Guide.md]
**Framework Version:** 0.10.1+

---

## Overview

This file tracks all style overrides in your book, providing a central registry for:
- Chapter-level style overrides
- Section-level style overrides
- Style distribution analysis
- Transition points between styles

**Cascading Hierarchy:**
```
Book Style (Global Default in Style_Guide.md)
  ↓ inherits
Chapter Style (Optional - Chapter_XX_style.md)
  ↓ inherits
Section Style (Optional - HTML comments in content)
```

---

## Book-Level Style (Global Default)

**Style:** [Style name]
**Source:** Manuscript/Style/Style_Guide.md
**Applies To:** All chapters and sections unless overridden

---

## Chapter-Level Overrides

### Active Chapter Overrides

| Chapter | Override Style | Rationale | File |
|---------|---------------|-----------|------|
| Chapter_03 | Technical Precision | Implementation details require technical depth | Chapter_03_style.md |
| Chapter_07 | Narrative Storyteller | Case study chapter benefits from narrative approach | Chapter_07_style.md |

### No Override (Uses Book-Level Style)

**Chapters using book-level style:**
- Chapter_01, Chapter_02, Chapter_04, Chapter_05, Chapter_06, Chapter_08, Chapter_09, Chapter_10

---

## Section-Level Overrides

**Format:** Sections marked with HTML comments in chapter content files

### Chapter_02 Sections

| Section | Override Style | Rationale | Location |
|---------|---------------|-----------|----------|
| "Database Schema Design" | Technical Precision | Needs SQL examples and technical precision | Chapter_02.md:145-230 |

### Chapter_05 Sections

| Section | Override Style | Rationale | Location |
|---------|---------------|-----------|----------|
| "User Story: Sarah's Journey" | Narrative Storyteller | Personal anecdote for engagement | Chapter_05.md:89-156 |
| "Interview Excerpt" | Conversational Expert | Direct quotes, conversational tone | Chapter_05.md:420-485 |

---

## Style Distribution Analysis

**Total Chapters:** 10
**Chapters with overrides:** 2 (20%)
**Chapters using book style:** 8 (80%)

**Section overrides across book:** 3 sections

### Style Usage Summary

| Style | Book-Level | Chapter-Level | Section-Level | Total Usage |
|-------|------------|---------------|---------------|-------------|
| [Book Style] | 1 | 0 | 0 | 8 chapters |
| Technical Precision | 0 | 1 | 1 | 1 chapter + 1 section |
| Narrative Storyteller | 0 | 1 | 1 | 1 chapter + 1 section |
| Conversational Expert | 0 | 0 | 1 | 1 section |

**Override Percentage:** 20% (below 30% threshold ✓)

---

## Style Transition Map

**Visual representation of style changes throughout the book:**

```
Ch 01: [Book Style]
Ch 02: [Book Style] → (Section: Technical Precision) → [Book Style]
Ch 03: [Technical Precision] ← CHAPTER OVERRIDE
Ch 04: [Book Style]
Ch 05: [Book Style] → (Section: Narrative) → (Section: Conversational) → [Book Style]
Ch 06: [Book Style]
Ch 07: [Narrative Storyteller] ← CHAPTER OVERRIDE
Ch 08: [Book Style]
Ch 09: [Book Style]
Ch 10: [Book Style]
```

### Transition Points Requiring Attention

**Chapter 02 → Chapter 03:**
- Transition from [Book Style] to Technical Precision
- Strategy: Opening paragraph of Ch 03 acknowledges shift to technical content

**Chapter 03 → Chapter 04:**
- Transition from Technical Precision back to [Book Style]
- Strategy: Closing paragraph of Ch 03 summarizes and bridges to conceptual content

**Chapter 06 → Chapter 07:**
- Transition from [Book Style] to Narrative Storyteller
- Strategy: Ch 07 opens with narrative hook that flows from Ch 06 conclusion

**Chapter 07 → Chapter 08:**
- Transition from Narrative Storyteller back to [Book Style]
- Strategy: Ch 07 ends with reflection that connects to Ch 08 analytical content

---

## Override Guidelines

### When to Use Chapter-Level Overrides

**Good reasons:**
- Entire chapter has fundamentally different purpose (e.g., technical appendix, case study, interview)
- Content type demands different voice (e.g., how-to instructions vs. conceptual explanation)
- Audience segment changes (e.g., beginner vs. advanced content)

**Poor reasons:**
- Minor variation in tone
- Single section needs different style (use section override instead)
- Personal preference without clear rationale

### When to Use Section-Level Overrides

**Good reasons:**
- Brief example, anecdote, or quote with different voice
- Embedded content (interview excerpt, case study, technical aside)
- Temporary shift for specific rhetorical purpose

**Poor reasons:**
- Entire sections spanning multiple pages (use chapter override)
- Inconsistent application without clear purpose
- More than 30% of chapter content

---

## Consistency Checks

**Run these checks regularly (Prompt 6 or Prompt 11):**

- [ ] All chapter override files exist in chapter directories
- [ ] All override rationales are documented
- [ ] Style transitions are smooth and intentional
- [ ] Override percentage is below 30% threshold
- [ ] Section override markers are properly closed
- [ ] All referenced styles exist in Style_Guide.md or Custom_Styles.md

---

## Validation Warnings

**Warnings will be issued if:**

1. **Override percentage exceeds 30%** - May indicate inconsistent book-level style choice
2. **Unclosed section override markers** - HTML comments must have matching END tags
3. **Undefined style referenced** - Style name doesn't exist in framework or custom styles
4. **Abrupt transitions** - Adjacent chapters/sections with very different styles without transition strategy
5. **Missing override file** - Registry lists chapter override but file doesn't exist

---

## Version History

### Version 1.0.0 - [Date]
- Initial style overrides registry created
- Book-level style: [Style name]
- Chapter overrides: None
- Section overrides: None

---

**Maintenance:**
- Update this file when adding/removing overrides via Prompt 11 (Style Manager)
- Prompt 6 (Consistency Checker) validates against this registry
- Prompt 8 (Dashboard) shows style distribution summary
- Prompt 3 (Modify File) automatically detects and applies overrides

---

**Note:** This file is auto-updated by Prompt 11 (Style Manager). Manual edits are allowed but should be synced by running "Prompt 11 → Validate Override Registry".
