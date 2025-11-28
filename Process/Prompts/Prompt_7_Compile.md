# Execute Prompt 7: Compile Complete Manuscript

**Version:** 0.15.4
**⚡ Token Efficient:** ~3,000 tokens (75% reduction from v0.14.0)
**CLI-ONLY:** Bulk file operations

**FIRST ACTION - MANDATORY:**
Reference `Process/Prompts/Prompt_Essentials.md` (loaded once per session via /fw-init)

---

## Quick Start

Generates a single compiled Markdown file from all manuscript content. Read-only operation - source files unchanged.

**Output:** `Manuscript/Drafts/[Project-Name]-[format]-vNN.md`

Example: `My-Book-Title-formatted-v03.md`

---

## Workflow (4 Steps)

1. Ask version and format
2. Validate files
3. Run compilation script
4. Report results

---

## Step 1: Questions

**Ask user:**

1. **Format option?**
   - Basic: Simple concatenation
   - Formatted: Proper headings, page breaks (default)
   - Publication-Ready: Full formatting for export

**Note:** Version number is auto-calculated from existing files in Drafts folder.

---

## Step 2: Validation

Before compiling:
- Verify all files exist
- Check for missing cross-references
- Warn about incomplete sections

---

## Step 3: Run Compilation

```bash
bash Process/Scripts/compile-manuscript.sh FORMAT
```

Where FORMAT is `basic`, `formatted`, or `publication`.

**Script assembles:**
1. Front Matter (Copyright, Title, Dedication)
2. Chapters (numerical order)
3. Back Matter (Appendices, Glossary, Bibliography)

**Optional post-processing:**
- Insert verified epigraphs from `Chapter_Quotes.md`
- Generate Table of Contents
- Process cross-references

---

## Step 4: Output

**Metadata header:**
```markdown
# [Working Title]

**Author:** [Name]
**Compile:** #NN
**Compiled:** [Date/Time]
**Format:** [basic|formatted|publication]
```

**Statistics displayed:**
- Total word count
- Line count
- Chapters compiled
- Epigraph status
- Output file path

---

## Epigraph Formatting

For chapters with verified quotes (Status ✓):

```markdown
# Chapter X: [Title]

> [Quote text]
>
> — [Author], *[Source]* ([Year])

[Chapter content begins...]
```

---

## Important Notes

- **Read-only operation**: No _chg updates needed
- **Both structures supported**: Flat files or subdirectory structure
- **Markdown output**: Use Prompt 9 for DOCX/PDF/EPUB export
- **Auto-versioning**: Version number auto-incremented based on existing files

---

📖 **For detailed compilation options:** See `Process/Prompts/Prompt_7_Reference.md`

---

**Version:** 0.15.4
**Last Updated:** 2025-11-24
**Token Efficiency:** 75% reduction

---

## Session Cleanup

Tell user: "✓ Prompt 7 Compile complete.

To free up tokens, say: **'Clear Prompt 7 from context'**"
