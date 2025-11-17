# Execute Prompt 10: Update Change Tracking

**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`

---

## What This Does

I will scan your project for content files that have been modified but their corresponding `_chg.md` (change tracking) files are out of sync. I'll automatically update the `_chg` files with version history entries based on the git changes.

---

## How This Works

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
- Chapters/Chapter_03_Methods.md
- Quotes/Chapter_Quotes.md

Updating Chapters/Chapter_03_Methods_chg.md:
  Added Version 1.3.0 - 2025-11-17
  Type: Content Addition
  Summary: Added case study examples to Data Collection section

Updating Quotes/Chapter_Quotes_chg.md:
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

## Ready to Begin?

I'll now scan for out-of-sync files and update their change tracking.

---

*Reference: Process/AI-Assisted_Nonfiction_Authoring_Process.md (Prompt 10)*
