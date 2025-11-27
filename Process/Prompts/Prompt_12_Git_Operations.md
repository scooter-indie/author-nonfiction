# Execute Prompt 12: Git Operations

**Version:** 0.14.5
**⚡ Token Efficient:** ~4,000 tokens (75% reduction from v0.14.0)
**DESKTOP-FRIENDLY:** Works 95% in Desktop (git commands via CLI)

**FIRST ACTION - MANDATORY:**
Reference `Process/Prompts/Prompt_Essentials.md` (loaded once per session via /fw-init)

---

## Quick Start

Performs git version control operations on your book project. Git is your safety net and time machine.

**No locks required** - git operations only, no content modifications.

---

## 7 Operations

| # | Operation | Purpose |
|---|-----------|---------|
| 1 | Commit | Save work to git history |
| 2 | Tag | Mark milestones (v1.0.0) |
| 3 | Branch | Create/switch/merge branches |
| 4 | History | View recent commits |
| 5 | Push | Backup to remote |
| 6 | Pull | Get remote changes |
| 7 | Status | Comprehensive status report |

---

## Operation 1: Commit

**Ask:**
- **Files?** (all / Chapter 5 / list first)
- **Message?** (or "suggest one")

**Message format guide:**
- **Update:** Content revisions
- **Edit:** Minor fixes
- **Add:** New content
- **Fix:** Bug fixes
- **Restructure:** Major changes

---

## Operation 2: Tag

**Ask:**
- **Tag name?** (v1.0.0, first-draft)
- **Message?**
- **Which commit?** (current/hash)

**Common tags:**
- Version: v1.0.0, v2.0.0
- Milestone: first-draft, 50-percent
- Submission: submission-v1

---

## Operation 3: Branch

**Sub-operations:**
- Create new branch
- Switch branches
- List branches
- Merge branch
- Delete branch

**Use cases:**
- Experimental edits
- Major restructures
- Editor feedback rounds

---

## Operation 4: History

**Ask:**
- **How many commits?** (10/20/all)
- **Specific file?** (all/Chapter 5)
- **Include diffs?** (yes/no)

---

## Operation 5: Push

**Ask:**
- **Push current branch?** (yes/main/all)
- **Include tags?** (yes/no/tags only)

**Important:** Regular pushes = cloud backup!

---

## Operation 6: Pull

**Ask:**
- **Uncommitted changes?** (no/stash/check)

**Use when:**
- Multiple computers
- Collaborating
- After remote changes

---

## Operation 7: Status

**Auto-generates:**
- Current branch
- Uncommitted changes
- Unpushed commits
- Recent commits
- All tags
- Remote status
- Recommendations

---

## Example Status Report

```
# Git Repository Status

**Current Branch:** main

**Uncommitted Changes:** 3 files
- Chapter_05.md
- Chapter_05_chg.md
- TOC.md
⚠️ Action: Commit these changes

**Unpushed Commits:** 2 ahead
⚠️ Action: Push to backup

**Recent Commits (last 5):**
1. [2025-11-24] Update Chapter 05 v1.3.0
2. [2025-11-23] Fix cross-references
3. [2025-11-22] Add Chapter 12
...

**Tags:** v1.0.0, first-draft

**Remote:** github.com/user/book ✓

**Recommendations:**
1. Commit uncommitted files
2. Push to remote for backup
```

---

## Recommended Workflow

**Daily:**
1. Work on content (Prompt 3/4)
2. Auto-commits during editing
3. Push at end of session

**Weekly:**
1. Run Status Report
2. Commit anything uncommitted
3. Push to remote

**Milestones:**
1. Commit all changes
2. Create tag (v1.0.0)
3. Push with tags

---

## Safety Notes

- **NEVER** runs destructive operations without confirmation
- **WARNS** before irreversible actions
- **CHECKS** status before modifying repository

---

📖 **For detailed examples:** See `Process/Prompts/Prompt_12_Reference.md`

---

**Version:** 0.14.5
**Last Updated:** 2025-11-24
**Token Efficiency:** 75% reduction

---

## Session Cleanup

Tell user: "✓ Prompt 12 Git Operations complete.

To free up tokens, say: **'Clear Prompt 12 from context'**"
