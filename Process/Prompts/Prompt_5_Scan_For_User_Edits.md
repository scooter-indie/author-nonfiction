# Execute Prompt 5: Scan For User Edits

**Version:** 0.13.0
**DESKTOP-FRIENDLY:** Works in Claude Desktop with optional copy/paste git commit at end

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

**NOTE:** This prompt explicitly updates _chg files to sync them with content changes made outside the framework

**Claude Desktop Compatibility:**
- ✅ All _chg file updates via MCP Filesystem
- ✅ Optional git commit at end (single copy/paste)
- ✅ No bash commands required
- 📋 Works 85% in Desktop

---

## What This Does

I will scan your project for content files that have been modified but their corresponding `_chg.md` (change tracking) files are out of sync. I'll automatically update the `_chg` files with version history entries based on the git changes.

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

After scanning, determine which chapters have been modified.
- For each modified chapter → Acquire lock: `Chapter_XX`

**Acquire Locks for Modified Chapters:**

Resources needed for this prompt: `Chapter_XX` (for each chapter with edits)

For each chapter that will be updated:

1. Read `.locks/locks.json`

2. Check if `Chapter_XX` is locked:
   - Search `locks` array for entry where `"resource": "Chapter_XX"`

3. **If lock exists:**
   - Calculate age: `current_time - lock.timestamp`

   - **If age < 15 minutes:**
     ```
     ⚠️ Chapter_XX is currently locked by another instance.

     Lock details:
     - Resource: Chapter_XX
     - Locked at: [timestamp] ([X] minutes ago)
     - Instance: [instance]

     Skipping this chapter (cannot update _chg file while locked).

     Options:
     1. Continue with other chapters
     2. Wait for lock to clear (checks every 5 seconds)
     3. Cancel entire operation

     Choose option (1-3):
     ```

   - **If age >= 15 minutes:**
     ```
     ⚠️ Chapter_XX has a stale lock (older than 15 minutes).

     Lock details:
     - Resource: Chapter_XX
     - Locked at: [timestamp] ([X] minutes ago)
     - Instance: [instance]

     This lock may be from a crashed instance.

     Options:
     1. Override stale lock and continue
     2. Skip this chapter
     3. Cancel entire operation

     Choose option (1-3):
     ```

4. **If user chooses to wait (Option 2 from active lock):**
   - Poll every 5 seconds
   - Re-check `.locks/locks.json`
   - If lock cleared: Proceed to acquire
   - If timeout (2 minutes): Skip chapter

5. **If user cancels:**
   - Exit prompt without changes

6. **If no lock OR override approved:**
   - Add lock entry:
     ```json
     {
       "resource": "Chapter_XX",
       "timestamp": "[ISO-8601-timestamp]",
       "instance": "[instance_id]"
     }
     ```
   - Write updated JSON to `.locks/locks.json`
   - Proceed with _chg file update

---

I'll scan for changes in three contexts, then auto-update any out-of-sync `_chg` files.

### What I'll do:

1. **Find all _chg file pairs** - Locate all `*_chg.md` files and their corresponding content files
2. **Check for changes** in three contexts:
   - Uncommitted local changes (`git diff`)
   - Staged changes (`git diff --cached`)
   - Unpushed commits (`git diff origin/main..HEAD`)
3. **Auto-update _chg files** for any out-of-sync content
4. **Show you a summary** of all updates made
5. **Wait for your acknowledgment** before finishing

---

## What Gets Updated

For each out-of-sync file, I'll:

- **Analyze the git diff** to understand what changed
- **Infer the change type**:
  - "Content Addition" - primarily new content added
  - "Content Deletion" - primarily content removed
  - "Structural Change" - headings/organization modified
  - "Refinement" - mostly line-by-line edits
  - "Content Update" - general modifications
- **Increment the version number** using semantic versioning:
  - Major version (X.0.0) for structural changes
  - Minor version (0.X.0) for content additions/deletions
  - Patch version (0.0.X) for refinements/updates
- **Generate a version history entry** with:
  - Version number and date
  - Type and scope of changes
  - Summary of what was modified
  - Rationale: "[Auto-generated from git diff]"
- **Update the _chg file** with new entry at top of Version History section
- **Update "Last Modified" date** in file header

---

## Example Output

```markdown
Found 2 files out of sync with their _chg tracking files:
- Manuscript/Chapters/Chapter_03/Chapter_03_Methods.md
- Manuscript/Quotes/Chapter_Quotes.md

Updating Manuscript/Chapters/Chapter_03/Chapter_03_Methods_chg.md:
  Added Version 1.3.0 - 2025-11-17
  Type: Content Addition
  Summary: Added case study examples to Data Collection section

Updating Manuscript/Quotes/Chapter_Quotes_chg.md:
  Added Version 1.1.0 - 2025-11-17
  Type: Content Update
  Summary: Updated Chapter 5 quote with verified attribution

All _chg files have been synchronized.
```

---

## When to Use This Prompt

**Recommended scenarios:**

1. **Before creating a milestone** - Ensure all change tracking is current before tagging a version
2. **After manual edits** - When you've edited content files directly (not through Prompt 3)
3. **Before a presentation/review** - Clean up change tracking for others reviewing your work
4. **Weekly maintenance** - Keep change tracking current as part of regular workflow
5. **After pulling from remote** - Sync tracking files if changes came from another machine

**Note:** The book-writing-assistant agent automatically runs this check at:
- Session start
- Before any git commit

So you may not need to run this prompt often if you're using the agent regularly.

---

## Change Tracking File Format

The auto-generated entries follow this format:

```markdown
### Version N.M.P - YYYY-MM-DD - [Brief Description]

**Type:** [Content Addition | Content Deletion | Structural Change | Refinement | Content Update]
**Scope:** [Affected sections/chapters]
**Priority:** Medium
**Rationale:** [Auto-generated from git diff]

**Changes Made:**
- [Summary of changes from diff analysis]
- [What sections were modified]
- [Nature of modifications]

**Verification Status:**
- [If applicable, based on file type]
```

---

## Safety Notes

- **Non-destructive** - Only updates `_chg` files, never modifies content files
- **Preserves existing entries** - New versions added to top of Version History
- **Git-based** - Only tracks changes that are in git (committed, staged, or modified)
- **Transparent** - Shows you exactly what was updated before finishing

---

## Git Commit Format (For Claude Desktop Users)

When providing the git commit command at the end, format it like this:

**For Claude Desktop users, provide:**

Go to Claude Code CLI and say:
```
Run: git add [list of _chg.md files] && git commit -m 'Update change tracking for [count] files

Synchronized change tracking with git history.

🤖 Generated with Claude Desktop

Co-Authored-By: Claude <noreply@anthropic.com>'
```

**The instruction "Go to Claude Code CLI and say:" must be OUTSIDE the code block.**
**Only the command starting with "Run:" should be inside the code block.**

---

## Release Locks

**CRITICAL:** Release locks even if operation fails or errors occur.

**Release all acquired locks:**

1. Read `.locks/locks.json`

2. Remove lock entries:
   - For each modified chapter: Filter `locks` array to remove where `"resource": "Chapter_XX"` AND `"instance": "[your_instance_id]"`

3. Write updated JSON to `.locks/locks.json`

**Confirmation:**
```
✓ Locks released: Chapter_03, Chapter_05, Chapter_07
```

---

## Lock Management Notes

**Concurrency Support (v0.13.0+):**
- This prompt locks each `Chapter_XX` being scanned/updated to prevent conflicts
- Locks are acquired after scanning, before updating _chg files
- Locked chapters are skipped with user notification
- Locks are released even if updates fail
- Stale locks (>15 minutes) can be overridden
- See `Process/_COMMON/18_Lock_Management_Module.md` for complete details

---

## Ready to Begin?

I'll now scan for out-of-sync files and update their change tracking.

---

**Version:** 0.13.0
**Last Updated:** 2025-11-23

*Reference: Process/AI-Assisted_Nonfiction_Authoring_Process.md (Prompt 10)*

---

## Session Cleanup

**After this prompt completes:**

Tell user: "✓ Prompt 5 Scan For User Edits complete.

To free up tokens for your next task, you can say:
**'Clear Prompt 5 Scan For User Edits from context'**

This will reclaim tokens for your next operation."
