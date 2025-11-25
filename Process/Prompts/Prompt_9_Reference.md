# Prompt 9 Reference Documentation

**Version:** 0.15.0
**Purpose:** Detailed export commands, format options, and troubleshooting

---

## Overview

This reference provides complete export command examples, format-specific options, and troubleshooting. Load when:
- First time using Prompt 9
- Exporting to specific formats
- Troubleshooting export issues
- Customizing export settings

**For core workflow:** See `Prompt_9_Export.md`

---

## Complete EPUB Command

```bash
#!/bin/bash
# Read tool paths from settings
PANDOC_PATH="[from .claude/settings.local.json]"

# Set variables
DRAFT_FILE="Drafts/Full_Draft_[date]_v[version].md"
OUTPUT_DIR="Exports/[CONFIRMED_DATE]"
BOOK_TITLE="[from .config/metadata.json: book.title]"
AUTHOR_NAME="[from .config/metadata.json: book.author]"

# Create EPUB with all options
"${PANDOC_PATH}" "${DRAFT_FILE}" \
  -o "${OUTPUT_DIR}/${BOOK_TITLE}.epub" \
  --metadata title="${BOOK_TITLE}" \
  --metadata author="${AUTHOR_NAME}" \
  --metadata lang="en-US" \
  --metadata publisher="[Publisher Name]" \
  --metadata rights="Copyright © [Year] [Author]. All rights reserved." \
  --toc \
  --toc-depth=2 \
  --epub-cover-image="Manuscript/images/cover.jpg" \
  --css="Manuscript/Style/epub-style.css" \
  --epub-embed-font="Manuscript/Style/fonts/*.ttf" \
  --resource-path="Manuscript" \
  --standalone
```

**EPUB Options Explained:**
- `--metadata`: Book metadata (title, author, language, publisher, rights)
- `--toc`: Generate table of contents
- `--toc-depth=2`: TOC shows chapters and major sections
- `--epub-cover-image`: Cover image file
- `--css`: Custom CSS for styling
- `--epub-embed-font`: Embed custom fonts
- `--resource-path="Manuscript"`: Images resolved from Manuscript/images/
- `--standalone`: Create complete EPUB file

---

## Complete DOCX Command

```bash
"${PANDOC_PATH}" "${DRAFT_FILE}" \
  -o "${OUTPUT_DIR}/${BOOK_TITLE}.docx" \
  --reference-doc="Manuscript/Style/reference.docx" \
  --toc \
  --toc-depth=2 \
  --resource-path="Manuscript"
```

**DOCX Options:**
- `--reference-doc`: Custom Word template for styling
- `--toc`: Generate table of contents
- `--resource-path`: Images resolved from Manuscript/images/

---

## Complete PDF Command (via Typst)

**Two-step process (Pandoc → Typst → PDF):**

```bash
# Convert markdown to Typst format
"${PANDOC_PATH}" "${DRAFT_FILE}" \
  -o "${OUTPUT_DIR}/${BOOK_TITLE}.typ" \
  --standalone

# Compile to PDF with Typst
"${TYPST_PATH}" compile "${OUTPUT_DIR}/${BOOK_TITLE}.typ" \
  "${OUTPUT_DIR}/${BOOK_TITLE}.pdf"
```

**NOTE:** Do NOT use `--pdf-engine=typst` - it has font fallback issues.

**Advanced: Direct Typst with Custom Template**

```bash
cat > "${OUTPUT_DIR}/${BOOK_TITLE}.typ" <<'TYPST_EOF'
#set document(
  title: "${BOOK_TITLE}",
  author: "${AUTHOR_NAME}",
)

#set page(
  paper: "us-letter",
  margin: (x: 1in, y: 1in),
  numbering: "1",
)

#set text(font: "Linux Libertine", size: 11pt)
#set par(justify: true)

// Title page
#align(center)[
  #text(size: 24pt, weight: "bold")[${BOOK_TITLE}]
  #v(1em)
  #text(size: 16pt)[${AUTHOR_NAME}]
]

#pagebreak()
#outline(title: "Table of Contents", depth: 2)
#pagebreak()

#include "${DRAFT_FILE}"
TYPST_EOF

"${TYPST_PATH}" compile \
  --root "." \
  --font-path "Manuscript/Style/fonts" \
  "${OUTPUT_DIR}/${BOOK_TITLE}.typ" \
  "${OUTPUT_DIR}/${BOOK_TITLE}.pdf"
```

---

## Export Validation

### Verify Files Exist

```bash
ls -lh "${OUTPUT_DIR}"
```

### Test EPUB Structure

```bash
# EPUB is a zip file - verify valid
unzip -t "${OUTPUT_DIR}/${BOOK_TITLE}.epub"
```

### Check File Sizes

| Format | Typical Size | Warning If |
|--------|--------------|------------|
| EPUB | 1-10 MB | > 50 MB |
| DOCX | 1-5 MB | > 20 MB |
| PDF | 2-15 MB | > 50 MB |

---

## Export README Template

```markdown
# Export Information

**Book Title:** ${BOOK_TITLE}
**Author:** ${AUTHOR_NAME}
**Export Date:** [CONFIRMED_DATE]
**Source Version:** v[version]

## Files Included

- ${BOOK_TITLE}.epub - E-book format
- ${BOOK_TITLE}.docx - Microsoft Word format
- ${BOOK_TITLE}.pdf - PDF format
- images/ - All embedded images
- README.md - This file

## Format Details

**EPUB:**
- Contains table of contents
- Embedded fonts and styling
- Optimized for e-readers

**DOCX:**
- Formatted with reference template
- Suitable for publisher submission
- Editable in Microsoft Word

**PDF:**
- Generated via Typst
- Print-ready quality
- Fixed layout

## Source

Generated from: Drafts/Full_Draft_[date]_v[version].md

🤖 Generated with Claude Code
```

---

## Troubleshooting

### Pandoc Not Found

**Error:** `pandoc: command not found`

**Solution:**
1. Run `execute configure.md` to detect pandoc
2. Or install manually:
   - Windows: `winget install pandoc`
   - macOS: `brew install pandoc`
   - Linux: `sudo apt install pandoc`

### Missing Cover Image

**Error:** `epub-cover-image: file not found`

**Solution:**
- Add cover to `Manuscript/images/cover.jpg`
- Or remove `--epub-cover-image` option

### Large File Size

**Issue:** EPUB file > 50MB

**Causes:**
- High-resolution images
- Many images

**Solutions:**
- Optimize images before export
- Use `--epub-embed-font=false`
- Convert to web-optimized JPG

### Images Not Displaying

**Issue:** Images missing in output

**Solutions:**
1. Verify images in `Manuscript/images/`
2. Use relative paths: `![](../images/fig-XX-YY.ext)`
3. Ensure `--resource-path="Manuscript"` is set
4. Run Prompt 16 Mode 4 before export

### Typst Not Found

**Error:** `typst: command not found`

**Solution:**
Install Typst:
- Windows: `winget install Typst.Typst`
- macOS: `brew install typst`
- Linux: Download from https://github.com/typst/typst/releases

---

## Format Comparison

| Feature | EPUB | DOCX | PDF |
|---------|------|------|-----|
| Reflowable | ✓ | ✓ | ✗ |
| Fixed layout | ✗ | ✗ | ✓ |
| Print-ready | ✗ | ✓ | ✓ |
| E-reader | ✓ | ✗ | ✗ |
| Editable | ✗ | ✓ | ✗ |
| Fonts embedded | ✓ | ✓ | ✓ |

---

## Citation Style Commands

**APA:**
```bash
--csl="Process/Templates/apa.csl"
```

**MLA:**
```bash
--csl="Process/Templates/mla.csl"
```

**Chicago:**
```bash
--csl="Process/Templates/chicago.csl"
```

**Harvard:**
```bash
--csl="Process/Templates/harvard.csl"
```

---

**Version:** 0.15.0
**For Core Workflow:** See `Prompt_9_Export.md`
