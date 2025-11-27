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
   - Default: DOCX + PDF + EPUB, Chicago citation, include all elements
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
# Compile and capture output filename
DRAFT_FILE=$(bash Process/Scripts/compile-manuscript.sh publication | grep "^OUTPUT_FILE:" | cut -d' ' -f2)
echo "Using draft: $DRAFT_FILE"
```

**Creates:** `Drafts/[Project-Name]-publication-vNN.md`

---

## Step 4: Generate Exports

**Setup export versioning:**
```bash
# Sanitize project name
PROJECT_NAME=$(echo "${BOOK_TITLE}" | sed 's/ /-/g' | sed 's/[^a-zA-Z0-9-]//g')

# Find next export version (independent from draft versions)
EXISTING=$(ls Manuscript/Exports/${PROJECT_NAME}-v*.* 2>/dev/null | \
  sed 's/.*-v\([0-9]*\)\..*/\1/' | sort -n | uniq | tail -1)
EXPORT_VERSION=$(printf "%02d" $((${EXISTING:-0} + 1)))

OUTPUT_DIR="Manuscript/Exports"
mkdir -p "${OUTPUT_DIR}"
```

**EPUB:**
```bash
pandoc "${DRAFT_FILE}" \
  -o "${OUTPUT_DIR}/${PROJECT_NAME}-v${EXPORT_VERSION}.epub" \
  --metadata title="${BOOK_TITLE}" \
  --metadata author="${AUTHOR_NAME}" \
  --toc --toc-depth=2 \
  --epub-cover-image="Manuscript/images/cover.jpg" \
  --resource-path="Manuscript"
```

**DOCX:**
```bash
# Use project reference.docx if exists, else framework template
if [ -f "Manuscript/Style/reference.docx" ]; then
  REF_DOC="Manuscript/Style/reference.docx"
else
  REF_DOC="Process/Templates/reference.docx"
fi

pandoc "${DRAFT_FILE}" \
  -o "${OUTPUT_DIR}/${PROJECT_NAME}-v${EXPORT_VERSION}.docx" \
  --reference-doc="${REF_DOC}" \
  --resource-path="Manuscript"
```
**NOTE:** The reference.docx controls Word styling (fonts, margins, headings). Customize your copy in `Manuscript/Style/reference.docx` to match publisher requirements.

**PDF (via Typst with Template):**
```bash
# Step 1: Generate content from markdown
pandoc "${DRAFT_FILE}" -o "${OUTPUT_DIR}/content.typ" -t typst

# Step 2: Create main file that imports template and content
cat > "${OUTPUT_DIR}/${PROJECT_NAME}-v${EXPORT_VERSION}.typ" << 'EOF'
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
typst compile "${OUTPUT_DIR}/${PROJECT_NAME}-v${EXPORT_VERSION}.typ" \
  "${OUTPUT_DIR}/${PROJECT_NAME}-v${EXPORT_VERSION}.pdf"

# Cleanup intermediate files
rm -f "${OUTPUT_DIR}/content.typ" "${OUTPUT_DIR}/${PROJECT_NAME}-v${EXPORT_VERSION}.typ"
```
**NOTE:** Template provides professional book layout with title page, headers/footers, and styled headings.

---

## Step 5: Completion

**Note:** Export files are saved directly to `Manuscript/Exports/` with versioned filenames. No additional packaging required.

**Example output files:**
```
Manuscript/Exports/
├── My-Book-Title-v01.epub
├── My-Book-Title-v01.docx
├── My-Book-Title-v01.pdf
├── My-Book-Title-v02.epub
└── ...
```

---

## Output Report

```
✅ Export Complete!

📦 Export Location: Manuscript/Exports/

📚 Files Generated:
- My-Book-Title-v03.epub (2.3 MB)
- My-Book-Title-v03.docx (1.8 MB)
- My-Book-Title-v03.pdf (1.5 MB)

📊 Statistics:
- Export version: #03
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
