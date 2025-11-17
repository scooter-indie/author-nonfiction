# Execute Prompt 4: Integrate Content from Inbox

**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`

---

## What This Does

I will process all files in your `Inbox/` directory and help you integrate them into the appropriate locations in your book project.

---

## How This Works

I'll scan the Inbox directory, analyze what you have, and work with you interactively to integrate each item.

### What I'll Do:

1. **Scan Inbox/**: List all files and analyze their content

2. **Identify file types**:
   - Regular content files (drafts, sections, chapters)
   - Reference materials (research notes, sources)
   - Assets (images, diagrams, charts)
   - **Special rule**: TOC files rejected if project already initialized

3. **Present findings**: Show you what I found and suggest destinations

4. **Interactive decisions**: For each file, I'll ask:
   - Where should this go? (New chapter, existing chapter, research, back matter, etc.)
   - How should it be integrated? (Replace, insert, append, merge)
   - What priority level?

5. **Execute integration**:
   - Create git commit of current state (safety)
   - Perform the integration based on your choices
   - Update change tracking files
   - Update cross-references if needed
   - Create git commits for changes
   - Archive processed files to `Inbox/Processed_[date]/`

6. **Generate report**: Summary of all actions taken

---

## Important Notes

### TOC Files After Initial Setup

**After your project is initialized, I will REJECT entire TOC files placed in Inbox.**

Why? To maintain single source of truth:
- Use **Prompt 2** to add individual chapters interactively
- Use **Prompt 4** (this prompt) to integrate individual chapter content from Inbox
- TOC/TOC_chg.md is AI-managed only - you should not edit it manually

### Integration Options

Depending on the file type, I may suggest:

**For content files:**
- Create new chapter (uses Prompt 2 workflow)
- Insert into existing chapter (uses Prompt 3 workflow)
- Add to front/back matter
- Move to Research/ directory

**For reference materials:**
- Add to Research/Sources/, Research/Notes/, or Research/References/
- Extract bibliography entries
- Link to relevant chapters

**For assets:**
- Organize into Assets/Images/, Assets/Diagrams/, Assets/Tables/, etc.
- Update references in content files

---

## Ready to Begin?

I'll scan your Inbox/ directory now and show you what I find.

**Scanning Inbox/...**

---

*Reference: Process/AI-Assisted_Nonfiction_Authoring_Process.md (Prompt 4)*
