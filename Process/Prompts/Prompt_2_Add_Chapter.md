# Execute Prompt 2: Add New Chapter

**Version:** 0.13.0
**DESKTOP-FRIENDLY:** Works in Claude Desktop with MCP Filesystem + single copy/paste git commit at end

**FIRST ACTION - MANDATORY:**
Reference `Process/Prompts/Prompt_Essentials.md` (loaded once per session via /fw-init)

**Quick references available in Prompt_Essentials:**
- Lock Management (acquire/release protocol)
- Anti-Hallucination Rules (ASK FIRST verification)
- Git Commit Format (CLI and Desktop templates)
- Style Resolution (hierarchical system)
- Date Handling (CONFIRMED_DATE protocol)
- Semantic Versioning
- Change Tracking Format

**Load full modules only if encountering edge cases:**
- Lock Management: Process/_COMMON/18_Lock_Management_Module.md
- Anti-Hallucination: Process/Anti-Hallucination_Guidelines.md

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
- Updating the TOC
- Updating all cross-references
- Committing changes to git
- Note: Images go in Manuscript/images/ (unified directory, v0.12.7+), not per-chapter

---

## How This Works

### Step 0: Lock Management

**Initialize Lock System:**

1. Check if `.locks/` directory exists
   - If not: Create `.locks/` directory using bash: `mkdir -p .locks`
   - **CRITICAL:** Use `mkdir -p` (bash/sh command), NOT Windows CMD syntax (`if not exist`)


2. Check if `.locks/locks.json` exists
   - If not: Create with empty structure:
     ```json
     {
       "locks": []
     }
     ```

**Generate Instance ID:**

Create unique instance identifier for this session:
- Format: `CLI-[5-digit-random]` or `Desktop-[5-digit-random]`
- Example: `CLI-12345`, `Desktop-67890`
- Reuse same ID for all locks in this session

**Acquire Locks:**

Resources needed for this prompt: `Chapter_XX` (new chapter), `ProjectConfig`

**For each resource:**

1. Read `.locks/locks.json`

2. Check if resource is locked:
   - Search `locks` array for entry where `"resource"` matches

3. **If lock exists:**
   - Calculate age: `current_time - lock.timestamp`

   - **If age < 15 minutes:**
     ```
     ⚠️ [Resource] is currently locked by another instance.

     Lock details:
     - Resource: [resource]
     - Locked at: [timestamp] ([X] minutes ago)
     - Instance: [instance]

     Another chapter operation may be in progress.

     Options:
     1. Wait for lock to clear (checks every 5 seconds)
     2. Cancel operation

     Choose option (1-2):
     ```

   - **If age >= 15 minutes:**
     ```
     ⚠️ [Resource] has a stale lock (older than 15 minutes).

     Lock details:
     - Resource: [resource]
     - Locked at: [timestamp] ([X] minutes ago)
     - Instance: [instance]

     This lock may be from a crashed instance.

     Options:
     1. Override stale lock and continue
     2. Cancel operation

     Choose option (1-2):
     ```

4. **If user chooses to wait (Option 1):**
   - Poll every 5 seconds
   - Re-check `.locks/locks.json`
   - If lock cleared: Proceed to acquire
   - If timeout (2 minutes): Ask to cancel or override

5. **If user cancels:**
   - Exit prompt without changes
   - Release any already-acquired locks

6. **If no lock OR override approved:**
   - Add lock entries:
     ```json
     {
       "resource": "Chapter_XX",
       "timestamp": "[ISO-8601-timestamp]",
       "instance": "[instance_id]"
     },
     {
       "resource": "ProjectConfig",
       "timestamp": "[ISO-8601-timestamp]",
       "instance": "[instance_id]"
     }
     ```
   - Write updated JSON to `.locks/locks.json`
   - Proceed with chapter addition

---

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
   - **Preserve warning header:** "⚠️ WARNING: This file is managed by Prompts 1 and 2. Direct edits may be overwritten. Use Prompt 2 to add/reorder chapters."
   - Add new chapter entry in correct position
   - Update numbering for affected chapters
5. AI updates Manuscript/_TOC_/TOC_chg.md (you should NOT edit this file manually)
6. Rename affected chapter directories in Manuscript/Chapters/
7. Create new chapter subdirectory: Manuscript/Chapters/Chapter_XX/
8. Create chapter files: Chapter_XX.md and Chapter_XX_chg.md
9. **If chapter-level style override selected:** Create Chapter_XX_style.md from template (v0.10.1+)
10. **Update Manuscript/Style/Style_Overrides.md** with new chapter entry (v0.10.1+)
11. Add new quote entry to Manuscript/Quotes/Chapter_Quotes.md (Status: ⏳ Pending)
12. Update Manuscript/Quotes/Chapter_Quotes_chg.md with addition note
13. Update cross-references in all files
14. Create git commit for all changes
15. Optionally tag if major milestone
16. Generate impact report (including style override impact if applicable)

**Note:** Chapter directories NO LONGER include a figures/ subdirectory. All images for the entire book go in the unified `Manuscript/images/` directory (v0.12.7+). Use Prompt 15 (Visual Content Suggester) or Prompt 16 (Image Manager) to add images to chapters.

---

## Important Notes

- **Manuscript/_TOC_/TOC.md has a warning header** at the top to remind users not to edit directly
- **Manuscript/_TOC_/TOC_chg.md is managed by the AI only** - Do not edit it manually
- After initial project setup, do NOT place complete TOC files in Manuscript/Inbox/
- Individual chapter additions should use this prompt or Prompt 4
- If users need to reorder chapters, they should use Prompt 2 to insert at new position (future: Prompt 12 for chapter reordering)
- Each chapter gets its own subdirectory (Chapter_XX/) containing only chapter markdown files
- **Images are NOT stored per-chapter** - all images go in unified `Manuscript/images/` directory (v0.12.7+)

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
- Do NOT update `.config/metadata.json` - chapter count is tracked in the TOC, not config files

**The instruction "Go to Claude Code CLI and say:" must be OUTSIDE the code block.**
**Only the command starting with "Run:" should be inside the code block.**

---

## Release Locks

**CRITICAL:** Release locks even if operation fails or errors occur.

**Release all acquired locks:**

1. Read `.locks/locks.json`

2. Remove lock entries:
   - Filter `locks` array to remove where `"resource": "Chapter_XX"` AND `"instance": "[your_instance_id]"`
   - Filter `locks` array to remove where `"resource": "ProjectConfig"` AND `"instance": "[your_instance_id]"`

3. Write updated JSON to `.locks/locks.json`

**Confirmation:**
```
✓ Locks released: Chapter_XX, ProjectConfig
```

---

## Lock Management Notes

**Concurrency Support (v0.13.0+):**
- This prompt locks `Chapter_XX` (new chapter) and `ProjectConfig` to prevent conflicts
- Locks are held from Step 0 through completion
- Locks are released even if chapter creation fails
- Stale locks (>15 minutes) can be overridden
- See `Process/_COMMON/18_Lock_Management_Module.md` for complete details

---

## Ready to Begin?

**How would you like to add the chapter: Interactively or from Inbox content?**

---

**Version:** 0.13.0
**Last Updated:** 2025-11-23

*Reference: Process/AI-Assisted_Nonfiction_Authoring_Process.md (Prompt 2)*

---

## Session Cleanup

**After this prompt completes:**

Tell user: "✓ Prompt 2 Add Chapter complete.

To free up tokens for your next task, you can say:
**'Clear Prompt 2 Add Chapter from context'**

This will reclaim tokens for your next operation."
