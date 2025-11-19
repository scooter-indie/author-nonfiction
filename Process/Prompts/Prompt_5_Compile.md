# Execute Prompt 5: Compile Complete Manuscript

**DESKTOP-READY:** 100% compatible with Claude Desktop (zero bash/git required)

**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`

**Claude Desktop Compatibility:**
- ✅ Pure file operations via MCP Filesystem
- ✅ No git commands required
- ✅ No bash commands required
- 📋 Works 100% in Desktop

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

I'll use your default compilation settings (stored in `Project_Config.md`), or you can customize them for this compilation.

### Questions I'll ask:

1. **What version number should this compilation be?** (e.g., v1.0.0, v2.3.1)

2. **Use default compilation settings?**
   - Default: Formatted layout, include placeholders, no change tracking metadata
   - Or: Customize settings now

**If you choose to customize:**
3. Include placeholder markers? (Yes/No)
4. Include change tracking notes? (Yes/No)
5. Format option: Basic | Formatted | Publication-Ready

### Then I'll:

1. **Validation**: Verify all files exist, check for missing cross-references

2. **Read Chapter Quotes**: Load Manuscript/Quotes/Chapter_Quotes.md and prepare epigraphs

3. **Assembly** in order:
   - Front Matter from Manuscript/FrontMatter/ (Title Page, Dedication, Acknowledgments, Foreword, Preface)
   - Table of Contents (auto-generated from headings)
   - All Chapters from Manuscript/Chapters/ (in numerical order, with epigraphs inserted)
   - Back Matter from Manuscript/BackMatter/ (Appendices, Glossary, Bibliography, Index)

4. **Processing**:
   - Strip change tracking metadata (unless you want it included)
   - Insert chapter epigraphs (if Status ✓ or ⚠ in Chapter_Quotes.md)
   - Process cross-references
   - Handle asset references
   - Insert page break markers

5. **Epigraph Formatting**: For each chapter with a quote:
   ```markdown
   # Chapter X: [Title]

   > [Quote text]
   >
   > — [Author], *[Source]* ([Year])

   [Chapter content begins...]
   ```

6. **Formatting**: Apply chosen format level
   - **Basic**: Simple concatenation, minimal formatting
   - **Formatted**: Proper heading hierarchy, page breaks, consistent spacing
   - **Publication-Ready**: Full formatting, formatted bibliography, index placeholders

7. **Statistics**: Calculate total word count, completion percentage, chapter breakdown, quote status

8. **Metadata header**: Add to top of compiled file:
   ```markdown
   # [Working Title]

   **Author:** [Name]
   **Version:** [N.M.P]
   **Compiled:** [Date/Time]
   **Total Word Count:** [count]
   **Completion:** [percentage]%
   **Status:** [Draft/Review/Final]
   ```

9. **Save**: `Manuscript/Drafts/Full_Draft_[YYYY-MM-DD]_v[version].md`

10. **Report**: Compilation statistics including:
    - Total word count
    - Completion percentage
    - Chapters with/without epigraphs
    - Epigraphs with Status ⏳ (pending verification)
    - Missing content warnings
    - Recommendations

---

## Default Settings

Your current defaults (from Project_Config.md):
- Format: Formatted
- Include Placeholders: Yes
- Include Change Tracking: No

These can be updated in `Project_Config.md` or customized per compilation.

---

## Important Notes

- **Original files unchanged**: Compilation creates a NEW file in Manuscript/Drafts/
- **Placeholders**: Sections marked as `[PLACEHOLDER: Content pending]` if incomplete
- **Not exported**: This creates a Markdown file. Use Prompt 7 for DOCX/PDF/EPUB export

---

## Ready to Begin?

**What version number should this compilation be?** (e.g., v1.0.0)

---

*Reference: Process/AI-Assisted_Nonfiction_Authoring_Process.md (Prompt 5)*
