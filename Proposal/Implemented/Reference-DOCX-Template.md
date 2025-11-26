# Proposal: Reference DOCX Template for Word Styling

**Issue:** #44
**Parent:** #29 (Export Modes)
**Status:** Implemented
**Created:** 2025-11-25
**Implemented:** 2025-11-25

---

## Implementation Summary

Used **Option A (Default Template)** - pandoc's default reference document, immediately usable:
- Generated `Process/Templates/reference.docx` via `pandoc --print-default-data-file`
- Updated `scripts/init.sh` to copy template during initialization
- Updated Prompt 9 and Prompt_9_Reference.md with fallback logic and documentation
- Users can customize their copy in `Manuscript/Style/reference.docx`

---

## Problem Statement

Prompt 9 Export references a Word reference document that doesn't exist:

```bash
pandoc "${DRAFT_FILE}" \
  -o "${OUTPUT_DIR}/${BOOK_TITLE}.docx" \
  --reference-doc="Manuscript/Style/reference.docx" \
  --toc --resource-path="Manuscript"
```

Without `reference.docx`, pandoc uses its default styles, producing functional but generic Word documents that lack professional book formatting.

---

## Proposed Solution

Create `Process/Templates/reference.docx` - a professionally styled Word document template that pandoc uses to extract style definitions for DOCX exports.

### How Pandoc Reference Documents Work

Pandoc extracts style definitions from the reference document, including:
- Named styles (Heading 1, Body Text, etc.)
- Page layout (margins, orientation, size)
- Header/footer formatting
- Font configurations
- Paragraph spacing

The content of the reference document is ignored; only styles are used.

---

## Style Specifications

### 1. Page Setup

| Property | Value | Rationale |
|----------|-------|-----------|
| Paper size | US Letter (8.5" x 11") | Standard publishing size |
| Top margin | 1" | Professional standard |
| Bottom margin | 1" | Room for page numbers |
| Inside margin | 1.25" | Extra space for binding |
| Outside margin | 1" | Standard readability |
| Header distance | 0.5" | Space for running header |
| Footer distance | 0.5" | Space for page numbers |

### 2. Body Text Style

| Property | Value | Rationale |
|----------|-------|-----------|
| Font | Georgia or Times New Roman | Professional serif fonts |
| Size | 12pt | Standard manuscript size |
| Line spacing | 1.5 lines | Publisher preference, readability |
| First line indent | 0.5" | Standard paragraph indent |
| Space after | 0pt | No extra space between paragraphs |
| Alignment | Justified | Professional book appearance |

### 3. Heading Styles

#### Heading 1 (Chapter Titles)
| Property | Value |
|----------|-------|
| Font | Arial or Helvetica |
| Size | 24pt |
| Weight | Bold |
| Space before | 72pt (start on new page) |
| Space after | 24pt |
| Alignment | Left or Centered |
| Page break before | Yes |

#### Heading 2 (Section Titles)
| Property | Value |
|----------|-------|
| Font | Arial or Helvetica |
| Size | 16pt |
| Weight | Bold |
| Space before | 24pt |
| Space after | 12pt |

#### Heading 3 (Subsections)
| Property | Value |
|----------|-------|
| Font | Arial or Helvetica |
| Size | 13pt |
| Weight | Bold |
| Space before | 18pt |
| Space after | 6pt |

#### Heading 4 (Minor Headings)
| Property | Value |
|----------|-------|
| Font | Arial or Helvetica |
| Size | 12pt |
| Weight | Bold Italic |
| Space before | 12pt |
| Space after | 6pt |

### 4. Block Quote Style

| Property | Value |
|----------|-------|
| Font | Georgia (same as body) |
| Size | 11pt |
| Style | Italic |
| Left indent | 0.5" |
| Right indent | 0.5" |
| Space before | 12pt |
| Space after | 12pt |

### 5. Header and Footer

**Header (odd pages):**
- Right-aligned book title
- Font: Arial, 10pt, Italic
- Visible from page 3 onward

**Header (even pages):**
- Left-aligned author name
- Font: Arial, 10pt, Italic

**Footer:**
- Center-aligned page number
- Font: Arial, 10pt
- No page number on title page

### 6. Additional Styles

| Style Name | Purpose | Formatting |
|------------|---------|------------|
| Title | Book title on title page | 28pt, Bold, Centered |
| Subtitle | Book subtitle | 16pt, Italic, Centered |
| Author | Author name on title page | 18pt, Centered |
| First Paragraph | After headings (no indent) | Same as Body, no first-line indent |
| Code | Inline code | Courier New, 10pt |
| Code Block | Code blocks | Courier New, 9pt, Gray background |
| Caption | Figure/table captions | 10pt, Italic, Centered |
| TOC 1-3 | Table of contents levels | Appropriate indentation |

---

## File Location Options

### Option A: Framework Templates (Recommended)
```
Process/Templates/reference.docx
```
- Part of framework distribution
- Copied to user's project during Prompt 1
- User can customize their copy

### Option B: User Project Style Directory
```
Manuscript/Style/reference.docx
```
- Created during Prompt 1 initialization
- Immediately customizable per-project
- Current Prompt 9 reference location

**Recommendation:** Use both:
1. Master template in `Process/Templates/reference.docx`
2. Copy to `Manuscript/Style/reference.docx` during Prompt 1
3. Users can customize their project copy

---

## Integration with Prompt 9

### Current Command (needs template)
```bash
pandoc "${DRAFT_FILE}" \
  -o "${OUTPUT_DIR}/${BOOK_TITLE}.docx" \
  --reference-doc="Manuscript/Style/reference.docx" \
  --toc --resource-path="Manuscript"
```

### Fallback Behavior
If `Manuscript/Style/reference.docx` doesn't exist:
1. Check for `Process/Templates/reference.docx`
2. If found, use framework template
3. If not found, use pandoc defaults with warning

### Enhanced Command
```bash
# Check for reference document
if [ -f "Manuscript/Style/reference.docx" ]; then
  REF_DOC="Manuscript/Style/reference.docx"
elif [ -f "Process/Templates/reference.docx" ]; then
  REF_DOC="Process/Templates/reference.docx"
else
  echo "Warning: No reference.docx found, using pandoc defaults"
  REF_DOC=""
fi

pandoc "${DRAFT_FILE}" \
  -o "${OUTPUT_DIR}/${BOOK_TITLE}.docx" \
  ${REF_DOC:+--reference-doc="$REF_DOC"} \
  --toc --resource-path="Manuscript"
```

---

## Creation Method

### Method 1: Pandoc Default Generation (Simplest)

Generate pandoc's default reference document, then customize:

```bash
pandoc -o reference.docx --print-default-data-file reference.docx
```

Then open in Word and modify styles.

### Method 2: Create from Scratch in Word

1. Create new Word document
2. Define all named styles (Heading 1-4, Body Text, etc.)
3. Set page layout
4. Configure headers/footers
5. Save as .docx

### Method 3: Start from Publisher Template

Use a publishing house template as starting point and adapt styles.

**Recommendation:** Method 1 - ensures all pandoc-required styles exist, then customize.

---

## Prompt 1 Integration

Add to Prompt 1 initialization:

```markdown
### Reference Document Setup

Copy framework reference template:
```bash
cp Process/Templates/reference.docx Manuscript/Style/reference.docx
```

Inform user:
"A Word reference document has been created at `Manuscript/Style/reference.docx`.
This controls DOCX export styling. You can customize it in Microsoft Word to match
publisher requirements or personal preferences."
```

---

## Testing Checklist

- [ ] Template includes all required pandoc styles
- [ ] Chapter headings start on new page
- [ ] Body text has proper indentation
- [ ] Block quotes are visually distinct
- [ ] Headers/footers render correctly
- [ ] Page numbers appear correctly
- [ ] Table of contents generates with proper formatting
- [ ] Code blocks have monospace font
- [ ] Images scale appropriately
- [ ] Tables have proper borders and padding

---

## Compatibility Considerations

### Word Versions
- Template should work with Word 2016+
- Test with LibreOffice for compatibility
- Avoid Word-specific features not in OpenDocument

### Publisher Requirements
Common publisher requirements to support:
- Double-spaced option for submissions
- Single-spaced option for final
- Standard margins (1" all around or custom)
- Specific font requirements (TNR 12pt common)

Consider creating multiple templates:
- `reference.docx` - Standard professional
- `reference-submission.docx` - Double-spaced manuscript format
- `reference-minimal.docx` - Clean, minimal styling

---

## Implementation Steps

1. **Generate base template** using pandoc default
2. **Open in Word** and customize all styles per specifications
3. **Configure page layout** (margins, headers, footers)
4. **Set up header/footer** with page numbers
5. **Test export** with sample manuscript
6. **Save to** `Process/Templates/reference.docx`
7. **Update Prompt 1** to copy template during initialization
8. **Update Prompt 9** with fallback logic
9. **Document** in USAGE_GUIDE template

---

## Questions for User

1. **Font preference?** Georgia/Times New Roman (classic) vs Calibri/Arial (modern)?
2. **Line spacing?** 1.5 (readable) vs Double (submission format)?
3. **Chapter title alignment?** Centered vs Left-aligned?
4. **Multiple templates?** Standard + submission format, or single template?

---

## File Structure After Implementation

```
Process/Templates/
├── reference.docx          # Word reference template (NEW)
├── book-template.typ       # Typst PDF template (existing)
├── epub-style.css          # EPUB stylesheet (existing)
└── ...

Manuscript/Style/           # (In user's book project)
├── Style_Guide.md          # Book writing style
├── Style_Overrides.md      # Chapter/section overrides
└── reference.docx          # Copied from templates (NEW)
```

---

## Consistency with Existing Templates

| Format | Template | Location |
|--------|----------|----------|
| EPUB | epub-style.css | Process/Templates/ |
| PDF | book-template.typ | Process/Templates/ |
| DOCX | reference.docx | Process/Templates/ (NEW) |

All export formats now have professional templates in the framework.

---

## References

- [Pandoc Reference Documents](https://pandoc.org/MANUAL.html#option--reference-doc)
- [Word Style Guide](https://support.microsoft.com/en-us/office/customize-or-create-new-styles-d38d6e47-f6fc-48eb-a607-1eb120dec563)
- Issue #45 (Typst Template) - similar approach for PDF
- epub-style.css - existing EPUB template

---

**Next Steps:** Await user approval, then:
1. Generate reference.docx using pandoc defaults
2. Customize styles in Word
3. Update Prompt 1 and Prompt 9
4. Test with sample export
