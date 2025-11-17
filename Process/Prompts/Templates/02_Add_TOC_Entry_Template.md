# Prompt 2: Add New TOC Entry

## Instructions to AI Assistant

**BEFORE PROCEEDING:** Read and apply the guidelines in `Process/Anti-Hallucination_Guidelines.md` throughout this entire process.

Execute Prompt 2 from the AI-Assisted Nonfiction Authoring Process (v3.0.0) to insert a new chapter or section into the existing structure with automatic reorganization.

## New Chapter Information

**New Chapter Title:** [FILL IN: Title of the new chapter]

**Desired Position:** [FILL IN: Chapter number (e.g., "5") or position reference (e.g., "after Chapter 3")]

**Estimated Word Count:** [FILL IN: Target word count for this chapter]

**Rationale for Addition:** [FILL IN: Why this chapter is needed]

## Key Topics to Cover

[FILL IN: List the main topics/points this chapter should address]

1. [Topic 1]
2. [Topic 2]
3. [Topic 3]
[Add more as needed]

## Expected Actions

Please follow the complete Prompt 2 workflow:

1. Pre-operation git commit (save current state)
2. Validate insertion point and suggest alternatives if needed
3. Perform impact analysis (files affected, renumbering needed)
4. Update TOC/TOC.md with new entry
5. Update TOC/TOC_chg.md with rationale and version increment
6. Reorganize chapter files (rename affected chapters)
7. Create new chapter files with placeholder structure
8. Update all cross-references in existing files
9. Update configuration files with new chapter count
10. Create git commits for all changes
11. Tag if major milestone (optional)
12. Generate impact report

## Additional Guidance

**Create branch for this operation:** [FILL IN: Yes/No - recommend Yes for major reorganizations]

**Branch name (if yes):** [FILL IN: e.g., "add-chapter-[name]"]

## Reference Document

Process document: `Process/AI-Assisted_Nonfiction_Authoring_Process.md` (Section: Prompt 2)

---

**Note:** This is a major structural change. A git commit will be created before any modifications for safety.
