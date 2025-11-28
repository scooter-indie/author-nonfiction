# Prompt 12 Reference Documentation

**Version:** 0.15.3
**Purpose:** Detailed git operation examples and troubleshooting

---

## Overview

This reference provides detailed git operation examples and troubleshooting. Load when:
- First time using Prompt 12
- Need operation details
- Troubleshooting git issues
- Understanding advanced workflows

**For core workflow:** See `Prompt_12_Git_Operations.md`

---

## Operation 1: Commit - Full Example

### Interaction

```
Claude: Which files to commit? (all/specific files/list files first)
You: list files first

Claude: Current uncommitted changes:

Modified files:
  M Manuscript/Chapters/Chapter_05/Chapter_05.md
  M Manuscript/Chapters/Chapter_05/Chapter_05_chg.md
  M Manuscript/_TOC_/TOC.md

New files:
  A Manuscript/Chapters/Chapter_12/Chapter_12.md
  A Manuscript/Chapters/Chapter_12/Chapter_12_chg.md

Which files to commit? (all/specific/select by number)
You: all

Claude: Commit message? (or say "suggest one")
You: suggest one

Claude: Based on changed files, suggested message:
"Update Chapter 05 and add Chapter 12"

Use this message or provide your own?
You: Update Chapter 05 v1.3.0 and add Chapter 12 - Conclusions

Claude: ✓ Committed 5 files
Commit: a1b2c3d "Update Chapter 05 v1.3.0 and add Chapter 12 - Conclusions"
```

### Commit Message Formats

**Update (content revisions):**
```
Update: Chapter 03 v1.5.0 - Add case studies

Added three new case studies demonstrating core principles.
Expanded methodology section with practical examples.
```

**Add (new content):**
```
Add: Chapter 12 - Conclusions

Created final chapter summarizing key findings.
Includes future research directions and call to action.
```

**Fix (corrections):**
```
Fix: Correct cross-references in Chapters 05-08

Fixed broken links to figures and tables.
Updated chapter number references after restructure.
```

---

## Operation 2: Tag - Full Example

### Interaction

```
Claude: Tag name? (e.g., v1.0.0, first-draft)
You: v1.0.0

Claude: Tag message/annotation?
You: First complete draft with all 12 chapters

Claude: Which commit to tag? (default: current HEAD)
You: current

Claude: ✓ Tag created
Tag: v1.0.0 "First complete draft with all 12 chapters"
Commit: a1b2c3d

All tags in project:
- v0.5.0 (2025-11-01) - Half draft complete
- v1.0.0 (2025-11-24) - First complete draft with all 12 chapters
```

### Tag Naming Conventions

| Type | Format | Example |
|------|--------|---------|
| Version | vX.Y.Z | v1.0.0, v2.1.0 |
| Milestone | name | first-draft, final |
| Progress | percent | 25-percent, 50-percent |
| Submission | submission-vN | submission-v1 |
| Date | draft-YYYY-MM-DD | draft-2025-11-24 |

---

## Operation 3: Branch - Full Example

### Create and Switch

```
Claude: Which branch operation? (create/switch/list/merge/delete)
You: create

Claude: Branch name?
You: experiment-shorter-intro

Claude: Switch to new branch after creation? (yes/no)
You: yes

Claude: ✓ Branch created and switched
New branch: experiment-shorter-intro
Previous branch: main

You can now work on experimental changes safely.
```

### Merge Branch

```
Claude: Which branch operation?
You: merge

Claude: Which branch to merge into current? (current: main)
You: experiment-shorter-intro

Claude: Checking for conflicts...
✓ No conflicts found

Merge preview:
- 3 files will be updated
- Chapter 01: 150 lines changed
- TOC.md: 2 lines changed

Proceed with merge? (yes/no)
You: yes

Claude: ✓ Merged experiment-shorter-intro into main
3 files updated

Would you like to delete the merged branch? (yes/no)
You: yes

Claude: ✓ Branch deleted: experiment-shorter-intro
```

### Branch Strategies

**Experimental edits:**
1. Create branch: `experiment-new-approach`
2. Make changes
3. If good: merge back to main
4. If bad: delete branch, no harm done

**Major restructure:**
1. Create branch: `restructure-part-2`
2. Work on branch over days/weeks
3. Merge when ready
4. Delete branch

**Editor feedback:**
1. Create branch: `editor-round-1`
2. Apply feedback
3. Merge to main
4. Create new branch for next round

---

## Operation 4: History - Full Example

### Basic History

```
Claude: How many recent commits? (default: 10)
You: 5

Claude: Specific file history, or all files?
You: Chapter 05

Claude: Include diffs (show actual changes)? (yes/no)
You: no

Claude: Commit history for Chapter 05 (last 5):

[2025-11-24] a1b2c3d Update Chapter 05 v1.3.0 - Add case studies
  Files: Chapter_05.md, Chapter_05_chg.md

[2025-11-20] e4f5g6h Fix cross-references in Chapter 05
  Files: Chapter_05.md

[2025-11-18] h7i8j9k Expand methodology section
  Files: Chapter_05.md, Chapter_05_chg.md

[2025-11-15] k0l1m2n Initial Chapter 05 draft
  Files: Chapter_05.md, Chapter_05_chg.md (new)

[2025-11-10] n3o4p5q Create Chapter 05 placeholder
  Files: Chapter_05.md (new)
```

### With Diffs

```
Claude: Include diffs?
You: yes

[2025-11-24] a1b2c3d Update Chapter 05 v1.3.0

Chapter_05.md:
@@ -45,6 +45,25 @@
 ## Case Studies

+### Case Study 1: TechCorp Implementation
+
+TechCorp implemented these principles in Q2 2024...
+[20 lines added]

@@ -120,8 +139,8 @@
-The results were positive.
+The results showed a 35% improvement in productivity.
```

---

## Operation 5: Push - Full Example

```
Claude: Push current branch? (current branch: main)
You: yes

Claude: Include tags? (yes/no/tags only)
You: yes

Claude: Checking remote status...
✓ Remote repository: github.com/username/book-project

Unpushed commits: 3
  - a1b2c3d Update Chapter 05 v1.3.0
  - e4f5g6h Add Chapter 12
  - h7i8j9k Fix cross-references

Unpushed tags: 1
  - v1.0.0

Claude: Pushing to origin/main...
✓ Pushed 3 commits
✓ Pushed 1 tag (v1.0.0)

Your work is now backed up to the cloud!
```

---

## Operation 6: Pull - Full Example

```
Claude: Do you have uncommitted changes? (yes/no/check first)
You: check first

Claude: Checking git status...
⚠️ You have uncommitted changes:
  M Chapter_05.md

Options:
1. Stash changes (save temporarily, restore after pull)
2. Commit changes first
3. Abort pull

You: 1

Claude: Stashing changes...
✓ Changes stashed

Claude: Pulling from origin/main...
✓ Pulled 2 new commits
✓ No conflicts

Claude: Restoring stashed changes...
✓ Stash applied

Your local copy is now up to date!

New commits pulled:
- [2025-11-23] Update from laptop - Chapter 03 edits
- [2025-11-22] Fix typos from phone review
```

---

## Troubleshooting

### "Not a git repository"

**Cause:** No .git directory

**Solution:**
```bash
git init
git add .
git commit -m "Initial commit"
```

### "No remote configured"

**Cause:** No origin set

**Solution:**
```bash
git remote add origin https://github.com/user/repo.git
```

### "Merge conflict"

**Cause:** Same lines changed in both branches

**Solution:**
1. Open conflicted files
2. Look for `<<<<<<` markers
3. Choose which version to keep
4. Remove markers
5. Commit resolution

### "Push rejected"

**Cause:** Remote has new commits

**Solution:**
1. Pull first: `git pull`
2. Resolve any conflicts
3. Push again

### "Detached HEAD"

**Cause:** Checked out specific commit

**Solution:**
```bash
git checkout main
```

---

## Verbose Mode Setting

In `.config/project.json`:
```json
{
  "settings": {
    "prompt_12_verbose": true
  }
}
```

- `true`: Show detailed explanations
- `false`: Skip to execution

---

**Version:** 0.15.3
**For Core Workflow:** See `Prompt_12_Git_Operations.md`
