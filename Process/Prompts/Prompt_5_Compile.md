# Execute Prompt 5: Compile Complete Manuscript

**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`

---

## What This Does

I will generate a single compiled Markdown file from all your current content, creating a complete manuscript that you can review or share.

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

2. **Assembly** in order:
   - Front Matter (Title Page, Dedication, Acknowledgments, Foreword, Preface)
   - Table of Contents (auto-generated from headings)
   - All Chapters (in numerical order)
   - Back Matter (Appendices, Glossary, Bibliography, Index)

3. **Processing**:
   - Strip change tracking metadata (unless you want it included)
   - Process cross-references
   - Handle asset references
   - Insert page break markers

4. **Formatting**: Apply chosen format level
   - **Basic**: Simple concatenation, minimal formatting
   - **Formatted**: Proper heading hierarchy, page breaks, consistent spacing
   - **Publication-Ready**: Full formatting, formatted bibliography, index placeholders

5. **Statistics**: Calculate total word count, completion percentage, chapter breakdown

6. **Metadata header**: Add to top of compiled file:
   ```markdown
   # [Working Title]

   **Author:** [Name]
   **Version:** [N.M.P]
   **Compiled:** [Date/Time]
   **Total Word Count:** [count]
   **Completion:** [percentage]%
   **Status:** [Draft/Review/Final]
   ```

7. **Save**: `Drafts/Full_Draft_[YYYY-MM-DD]_v[version].md`

8. **Report**: Compilation statistics, missing content warnings, recommendations

---

## Default Settings

Your current defaults (from Project_Config.md):
- Format: Formatted
- Include Placeholders: Yes
- Include Change Tracking: No

These can be updated in `Project_Config.md` or customized per compilation.

---

## Important Notes

- **Original files unchanged**: Compilation creates a NEW file in Drafts/
- **Placeholders**: Sections marked as `[PLACEHOLDER: Content pending]` if incomplete
- **Not exported**: This creates a Markdown file. Use Prompt 7 for DOCX/PDF/EPUB export

---

## Ready to Begin?

**What version number should this compilation be?** (e.g., v1.0.0)

---

*Reference: Process/AI-Assisted_Nonfiction_Authoring_Process.md (Prompt 5)*
