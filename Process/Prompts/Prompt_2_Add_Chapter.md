# Execute Prompt 2: Add New Chapter

**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`

---

## What This Does

I will help you add a new chapter to your book, which includes:
- Inserting the chapter at the correct position
- Renumbering affected chapter directories
- Creating new chapter subdirectory with files and change tracking
- Creating figures/ subdirectory for chapter images
- Updating the TOC
- Updating all cross-references
- Committing changes to git

---

## How This Works

You can add a chapter in two ways:

### Option A: Interactive (Quick Add)
I'll ask you questions and create the chapter immediately.

### Option B: From Inbox Content
You've already drafted content and placed it in Inbox/. I'll integrate it as a new chapter.

**Questions I'll ask:**

1. Do you want to add interactively or from Inbox content?

**If Interactive:**
2. What is the chapter title?
3. Where should it be positioned? (chapter number or "after Chapter X")
4. What is the estimated word count?
5. What are the key topics to cover? (optional)
6. What is the rationale for adding this chapter?

**If From Inbox:**
2. Which file in Manuscript/Inbox/ contains the chapter content?
3. Where should it be positioned?
4. Should I use the content as-is or create a placeholder with the content in Research/?

**Then I'll:**

1. Create git commit of current state (safety)
2. Validate insertion point
3. Analyze impact (which chapter directories need renumbering)
4. Update Manuscript/_TOC_/TOC.md
5. AI updates Manuscript/_TOC_/TOC_chg.md (you should NOT edit this file manually)
6. Rename affected chapter directories in Manuscript/Chapters/
7. Create new chapter subdirectory: Manuscript/Chapters/Chapter_XX/
8. Create chapter files: Chapter_XX.md and Chapter_XX_chg.md
9. Create empty figures/ subdirectory: Manuscript/Chapters/Chapter_XX/figures/
10. Add new quote entry to Manuscript/Quotes/Chapter_Quotes.md (Status: ⏳ Pending)
11. Update Manuscript/Quotes/Chapter_Quotes_chg.md with addition note
12. Update cross-references in all files
13. Update Project_Config.md with new chapter count
14. Create git commits for all changes
15. Optionally tag if major milestone
16. Generate impact report

---

## Important Notes

- **Manuscript/_TOC_/TOC_chg.md is managed by the AI only** - Do not edit it manually
- After initial project setup, do NOT place complete TOC files in Manuscript/Inbox/
- Individual chapter additions should use this prompt or Prompt 4
- Each chapter gets its own subdirectory to support chapter-specific assets (images, figures, tables)

---

## Ready to Begin?

**How would you like to add the chapter: Interactively or from Inbox content?**

---

*Reference: Process/AI-Assisted_Nonfiction_Authoring_Process.md (Prompt 2)*
