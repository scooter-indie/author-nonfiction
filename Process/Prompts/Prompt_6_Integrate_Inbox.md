# Execute Prompt 6: Integrate Inbox

**Version:** 0.13.0
**DESKTOP-FRIENDLY:** Works in Claude Desktop with MCP Filesystem (git via Claude Code CLI)

**FIRST ACTION - MANDATORY:**
I acknowledge access to lock management and anti-hallucination protocols from FRAMEWORK_CORE.md (loaded at session startup via /fw-init).

**Protocols available:**
- Lock Management: Essential rules in FRAMEWORK_CORE.md, full details in Process/_COMMON/18_Lock_Management_Module.md (load on-demand)
- Anti-Hallucination: Core rules in FRAMEWORK_CORE.md, full protocol in Process/Anti-Hallucination_Guidelines.md (load on-demand)

**Load full modules only if:**
- Encountering edge cases or complex scenarios
- Need detailed troubleshooting guidance
- Require comprehensive protocol details

**CRITICAL ENFORCEMENT:**
- **RULE 1:** All file modifications MUST update corresponding _chg files
- **RULE 2:** All Manuscript/ changes must go through appropriate prompts

See: `Process/ENFORCEMENT_RULES.md` for complete details

**AGENT INSTRUCTIONS:**
When spawning agents (using Task tool), include in agent prompt:
- "FIRST ACTION: Read Process/Anti-Hallucination_Guidelines.md before proceeding."

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

**Determine Required Resources:**

After scanning Inbox/ and user decisions, determine which resources will be modified:
- Integrating into chapter → `Chapter_XX`
- Adding to front matter → `FrontMatter`
- Adding to back matter → `BackMatter`
- Adding images → `ImageRegistry`

**Acquire Locks Based on Content:**

Resources needed for this prompt: **Varies by content** (determined after user decisions)

For each resource that will be modified:

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

     Cannot integrate content to this location while locked.

     Options:
     1. Choose different destination
     2. Wait for lock to clear (checks every 5 seconds)
     3. Skip this inbox item
     4. Cancel entire operation

     Choose option (1-4):
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
     2. Choose different destination
     3. Skip this inbox item
     4. Cancel entire operation

     Choose option (1-4):
     ```

4. **If user chooses to wait (Option 2):**
   - Poll every 5 seconds
   - Re-check `.locks/locks.json`
   - If lock cleared: Proceed to acquire
   - If timeout (2 minutes): Ask to choose different option

5. **If user cancels or skips:**
   - Move to next inbox item or exit

6. **If no lock OR override approved:**
   - Add lock entry:
     ```json
     {
       "resource": "[resource_name]",
       "timestamp": "[ISO-8601-timestamp]",
       "instance": "[instance_id]"
     }
     ```
   - Write updated JSON to `.locks/locks.json`
   - Proceed with integration

---

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

## Release Locks

**CRITICAL:** Release locks even if operation fails or errors occur.

**Release all acquired locks:**

1. Read `.locks/locks.json`

2. Remove lock entries:
   - For each acquired resource: Filter `locks` array to remove where `"resource"` matches AND `"instance": "[your_instance_id]"`

3. Write updated JSON to `.locks/locks.json`

**Confirmation:**
```
✓ Locks released: Chapter_05, ImageRegistry
```

---

## Lock Management Notes

**Concurrency Support (v0.13.0+):**
- This prompt locks resources based on integration destination (varies by content)
- Possible resources: `Chapter_XX`, `FrontMatter`, `BackMatter`, `ImageRegistry`
- Locks are acquired after user decisions, before integration
- Locked destinations offer alternative options
- Locks are released even if integration fails
- Stale locks (>15 minutes) can be overridden
- See `Process/_COMMON/18_Lock_Management_Module.md` for complete details

---

**Version:** 0.13.0
**Last Updated:** 2025-11-23

*Reference: Process/AI-Assisted_Nonfiction_Authoring_Process.md (Prompt 4)*

---

## Session Cleanup

**After this prompt completes:**

Tell user: "✓ Prompt 6 Integrate Inbox complete.

To free up tokens for your next task, you can say:
**'Clear Prompt 6 Integrate Inbox from context'**

This will reclaim tokens for your next operation."
