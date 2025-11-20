# Execute Prompt 2: Add New Chapter

**DESKTOP-FRIENDLY:** Works in Claude Desktop with MCP Filesystem + single copy/paste git commit at end

**FIRST ACTION - MANDATORY:**
Use the Read tool to read `Process/Anti-Hallucination_Guidelines.md` in full before proceeding with ANY other actions or questions.

**CRITICAL ENFORCEMENT:**
- **RULE 1:** All file modifications MUST update corresponding _chg files
- **RULE 2:** All Manuscript/ changes must go through appropriate prompts

See: `Process/ENFORCEMENT_RULES.md` for complete details

**DATE CONFIRMATION REQUIRED:**
- **USE CONFIRMED_DATE from session startup** (see CLAUDE.md Date Confirmation Protocol)
- **NEVER use raw `<env>` date** without confirmation
- Pass confirmed date to any spawned agents: "Today's confirmed date is [CONFIRMED_DATE]. Use this date for all operations."

**AGENT INSTRUCTIONS:**
When spawning agents (using Task tool), include in agent prompt:
- "FIRST ACTION: Read Process/Anti-Hallucination_Guidelines.md before proceeding."
- "Today's confirmed date is [CONFIRMED_DATE]. Use this date for all operations."

**Claude Desktop Compatibility:**
- ✅ All file/directory operations via MCP Filesystem (including move_file for renumbering)
- ✅ Single git commit command provided as copy/paste at end
- ✅ No bash commands required during execution
- 📋 Works 95% in Desktop

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
7. **Does this chapter need a different style than the book-level style?** (v0.10.1+)
   - If yes: Select override style and create Chapter_XX_style.md
   - If no: Chapter inherits book-level style from Style_Guide.md

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
9. **If chapter-level style override selected:** Create Chapter_XX_style.md from template (v0.10.1+)
10. **Update Manuscript/Style/Style_Overrides.md** with new chapter entry (v0.10.1+)
11. Create empty figures/ subdirectory: Manuscript/Chapters/Chapter_XX/figures/
12. Add new quote entry to Manuscript/Quotes/Chapter_Quotes.md (Status: ⏳ Pending)
13. Update Manuscript/Quotes/Chapter_Quotes_chg.md with addition note
14. Update cross-references in all files
15. Create git commit for all changes
16. Optionally tag if major milestone
17. Generate impact report (including style override impact if applicable)

---

## Important Notes

- **Manuscript/_TOC_/TOC_chg.md is managed by the AI only** - Do not edit it manually
- After initial project setup, do NOT place complete TOC files in Manuscript/Inbox/
- Individual chapter additions should use this prompt or Prompt 4
- Each chapter gets its own subdirectory to support chapter-specific assets (images, figures, tables)

---

## Git Commit Format (For Claude Desktop Users)

When providing the git commit command at the end, format it like this:

**For Claude Desktop users, provide:**

Go to Claude Code CLI and say:
```
Run: git add Manuscript/Chapters/Chapter_XX/ Manuscript/_TOC_/ Manuscript/Quotes/ && git commit -m 'Add Chapter X: [Title]

[Brief description of chapter content and purpose]

🤖 Generated with Claude Desktop

Co-Authored-By: Claude <noreply@anthropic.com>'
```

**IMPORTANT:**
- The TOC directory is `Manuscript/_TOC_/` (with underscores), not `Manuscript/TOC/`
- Do NOT include `Project_Config.md` - chapter count is tracked in the TOC, not Project_Config.md

**The instruction "Go to Claude Code CLI and say:" must be OUTSIDE the code block.**
**Only the command starting with "Run:" should be inside the code block.**

---

## Ready to Begin?

**How would you like to add the chapter: Interactively or from Inbox content?**

---

*Reference: Process/AI-Assisted_Nonfiction_Authoring_Process.md (Prompt 2)*
