# Execute Prompt 2: Add New Chapter

**Version:** 0.15.2
**⚡ Token Efficient:** ~4,000 tokens (65% reduction from v0.14.0)
**DESKTOP-FRIENDLY:** Works 95% in Desktop (git via CLI)

**FIRST ACTION - MANDATORY:**
Reference `Process/Prompts/Prompt_Essentials.md` (loaded once per session via /fw-init)

---

## Quick Start

Adds a new chapter to your book:
- Inserts at correct position
- Renumbers affected chapters
- Creates chapter files and change tracking
- Updates TOC and cross-references
- Commits to git

**Note:** Images go in `Manuscript/images/` (unified), not per-chapter.

---

## Workflow (5 Steps)

1. Lock resources
2. Collect chapter information
3. Create chapter files
4. Update TOC and references
5. Commit and release locks

---

## Step 0: Lock Management

**Acquire locks:**
1. Generate instance ID: `CLI-[5-digit]` or `Desktop-[5-digit]`
2. Lock `Chapter_XX` (new chapter)
3. Lock `ProjectConfig`

See: Prompt_Essentials.md → Lock Management

---

## Step 1: Questions

**Two options:**

### Option A: Interactive (Quick Add)

1. **Chapter title?**
2. **Position?** (number or "after Chapter X")
3. **Estimated word count?**
4. **Key topics?** (optional)
5. **Rationale?**
6. **Style override?** (or inherit book-level)

### Option B: From Inbox

1. **Which file in Manuscript/Inbox/?**
2. **Position?**
3. **Use as-is or placeholder?**

---

## Step 2: Create Chapter Structure

**Create subdirectory:**
```
Manuscript/Chapters/Chapter_XX/
├── Chapter_XX.md
└── Chapter_XX_chg.md
```

**If style override selected:**
- Create `Chapter_XX_style.md` from template
- Update `Manuscript/Style/Style_Overrides.md`

**Add quote entry:**
- Add to `Manuscript/Quotes/Chapter_Quotes.md` (Status: ⏳)
- Update `Chapter_Quotes_chg.md`

---

## Step 3: Update TOC

**Preserve warning header:**
```markdown
⚠️ WARNING: This file is managed by Prompts 1 and 2.
Direct edits may be overwritten.
```

**Actions:**
1. Add new chapter entry
2. Renumber affected chapters
3. Update `TOC_chg.md`

---

## Step 4: Renumber & Update

**For affected chapters (if inserting):**
1. Rename chapter directories
2. Update file contents with new numbers
3. Update cross-references in all files

---

## Step 5: Git Commit & Release

```bash
git add Manuscript/Chapters/Chapter_XX/ Manuscript/_TOC_/ Manuscript/Quotes/
git commit -m "$(cat <<'EOF'
Add Chapter X: [Title]

[Brief description]

🤖 Generated with Claude Code - Prompt 2

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

Release locks: `Chapter_XX`, `ProjectConfig`

---

## Chapter File Template

**Chapter_XX.md:**
```markdown
# Chapter X: [Title]

**Status:** Draft
**Target Word Count:** [N]

---

## Section 1

[Content placeholder]

---

## Summary

[Summary placeholder]
```

**Chapter_XX_chg.md:**
```markdown
# Change Tracking: Chapter X

**Current Version:** 1.0.0
**Last Modified:** [CONFIRMED_DATE]

---

### [INSTRUCTIONS FOR THIS REVISION]

[Empty - ready for revision instructions]

---

### Version History

#### v1.0.0 - [CONFIRMED_DATE] - Initial creation
**Type:** New chapter
**Rationale:** [From user input]
```

---

## Important Notes

- **TOC.md** has warning header (AI-managed)
- **TOC_chg.md** is AI-managed only
- After setup, do NOT place TOC files in Inbox
- For reordering, use this prompt to insert at new position
- Images use unified `Manuscript/images/` directory

---

📖 **For detailed examples:** See `Process/Prompts/Prompt_2_Reference.md`

---

**Version:** 0.15.2
**Last Updated:** 2025-11-24
**Token Efficiency:** 65% reduction

---

## Session Cleanup

Tell user: "✓ Prompt 2 Add Chapter complete.

To free up tokens, say: **'Clear Prompt 2 from context'**"
