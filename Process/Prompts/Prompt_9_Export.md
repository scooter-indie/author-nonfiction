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
BOOK_TITLE="[from Project_Config.md]"
AUTHOR_NAME="[from Project_Config.md]"

# Create EPUB
"${PANDOC_PATH}" "${DRAFT_FILE}" \
  -o "${OUTPUT_DIR}/${BOOK_TITLE}.epub" \
  --metadata title="${BOOK_TITLE}" \
  --metadata author="${AUTHOR_NAME}" \
  --metadata lang="en-US" \
  --toc \
  --toc-depth=2 \
  --epub-cover-image="FrontMatter/cover.jpg" \
  --css="Style/epub-style.css" \
  --epub-embed-font="Style/fonts/*.ttf" \
  --resource-path=".:Chapters:FrontMatter:BackMatter" \
  --standalone
```

**EPUB Options Explained:**
- `--metadata`: Book metadata (title, author, language)
- `--toc`: Generate table of contents
- `--toc-depth=2`: TOC shows chapters and major sections
- `--epub-cover-image`: Cover image file
- `--css`: Custom CSS for styling
- `--epub-embed-font`: Embed custom fonts
- `--resource-path`: Where to find images
- `--standalone`: Create complete EPUB file

### Step 5: Generate DOCX (if requested)

```bash
"${PANDOC_PATH}" "${DRAFT_FILE}" \
  -o "${OUTPUT_DIR}/${BOOK_TITLE}.docx" \
  --reference-doc="Style/reference.docx" \
  --toc \
  --toc-depth=2 \
  --resource-path=".:Chapters:FrontMatter:BackMatter"
```

**DOCX Options:**
- `--reference-doc`: Custom Word template for styling
- `--toc`: Generate table of contents
- `--resource-path`: Where to find images

### Step 6: Generate PDF (if requested)

**Option A: Via LaTeX (best quality):**

```bash
"${PANDOC_PATH}" "${DRAFT_FILE}" \
  -o "${OUTPUT_DIR}/${BOOK_TITLE}.pdf" \
  --pdf-engine=xelatex \
  --toc \
  --toc-depth=2 \
  --template="Style/template.latex" \
  --variable documentclass=book \
  --variable geometry:margin=1in \
  --resource-path=".:Chapters:FrontMatter:BackMatter"
```

**Option B: Via Typst (if installed):**

```bash
# Check if typst is available from settings
TYPST_PATH="[from .claude/settings.local.json]"

# First convert to Typst format
"${PANDOC_PATH}" "${DRAFT_FILE}" \
  -o "${OUTPUT_DIR}/${BOOK_TITLE}.typ" \
  --standalone

# Then compile to PDF with Typst
"${TYPST_PATH}" compile "${OUTPUT_DIR}/${BOOK_TITLE}.typ" \
  "${OUTPUT_DIR}/${BOOK_TITLE}.pdf"
```

### Step 7: Copy Assets

```bash
# Copy images to export directory
mkdir -p "${OUTPUT_DIR}/images"
find Chapters -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" | \
  xargs -I {} cp {} "${OUTPUT_DIR}/images/"

# Copy cover image if exists
if [ -f "FrontMatter/cover.jpg" ]; then
  cp "FrontMatter/cover.jpg" "${OUTPUT_DIR}/"
fi
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
- Verify images exist in chapter figures/ directories
- Use relative paths in markdown: `![](figures/image.png)`
- Check `--resource-path` includes all image directories

---

*Reference: Process/AI-Assisted_Nonfiction_Authoring_Process.md (Prompt 7)*
