# Proposal: Typst Template for PDF Styling

**Issue:** #45
**Parent:** #29 (Export Modes)
**Status:** Implemented
**Created:** 2025-11-25
**Implemented:** 2025-11-25

---

## Problem Statement

Currently, PDF export uses basic pandoc→typ conversion without custom styling:

```bash
pandoc "${DRAFT_FILE}" -o "${OUTPUT_DIR}/${BOOK_TITLE}.typ" --toc
typst compile "${OUTPUT_DIR}/${BOOK_TITLE}.typ" "${OUTPUT_DIR}/${BOOK_TITLE}.pdf"
```

This produces functional but unstyled PDFs that lack professional book formatting.

---

## Proposed Solution

Create `Process/Templates/book-template.typ` - a professional Typst template that provides:

1. **Title page formatting**
2. **Chapter heading styles**
3. **Page margins for print**
4. **Font configuration**
5. **Header/footer with page numbers**

---

## Template Design

### 1. Page Setup

```typst
#set page(
  paper: "us-letter",
  margin: (
    top: 1in,
    bottom: 1in,
    inside: 1.25in,  // Larger for binding
    outside: 1in,
  ),
  header: context {
    if counter(page).get().first() > 1 {
      align(center, emph(document.title))
    }
  },
  footer: context {
    align(center, counter(page).display("1"))
  },
)
```

### 2. Typography

```typst
#set text(
  font: "Linux Libertine",  // Free, professional serif
  size: 11pt,
  lang: "en",
)

#set par(
  justify: true,
  leading: 0.65em,
  first-line-indent: 1.5em,
)
```

### 3. Heading Styles

```typst
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  v(2em)
  text(size: 24pt, weight: "bold", it.body)
  v(1em)
}

#show heading.where(level: 2): it => {
  v(1.5em)
  text(size: 16pt, weight: "bold", it.body)
  v(0.75em)
}

#show heading.where(level: 3): it => {
  v(1em)
  text(size: 13pt, weight: "bold", it.body)
  v(0.5em)
}
```

### 4. Title Page

```typst
#let title-page(title, author, date: none) = {
  set page(header: none, footer: none)

  v(30%)
  align(center)[
    #text(size: 32pt, weight: "bold", title)

    #v(2em)

    #text(size: 18pt, author)

    #if date != none {
      v(4em)
      text(size: 12pt, date)
    }
  ]
  pagebreak()
}
```

### 5. Chapter Epigraphs (Quotes)

```typst
#let epigraph(quote, attribution) = {
  v(1em)
  block(
    width: 80%,
    inset: (left: 2em),
    [
      #emph(quote)
      #v(0.5em)
      #align(right, [— #attribution])
    ]
  )
  v(2em)
}
```

---

## Integration with Prompt 9

### Option A: Pandoc with Template (Recommended)

Modify the export command to use the template:

```bash
pandoc "${DRAFT_FILE}" \
  -o "${OUTPUT_DIR}/${BOOK_TITLE}.typ" \
  --template="Process/Templates/book-template.typ" \
  --toc \
  -V title="${BOOK_TITLE}" \
  -V author="${AUTHOR_NAME}"

typst compile "${OUTPUT_DIR}/${BOOK_TITLE}.typ" "${OUTPUT_DIR}/${BOOK_TITLE}.pdf"
```

### Option B: Post-Processing Wrapper

If pandoc template support is limited, create a wrapper that:
1. Generates basic `.typ` from pandoc
2. Prepends template configuration
3. Compiles with typst

```bash
# Generate content
pandoc "${DRAFT_FILE}" -o "${OUTPUT_DIR}/content.typ" --toc

# Combine with template
cat Process/Templates/book-template.typ "${OUTPUT_DIR}/content.typ" > "${OUTPUT_DIR}/${BOOK_TITLE}.typ"

# Compile
typst compile "${OUTPUT_DIR}/${BOOK_TITLE}.typ" "${OUTPUT_DIR}/${BOOK_TITLE}.pdf"
```

---

## File Structure

```
Process/Templates/
├── book-template.typ      # Main template (NEW)
├── reference.docx         # Word template (Issue #44)
├── epub-style.css         # EPUB stylesheet (existing)
└── ...
```

---

## Configuration Options

The template should support these variables (passed via pandoc or defined in template):

| Variable | Description | Default |
|----------|-------------|---------|
| `title` | Book title | Required |
| `author` | Author name | Required |
| `date` | Publication date | None |
| `paper` | Page size | "us-letter" |
| `font` | Body font | "Linux Libertine" |
| `font-size` | Body text size | 11pt |
| `margin-inside` | Inside margin (binding) | 1.25in |
| `margin-outside` | Outside margin | 1in |
| `include-toc` | Include table of contents | true |

---

## Print-Ready Considerations

For professional print output:

1. **Bleed area** - Add 0.125in bleed for full-page elements
2. **Gutter** - Inside margin accounts for binding
3. **Orphans/Widows** - Prevent single lines at page breaks
4. **Chapter starts** - Chapters start on recto (right) pages

```typst
#set par(
  justify: true,
  leading: 0.65em,
  first-line-indent: 1.5em,
)

// Prevent orphans and widows
#show par: set block(breakable: true)
```

---

## Font Considerations

**Bundled fonts (no installation required):**
- Linux Libertine (serif, body text)
- Linux Biolinum (sans-serif, headings alternative)

**User-installable alternatives:**
- Garamond (classic book font)
- Palatino (readable serif)
- Source Serif Pro (Google font, free)

Template should gracefully fall back if preferred font unavailable.

---

## Implementation Steps

1. **Create basic template** with page setup and typography
2. **Add heading styles** for chapters and sections
3. **Create title page function**
4. **Add header/footer** with page numbers
5. **Test with sample manuscript**
6. **Update Prompt 9** with template integration
7. **Document in USAGE_GUIDE** template

---

## Testing Checklist

- [ ] Title page renders correctly
- [ ] Chapter headings have proper styling
- [ ] Page numbers appear in footer
- [ ] Margins suitable for print binding
- [ ] Table of contents generates properly
- [ ] Epigraphs/quotes styled correctly
- [ ] Font fallback works when preferred font missing
- [ ] PDF metadata (title, author) embedded

---

## Questions for User

1. **Paper size preference?** US Letter (8.5x11) vs A4 vs Trade paperback (6x9)?
2. **Font preference?** Serif (traditional) vs Sans-serif (modern)?
3. **Page numbers location?** Footer center, footer outside, header outside?
4. **Chapter start pages?** Any page vs always right-hand page?

---

## Estimated Effort

- Template creation: 2-3 hours
- Prompt 9 integration: 1 hour
- Testing and refinement: 1-2 hours
- Documentation: 30 minutes

**Total: ~5-6 hours**

---

## References

- [Typst Documentation](https://typst.app/docs/)
- [Typst Book Template Examples](https://typst.app/universe/search?kind=templates&q=book)
- [Pandoc Typst Writer](https://pandoc.org/MANUAL.html#typst)
- Commit ac636f4 (Typst-only PDF export)

---

**Next Steps:** Await user feedback on design preferences before implementation.
