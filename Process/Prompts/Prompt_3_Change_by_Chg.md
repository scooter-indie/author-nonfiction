# Execute Prompt 3: Change by Chg

**Version:** 0.14.3
**⚡ Token Efficient:** ~6,000 tokens (67% reduction from v0.14.0)
**DESKTOP-FRIENDLY:** Works in Claude Desktop with MCP Filesystem + single copy/paste git commit

**FIRST ACTION - MANDATORY:**
Reference `Process/Prompts/Prompt_Essentials.md` (loaded once per session via /fw-init)

---

## Quick Start

This prompt modifies content files based on instructions in `_chg.md` files. It's the **primary workflow for content revisions**.

### Workflow (7 Steps)

1. Read _chg file and extract instructions
2. Acquire lock for chapter
3. Apply modifications to content file
4. Verify anti-hallucination compliance (ASK FIRST)
5. Check style consistency
6. Auto-archive instructions to Version History
7. Commit changes and release lock

---

## Step 0: Lock Management

**Acquire lock before modifications:**

1. Check/create `.locks/locks.json`
2. Generate instance ID: `CLI-[5-digit]` or `Desktop-[5-digit]`
3. Acquire lock for `Chapter_XX` (from _chg file path)
4. If locked < 15 min: Wait or cancel
5. If locked >= 15 min: Override stale lock or cancel

See: Prompt_Essentials.md → Lock Management

---

## Step 1: Read Instructions

**Ask user:** "Which file should I modify?"

**Then:**
1. Read the `_chg.md` file for that content
2. Extract instructions from `[INSTRUCTIONS FOR THIS REVISION]` section
3. Validate target file exists
4. Check git status for uncommitted changes

---

## Step 2: Apply Modifications

1. Load target content file
2. Apply specified modifications
3. Preserve formatting and structure
4. Update metadata (word count, status)

---

## Step 3: Anti-Hallucination Verification

**CRITICAL: ASK FIRST before finalizing content containing:**

| Content Type | Action |
|--------------|--------|
| Personal stories/anecdotes | Ask: Real experience, hypothetical, or generic? |
| Statistics/data | Request source or use placeholder |
| Quotes | Request source or mark ⏳ Pending |
| Specific examples | Verify real or mark hypothetical |

**Labels to use:**
- ✅ REAL EXPERIENCE (confirmed by user)
- ✅ HYPOTHETICAL SCENARIO (marked with "Imagine...")
- ✅ GENERIC STATEMENT ("Many authors...")
- ✅ [CITATION NEEDED] (for later verification)
- ⏳ Pending verification (quotes)

📖 **For detailed examples:** See `Process/Prompts/Prompt_3_Reference.md`

---

## Step 4: Style Consistency Check

**Resolve active style (cascading):**
1. Section override? (`<!-- STYLE_OVERRIDE: StyleName -->`)
2. Chapter override? (`Chapter_XX_style.md`)
3. Book-level default (`Style_Guide.md`)

**Report active style:**
```
Active Style: [StyleName] ([source])
```

**If issues found:**
- Minor: Note in report
- Moderate: Ask user to fix or auto-correct
- Significant: Highlight and offer suggestions

---

## Step 5: Auto-Archive Instructions

1. Move completed instructions to Version History section
2. Increment version (Major.Minor.Patch per Prompt_Essentials)
3. Clear `[INSTRUCTIONS FOR THIS REVISION]` section
4. Add timestamp and version to archive entry

---

## Step 6: Git Commit

**CLI:**
```bash
git add [file-path] [file-path]_chg.md && git commit -m "$(cat <<'EOF'
[Description] v[version]

[Details of changes]

🤖 Generated with Claude Code

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

**Desktop:** Provide copy/paste command for Claude Code CLI.

---

## Step 7: Release Lock & Report

1. Remove lock entry from `.locks/locks.json`
2. Display confirmation: `✓ Lock released: Chapter_XX`
3. Generate modification report

---

## Important Notes

- **Single source of truth:** _chg file contains your instructions
- **Auto-archive:** Completed instructions move to Version History
- **Version increment:** Chosen based on change scope
- **Style check:** Optional - skip with "skip style check"

---

📖 **For detailed examples and troubleshooting:** See `Process/Prompts/Prompt_3_Reference.md`

📋 **Quick references:** Prompt_Essentials.md (Lock Management, Anti-Hallucination, Git Format)

---

**Version:** 0.14.3
**Last Updated:** 2025-11-24
**Token Efficiency:** 67% reduction

---

## Session Cleanup

**After this prompt completes:**

Tell user: "✓ Prompt 3 Change by Chg complete.

To free up tokens for your next task, you can say:
**'Clear Prompt 3 from context'**"
