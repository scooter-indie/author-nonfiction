# Image Registry (Master Index)

**Registry Type:** Split (Chapter-Based)
**Total Images:** [COUNT]
**Split Date:** [DATE]
**Framework Version:** 0.14.0

---

## Overview

This image registry has been split into per-chapter registries for performance and usability.

**Performance:** Each chapter registry is ~20-50 entries (~5,000-12,500 tokens)
**Navigation:** See `Image_Registry_Chapter_XX.md` for chapter-specific images

---

## Registry Distribution

| Chapter | Registry File | Images | Last Updated |
|---------|--------------|--------|--------------|
| Frontmatter | `Image_Registry_Frontmatter.md` | [N] | [DATE] |
| Chapter 01 | `Image_Registry_Chapter_01.md` | [N] | [DATE] |
| Chapter 02 | `Image_Registry_Chapter_02.md` | [N] | [DATE] |
| Backmatter | `Image_Registry_Backmatter.md` | [N] | [DATE] |

**Total:** [COUNT] images across [N] registries

---

## Quick Stats

**By Type:**
- Text-based visuals: [N] ([%])
- Professional images: [N] ([%])
- Photos/screenshots: [N] ([%])

**By Chapter:**
- Average: [N] images/chapter
- Most images: Chapter [XX] ([N] images)
- Least images: Chapter [XX] ([N] images)

**Status:**
- Referenced: [N] ([%])
- Unreferenced: [N] ([%])
- Missing files: [N] ([%])

---

## How to Use Split Registries

**For Authors:**
- Reference images normally: `![Description](images/fig-02-01-diagram.png)`
- Prompts automatically use correct chapter registry

**For AI (Claude):**
- When processing Chapter 5: Read `Image_Registry_Chapter_05.md` only
- For full validation: Read master index + all chapter registries
- For duplicate detection: Read only relevant chapter registry

**Adding Images:**
1. User specifies chapter (or AI detects from context)
2. Prompt 16 reads chapter registry only
3. Adds entry to chapter registry
4. Updates master index stats

---

## Migration Information

**Migrated from:** Single registry (`Image_Registry.md`)
**Migration Date:** [DATE]
**Original File:** Archived as `Image_Registry_LEGACY_[DATE].md`
**Migration Tool:** Prompt 16 automatic split

**All image references preserved:** No content file updates required

---

**Framework Version:** 0.14.0
**Last Updated:** [DATE]
