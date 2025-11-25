# Execute Prompt 9: Export and Format

**Version:** 0.15.0
**⚡ Token Efficient:** ~4,500 tokens (70% reduction from v0.14.0)
**CLI-ONLY:** Requires pandoc for format conversion

**FIRST ACTION - MANDATORY:**
Reference `Process/Prompts/Prompt_Essentials.md` (loaded once per session via /fw-init)

---

## Quick Start

Exports manuscript to DOCX, PDF, or EPUB formats. Validates content, compiles source, and generates export package.

**Pre-Export Checklist:**
- ✓ Run Prompt 8 (Consistency) and fixed issues
- ✓ Run Prompt 16 Mode 4 (Validate Images)
- ✓ Resolved all `[CITATION NEEDED]` markers
- ✓ Completed all placeholder sections

---

## Workflow (5 Steps)

1. Ask format and settings
2. Check tool availability
3. Compile source manuscript
4. Generate exports
5. Create export package

---

## Step 1: Questions

**Ask user:**

1. **Use default settings?**
   - Default: DOCX, Chicago citation, include all elements
   - Or: Customize now

**If customizing:**

2. **Target format(s)?**
   - Markdown, DOCX, PDF, EPUB

3. **Citation style?**
   - APA, MLA, Chicago, Harvard

4. **Include elements?**
   - Cover page, TOC, Index, Page numbers

5. **Image handling?**
   - Include all, Optimize for size, High/Low resolution

---

## Step 2: Check Tools

```bash
cat .claude/settings.local.json
```

**If pandoc not installed:**
- Inform user pandoc is required
- Provide installation instructions
- Offer markdown-only export

---

## Step 3: Compile Source

```bash
bash Process/Scripts/compile-manuscript.sh VERSION CONFIRMED_DATE FORMAT
```

**Creates:** `Drafts/Full_Draft_[CONFIRMED_DATE]_v[version].md`

---

## Step 4: Generate Exports

**Create export directory:**
```bash
mkdir -p "Exports/[CONFIRMED_DATE]"
```

**EPUB:**
```bash
pandoc "${DRAFT_FILE}" \
  -o "${OUTPUT_DIR}/${BOOK_TITLE}.epub" \
  --metadata title="${BOOK_TITLE}" \
  --metadata author="${AUTHOR_NAME}" \
  --toc --toc-depth=2 \
  --epub-cover-image="Manuscript/images/cover.jpg" \
  --resource-path="Manuscript"
```

**DOCX:**
```bash
pandoc "${DRAFT_FILE}" \
  -o "${OUTPUT_DIR}/${BOOK_TITLE}.docx" \
  --reference-doc="Manuscript/Style/reference.docx" \
  --toc --resource-path="Manuscript"
```
**NOTE:** Word may ask "update fields?" when opening - click No (TOC is already generated).

**PDF (via Typst):**
```bash
pandoc "${DRAFT_FILE}" -o "${OUTPUT_DIR}/${BOOK_TITLE}.typ" --toc
typst compile "${OUTPUT_DIR}/${BOOK_TITLE}.typ" "${OUTPUT_DIR}/${BOOK_TITLE}.pdf"
```
**NOTE:** Do NOT use `--pdf-engine=typst` - it has font fallback issues. Use two-step process above.

---

## Step 5: Export Package

**Copy assets:**
```bash
mkdir -p "${OUTPUT_DIR}/images"
cp Manuscript/images/* "${OUTPUT_DIR}/images/" 2>/dev/null || true
```

**Create README:**
```markdown
# Export Information

**Book:** ${BOOK_TITLE}
**Author:** ${AUTHOR_NAME}
**Date:** [CONFIRMED_DATE]
**Version:** v[version]

## Files
- ${BOOK_TITLE}.epub
- ${BOOK_TITLE}.docx (if generated)
- ${BOOK_TITLE}.pdf (if generated)
- images/
```

---

## Output Report

```
✅ Export Complete!

📦 Export Location: Exports/[date]/

📚 Files Generated:
- [Book Title].epub (2.3 MB)
- [Book Title].docx (1.8 MB)
- images/ (15 files)

📊 Statistics:
- Word count: [N] words
- Chapters: [N]
- Images: [N]

🎯 Next Steps:
1. Test EPUB in e-reader
2. Review DOCX formatting
3. Verify all images display
```

---

## Common Scenarios

**Publisher Submission (DOCX):**
- Format: DOCX with publisher template
- High resolution images
- Chicago/MLA citation style

**E-book (EPUB):**
- Optimized images for digital
- Cover, TOC, navigation
- Embedded fonts

**Print (PDF):**
- High resolution, print-ready
- Specific page layout
- Via Typst (two-step process)

---

📖 **For detailed commands and troubleshooting:** See `Process/Prompts/Prompt_9_Reference.md`

---

**Version:** 0.15.0
**Last Updated:** 2025-11-24
**Token Efficiency:** 70% reduction

---

## Session Cleanup

Tell user: "✓ Prompt 9 Export complete.

To free up tokens, say: **'Clear Prompt 9 from context'**"
