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
- Which files to commit? (All modified files, or specific files)
- Commit message? (Or should I suggest one based on changes)

**Then I'll:**
- Run `git status` and show you what's changed
- Stage the selected files
- Create commit with your message
- Display commit hash and summary

**Commit message format examples:**
- "Update: Chapter 03 v1.5.0 - Add case studies"
- "Edit: Fix typos in Chapters 01-03"
- "Add: Chapter 12 - Conclusions"

---

### 2. Create Tag

**I'll ask:**
- Tag name? (e.g., v1.0.0, first-draft, submission-v1)
- Tag message/annotation?
- Which commit to tag? (default: current HEAD)

**Then I'll:**
- Create annotated tag with your message
- Confirm creation
- List all tags in project

**Common tag names:**
- Version tags: v1.0.0, v2.0.0, v2.1.0
- Milestone tags: first-draft, revised-draft, final-draft
- Submission tags: submission-v1, submission-v2

---

### 3. Branch Management

**I'll ask which operation:**
- Create new branch
- Switch to existing branch
- List all branches
- Merge branch into current
- Delete branch

**For creating:**
- Branch name? (e.g., draft-chapter-12, restructure-part-2)
- Switch to new branch after creation?

**For merging:**
- Which branch to merge into current?
- I'll check for conflicts first

**Use cases:**
- **Experimental edits**: Create branch, try changes, merge if good or delete if not
- **Major restructures**: Work on branch, merge when ready
- **Parallel work**: Different branches for different sections

---

### 4. View History

**I'll ask:**
- How many recent commits? (default: 10)
- Specific file history, or all files?
- Include diffs (show actual changes)?

**Then I'll show:**
- Commit history in readable format
- Dates, messages, affected files
- Optionally: actual changes (diffs)

**Useful for:**
- Seeing what you've been working on
- Finding when a specific change was made
- Reviewing evolution of a chapter

---

### 5. Push to Remote

**I'll ask:**
- Push current branch?
- Include tags?

**Then I'll:**
- Verify remote repository configured
- Check which commits are unpushed
- Push to remote (usually `origin`)
- Confirm success

**Important**: Regular pushes are your cloud backup!

---

### 6. Pull from Remote

**I'll ask:**
- Do you have uncommitted changes that need stashing first?

**Then I'll:**
- Check for conflicts
- Pull latest from remote
- Report any merge conflicts (rare in single-author workflow)

**Use when:**
- Working from multiple computers
- Collaborating with editors
- Syncing after cloud backup

---

### 7. Status Report

**I'll generate:**
- Current branch
- Uncommitted changes (what files are modified)
- Unpushed commits (what's not backed up)
- Recent commits (last 5)
- All tags
- Remote repository status

**Example report:**
```markdown
# Git Repository Status

**Branch:** main
**Uncommitted Changes:** 3 files modified
  - Manuscript/Chapters/Chapter_05/Chapter_05_Analysis.md
  - Manuscript/Chapters/Chapter_05/Chapter_05_Analysis_chg.md
  - Manuscript/_TOC_/TOC.md

**Unpushed Commits:** 2
  - a1b2c3d Update Chapter 05 v1.3.0
  - e4f5g6h Fix cross-references

**Recent Commits:**
  - [2025-11-17] Update Chapter 05 v1.3.0
  - [2025-11-16] Add Appendix B
  - [2025-11-15] Consistency fixes

**Tags:**
  - v1.0.0 (2025-11-01)
  - first-draft (2025-11-15)

**Remote:** https://github.com/user/book-project
**Status:** 2 commits ahead of origin/main
```

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

## Ready to Begin?

**Which git operation would you like to perform?**

(1) Commit | (2) Tag | (3) Branch | (4) History | (5) Push | (6) Pull | (7) Status

---

*Reference: Process/AI-Assisted_Nonfiction_Authoring_Process.md (Prompt 9)*
