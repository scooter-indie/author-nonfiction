# Execute Prompt 5: Scan For User Edits

**Version:** 0.14.5
**⚡ Token Efficient:** ~3,500 tokens (65% reduction from v0.14.0)
**DESKTOP-FRIENDLY:** Works 85% in Desktop (git via CLI)

**FIRST ACTION - MANDATORY:**
Reference `Process/Prompts/Prompt_Essentials.md` (loaded once per session via /fw-init)

---

## Quick Start

Scans for content files modified outside the framework and synchronizes their `_chg.md` tracking files. Non-destructive - only updates `_chg` files.

**Use when:**
- Before milestones
- After manual edits
- Weekly maintenance
- After pulling from remote

---

## Workflow (4 Steps)

1. Find all _chg file pairs
2. Check for changes (uncommitted, staged, unpushed)
3. Auto-update _chg files
4. Report and commit

---

## Step 0: Lock Management

**Acquire locks for modified chapters:**
- Scan first, then lock each `Chapter_XX` being updated
- Locked chapters are skipped with notification

See: Prompt_Essentials.md → Lock Management

---

## Step 1: Find File Pairs

**Scan for:**
- `*_chg.md` files and their corresponding content files
- Check all Manuscript/ subdirectories

---

## Step 2: Check for Changes

**Three contexts:**
1. Uncommitted local changes (`git diff`)
2. Staged changes (`git diff --cached`)
3. Unpushed commits (`git diff origin/main..HEAD`)

**For each out-of-sync file, infer:**
- Change type (Addition, Deletion, Structural, Refinement, Update)
- Version increment (Major/Minor/Patch)

---

## Step 3: Auto-Update _chg Files

**For each out-of-sync file:**
1. Analyze git diff
2. Increment version using semantic versioning
3. Generate version history entry
4. Update "Last Modified" date

**Version History Entry Format:**
```markdown
### Version N.M.P - YYYY-MM-DD - [Description]

**Type:** [Content Addition | Deletion | Structural | Refinement | Update]
**Scope:** [Affected sections]
**Priority:** Medium
**Rationale:** [Auto-generated from git diff]

**Changes Made:**
- [Summary from diff analysis]
```

---

## Step 4: Report & Commit

**Example output:**
```
Found 2 files out of sync:
- Manuscript/Chapters/Chapter_03/Chapter_03.md
- Manuscript/Quotes/Chapter_Quotes.md

Updating Chapter_03_chg.md:
  Added Version 1.3.0 - 2025-11-24
  Type: Content Addition
  Summary: Added case study examples

Updating Chapter_Quotes_chg.md:
  Added Version 1.1.0 - 2025-11-24
  Type: Content Update
  Summary: Updated Chapter 5 quote

✓ All _chg files synchronized
```

---

## Git Commit & Release

```bash
git add [list of _chg.md files]
git commit -m "$(cat <<'EOF'
UPDATE: Sync change tracking for [N] files

Synchronized change tracking with git history.

🤖 Generated with Claude Code - Prompt 5

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

Release locks for all updated chapters.

---

## Safety Notes

- **Non-destructive**: Only updates `_chg` files
- **Preserves existing entries**: New versions added to top
- **Git-based**: Only tracks git changes
- **Transparent**: Shows exactly what was updated

---

📖 **For detailed examples:** See `Process/Prompts/Prompt_5_Reference.md`

---

**Version:** 0.14.5
**Last Updated:** 2025-11-24
**Token Efficiency:** 65% reduction

---

## Session Cleanup

Tell user: "✓ Prompt 5 Scan For User Edits complete.

To free up tokens, say: **'Clear Prompt 5 from context'**"
