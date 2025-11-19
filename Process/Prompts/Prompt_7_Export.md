# Execute Prompt 7: Export and Format

**HYBRID:** Markdown export works in Desktop (80%), format conversion requires Claude Code CLI

**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`

**Claude Desktop Compatibility:**
- ✅ Markdown export via MCP Filesystem (100%)
- ❌ DOCX/PDF/EPUB require pandoc (CLI only)
- ❌ Image optimization requires imagemagick (CLI only)
- 📋 Markdown works 80% in Desktop, other formats need CLI

---

## What This Does

I will export your manuscript to various formats (DOCX, PDF, EPUB, LaTeX) suitable for publication, submission, or distribution.

---

## How This Works

I'll use your default export settings (from `Project_Config.md`) or you can customize for this export.

### Pre-Export Checklist

**Before exporting, you should have:**
- ✓ Run Prompt 6 (Consistency Checker) and fixed issues
- ✓ Run Prompt 8 (Progress Dashboard) to verify completion
- ✓ Resolved all `[CITATION NEEDED]` markers
- ✓ Completed all placeholder sections
- ✓ Verified all images are in chapter figures/ directories (Manuscript/Chapters/Chapter_XX/figures/)

### Questions I'll ask:

1. **Use default export settings?**
   - Default: DOCX format, Chicago citation style, include all elements
   - Or: Customize settings now

**If you choose to customize:**

2. **Target format(s)?** (Select one or more)
   - Markdown (clean, formatted)
   - DOCX (Microsoft Word)
   - PDF
   - EPUB (e-book)
   - LaTeX

3. **Citation style?**
   - APA
   - MLA
   - Chicago
   - Harvard
   - Other

4. **Include elements?**
   - Cover page
   - Table of Contents
   - Index
   - Page numbers
   - Headers/Footers

5. **Image handling?**
   - Include all images
   - Optimize for file size
   - High resolution (print) or low resolution (digital)

### Then I'll:

1. **Pre-Export Validation**:
   - Run consistency checker automatically
   - Verify all cross-references
   - Check for placeholder content (warn if found)
   - Validate all asset references

2. **Compile Source**:
   - Use Prompt 5 workflow to generate single Markdown
   - Apply formatting rules

3. **Format-Specific Processing**:
   - Prepare for target format(s)
   - Apply style mappings
   - Handle images and tables appropriately
   - Format bibliography in chosen citation style

4. **Asset Handling**:
   - Copy images to export package
   - Convert formats if needed
   - Optimize for target medium

5. **Generate Export Package**:
   - Main document file(s) in requested format(s)
   - Assets folder with images/diagrams
   - README with export information
   - Style files if applicable (LaTeX, custom DOCX styles)

6. **Save to Export Directory**: `Manuscript/Exports/[YYYY-MM-DD]/`

---

## Default Settings

Your current defaults (from Project_Config.md):
- Format: DOCX
- Citation Style: Chicago
- Include: Cover, TOC, Page numbers
- Image Handling: High resolution, include all

These can be updated in `Project_Config.md` or customized per export.

---

## Important Notes

- **Export requires complete content**: Placeholder sections will be flagged
- **Citation markers must be resolved**: All `[CITATION NEEDED]` should have proper citations
- **Assets must exist**: Referenced images must be in chapter figures/ directories or Research/Assets/
- **This creates new files**: Original manuscript files are unchanged

---

## Common Export Scenarios

**For Publisher Submission (DOCX):**
- Format: DOCX
- Style: Publisher-specific (or Chicago/MLA)
- High resolution images
- Include all elements

**For E-book Distribution (EPUB):**
- Format: EPUB
- Include cover, TOC, navigation
- Optimized images for digital

**For Print-on-Demand (PDF):**
- Format: PDF via LaTeX
- High resolution images
- Specific page layout (trim size, margins)
- Print-ready formatting

---

## Ready to Begin?

**Use default export settings, or customize for this export?**

---

*Reference: Process/AI-Assisted_Nonfiction_Authoring_Process.md (Prompt 7)*
