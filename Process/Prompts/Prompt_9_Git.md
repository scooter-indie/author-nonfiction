# Execute Prompt 9: Git Operations

**DESKTOP-FRIENDLY:** Works in Claude Desktop (provides git commands to copy/paste into Claude Code CLI)

**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`

**CRITICAL ENFORCEMENT:**
- **RULE 1:** All file modifications MUST update corresponding _chg files
- **RULE 2:** All Manuscript/ changes must go through appropriate prompts

See: `Process/ENFORCEMENT_RULES.md` for complete details

**NOTE:** This handles git operations only. No _chg updates are required (version control operations, does not modify content files)

**Claude Desktop Compatibility:**
- ✅ Interactive workflow in Desktop
- ✅ Provides git commands to execute via Claude Code CLI
- ✅ Validates operations before providing commands
- 📋 Works 95% in Desktop

---

## What This Does

I will help you perform git version control operations on your book project. Git is your safety net and time machine for all content.

---

## How This Works

I'll ask you which git operation you want to perform, then execute it with appropriate safety checks.

### Detailed Explanations Preference

**At the start of execution**, I'll check your `Project_Config.md` for the `prompt_9_verbose` setting:

- **If `prompt_9_verbose: true` (default)**: I'll show detailed explanations and examples for each operation
- **If `prompt_9_verbose: false`**: I'll skip detailed explanations and go straight to execution

**I'll ask:** "Show detailed explanations? (yes/no/never ask again)"
- Answer **"yes"** - Show explanations this time
- Answer **"no"** - Skip explanations this time
- Answer **"never ask again"** - Set `prompt_9_verbose: false` in Project_Config.md permanently

### Question I'll ask:

**Which git operation would you like to perform?**

1. **Commit Current Changes** - Save your current work to git history
2. **Create Tag** - Mark a milestone (e.g., v1.0.0, first-draft)
3. **Branch Management** - Create, switch, merge, or delete branches
4. **View History** - See recent commits or changes to specific files
5. **Push to Remote** - Backup to GitHub/GitLab/Bitbucket
6. **Pull from Remote** - Get latest changes from remote repository
7. **Status Report** - Comprehensive git repository status

---

## Operation Details

### 1. Commit Current Changes

**I'll ask:**
- **"Which files to commit?"**
  - Answer: **"all"** or **"all modified"** - Commits everything that's changed
  - Answer: **"Chapter 5"** or **"chapter 05"** - Commits only Chapter 5 files
  - Answer: **"TOC"** - Commits only TOC files
  - Answer: **"list files first"** - Shows you what's changed before deciding

- **"Commit message?"**
  - Answer: **"Update Chapter 03 v1.5.0 - Add case studies"** - Specific descriptive message
  - Answer: **"Fix typos in Chapter 01"** - Simple fix description
  - Answer: **"suggest one"** - I'll suggest a message based on changed files

**Then I'll:**
- Run `git status` and show you what's changed
- Stage the selected files
- Create commit with your message
- Display commit hash and summary

**Example Interaction:**

```
Claude: Which files to commit? (all/specific files/list files first)
You: all

Claude: Commit message? (or say "suggest one")
You: Update Chapter 05 v1.3.0 - Add productivity case studies

Claude: ✓ Committed 3 files
Commit: a1b2c3d "Update Chapter 05 v1.3.0 - Add productivity case studies"
Files: Chapter_05_Analysis.md, Chapter_05_Analysis_chg.md, TOC.md
```

**Commit message format guide:**
- **Update**: Content revisions - "Update: Chapter 03 v1.5.0 - Add case studies"
- **Edit**: Minor fixes - "Edit: Fix typos in Chapters 01-03"
- **Add**: New content - "Add: Chapter 12 - Conclusions"
- **Fix**: Bug fixes - "Fix: Correct cross-references in Chapter 08"
- **Restructure**: Major changes - "Restructure: Reorganize Part 2 chapters"

---

### 2. Create Tag

**I'll ask:**
- **"Tag name?"**
  - Answer: **"v1.0.0"** - Version tag for major milestone
  - Answer: **"first-draft"** - Milestone tag
  - Answer: **"submission-v1"** - Submission/publication tag
  - Answer: **"25-percent-complete"** - Progress marker

- **"Tag message/annotation?"**
  - Answer: **"First complete draft with all chapters"** - Descriptive message
  - Answer: **"25% milestone - 5 chapters complete"** - Progress description
  - Answer: **"Same as tag name"** - Use tag name as message

- **"Which commit to tag?"**
  - Answer: **"current"** or just press Enter - Tags the latest commit (HEAD)
  - Answer: **"a1b2c3d"** - Tags specific commit hash

**Then I'll:**
- Create annotated tag with your message
- Confirm creation
- List all tags in project

**Example Interaction:**

```
Claude: Tag name? (e.g., v1.0.0, first-draft, submission-v1)
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
- v1.0.0 (2025-11-20) - First complete draft with all 12 chapters
```

**Common tag naming conventions:**
- **Version tags**: v1.0.0, v2.0.0, v2.1.0 (semantic versioning)
- **Milestone tags**: first-draft, revised-draft, final-draft, 25-percent, 50-percent
- **Submission tags**: submission-v1, submission-v2, publisher-review-1
- **Date tags**: draft-2025-11-20 (if you prefer dates)

---

### 3. Branch Management

**I'll ask which operation:**
- **"Create new branch"** - Start a new branch for experimental work
- **"Switch to existing branch"** - Change to a different branch
- **"List all branches"** - See all branches and current branch
- **"Merge branch"** - Merge another branch into current
- **"Delete branch"** - Remove a branch you no longer need

**For creating:**
- **"Branch name?"**
  - Answer: **"draft-chapter-12"** - Working on new chapter
  - Answer: **"restructure-part-2"** - Major reorganization
  - Answer: **"experiment-new-intro"** - Trying alternative approach
  - Answer: **"editor-feedback-v1"** - Incorporating editor notes

- **"Switch to new branch after creation?"**
  - Answer: **"yes"** - Create and immediately switch to it
  - Answer: **"no"** - Create but stay on current branch

**For switching:**
- **"Which branch?"**
  - Answer: **"main"** - Back to main branch
  - Answer: **"draft-chapter-12"** - Switch to that branch

**For merging:**
- **"Which branch to merge into current?"**
  - Answer: **"draft-chapter-12"** - Merge that branch into current
  - I'll check for conflicts first and warn you

**For deleting:**
- **"Which branch to delete?"**
  - Answer: **"old-experiment"** - Delete that branch
  - I'll confirm it's been merged first (safety check)

**Example Interaction (Create & Switch):**

```
Claude: Which branch operation? (create/switch/list/merge/delete)
You: create

Claude: Branch name? (e.g., draft-chapter-12, restructure-part-2)
You: experiment-shorter-intro

Claude: Switch to new branch after creation? (yes/no)
You: yes

Claude: ✓ Branch created and switched
New branch: experiment-shorter-intro
Previous branch: main

You can now work on experimental changes safely.
```

**Example Interaction (Merge):**

```
Claude: Which branch operation? (create/switch/list/merge/delete)
You: merge

Claude: Which branch to merge into current? (current: main)
You: draft-chapter-12

Claude: Checking for conflicts...
✓ No conflicts found

Claude: ✓ Merged draft-chapter-12 into main
3 files updated
```

**Use cases:**
- **Experimental edits**: Create branch, try changes, merge if good or delete if not
- **Major restructures**: Work on branch, merge when ready
- **Parallel work**: Different branches for different sections
- **Editor feedback**: Create branch for each round of revisions

---

### 4. View History

**I'll ask:**
- **"How many recent commits?"**
  - Answer: **"10"** - Last 10 commits (default)
  - Answer: **"20"** or **"50"** - More history
  - Answer: **"all"** - Complete history (can be long)

- **"Specific file history, or all files?"**
  - Answer: **"all"** - Show all commits
  - Answer: **"Chapter 05"** or **"Chapter_05"** - Only commits affecting Chapter 5
  - Answer: **"TOC"** - Only TOC changes

- **"Include diffs (show actual changes)?"**
  - Answer: **"no"** - Just show commit messages (faster, cleaner)
  - Answer: **"yes"** - Show what actually changed in each commit (detailed)

**Then I'll show:**
- Commit history in readable format
- Dates, messages, affected files
- Optionally: actual changes (diffs)

**Example Interaction:**

```
Claude: How many recent commits? (default: 10)
You: 10

Claude: Specific file history, or all files?
You: all

Claude: Include diffs (show actual changes)? (yes/no)
You: no

Claude: Recent commit history (last 10):

[2025-11-20] a1b2c3d Update Chapter 05 v1.3.0 - Add case studies
  - Manuscript/Chapters/Chapter_05/Chapter_05_Analysis.md
  - Manuscript/Chapters/Chapter_05/Chapter_05_Analysis_chg.md

[2025-11-19] e4f5g6h Fix cross-references in Chapter 03
  - Manuscript/Chapters/Chapter_03/Chapter_03_Methods.md

[2025-11-18] h7i8j9k Add Chapter 12 - Conclusions
  - Manuscript/Chapters/Chapter_12/ (new)
  - Manuscript/_TOC_/TOC.md
```

**Useful for:**
- Seeing what you've been working on
- Finding when a specific change was made
- Reviewing evolution of a chapter
- Creating progress reports

---

### 5. Push to Remote

**I'll ask:**
- **"Push current branch?"**
  - Answer: **"yes"** or **"current"** - Push the branch you're on
  - Answer: **"main"** - Push main branch specifically
  - Answer: **"all branches"** - Push all branches (use carefully)

- **"Include tags?"**
  - Answer: **"yes"** - Push commits AND tags
  - Answer: **"no"** - Just push commits, not tags
  - Answer: **"tags only"** - Only push tags, not commits

**Then I'll:**
- Verify remote repository configured
- Check which commits are unpushed
- Push to remote (usually `origin`)
- Confirm success

**Example Interaction:**

```
Claude: Push current branch? (current branch: main)
You: yes

Claude: Include tags? (yes/no/tags only)
You: yes

Claude: Checking remote status...
✓ Remote repository: github.com/username/book-project

Unpushed commits: 3
Unpushed tags: 1

Claude: Pushing to origin/main...
✓ Pushed 3 commits
✓ Pushed 1 tag (v1.0.0)

Your work is now backed up to the cloud!
```

**Important notes:**
- **Regular pushes are your cloud backup!** Push at end of every session
- If working from multiple computers, push before switching machines
- Tags must be explicitly pushed (use "yes" or "tags only")

---

### 6. Pull from Remote

**I'll ask:**
- **"Do you have uncommitted changes that need stashing first?"**
  - Answer: **"no"** - I've committed everything (safest)
  - Answer: **"yes, stash them"** - Temporarily save uncommitted work
  - Answer: **"check first"** - Show me what's uncommitted

**Then I'll:**
- Check for conflicts
- Pull latest from remote
- Report any merge conflicts (rare in single-author workflow)

**Example Interaction:**

```
Claude: Do you have uncommitted changes that need stashing first? (yes/no/check first)
You: check first

Claude: Checking git status...
✓ No uncommitted changes, safe to pull

Claude: Pulling from origin/main...
✓ Pulled 2 new commits
✓ No conflicts

Your local copy is now up to date with remote!

New commits:
- [2025-11-19] Update Chapter 03 (from laptop)
- [2025-11-18] Fix typos in Chapter 02 (from laptop)
```

**Use when:**
- Working from multiple computers (pull before starting work on new machine)
- Collaborating with editors or co-authors
- Syncing after someone else pushed to the remote
- Recovering work after computer issues

**Important**: Always pull before starting work if you use multiple devices!

---

### 7. Status Report

**This operation requires no questions** - I'll automatically generate a comprehensive status report.

**I'll generate:**
- Current branch
- Uncommitted changes (what files are modified)
- Unpushed commits (what's not backed up)
- Recent commits (last 5)
- All tags
- Remote repository status

**Example Interaction:**

```
You: Status report (or just "7")

Claude: Generating git repository status...

# Git Repository Status

**Current Branch:** main

**Uncommitted Changes:** 3 files modified
  - Manuscript/Chapters/Chapter_05/Chapter_05_Analysis.md
  - Manuscript/Chapters/Chapter_05/Chapter_05_Analysis_chg.md
  - Manuscript/_TOC_/TOC.md

**⚠ Action needed**: Commit these changes before pushing

**Unpushed Commits:** 2 commits ahead of origin/main
  - a1b2c3d [2025-11-20] Update Chapter 05 v1.3.0
  - e4f5g6h [2025-11-19] Fix cross-references

**⚠ Action needed**: Push to back up your work

**Recent Commits (last 5):**
  1. [2025-11-20] Update Chapter 05 v1.3.0 - Add case studies
  2. [2025-11-19] Fix cross-references in Chapter 03
  3. [2025-11-18] Add Chapter 12 - Conclusions
  4. [2025-11-17] Consistency fixes across all chapters
  5. [2025-11-16] Add Appendix B

**Tags:**
  - v1.0.0 (2025-11-01) - First complete draft
  - first-draft (2025-11-15) - Initial submission draft

**Remote Repository:**
  - URL: https://github.com/username/book-project
  - Status: Connected ✓

**Recommendations:**
  1. Commit your 3 uncommitted files
  2. Push 2 commits to remote for backup
  3. Consider creating a tag at next milestone
```

**Use this to:**
- Get a quick overview before ending a session
- Check what needs to be committed or pushed
- See recent progress at a glance
- Verify remote backup status

---

## Safety Notes

- **I will NEVER run destructive operations** (force push, hard reset) without explicit confirmation
- **I will warn you** before any operation that can't be easily undone
- **I always check status first** before operations that modify repository state

---

## Recommended Git Workflow

**Daily:**
1. Work on content
2. Use Prompt 3 (which auto-commits changes)
3. Push to remote at end of session

**Weekly:**
1. Run Status Report (this prompt)
2. Review uncommitted changes
3. Commit anything not auto-committed
4. Push to remote

**Milestones:**
1. Commit all changes
2. Create tag (e.g., v1.0.0, first-draft)
3. Push with tags

---

## Execution Workflow

**Step 1: Check verbose preference**

1. Read `Project_Config.md` to check `prompt_9_verbose` setting
2. If `prompt_9_verbose` not found or is `true`:
   - Ask: "Show detailed explanations? (yes/no/never ask again)"
   - If answer is "yes": Show detailed explanations for chosen operation
   - If answer is "no": Skip detailed explanations, proceed directly
   - If answer is "never ask again": Set `prompt_9_verbose: false` in Project_Config.md, then skip explanations
3. If `prompt_9_verbose: false`:
   - Skip explanations entirely, proceed directly to operation

**Step 2: Ask which operation**

**Which git operation would you like to perform?**

(1) Commit | (2) Tag | (3) Branch | (4) History | (5) Push | (6) Pull | (7) Status

**Step 3: Execute operation**

Follow the detailed instructions for the selected operation above.

---

## Project_Config.md Setting

**To configure verbose mode**, add or update this line in your `Project_Config.md`:

```yaml
prompt_9_verbose: true   # Show detailed explanations (default)
prompt_9_verbose: false  # Skip detailed explanations
```

**To manually change later:**
- Edit `Project_Config.md` at your book project root
- Change `prompt_9_verbose: true` to `false` (or vice versa)
- Save the file

---

*Reference: Process/AI-Assisted_Nonfiction_Authoring_Process.md (Prompt 9)*
