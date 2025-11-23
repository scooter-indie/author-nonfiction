# Execute Prompt 7: Compile Complete Manuscript

**CLI-ONLY:** This prompt MUST be run in Claude Code CLI, not Claude Desktop.

Compilation involves reading all manuscript files and writing a large compiled draft. Claude Code CLI is optimized for these bulk file operations, regardless of manuscript size.

**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`

**CRITICAL ENFORCEMENT:**
- **RULE 1:** All file modifications MUST update corresponding _chg files
- **RULE 2:** All Manuscript/ changes must go through appropriate prompts

See: `Process/ENFORCEMENT_RULES.md` for complete details

**NOTE:** This is a read-only compilation operation. No _chg updates are required (drafts are generated, source files are not modified)

**DATE CONFIRMATION REQUIRED:**
- **USE CONFIRMED_DATE from session startup** (see CLAUDE.md Date Confirmation Protocol)
- **NEVER use raw `<env>` date** without confirmation
- Pass confirmed date to any spawned agents: "Today's confirmed date is [CONFIRMED_DATE]. Use this date for all operations."

---

## What This Does

I will generate a single compiled Markdown file from all your current content, creating a complete manuscript that you can review or share.

---

## Anti-Hallucination Note

**During compilation, I will NOT generate new content.** This prompt only assembles existing content from your files.

However, if you request additions or modifications during compilation:
- I'll follow the verification protocol detailed in Prompt 3's Anti-Hallucination Verification section
- I'll **ASK first** before adding examples, anecdotes, statistics, or quotes
- I'll use clear labels: REAL vs HYPOTHETICAL vs GENERIC vs [CITATION NEEDED]

---

## How This Works

I'll use the compilation bash script (`Process/Scripts/compile-manuscript.sh`) to efficiently assemble your manuscript.

### Questions I'll ask:

1. **What version number should this compilation be?** (e.g., v1.0.0, v2.3.1)

2. **Format option:**
   - **Basic**: Simple concatenation, minimal formatting
   - **Formatted**: Proper heading hierarchy, page breaks, consistent spacing (default)
   - **Publication-Ready**: Full formatting, ready for export

### Then I'll:

1. **Validation**: Verify all files exist, check for missing cross-references

2. **Run Compilation Script**: Execute `Process/Scripts/compile-manuscript.sh` with parameters:
   ```bash
   bash Process/Scripts/compile-manuscript.sh VERSION CONFIRMED_DATE FORMAT
   ```

   The script will:
   - Read metadata from `.config/metadata.json`
   - Assemble content in order:
     - Front Matter (Copyright, Title Page, Dedication, etc.)
     - Chapters (in numerical order, handles both flat and subdirectory structures)
     - Back Matter (Appendices, Glossary, Bibliography, etc.)
   - Add metadata header with version and compilation timestamp
   - Save to `Manuscript/Drafts/Full_Draft_[YYYY-MM-DD]_v[version].md`
   - Calculate word count and line count statistics

3. **Post-Processing** (optional enhancements):
   - **Insert chapter epigraphs** from `Manuscript/Quotes/Chapter_Quotes.md` (if Status ✓ or ⚠)
   - **Generate Table of Contents** from chapter headings
   - **Process cross-references** and validate internal links
   - **Strip change tracking metadata** (if present in source files)

4. **Epigraph Formatting** (if processed): For each chapter with a quote:
   ```markdown
   # Chapter X: [Title]

   > [Quote text]
   >
   > — [Author], *[Source]* ([Year])

   [Chapter content begins...]
   ```

5. **Statistics Report**: After compilation, I'll display:
   - Total word count
   - Line count
   - Output file path
   - Chapters compiled
   - Format applied
   - (Optional) Epigraph status
   - (Optional) Completion percentage

6. **Metadata header** (added by script):
   ```markdown
   # [Working Title]

   **Author:** [Name]
   **Version:** v[N.M.P]
   **Compiled:** [Date/Time]
   **Format:** [basic|formatted|publication]
   ```

**Output**: `Manuscript/Drafts/Full_Draft_[YYYY-MM-DD]_v[version].md`

---

## Default Settings

Default format: **Formatted** (proper heading hierarchy, page breaks, consistent spacing)

You can choose a different format when running the compilation:
- **Basic**: Fast, simple concatenation
- **Formatted**: Recommended for most uses
- **Publication-Ready**: Includes all formatting for export preparation

---

## Important Notes

- **Bash script execution**: Uses `Process/Scripts/compile-manuscript.sh` for efficient file concatenation
- **Original files unchanged**: Compilation creates a NEW file in `Manuscript/Drafts/`
- **Both structures supported**: Handles flat files (`Chapter_XX.md`) and subdirectory structure (`Chapter_XX/Chapter_XX.md`)
- **Markdown output**: This creates a Markdown file. Use **Prompt 9** for DOCX/PDF/EPUB export
- **Post-processing optional**: Epigraphs, TOC, and cross-reference processing can be added after basic compilation

---

## Ready to Begin?

**What version number should this compilation be?** (e.g., v1.0.0)

---

*Reference: Process/AI-Assisted_Nonfiction_Authoring_Process.md (Prompt 7)*
