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
# Use project reference.docx if exists, else framework template
if [ -f "Manuscript/Style/reference.docx" ]; then
  REF_DOC="Manuscript/Style/reference.docx"
else
  REF_DOC="Process/Templates/reference.docx"
fi

"${PANDOC_PATH}" "${DRAFT_FILE}" \
  -o "${OUTPUT_DIR}/${BOOK_TITLE}.docx" \
  --reference-doc="${REF_DOC}" \
  --toc \
  --toc-depth=2 \
  --resource-path="Manuscript"
```

**DOCX Options:**
- `--reference-doc`: Word template that controls styling (fonts, margins, headings)
- `--toc`: Generate table of contents
- `--resource-path`: Images resolved from Manuscript/images/

---

## DOCX Reference Template

**Template Location:** `Process/Templates/reference.docx` (framework default)
**Project Copy:** `Manuscript/Style/reference.docx` (customizable per-project)

### What the Reference Document Controls

The reference.docx file defines Word styles that pandoc applies to the output:
- **Typography:** Body text font, size, line spacing
- **Headings:** Fonts and sizes for H1-H4
- **Page Layout:** Margins, paper size, orientation
- **Headers/Footers:** Running headers, page numbers
- **Paragraph Styles:** Indentation, spacing, alignment
- **Block Quotes:** Indentation and styling
- **Code Blocks:** Monospace font settings

### Customizing the Template

1. Open `Manuscript/Style/reference.docx` in Microsoft Word
2. Modify the built-in styles (Home > Styles panel):
   - **Normal** - Body text
   - **Heading 1** - Chapter titles
   - **Heading 2** - Section titles
   - **Heading 3** - Subsection titles
   - **Block Text** - Block quotes
   - **Source Code** - Code blocks
3. Adjust Page Layout (Layout tab):
   - Margins, paper size, orientation
4. Set up Headers/Footers (Insert > Header/Footer)
5. Save the document

### Publisher-Specific Templates

Many publishers provide Word templates. To use them:
1. Obtain the publisher's template
2. Copy it to `Manuscript/Style/reference.docx`
3. Run export - pandoc will use their styles

### Resetting to Default

To restore the framework default:
```bash
cp Process/Templates/reference.docx Manuscript/Style/reference.docx
```

---

## Complete PDF Command (via Typst with Template)

**Three-step process using professional book template:**

```bash
# Step 1: Convert markdown to Typst format
"${PANDOC_PATH}" "${DRAFT_FILE}" \
  -o "${OUTPUT_DIR}/content.typ" \
  -t typst

# Step 2: Create main file that imports template
cat > "${OUTPUT_DIR}/${BOOK_TITLE}.typ" << 'EOF'
#import "../../Process/Templates/book-template.typ": *

#show: book.with(
  title: "${BOOK_TITLE}",
  author: "${AUTHOR_NAME}",
)

#title-page("${BOOK_TITLE}", "${AUTHOR_NAME}")
#outline(title: "Contents", depth: 2)
#pagebreak()

#include "content.typ"
EOF

# Step 3: Compile to PDF
"${TYPST_PATH}" compile "${OUTPUT_DIR}/${BOOK_TITLE}.typ" \
  "${OUTPUT_DIR}/${BOOK_TITLE}.pdf"
```

**NOTE:** Do NOT use `--pdf-engine=typst` - it has font fallback issues.

---

## Typst Template Features

**Template Location:** `Process/Templates/book-template.typ`

### Default Settings

| Setting | Default | Description |
|---------|---------|-------------|
| Paper size | US Letter | Standard 8.5" × 11" |
| Body font | Linux Libertine | Professional serif font |
| Font size | 11pt | Standard book size |
| Inside margin | 1.25" | Larger for binding |
| Outside margin | 1" | Standard margin |
| Top/Bottom margin | 1" | Standard margins |

### Template Functions

**`book()`** - Main document wrapper
```typst
#show: book.with(
  title: "My Book Title",
  author: "Author Name",
  date: none,                    // Optional publication date
  paper-size: "us-letter",       // or "a4", "us-trade"
  font-body: "Linux Libertine",  // Body text font
  font-size: 11pt,               // Body text size
  margin-inside: 1.25in,         // Binding margin
  margin-outside: 1in,
)
```

**`title-page()`** - Professional title page
```typst
#title-page(
  "Book Title",
  "Author Name",
  date: "2025",           // Optional
  subtitle: "A Subtitle", // Optional
)
```

**`epigraph()`** - Chapter quotes/epigraphs
```typst
#epigraph(
  "The beginning of wisdom is the definition of terms.",
  attribution: "Socrates",
)
```

**`copyright-page()`** - Standard copyright page
```typst
#copyright-page(
  title: "Book Title",
  author: "Author Name",
  year: "2025",
  publisher: "Publisher Name",
  isbn: "978-0-000-00000-0",
  edition: "First Edition",
)
```

**`dedication-page()`** - Dedication page
```typst
#dedication-page[
  _For my family_
]
```

**`part()`** - Part divider for multi-part books
```typst
#part("The Beginning", number: "I")
```

### Customization Examples

**Trade Paperback Size (6" × 9"):**
```typst
#show: book.with(
  title: "My Book",
  author: "Author",
  paper-size: "us-trade",
  margin-inside: 0.875in,
  margin-outside: 0.75in,
)
```

**A4 Paper:**
```typst
#show: book.with(
  title: "My Book",
  author: "Author",
  paper-size: "a4",
)
```

**Custom Font:**
```typst
#show: book.with(
  title: "My Book",
  author: "Author",
  font-body: "Garamond",
  font-size: 12pt,
)
```

### Using with Custom Fonts

If using custom fonts, specify font path during compilation:
```bash
typst compile \
  --font-path "Manuscript/Style/fonts" \
  "${OUTPUT_DIR}/${BOOK_TITLE}.typ" \
  "${OUTPUT_DIR}/${BOOK_TITLE}.pdf"
```

### Full Example with All Options

```typst
#import "../../Process/Templates/book-template.typ": *

#show: book.with(
  title: "The Complete Guide",
  author: "Jane Author",
  paper-size: "us-letter",
  font-body: "Linux Libertine",
  font-size: 11pt,
)

// Front matter
#title-page(
  "The Complete Guide",
  "Jane Author",
  subtitle: "A Comprehensive Resource",
)

#copyright-page(
  title: "The Complete Guide",
  author: "Jane Author",
  year: "2025",
  publisher: "Self-Published",
)

#dedication-page[
  _For everyone who helped along the way_
]

#outline(title: "Contents", depth: 2)
#pagebreak()

// Main content
#include "content.typ"
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
