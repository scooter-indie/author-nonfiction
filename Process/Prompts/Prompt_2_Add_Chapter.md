# Execute Prompt 2: Add New Chapter

**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`

---

## What This Does

I will help you add a new chapter to your book, which includes:
- Inserting the chapter at the correct position
- Renumbering affected chapters
- Creating new chapter files with change tracking
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
2. Which file in Inbox/ contains the chapter content?
3. Where should it be positioned?
4. Should I use the content as-is or create a placeholder with the content in Research/?

**Then I'll:**

1. Create git commit of current state (safety)
2. Validate insertion point
3. Analyze impact (which files need renumbering)
4. Update TOC/TOC.md
5. AI updates TOC/TOC_chg.md (you should NOT edit this file manually)
6. Rename affected chapter files
7. Create new chapter files (Chapter_XX.md and Chapter_XX_chg.md)
8. Add new quote entry to Quotes/Chapter_Quotes.md (Status: ⏳ Pending)
9. Update Quotes/Chapter_Quotes_chg.md with addition note
10. Update cross-references in all files
11. Update Project_Config.md with new chapter count
12. Create git commits for all changes
13. Optionally tag if major milestone
14. Generate impact report

---

## Important Notes

- **TOC/TOC_chg.md is managed by the AI only** - Do not edit it manually
- After initial project setup, do NOT place complete TOC files in Inbox/
- Individual chapter additions should use this prompt or Prompt 4

---

## Ready to Begin?

**How would you like to add the chapter: Interactively or from Inbox content?**

---

*Reference: Process/AI-Assisted_Nonfiction_Authoring_Process.md (Prompt 2)*
