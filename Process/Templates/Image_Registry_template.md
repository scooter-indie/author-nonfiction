# Visual Asset Registry

**Last Updated:** [DATE]
**Total Assets:** 0
**By Status:** 0 📝 text-based, 0 🖼️ images
**By Type:** 0 figures

---

## Instructions

This registry tracks all visual assets in your book:
- Text-based placeholders (📝): Markdown tables, ASCII diagrams, mermaid flowcharts
- Professional images (🖼️): Photos, screenshots, charts, graphics

**Managed by:**
- Prompt 15 (Visual Content Suggester) - Creates text-based visuals
- Prompt 16 (Image Manager) - Adds actual images

**Registry format for each figure:**

```markdown
### fig-XX-YY-description
- **Figure:** X.Y
- **Title:** Figure title
- **Type:** [Table | Diagram | Photo | Screenshot | Chart | Flowchart | Infographic]
- **Status:** [📝 Text-based | 🖼️ Professional image]
- **File:** `images/fig-XX-YY-description.ext`
- **Size:** [KB/MB] ([width]x[height]px) - for images only
- **Referenced in:** Chapter_XX.md:line
- **Alt Text:** "Description for accessibility"
- **Caption:** "Figure X.Y: Caption text"
- **Created:** YYYY-MM-DD by [Prompt 15 | Prompt 16 | Manual]
- **Upgrade Priority:** [High | Medium | Low | N/A] - for text-based only
- **Notes:** [Any additional context]
```

---

## Front Matter

### cover
- **Figure:** N/A (Cover)
- **Title:** Book Cover
- **Type:** Cover Image
- **Status:** 🖼️ Professional image (JPG)
- **File:** `images/cover.jpg`
- **Size:** [SIZE] ([dimensions])
- **Referenced in:** EPUB export, Title Page
- **Alt Text:** "[Book Title] by [Author Name]"
- **Caption:** N/A
- **Created:** [DATE] by author
- **Upgrade Priority:** N/A (final)
- **Notes:** Professional design, meets EPUB specs (1600x2560px minimum)

---

## Chapter 01: [Chapter Title]

[Figures for Chapter 1 will be added here by Prompt 15 and Prompt 16]

---

## Chapter 02: [Chapter Title]

[Figures for Chapter 2 will be added here by Prompt 15 and Prompt 16]

---

## Upgrade Recommendations

### High Priority (Professional graphic recommended)
[Text-based figures that would significantly benefit from professional design]

### Medium Priority (Would benefit from design)
[Text-based figures that would look better as graphics but work adequately as text]

### Low Priority (Text-based adequate)
[Text-based figures that work fine as-is]

---

## Statistics

**By Chapter:**
[Will be calculated as figures are added]

**By Status:**
- 📝 Text-based: 0 (0%)
- 🖼️ Professional: 0 (0%)

**By Type:**
[Will be calculated as figures are added]

**Total Size:** 0 MB
**Average Size:** N/A

---

**Maintained by:** Prompt 15 (Visual Content Suggester) and Prompt 16 (Image Manager)
**Last validated:** [DATE] by Prompt 8 (Consistency Checker)
