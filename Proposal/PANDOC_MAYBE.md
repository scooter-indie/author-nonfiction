# Pandoc EPUB Export - Optional Enhancements

**Status:** Future Consideration
**Target Version:** 0.13.0+
**Created:** 2025-11-21
**Priority:** Low to Medium

---

## Purpose

Document optional enhancements for Pandoc EPUB export that are not critical for initial implementation but could improve the author experience or output quality in future releases.

---

## Enhancement 1: Font Embedding Support

**Priority:** Medium

**Current State:**
EPUBs use reader's default fonts (standard behavior)

**Enhancement:**
Support custom font embedding for books requiring specific typography

**Implementation:**

1. **Create fonts directory during initialization:**

```bash
# In Prompt 1
mkdir -p "Manuscript/Style/fonts"

# Create README
cat > "Manuscript/Style/fonts/README.md" <<'FONTS_EOF'
# Custom Fonts for EPUB

Place custom font files (.ttf or .otf) in this directory to embed them in your EPUB.

## Requirements

- **Formats:** TrueType (.ttf) or OpenType (.otf)
- **Licensing:** Ensure you have rights to embed fonts in EPUB
- **Naming:** Use descriptive names (e.g., OpenSans-Regular.ttf, OpenSans-Bold.ttf)

## Usage

1. Add font files to this directory
2. Reference in `Manuscript/Style/epub.css`:

```css
@font-face {
  font-family: "Custom Font";
  src: url("fonts/YourFont-Regular.ttf");
  font-weight: normal;
  font-style: normal;
}

body {
  font-family: "Custom Font", Georgia, serif;
}
```

3. Export with Prompt 9 - fonts will be automatically embedded

## Font Sources

Free fonts with EPUB-compatible licenses:
- **Google Fonts:** https://fonts.google.com/ (most are OFL licensed)
- **Font Squirrel:** https://www.fontsquirrel.com/fonts/list/find_fonts?filter%5Blicense%5D%5B0%5D=app
- **Adobe Fonts:** https://fonts.adobe.com/ (with Creative Cloud subscription)

## Note

Most EPUBs work fine without custom fonts. Only add fonts if:
- Your book requires specific typography (technical books, design books)
- You want consistent branding across devices
- Publisher requires specific fonts

**Warning:** Embedded fonts increase EPUB file size significantly.
FONTS_EOF
```

2. **Update Prompt 9 to detect and embed fonts:**

```bash
# Check for custom fonts
if [ -d "Manuscript/Style/fonts" ] && [ "$(ls -A Manuscript/Style/fonts/*.ttf 2>/dev/null)" ]; then
  echo "📝 Found custom fonts - will embed in EPUB"
  FONT_ARGS="--epub-embed-font=Manuscript/Style/fonts/*.ttf"

  # Also check for OTF
  if [ "$(ls -A Manuscript/Style/fonts/*.otf 2>/dev/null)" ]; then
    FONT_ARGS="${FONT_ARGS} --epub-embed-font=Manuscript/Style/fonts/*.otf"
  fi
else
  FONT_ARGS=""
fi

# Add to pandoc command
"${PANDOC_PATH}" "${DRAFT_FILE}" \
  -o "${OUTPUT_DIR}/${BOOK_TITLE}.epub" \
  ${FONT_ARGS} \
  ...
```

**Pros:**
- Professional typography control
- Consistent appearance across devices
- Useful for technical or design-focused books

**Cons:**
- Increases EPUB file size (100KB-500KB per font weight)
- Font licensing considerations
- Most readers work fine with default fonts
- Added complexity for authors

**Recommendation:** Implement as opt-in feature with clear documentation

---

## Enhancement 2: Structured Bibliography with BibTeX/CSL

**Priority:** Low

**Current State:**
Free-form markdown bibliography in `BackMatter/Bibliography.md`

**Enhancement:**
Support structured bibliographies using BibTeX format with Pandoc's citeproc for automatic citation formatting

**Implementation:**

1. **Create bibliography directory structure:**

```bash
# In Prompt 1
mkdir -p "Manuscript/BackMatter/Bibliography"

# Create BibTeX file
cat > "Manuscript/BackMatter/Bibliography/references.bib" <<'BIB_EOF'
@book{example2020,
  author = {Last, First},
  title = {Book Title},
  publisher = {Publisher Name},
  year = {2020},
  address = {City},
  isbn = {123-4567890123}
}

@article{example2021,
  author = {Last, First and Last, Second},
  title = {Article Title},
  journal = {Journal Name},
  volume = {10},
  number = {2},
  pages = {123--145},
  year = {2021},
  doi = {10.1234/example}
}
BIB_EOF

# Create formatted bibliography markdown
cat > "Manuscript/BackMatter/Bibliography.md" <<'BIBMD_EOF'
# Bibliography

This bibliography is generated from `Bibliography/references.bib`.

To add citations:
1. Add entries to `Bibliography/references.bib` in BibTeX format
2. Reference in text: `[@citekey]` or `@citekey`
3. Run Prompt 9 with `--citeproc` to generate formatted citations

**Note:** You can also maintain this as a free-form markdown list if you prefer.

---

<!-- GENERATED BIBLIOGRAPHY GOES HERE -->
BIBMD_EOF
```

2. **Update Prompt 9 with citeproc support:**

```bash
# Ask user if they want citation processing
echo "Do you want to use structured citations (BibTeX)? [y/N]"
read -r USE_CITEPROC

if [[ "$USE_CITEPROC" =~ ^[Yy]$ ]] && [ -f "Manuscript/BackMatter/Bibliography/references.bib" ]; then
  CITE_ARGS="--citeproc --bibliography=Manuscript/BackMatter/Bibliography/references.bib"

  # Optional: CSL style file
  if [ -f "Manuscript/Style/citation-style.csl" ]; then
    CITE_ARGS="${CITE_ARGS} --csl=Manuscript/Style/citation-style.csl"
  fi
else
  CITE_ARGS=""
fi

# Add to pandoc command
"${PANDOC_PATH}" "${DRAFT_FILE}" \
  -o "${OUTPUT_DIR}/${BOOK_TITLE}.epub" \
  ${CITE_ARGS} \
  ...
```

3. **Provide CSL style files:**

```bash
# Download popular citation styles during configuration
# Store in Manuscript/Style/
# Examples: chicago-author-date.csl, apa.csl, mla.csl
```

**Pros:**
- Professional citation management
- Consistent formatting across all citations
- Easy to change citation styles (APA, MLA, Chicago, etc.)
- Integration with reference management tools (Zotero, Mendeley)

**Cons:**
- Steeper learning curve for authors unfamiliar with BibTeX
- Requires learning citation key syntax (`[@smith2020]`)
- Overkill for books with simple bibliographies
- Added complexity in workflow

**Recommendation:**
- Keep free-form markdown as default
- Add BibTeX support as advanced opt-in feature
- Document both approaches in USAGE_GUIDE.md

---

## Enhancement 3: Multi-Format Cover Images

**Priority:** Low

**Current State:**
Single cover image: `FrontMatter/cover.jpg`

**Enhancement:**
Support multiple cover image formats and sizes for different export targets

**Implementation:**

```bash
# Directory structure
Manuscript/FrontMatter/covers/
├── cover-epub.jpg        # 1600x2560 - for EPUB
├── cover-print.jpg       # 2550x4200 - for print PDF (300dpi, 8.5x14)
├── cover-thumbnail.jpg   # 400x640 - for web/marketing
└── cover-source.psd      # Original design file (optional)

# Update Prompt 9 to select appropriate cover
if [ -f "Manuscript/FrontMatter/covers/cover-epub.jpg" ]; then
  COVER_PATH="Manuscript/FrontMatter/covers/cover-epub.jpg"
elif [ -f "Manuscript/FrontMatter/cover.jpg" ]; then
  COVER_PATH="Manuscript/FrontMatter/cover.jpg"
fi
```

**Pros:**
- Optimized covers for different formats
- Better print quality with high-res print cover
- Smaller EPUB files with optimized EPUB cover

**Cons:**
- Authors need to manage multiple cover files
- Adds complexity to simple use case
- Most authors only have one cover image

**Recommendation:**
- Not worth the complexity for most users
- Keep single `cover.jpg` approach
- Document recommended specs in USAGE_GUIDE.md

---

## Enhancement 4: Enhanced Figure Captions

**Priority:** Medium

**Current State:**
Figures use markdown image syntax: `![Alt text](figures/image.png)`

**Enhancement:**
Support proper figure syntax with numbered captions and cross-references

**Implementation:**

1. **Document figure syntax in USAGE_GUIDE.md:**

```markdown
## Figures with Captions

Use this syntax for properly numbered figures:

![**Figure 5.1:** Diagram showing the three-stage process of data transformation. The first stage (Collection) gathers raw data, the second stage (Processing) cleans and structures it, and the third stage (Analysis) extracts insights.](figures/process-diagram.png)

- Use bold for "Figure X.Y:" prefix
- Follow with descriptive caption
- Use chapter number for first digit (5 = Chapter 5)
- Use sequential numbering within chapter for second digit

Pandoc will convert this to proper `<figure>` and `<figcaption>` tags in EPUB.
```

2. **Add figure validation in Prompt 8 (Consistency Checker):**

```bash
# Check for figure numbering consistency
# Verify Figure X.Y matches Chapter X
# Warn about skipped numbers or duplicates
# Suggest adding descriptive captions to bare image tags
```

**Pros:**
- Professional figure presentation
- Better accessibility (screen readers)
- Easier to reference figures in text

**Cons:**
- Authors must manually number figures
- Renumbering needed if figures are added/removed
- More verbose syntax

**Recommendation:**
- Document as best practice, not requirement
- Add validation to Prompt 8 as suggestion (not error)
- Don't enforce unless author opts in

---

## Enhancement 5: EPUB Validation Integration

**Priority:** Medium

**Current State:**
No validation of generated EPUB files

**Enhancement:**
Integrate epubcheck validation into Prompt 9 export workflow

**Implementation:**

1. **Add epubcheck detection in configure.md:**

```bash
# Check for epubcheck
if command -v epubcheck &> /dev/null; then
  EPUBCHECK_PATH=$(command -v epubcheck)
  EPUBCHECK_INSTALLED=true
else
  EPUBCHECK_INSTALLED=false
fi

# Write to settings
{
  "epubcheck": {
    "installed": ${EPUBCHECK_INSTALLED},
    "path": "${EPUBCHECK_PATH}",
    "version": "$(epubcheck --version 2>&1 | head -n1)"
  }
}
```

2. **Add validation step in Prompt 9:**

```bash
# After EPUB generation
if [ -f "${OUTPUT_DIR}/${BOOK_TITLE}.epub" ]; then
  echo "✅ EPUB generated successfully"

  # Run epubcheck if available
  if [ "${EPUBCHECK_INSTALLED}" = "true" ]; then
    echo ""
    echo "📋 Running EPUB validation..."

    if epubcheck "${OUTPUT_DIR}/${BOOK_TITLE}.epub"; then
      echo "✅ EPUB validation passed - no errors"
    else
      echo "⚠️  EPUB validation found issues (see above)"
      echo "    Most EPUB readers will still work despite warnings"
      echo "    Check errors before publishing to stores (Amazon, Apple, etc.)"
    fi
  else
    echo ""
    echo "💡 Tip: Install epubcheck to validate EPUB files"
    echo "    https://github.com/w3c/epubcheck"
  fi
fi
```

**Pros:**
- Catch EPUB structure errors before publishing
- Required by some publishing platforms (Amazon KDP, Apple Books)
- Professional quality assurance

**Cons:**
- Requires Java and external tool installation
- Adds time to export process (5-30 seconds)
- May report warnings that don't affect functionality

**Recommendation:**
- Add as optional feature (skip if not installed)
- Document installation in INSTALLATION.md
- Show validation results but don't block export on warnings

---

## Enhancement 6: Kindle-Specific Export

**Priority:** Low

**Current State:**
EPUB export only (can convert to MOBI manually with Calibre)

**Enhancement:**
Direct Kindle format export (KF8/AZW3) using Kindle Previewer or Calibre

**Implementation:**

```bash
# In Prompt 9, after EPUB generation
echo ""
echo "Would you like to convert to Kindle format (MOBI/AZW3)? [y/N]"
read -r CONVERT_KINDLE

if [[ "$CONVERT_KINDLE" =~ ^[Yy]$ ]]; then
  # Check for Calibre's ebook-convert
  if command -v ebook-convert &> /dev/null; then
    echo "📱 Converting to Kindle format..."
    ebook-convert \
      "${OUTPUT_DIR}/${BOOK_TITLE}.epub" \
      "${OUTPUT_DIR}/${BOOK_TITLE}.azw3" \
      --enable-heuristics

    echo "✅ Kindle file created: ${BOOK_TITLE}.azw3"
  else
    echo "⚠️  Calibre not found. Install Calibre for Kindle conversion:"
    echo "    https://calibre-ebook.com/"
    echo ""
    echo "    Or upload EPUB to Amazon KDP - they'll convert automatically"
  fi
fi
```

**Pros:**
- Direct Kindle format for testing/preview
- Convenience for authors publishing to Amazon

**Cons:**
- Amazon KDP auto-converts EPUB anyway
- Requires Calibre installation
- EPUB → MOBI conversion can introduce formatting issues
- Amazon is phasing out MOBI in favor of EPUB

**Recommendation:**
- Skip this feature
- Document that EPUB is sufficient for Amazon KDP
- Mention Calibre as optional tool in documentation

---

## Enhancement 7: Interactive TOC Depth Configuration

**Priority:** Low

**Current State:**
Fixed TOC depth in Prompt 9 (currently depth=2)

**Enhancement:**
Ask user for TOC depth preference during export

**Implementation:**

```bash
# In Prompt 9
echo "Table of Contents depth:"
echo "  1 - Chapters only"
echo "  2 - Chapters and major sections (recommended)"
echo "  3 - Include all subsections"
echo ""
echo "Choose TOC depth [1-3, default: 2]:"
read -r TOC_DEPTH

TOC_DEPTH=${TOC_DEPTH:-2}  # Default to 2

# Use in pandoc command
"${PANDOC_PATH}" "${DRAFT_FILE}" \
  -o "${OUTPUT_DIR}/${BOOK_TITLE}.epub" \
  --toc \
  --toc-depth=${TOC_DEPTH} \
  ...
```

**Pros:**
- Flexibility for different book structures
- Simple books (chapters only) get cleaner TOCs
- Complex books can show detailed structure

**Cons:**
- One more question during export
- Most books work fine with depth=2
- Can be set in Project_Config.md instead

**Recommendation:**
- Store default in Project_Config.md (set during Prompt 1)
- Allow override in Prompt 9 via customization option
- Don't ask every time

---

## Enhancement 8: Batch Export (Multiple Formats)

**Priority:** Medium

**Current State:**
Export one format at a time (must run Prompt 9 multiple times for EPUB + PDF + DOCX)

**Enhancement:**
Generate multiple formats in single Prompt 9 execution

**Implementation:**

```bash
# In Prompt 9
echo "Select export formats (space-separated):"
echo "  1 - EPUB"
echo "  2 - DOCX"
echo "  3 - PDF (LaTeX)"
echo "  4 - PDF (Typst)"
echo "  5 - All formats"
echo ""
echo "Enter numbers [e.g., 1 2 3]:"
read -r FORMAT_CHOICES

# Parse choices and generate all selected formats
for choice in $FORMAT_CHOICES; do
  case $choice in
    1|5) generate_epub ;;
    2|5) generate_docx ;;
    3|5) generate_pdf_latex ;;
    4) generate_pdf_typst ;;
  esac
done
```

**Pros:**
- Convenience - one command for all formats
- Consistent source across all formats
- Saves time for final exports

**Cons:**
- Longer export time if generating multiple formats
- More complex error handling
- May not need all formats every time

**Recommendation:**
- Implement as "All formats" option (5)
- Keep individual format options for quick iterations
- Show progress for each format during batch export

---

## Enhancement 9: EPUB Theme/Style Presets

**Priority:** Low

**Current State:**
Single default CSS (`epub.css`)

**Enhancement:**
Multiple CSS presets for different book genres/styles

**Implementation:**

```bash
# During Prompt 1 or Prompt 9
echo "Choose EPUB style preset:"
echo "  1 - Classic (serif body, sans headers) - default"
echo "  2 - Modern (sans-serif, clean)"
echo "  3 - Technical (monospace code, tight spacing)"
echo "  4 - Literary (elegant serif, generous margins)"
echo "  5 - Custom (edit epub.css manually)"

# Copy selected preset to Manuscript/Style/epub.css
```

**Pros:**
- Easy styling for non-technical authors
- Genre-appropriate defaults
- Professional appearance out of box

**Cons:**
- Authors can edit CSS directly if needed
- Presets may not fit all books
- Maintenance burden (multiple CSS files)

**Recommendation:**
- Not worth complexity
- Keep single good default CSS
- Document how to customize CSS in USAGE_GUIDE.md
- Authors who want custom styling can edit CSS directly

---

## Enhancement 10: Image Optimization Pipeline

**Priority:** Low

**Current State:**
Images used as-is from chapter `figures/` directories

**Enhancement:**
Automatic image optimization during export (resize, compress, format conversion)

**Implementation:**

```bash
# Requires ImageMagick or similar
for img in images/*.{jpg,png}; do
  # Resize to max 1200px width (sufficient for most e-readers)
  convert "$img" -resize "1200>" -quality 85 "optimized_$img"
done
```

**Pros:**
- Smaller EPUB file sizes
- Faster loading on e-readers
- Consistent image quality

**Cons:**
- Requires ImageMagick installation
- May degrade quality for detailed diagrams
- Authors should optimize images before adding to manuscript
- Adds time to export process

**Recommendation:**
- Skip automatic optimization
- Document image best practices in USAGE_GUIDE.md:
  - Recommended max width: 1200px for EPUB
  - Recommended format: JPG (photos), PNG (diagrams/text)
  - Recommended compression: 80-85% quality
- Let authors use external tools (Photoshop, GIMP, online compressors)

---

## Summary Recommendations

**Implement in v0.13.0:**
- ✅ Enhancement 1: Font embedding support (opt-in)
- ✅ Enhancement 5: EPUB validation integration (opt-in)
- ✅ Enhancement 8: Batch export (multiple formats)

**Document but don't implement:**
- 📄 Enhancement 2: BibTeX/CSL (document as advanced feature, manual setup)
- 📄 Enhancement 4: Figure captions (document as best practice)
- 📄 Enhancement 10: Image optimization (document best practices)

**Skip (not worth complexity):**
- ❌ Enhancement 3: Multi-format cover images
- ❌ Enhancement 6: Kindle-specific export
- ❌ Enhancement 7: Interactive TOC depth (use config file)
- ❌ Enhancement 9: EPUB style presets

---

**End of Document**
