# Execute Prompt 4: Integrate Content from Inbox

**DESKTOP-FRIENDLY:** Works in Claude Desktop with MCP Filesystem (git via Claude Code CLI)

**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`

**Claude Desktop Compatibility:**
- ✅ All file operations via MCP Filesystem (read, write, move_file)
- ✅ Git operations via Claude Code CLI (copy/paste commands at checkpoints)
- 📋 Works 95% in Desktop

---

## What This Does

I will process all files in your `Manuscript/Inbox/` directory and help you integrate them into the appropriate locations in your book project.

---

## Anti-Hallucination Note

**When integrating content from Inbox** that contains examples, anecdotes, statistics, or quotes:
- Follow the verification protocol detailed in Prompt 3's Anti-Hallucination Verification section
- **ASK the user** to verify examples/anecdotes before integration
- **Request sources** for statistics and quotes before adding them
- **Use clear labels**: REAL vs HYPOTHETICAL vs GENERIC vs [CITATION NEEDED]
- **Never assume** inbox content reflects the user's real experiences without confirmation

---

## How This Works

I'll scan the Inbox directory, analyze what you have, and work with you interactively to integrate each item.

### What I'll Do:

1. **Scan Manuscript/Inbox/**: List all files and analyze their content

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
   - Archive processed files to `Manuscript/Inbox/Processed_[date]/`

6. **Generate report**: Summary of all actions taken

---

## Important Notes

### TOC Files After Initial Setup

**After your project is initialized, I will REJECT entire TOC files placed in Manuscript/Inbox/.**

Why? To maintain single source of truth:
- Use **Prompt 2** to add individual chapters interactively
- Use **Prompt 4** (this prompt) to integrate individual chapter content from Manuscript/Inbox/
- Manuscript/_TOC_/TOC_chg.md is AI-managed only - you should not edit it manually

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
- Organize into chapter-specific figures/ directories (Manuscript/Chapters/Chapter_XX/figures/)
- Or into Research/Assets/ for general project assets
- Update references in content files

---

## Ready to Begin?

I'll scan your Manuscript/Inbox/ directory now and show you what I find.

**Scanning Manuscript/Inbox/...**

---

*Reference: Process/AI-Assisted_Nonfiction_Authoring_Process.md (Prompt 4)*
