# Execute Prompt 4: Interactive Change

**DESKTOP-FRIENDLY:** Works in Claude Desktop with MCP Filesystem + single copy/paste git commit at end

**FIRST ACTION - MANDATORY:**
Use the Read tool to read `Process/Anti-Hallucination_Guidelines.md` in full before proceeding with ANY other actions or questions.

**CRITICAL ENFORCEMENT:**
- **RULE 1:** All file modifications MUST update corresponding _chg files
- **RULE 2:** All Manuscript/ changes must go through appropriate prompts

See: `Process/ENFORCEMENT_RULES.md` for complete details

**DATE CONFIRMATION REQUIRED:**
- **USE CONFIRMED_DATE from session startup** (see CLAUDE.md Date Confirmation Protocol)
- **NEVER use raw `<env>` date** without confirmation
- Pass confirmed date to any spawned agents: "Today's confirmed date is [CONFIRMED_DATE]. Use this date for all operations."

**AGENT INSTRUCTIONS:**
When spawning agents (using Task tool), include in agent prompt:
- "FIRST ACTION: Read Process/Anti-Hallucination_Guidelines.md before proceeding."
- "Today's confirmed date is [CONFIRMED_DATE]. Use this date for all operations."

**Claude Desktop Compatibility:**
- ✅ All file operations via MCP Filesystem connector
- ✅ Single git commit command provided as copy/paste at end
- ✅ No bash commands required during execution
- 📋 Works 95% in Desktop

---

## What This Does

I will have an **interactive conversation** with you about changes to your content, then write clear instructions to the appropriate `_chg.md` file. This is an **alternative to manually editing _chg files** - you describe what you want in natural language, and I formalize it.

**Workflow difference:**
- **Prompt 3 (Change_by_Chg)**: You manually write instructions in _chg file → Execute Prompt 3 → Changes applied
- **Prompt 4 (Interactive_Change)**: You describe changes conversationally → I write to _chg file → Optionally execute Prompt 3

**When to use Prompt 4:**
- You want to discuss changes interactively before committing
- You're not sure how to phrase instructions
- You want to explore different approaches through conversation
- You want me to help structure your revision ideas

**When to use Prompt 3:**
- You already know exactly what changes you want
- You prefer to write instructions yourself
- You're following a pre-planned revision outline

---

## How This Works

### My Workflow:

**Step 1: Ask which file to edit**

I'll ask: "Which file do you want to edit?"

Available file types:
- **Chapters**: `Manuscript/Chapters/Chapter_XX/Chapter_XX.md`
- **Front Matter**: `Manuscript/FrontMatter/Title_Page.md`, `Preface.md`, `Dedication.md`, etc.
- **Back Matter**: `Manuscript/BackMatter/Appendix_A.md`, `Bibliography.md`, etc.
- **Quotes**: `Manuscript/Quotes/Chapter_Quotes.md`
- **Style**: `Manuscript/Style/Style_Guide.md`, `Style_Overrides.md`
- **TOC**: `Manuscript/_TOC_/TOC.md` (⚠️ WARNING: Managed by Prompts 1 and 2)

**Special case - TOC editing:**
If you select TOC, I'll warn you:
> "⚠️ WARNING: TOC.md is managed by Prompts 1 and 2. Direct edits may be overwritten when adding/reordering chapters. Are you sure you want to edit it? (yes/no)"

If you say yes, I'll proceed. If no, I'll stop.

---

**Step 2: Conversational editing session**

I'll engage in a natural conversation to understand your desired changes:

**Example conversation:**
```
Me: What changes would you like to make to this file?

You: I want to improve the introduction

Me: Can you be more specific? What aspects of the introduction need work?

You: It's too dry. I want to start with a compelling anecdote

Me: Great! Do you have a specific anecdote in mind, or would you like me to help develop one?

You: I have one - about a client who struggled with writer's block

Me: Perfect. What should the anecdote illustrate?

You: That writer's block often comes from perfectionism, not lack of ideas

Me: Excellent. Should this anecdote replace the current opening paragraph, or come after the thesis statement?

You: Replace the current opening

Me: Anything else you want to change in the introduction?

You: Yes, add a transition to the first section that's smoother

Me: Got it. Any other changes to this file?

You: No, that's all
```

**I'll ask clarifying questions like:**
- Where exactly should this change go?
- Should I replace existing content or add to it?
- What's the purpose/rationale for this change?
- Do you have specific examples or should I mark them as placeholders?
- Are there any constraints I should know about?

**You can:**
- Refine instructions as we talk
- Add more changes during conversation
- Say "that's all" when done

---

**Step 3: Write to _chg file**

I'll format your instructions clearly in the `_chg.md` file following these conventions:

```markdown
## REWRITE INSTRUCTIONS

### [INSTRUCTIONS FOR THIS REVISION]

[Date: YYYY-MM-DD]

**Changes requested:**

1. Replace opening paragraph with anecdote about client and writer's block
   - Anecdote should illustrate: Writer's block comes from perfectionism, not lack of ideas
   - Use client example: [PROVIDE REAL EXAMPLE - do not fabricate]
   - Placement: Replace current opening paragraph (lines 1-5)

2. Improve transition to first section
   - Current transition is abrupt
   - Create smoother flow from anecdote to Section 1 ("Understanding the Problem")
   - Goal: Connect personal story to broader thesis

**Priority:** Medium
**Rationale:** Introduction needs to hook reader with concrete example before presenting thesis
**Estimated scope:** Minor revision (patch version bump)
```

**Anti-Hallucination markers I'll use:**
- `[PROVIDE REAL EXAMPLE - do not fabricate]` - Prompts you to supply real content
- `[CITATION NEEDED]` - Statistics or claims needing sources
- `[VERIFY QUOTE]` - Quotes needing source verification
- `⏳ Pending` - Content needing user confirmation

---

**Step 4: Show you the instructions**

I'll display the formatted instructions and ask:
> "Here are the instructions I'll write to the _chg file. Do these accurately capture what you want? (yes/edit/cancel)"

**Your options:**
- **yes**: Proceed to write and commit
- **edit**: Tell me what to adjust, I'll revise
- **cancel**: Abort without writing anything

---

**Step 5: Commit _chg file**

**For Claude Code CLI users:**
I'll automatically commit the _chg file with this message format:
```
Add change instructions for [filename]

Interactive session via Prompt 4 (Interactive_Change)

Changes planned:
- [Brief summary of changes]

Next step: Execute Prompt 3 to apply changes

🤖 Generated with Claude Code

Co-Authored-By: Claude <noreply@anthropic.com>
```

**For Claude Desktop users:**
I'll provide this command to copy/paste into Claude Code CLI:

```
Run: git add [path-to-chg-file] && git commit -m 'Add change instructions for [filename]

Interactive session via Prompt 4 (Interactive_Change)

Changes planned:
- [Brief summary of changes]

Next step: Execute Prompt 3 to apply changes

🤖 Generated with Claude Desktop

Co-Authored-By: Claude <noreply@anthropic.com>'
```

---

**Step 6: Offer to apply changes**

After committing the _chg file, I'll ask:
> "Apply changes now? (yes/no)"

**If you say YES:**
- I'll automatically execute Prompt 3 (Change_by_Chg) in the same session
- Your changes will be applied immediately
- Both the _chg file (with instructions) and content file (with changes) will be committed

**If you say NO:**
- Session ends here
- You can execute Prompt 3 later when ready
- The _chg file contains your instructions and is committed

---

## Example Full Session

**User:** Execute Prompt 4

**Me:** Which file do you want to edit?

**User:** Chapter 3

**Me:** I'll work with `Manuscript/Chapters/Chapter_03/Chapter_03.md`. What changes would you like to make?

**User:** The data collection section is too technical

**Me:** Can you elaborate? What specifically makes it too technical?

**User:** Too much jargon, and no concrete examples

**Me:** Got it. Would you like me to:
A) Simplify the language (reduce jargon)
B) Add concrete examples
C) Both

**User:** Both

**Me:** For the examples - do you have specific examples in mind, or should I add placeholders for you to fill in?

**User:** I have examples from my research

**Me:** Perfect. How many examples should I tell Prompt 3 to add?

**User:** Two examples

**Me:** Where should they go in the section?

**User:** After the explanation of each survey method

**Me:** Great. Anything else you want to change?

**User:** No, that's it

**Me:** Here are the instructions I'll write to the _chg file:

```markdown
### [INSTRUCTIONS FOR THIS REVISION]

[Date: 2025-11-20]

**Changes requested:**

1. Simplify language in "Data Collection" section
   - Remove or explain jargon (identify terms that need simplification)
   - Use more accessible language for general audience
   - Maintain technical accuracy while improving clarity

2. Add concrete examples from research
   - Add example #1 after survey method explanation (paragraph 3)
   - Add example #2 after survey method explanation (paragraph 7)
   - Examples should be: [PROVIDE REAL RESEARCH EXAMPLES - do not fabricate]
   - Format: Brief description (2-3 sentences) showing method in practice

**Priority:** High
**Rationale:** Section is currently too dense for target audience; needs concrete grounding
**Estimated scope:** Minor revision (0.X.0)
```

Do these accurately capture what you want? (yes/edit/cancel)

**User:** yes

**Me:** ✓ Instructions written to `Manuscript/Chapters/Chapter_03/Chapter_03_chg.md`

[Provides git commit command for Claude Desktop users, or auto-commits for CLI users]

Apply changes now? (yes/no)

**User:** yes

**Me:** [Automatically executes Prompt 3: Change_by_Chg]

[Applies changes, creates second commit with modified content]

✓ Changes applied successfully!

---

## Anti-Hallucination Integration

**During the conversational editing phase:**

I will **ASK YOU** before suggesting:
- Specific examples or anecdotes (never fabricate)
- Statistics or data (request source or mark [CITATION NEEDED])
- Quotes (request source or mark ⏳ Pending)
- Personal experiences (confirm if REAL vs HYPOTHETICAL)

**In the _chg file instructions:**

I will use clear markers:
- `[PROVIDE REAL EXAMPLE - do not fabricate]`
- `[CITATION NEEDED: statistic about X]`
- `[VERIFY QUOTE from Author Name]`
- `⏳ Pending verification`

**When Prompt 3 executes:**

It will see these markers and:
- Pause to ask you for real examples
- Request citations for statistics
- Verify quote sources
- Never fabricate content

See: `Process/Anti-Hallucination_Guidelines.md` for complete protocol

---

## Style Consistency

**The instructions I write will consider:**

1. **Active style resolution** (hierarchical system v0.10.1+):
   - Book-level style (Style_Guide.md)
   - Chapter-level override (Chapter_XX_style.md if exists)
   - Section-level override (HTML markers in content)

2. **Style notes in instructions:**
   If the file has a style override, I'll note it:
   ```markdown
   **Style note:** This chapter uses [Style Name] override
   - Maintain [key characteristics]
   - Changes should align with this style
   ```

See: `Process/_COMMON/10_Style_Consistency_Protocol.md`

---

## Important Notes

### About TOC Editing

**⚠️ WARNING:** `Manuscript/_TOC_/TOC.md` is managed by Prompts 1 and 2.

The TOC file has a warning header:
> "⚠️ WARNING: This file is managed by Prompts 1 and 2. Direct edits may be overwritten. Use Prompt 2 to add/reorder chapters."

**If you insist on editing TOC:**
- I'll allow it but warn you about potential overwrites
- Your changes may be lost if you later use Prompt 2
- Only use for minor fixes (typos, formatting)
- For structural changes (adding/reordering chapters), use Prompt 2

### Difference from Prompt 3

**Prompt 4 (Interactive_Change):**
- Conversational, exploratory
- I help you formulate instructions
- Writes to _chg file for you
- Optional immediate execution

**Prompt 3 (Change_by_Chg):**
- Direct execution
- You write instructions yourself
- Reads _chg file and applies
- Always executes immediately

**Both can work together:**
1. Use Prompt 4 to discuss and write instructions
2. Say "no" to immediate application
3. Later, use Prompt 3 to apply when ready

### Process/_COMMON Modules Used

This prompt uses:
- **Module 01:** Prompt Structure Template
- **Module 02:** Desktop Compatibility (DESKTOP-FRIENDLY)
- **Module 03:** Anti-Hallucination Protocols (Level 3)
- **Module 04:** File Operations Library (_chg file writes)
- **Module 05:** Git Integration Module (commit format)
- **Module 06:** Validation Protocols (file existence checks)
- **Module 08:** Semantic Versioning Guide (scope estimation)
- **Module 10:** Style Consistency Protocol (style resolution)
- **Module 11:** Interactive Patterns (conversational Q&A)
- **Module 14:** Enforcement Rules (RULE 1 compliance)

---

## Git Commit Format

See: `Process/_COMMON/05_Git_Integration_Module.md` for commit format templates

**For Claude Desktop users**, the git commit command format is:

```
Run: git add [file-path] && git commit -m 'Commit message here

🤖 Generated with Claude Desktop

Co-Authored-By: Claude <noreply@anthropic.com>'
```

---

## Ready to Begin?

**I'm ready to help you edit your content interactively.**

Just tell me which file you want to work on, and we'll start the conversation!

---

*Reference: Process/_COMMON/11_Interactive_Patterns.md*
*Created: v0.11.0*
*Prompt Type: Interactive content editing workflow*
