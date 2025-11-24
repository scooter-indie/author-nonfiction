# Execute Prompt 4: Interactive Change

**Version:** 0.14.0
**DESKTOP-FRIENDLY:** Works in Claude Desktop with MCP Filesystem
**⚡ Token Efficient:** ~2,000 tokens (95% reduction from v0.13.0)

---

## Quick Start

**I will have an interactive conversation with you about changes to your content, then write clear instructions to the `_chg.md` file.**

### Workflow (6 Steps)

1. **Lock chapter** → Acquire lock for the chapter you're editing
2. **Ask you:** "Which file do you want to edit?"
3. **Converse:** Have natural conversation about desired changes
4. **Write instructions:** Format instructions clearly in `_chg.md` file
5. **Show you:** Display instructions for review (yes/edit/cancel)
6. **Apply now?** Optionally execute Prompt 3 to apply changes immediately

---

## Step 0: Lock Management

**Initialize locks:**
- Create `.locks/` directory: `mkdir -p .locks`
- Create `.locks/locks.json` if not exists: `{"locks": []}`
- Generate instance ID: `CLI-[5-digit-random]` or `Desktop-[5-digit-random]`

**Acquire lock:**
- User specifies file → Determine chapter (e.g., `Chapter_03.md` → Resource: `Chapter_03`)
- Check if `Chapter_XX` is locked
- If locked < 15 min: Offer to wait or cancel
- If locked >= 15 min (stale): Offer to override or cancel
- Acquire lock:
  ```json
  {
    "resource": "Chapter_XX",
    "timestamp": "[ISO-8601]",
    "instance": "[instance_id]"
  }
  ```

**Full lock protocol:** See `Process/_COMMON/18_Lock_Management_Module.md`

---

## Step 1: Ask Which File

**Available file types:**
- Chapters: `Manuscript/Chapters/Chapter_XX/Chapter_XX.md`
- Front Matter: `Manuscript/FrontMatter/*.md`
- Back Matter: `Manuscript/BackMatter/*.md`
- Quotes: `Manuscript/Quotes/Chapter_Quotes.md`
- Style: `Manuscript/Style/*.md`
- TOC: `Manuscript/_TOC_/TOC.md` ⚠️ Managed by Prompts 1/2

**TOC warning:** If user selects TOC, warn: "⚠️ TOC is managed by Prompts 1 and 2. Direct edits may be overwritten. Continue? (yes/no)"

---

## Step 2: Conversational Editing

**Ask clarifying questions:**
- What changes would you like to make?
- Can you be more specific about [aspect]?
- Where exactly should this change go?
- Should I replace existing content or add to it?
- Do you have specific examples or should I mark placeholders?
- What's the rationale for this change?
- Anything else you want to change?

**Continue until user says:** "That's all" or "No more changes"

---

## Step 3: Write to _chg File

**Format instructions in `[filename]_chg.md`:**

```markdown
### [INSTRUCTIONS FOR THIS REVISION]

[Date: CONFIRMED_DATE]

**Changes requested:**

1. [Clear, actionable instruction]
   - [Specific details]
   - Placement: [Where in file]
   - [Any constraints or notes]

2. [Next instruction]
   - [Details]

**Priority:** [High/Medium/Low]
**Rationale:** [Why these changes are needed]
**Estimated scope:** [Major/Minor/Patch version bump]

**Anti-Hallucination Notes:**
- [PROVIDE REAL EXAMPLE - do not fabricate]
- [CITATION NEEDED: statistic about X]
- [VERIFY QUOTE from Author Name]
- ⏳ Pending verification
```

**Anti-Hallucination Protocol:**
- **ASK before** suggesting examples/anecdotes/statistics/quotes
- **NEVER fabricate** - use placeholders instead
- **Mark clearly**: `[PROVIDE REAL EXAMPLE]`, `[CITATION NEEDED]`, `[VERIFY QUOTE]`
- See: `Process/Anti-Hallucination_Guidelines.md`

---

## Step 4: Show Instructions for Review

Display formatted instructions and ask:
> "Here are the instructions I'll write to the _chg file. Do these accurately capture what you want? (yes/edit/cancel)"

**Options:**
- **yes**: Proceed to commit
- **edit**: Revise based on feedback
- **cancel**: Abort without writing

---

## Step 5: Commit _chg File

**Claude Code CLI (auto-commit):**
```
git add [chg-file] && git commit -m "Add change instructions for [filename]

Interactive session via Prompt 4

Changes planned:
- [Brief summary]

Next step: Execute Prompt 3 to apply changes

🤖 Generated with Claude Code

Co-Authored-By: Claude <noreply@anthropic.com>"
```

**Claude Desktop (copy/paste command):**
```
Run: git add [chg-file] && git commit -m 'Add change instructions for [filename]

Interactive session via Prompt 4

Changes planned:
- [Brief summary]

Next step: Execute Prompt 3 to apply changes

🤖 Generated with Claude Desktop

Co-Authored-By: Claude <noreply@anthropic.com>'
```

---

## Step 6: Apply Changes Now?

Ask: "Apply changes now? (yes/no)"

**If YES:**
- Execute Prompt 3 (Change_by_Chg) immediately
- Changes applied in same session
- Lock passes to Prompt 3 execution

**If NO:**
- Session ends
- Instructions saved in _chg file (committed)
- User can execute Prompt 3 later

---

## Release Locks

**CRITICAL:** Release lock even if operation fails.

1. Read `.locks/locks.json`
2. Remove lock where `"resource": "Chapter_XX"` AND `"instance": "[instance_id]"`
3. Write updated JSON
4. Confirm: `✓ Lock released: Chapter_XX`

---

## Session Cleanup

**After this prompt completes:**

Tell user: "✓ Prompt 4 complete. Instructions saved to `[filename]_chg.md`.

To free up tokens for your next task, you can say:
**'Clear Prompt 4 from context'**

This will save ~2,000 tokens (or ~53,000 tokens in v0.13.0) for your next editing session."

---

## Important Notes

**Prompt 4 vs Prompt 3:**
- **Prompt 4**: Conversational, exploratory → I help write instructions → Optional immediate execution
- **Prompt 3**: Direct execution → You write instructions → Always executes immediately

**They work together:**
1. Use Prompt 4 to discuss and write instructions
2. Say "no" to immediate application
3. Use Prompt 3 later to apply when ready

**Style Consistency:**
- Instructions consider active style (book/chapter/section overrides)
- Note style overrides in instructions if present
- See: `Process/_COMMON/10_Style_Consistency_Protocol.md`

**Date Handling:**
- Use CONFIRMED_DATE from session startup (see CLAUDE.md)
- NEVER use raw `<env>` date without confirmation

---

## Ready to Begin?

**I'm ready to help you edit your content interactively.**

Just tell me which file you want to work on, and we'll start the conversation!

---

📖 **For detailed examples, edge cases, and full workflows:** See `Process/Prompts/Prompt_4_Reference.md`

🔒 **For complete lock management details:** See `Process/_COMMON/18_Lock_Management_Module.md`

🎨 **For style consistency rules:** See `Process/_COMMON/10_Style_Consistency_Protocol.md`

⚠️ **For anti-hallucination protocol:** See `Process/Anti-Hallucination_Guidelines.md`

---

**Version:** 0.14.0
**Last Updated:** 2025-11-24
**Token Efficiency:** 95% reduction (53,000 → 2,000 tokens)

*Prompt Type: Interactive content editing workflow*
*Created: v0.11.0*
*Optimized: v0.14.0*
