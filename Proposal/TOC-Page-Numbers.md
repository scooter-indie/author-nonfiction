# Proposal: TOC Must Have Page Numbers

**Issue:** #57
**Status:** Proposed
**Created:** 2025-11-26
**Scope:** PDF and DOCX exports only

---

## Problem Statement

When exporting manuscripts to PDF and DOCX formats, the Table of Contents should include page numbers for each entry. This is a standard expectation for professional book exports.

### Current State

**PDF Export (Typst):**
- Uses `#outline(title: "Contents", depth: 2)` in Prompt 9
- Typst's `#outline()` function **already includes page numbers by default**
- No changes needed for PDF

**DOCX Export (Pandoc):**
- Current command in Prompt 9:
  ```bash
  pandoc "${DRAFT_FILE}" \
    -o "${OUTPUT_DIR}/${PROJECT_NAME}-v${EXPORT_VERSION}.docx" \
    --reference-doc="${REF_DOC}" \
    --resource-path="Manuscript"
  ```
- **Missing `--toc` flag** - No TOC is generated at all
- The Reference-DOCX-Template proposal (#44) included `--toc` in the specification, but the implemented command omits it

**EPUB Export (Not in scope):**
- Uses `--toc --toc-depth=2`
- EPUBs are reflowable and don't have fixed page numbers (by design)

---

## Proposed Solution

### 1. DOCX Export - Add TOC Generation

Update Prompt 9 DOCX command to include `--toc`:

```bash
pandoc "${DRAFT_FILE}" \
  -o "${OUTPUT_DIR}/${PROJECT_NAME}-v${EXPORT_VERSION}.docx" \
  --reference-doc="${REF_DOC}" \
  --toc --toc-depth=2 \
  --resource-path="Manuscript"
```

**How DOCX TOC Page Numbers Work:**
- Pandoc generates a Word TOC field with page number references
- When the user opens the document in Word, the TOC shows page numbers
- If page numbers show as outdated, user can right-click TOC → "Update Field" → "Update entire table"
- This is standard Word behavior for auto-generated TOCs

### 2. PDF Export - Verify Current Behavior

The Typst template already uses `#outline()` which includes page numbers. Verify this works correctly:

```typst
#outline(title: "Contents", depth: 2)
```

No changes needed - just verification during testing.

---

## Implementation Details

### Files to Modify

1. **Process/Prompts/Prompt_9_Export.md** (lines 110-123)
   - Add `--toc --toc-depth=2` to DOCX pandoc command

2. **Process/Prompts/Prompt_9_Reference.md** (if exists)
   - Update DOCX command documentation

### Code Changes

**Prompt_9_Export.md - DOCX section (around line 110):**

Before:
```bash
pandoc "${DRAFT_FILE}" \
  -o "${OUTPUT_DIR}/${PROJECT_NAME}-v${EXPORT_VERSION}.docx" \
  --reference-doc="${REF_DOC}" \
  --resource-path="Manuscript"
```

After:
```bash
pandoc "${DRAFT_FILE}" \
  -o "${OUTPUT_DIR}/${PROJECT_NAME}-v${EXPORT_VERSION}.docx" \
  --reference-doc="${REF_DOC}" \
  --toc --toc-depth=2 \
  --resource-path="Manuscript"
```

---

## User Experience

### DOCX TOC Behavior

When user opens the exported DOCX:
1. TOC appears after title page (or as configured)
2. Each chapter/section entry shows page number
3. If layout changes, user can update TOC via Word's "Update Field" feature

### PDF TOC Behavior

When user opens the exported PDF:
1. TOC appears on its own page(s)
2. Each chapter/section entry shows page number
3. Page numbers are clickable links (Typst default behavior)

---

## Testing Checklist

- [ ] DOCX export generates TOC
- [ ] DOCX TOC includes page numbers
- [ ] DOCX TOC page numbers are accurate
- [ ] DOCX TOC updates correctly in Word
- [ ] PDF export includes TOC (already working)
- [ ] PDF TOC includes page numbers (already working)
- [ ] PDF TOC entries are clickable links
- [ ] TOC depth shows chapters and sections (depth=2)

---

## Out of Scope

- **EPUB:** Reflowable format, no fixed page numbers
- **Markdown compiled drafts:** Not paginated
- **TOC styling:** Separate concern (handled by reference.docx and book-template.typ)

---

## Acceptance Criteria

1. DOCX exports include a Table of Contents with page numbers
2. PDF exports continue to include TOC with page numbers (verify working)
3. TOC shows chapters (H1) and sections (H2) by default
4. Documentation updated in Prompt 9

---

## References

- Issue #57: TOC Must have page numbers
- Issue #44: Reference DOCX Template (implemented)
- Issue #45: Typst Template Design (implemented)
- [Pandoc --toc documentation](https://pandoc.org/MANUAL.html#option--toc)
- [Typst outline function](https://typst.app/docs/reference/meta/outline/)

---

**Implementation Estimate:** Small change - single flag addition to DOCX command
