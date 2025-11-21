# Execute Prompt 9: Export and Format

**CLI-ONLY:** This prompt requires Claude Code CLI for format conversion (pandoc, imagemagick).

Exporting to DOCX/PDF/EPUB requires external tools (pandoc) that are best run via CLI. While Markdown export could work in Desktop, the full export workflow is optimized for CLI.

**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`

**CRITICAL ENFORCEMENT:**
- **RULE 1:** All file modifications MUST update corresponding _chg files
- **RULE 2:** All Manuscript/ changes must go through appropriate prompts

See: `Process/ENFORCEMENT_RULES.md` for complete details

**NOTE:** This is an export operation. No _chg updates are required (creates formatted exports, does not modify source files)

**DATE CONFIRMATION REQUIRED:**
- **USE CONFIRMED_DATE from session startup** (see CLAUDE.md Date Confirmation Protocol)
- **NEVER use raw `<env>` date** without confirmation
- Pass confirmed date to any spawned agents: "Today's confirmed date is [CONFIRMED_DATE]. Use this date for all operations."

---

## What This Does

I will export your manuscript to various formats (DOCX, PDF, EPUB, LaTeX) suitable for publication, submission, or distribution.

---

## How This Works

I'll use your default export settings (from `.config/project.json`) or you can customize for this export.

### Pre-Export Checklist

**Before exporting, you should have:**
- ✓ Run Prompt 8 (Consistency Checker) and fixed issues
- ✓ Run Prompt 10 (Progress Dashboard) to verify completion
- ✓ Run Prompt 16 Mode 4 (Validate Image References) to check images
- ✓ Resolved all `[CITATION NEEDED]` markers
- ✓ Completed all placeholder sections
- ✓ Verified all images are in Manuscript/images/ directory (v0.12.5+)

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

Your current defaults (from .config/project.json):
- Format: DOCX
- Citation Style: Chicago
- Include: Cover, TOC, Page numbers
- Image Handling: High resolution, include all

These can be updated in `.config/project.json` or customized per export.

---

## Important Notes

- **Export requires complete content**: Placeholder sections will be flagged
- **Citation markers must be resolved**: All `[CITATION NEEDED]` should have proper citations
- **Assets must exist**: Referenced images must be in Manuscript/images/ directory (v0.12.5+)
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

## Implementation Workflow

### Step 1: Check Tool Availability

I will check `.claude/settings.local.json` for tool configuration:

```bash
# Check if pandoc is configured
cat .claude/settings.local.json
```

**If pandoc.installed = false or not found:**
- Inform you that pandoc is required for DOCX/PDF/EPUB export
- Provide installation instructions
- Offer to continue with markdown-only export

**If pandoc.installed = true:**
- Use `pandoc.path` from settings for all pandoc commands
- Verify pandoc is working: `"${PANDOC_PATH}" --version`

### Step 2: Compile Source Manuscript

Use Prompt 7 workflow to generate compiled markdown:

```bash
# This creates: Drafts/Full_Draft_[date]_v[version].md
```

**Source file will be:** `Drafts/Full_Draft_[CONFIRMED_DATE]_v[version].md`

### Step 3: Create Export Directory

```bash
# Create export directory with timestamp
mkdir -p "Exports/[CONFIRMED_DATE]"
```

### Step 4: Generate EPUB

**Basic EPUB command:**

```bash
pandoc "Drafts/Full_Draft_[date]_v[version].md" \
  -o "Exports/[date]/[book-title].epub" \
  --metadata title="[Book Title]" \
  --metadata author="[Author Name]" \
  --toc \
  --toc-depth=2 \
  --epub-cover-image="[cover-path]" \
  --css="[style-path]"
```

**With all options:**

```bash
#!/bin/bash
# Read tool paths from settings
PANDOC_PATH="[from .claude/settings.local.json]"

# Set variables
DRAFT_FILE="Drafts/Full_Draft_[date]_v[version].md"
OUTPUT_DIR="Exports/[CONFIRMED_DATE]"
BOOK_TITLE="[from .config/metadata.json: book.title]"
AUTHOR_NAME="[from .config/metadata.json: book.author]"

# Create EPUB
"${PANDOC_PATH}" "${DRAFT_FILE}" \
  -o "${OUTPUT_DIR}/${BOOK_TITLE}.epub" \
  --metadata title="${BOOK_TITLE}" \
  --metadata author="${AUTHOR_NAME}" \
  --metadata lang="en-US" \
  --metadata publisher="[Publisher Name or Self-Published]" \
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
- `--epub-cover-image`: Cover image file (Manuscript/images/cover.jpg)
- `--css`: Custom CSS for styling (epub-style.css from templates)
- `--epub-embed-font`: Embed custom fonts
- `--resource-path="Manuscript"`: Images resolved from Manuscript/images/ (v0.12.5+)
- `--standalone`: Create complete EPUB file

### Step 5: Generate DOCX (if requested)

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
- `--resource-path="Manuscript"`: Images resolved from Manuscript/images/ (v0.12.5+)

### Step 6: Generate PDF (if requested)

**Option A: Via LaTeX (best quality):**

```bash
"${PANDOC_PATH}" "${DRAFT_FILE}" \
  -o "${OUTPUT_DIR}/${BOOK_TITLE}.pdf" \
  --pdf-engine=xelatex \
  --toc \
  --toc-depth=2 \
  --template="Manuscript/Style/template.latex" \
  --variable documentclass=book \
  --variable geometry:margin=1in \
  --resource-path="Manuscript"
```

**Option B: Via Typst (if installed):**

Typst is a modern, fast alternative to LaTeX with simpler syntax and faster compilation.

**Method 1: Pandoc → Typst → PDF (Recommended)**

```bash
# Check if typst is available from settings
TYPST_PATH="[from .claude/settings.local.json]"

# First convert markdown to Typst format
"${PANDOC_PATH}" "${DRAFT_FILE}" \
  -o "${OUTPUT_DIR}/${BOOK_TITLE}.typ" \
  --standalone

# Then compile to PDF with Typst
"${TYPST_PATH}" compile "${OUTPUT_DIR}/${BOOK_TITLE}.typ" \
  "${OUTPUT_DIR}/${BOOK_TITLE}.pdf"
```

**Method 2: Direct Typst with Custom Template**

```bash
# Create Typst document with custom template
cat > "${OUTPUT_DIR}/${BOOK_TITLE}.typ" <<'TYPST_EOF'
#set document(
  title: "${BOOK_TITLE}",
  author: "${AUTHOR_NAME}",
  date: auto,
)

#set page(
  paper: "us-letter",
  margin: (x: 1in, y: 1in),
  numbering: "1",
)

#set text(
  font: "Linux Libertine",
  size: 11pt,
  lang: "en",
)

#set par(
  justify: true,
  leading: 0.65em,
)

#set heading(
  numbering: "1.1",
)

// Title page
#align(center)[
  #text(size: 24pt, weight: "bold")[${BOOK_TITLE}]
  #v(1em)
  #text(size: 16pt)[${AUTHOR_NAME}]
  #v(2em)
]

#pagebreak()

// Table of contents
#outline(
  title: "Table of Contents",
  depth: 2,
)

#pagebreak()

// Import the markdown content
#include "${DRAFT_FILE}"

TYPST_EOF

# Compile to PDF
"${TYPST_PATH}" compile \
  --root "." \
  --font-path "Manuscript/Style/fonts" \
  "${OUTPUT_DIR}/${BOOK_TITLE}.typ" \
  "${OUTPUT_DIR}/${BOOK_TITLE}.pdf"
```

**Method 3: Direct Markdown with Typst**

Typst can read markdown directly (experimental):

```bash
# Compile markdown directly to PDF with Typst
"${TYPST_PATH}" compile \
  --root "." \
  --input title="${BOOK_TITLE}" \
  --input author="${AUTHOR_NAME}" \
  "${DRAFT_FILE}" \
  "${OUTPUT_DIR}/${BOOK_TITLE}.pdf"
```

**Typst Options:**
- `--root`: Set root directory for imports
- `--font-path`: Custom font directory
- `--input`: Pass variables to template
- `compile`: Compile to PDF
- Much faster than LaTeX (typically 10-100x)
- Better error messages
- Modern syntax

**Typst vs LaTeX:**
- ✅ **Typst**: Faster, simpler, better errors, modern
- ✅ **LaTeX**: More mature, more packages, industry standard
- **Choose Typst for**: Speed, simplicity, modern workflows
- **Choose LaTeX for**: Publisher requirements, complex layouts

### Step 7: Copy Assets

```bash
# Copy images to export directory (v0.12.5+ unified directory)
mkdir -p "${OUTPUT_DIR}/images"
cp Manuscript/images/* "${OUTPUT_DIR}/images/" 2>/dev/null || true

# Verify image count
IMAGE_COUNT=$(ls -1 "${OUTPUT_DIR}/images" 2>/dev/null | wc -l)
echo "Copied ${IMAGE_COUNT} images to export directory"

# Note: Cover image (Manuscript/images/cover.jpg) is already included above
# No separate copy needed since all images are in one directory
```

### Step 8: Create Export README

```bash
cat > "${OUTPUT_DIR}/README.md" <<EOF
# Export Information

**Book Title:** ${BOOK_TITLE}
**Author:** ${AUTHOR_NAME}
**Export Date:** [CONFIRMED_DATE]
**Source Version:** v[version]

## Files Included

- ${BOOK_TITLE}.epub - E-book format
- ${BOOK_TITLE}.docx - Microsoft Word format (if generated)
- ${BOOK_TITLE}.pdf - PDF format (if generated)
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
- Generated via [LaTeX/Typst]
- Print-ready quality
- Fixed layout

## Source

Generated from: Drafts/Full_Draft_[date]_v[version].md

🤖 Generated with [Claude Code](https://claude.com/claude-code)
EOF
```

### Step 9: Validation

After export, I will:

1. **Verify files exist:**
   ```bash
   ls -lh "${OUTPUT_DIR}"
   ```

2. **Check file sizes:**
   - EPUB should be reasonable size (< 50MB typically)
   - Warn if files are unexpectedly large/small

3. **Test EPUB structure** (if possible):
   ```bash
   # EPUB is a zip file - verify it's valid
   unzip -t "${OUTPUT_DIR}/${BOOK_TITLE}.epub"
   ```

### Step 10: Report Results

I will display:

```
✅ Export Complete!

📦 Export Location: Exports/[date]/

📚 Files Generated:
- [Book Title].epub (2.3 MB)
- [Book Title].docx (1.8 MB) [if requested]
- [Book Title].pdf (4.5 MB) [if requested]
- images/ (15 files)
- README.md

📊 Statistics:
- Word count: [N] words
- Chapters: [N]
- Images: [N]
- Export time: [N] seconds

🎯 Next Steps:
1. Test EPUB in e-reader (Calibre, Apple Books, Kindle Previewer)
2. Review DOCX formatting before submission
3. Verify all images display correctly
4. Check table of contents navigation

💡 Tips:
- Use Calibre to convert EPUB → MOBI for Kindle
- Test EPUB on multiple devices before publishing
- Keep source Markdown for future updates
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
- Add cover image to `FrontMatter/cover.jpg`
- Or skip cover with: remove `--epub-cover-image` option

### Large File Size

**Issue:** EPUB file is very large (> 50MB)

**Causes:**
- High-resolution images embedded
- Many images included

**Solutions:**
- Optimize images before export
- Use `--epub-embed-font=false` if not needed
- Convert images to web-optimized JPG

### Images Not Displaying

**Issue:** Images missing in EPUB

**Solutions:**
- Verify images exist in Manuscript/images/ directory (v0.12.5+)
- Use relative paths in markdown: `![](../images/fig-XX-YY-name.ext)`
- Ensure `--resource-path="Manuscript"` is set correctly
- Run Prompt 16 Mode 4 (Validate) to check all image references before export

### Typst Not Found

**Error:** `typst: command not found`

**Solution:**
1. Run `execute configure.md` to detect typst
2. Or install manually:
   - Windows: `winget install typst`
   - macOS: `brew install typst`
   - Linux: See https://github.com/typst/typst#installation
3. Or use LaTeX instead (Option A in Step 6)

### Typst Compilation Errors

**Error:** `error: failed to compile`

**Common causes:**
- Invalid Typst syntax in template
- Missing fonts specified in template
- Path issues with `--root` or `--font-path`

**Solutions:**
- Check Typst error message (much clearer than LaTeX!)
- Verify font files exist in `Style/fonts/`
- Use Method 1 (Pandoc → Typst) for simplest workflow
- Test with basic template first

### LaTeX Not Found

**Error:** `xelatex: command not found`

**Solution:**
1. Install LaTeX distribution:
   - Windows: MiKTeX or TeX Live
   - macOS: MacTeX (`brew install --cask mactex`)
   - Linux: TeX Live (`sudo apt install texlive-full`)
2. Or use Typst instead (faster, easier to install)

---

*Reference: Process/AI-Assisted_Nonfiction_Authoring_Process.md (Prompt 7)*
