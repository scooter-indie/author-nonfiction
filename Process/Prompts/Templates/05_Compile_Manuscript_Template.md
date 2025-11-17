# Prompt 5: Compile Complete Manuscript

## Instructions to AI Assistant

**BEFORE PROCEEDING:** Read and apply the guidelines in `Process/Anti-Hallucination_Guidelines.md` throughout this entire process.

Execute Prompt 5 from the AI-Assisted Nonfiction Authoring Process (v3.0.0) to generate a single Markdown file from all current content.

## Compilation Parameters

**Version Number:** [FILL IN: e.g., v1.0.0, v2.3.1]

**Include Placeholders:** [FILL IN: Yes/No - Should incomplete sections show placeholder markers?]

**Include Change Tracking Notes:** [FILL IN: Yes/No - Include metadata from _chg files?]

**Format Option:** [FILL IN: Choose ONE]
- [ ] Basic (simple concatenation, minimal formatting)
- [ ] Formatted (proper hierarchy, page breaks, consistent spacing)
- [ ] Publication-Ready (full formatting, bibliography, index references)

## Assembly Configuration

**Front Matter to Include:**
- [ ] Title Page
- [ ] Dedication
- [ ] Acknowledgments
- [ ] Foreword
- [ ] Preface

**Table of Contents:**
- [ ] Auto-generate from headings
- [ ] Use existing TOC/TOC.md

**Back Matter to Include:**
- [ ] Appendices
- [ ] Glossary
- [ ] Bibliography
- [ ] Index

## Expected Actions

Please follow the complete Prompt 5 workflow:

1. Validation check (verify all files exist, check references)
2. Assemble in order: Front Matter → TOC → Chapters → Back Matter
3. Process content (strip tracking metadata, process cross-references, handle assets)
4. Generate/insert Table of Contents
5. Handle placeholders according to settings
6. Generate statistics (word counts, completion percentage)
7. Apply formatting based on chosen format option
8. Add metadata header to compiled document
9. Save to `Drafts/Full_Draft_[date]_v[version].md`
10. Generate compilation report

## Output File

**Filename:** `Full_Draft_[YYYY-MM-DD]_v[version].md`

**Location:** `Drafts/` directory

## Additional Instructions

[FILL IN: Any special formatting requirements or sections to exclude]

## Reference Document

Process document: `Process/AI-Assisted_Nonfiction_Authoring_Process.md` (Section: Prompt 5)

---

**Note:** This creates a new compiled file. Original chapter files remain unchanged.
