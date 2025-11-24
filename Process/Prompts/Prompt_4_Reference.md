# Prompt 4 Reference Documentation

**Version:** 0.14.0
**Purpose:** Detailed examples, edge cases, and troubleshooting for Interactive Change workflow

---

## Overview

This document contains comprehensive examples and edge cases for Prompt 4 (Interactive Change). The core workflow is in `Prompt_4_Interactive_Change.md` - use this file for reference only.

---

## Example Full Session 1: Simple Edit

**User:** Execute Prompt 4

**Claude:** Which file do you want to edit?

**User:** Chapter 3

**Claude:** I'll work with `Manuscript/Chapters/Chapter_03/Chapter_03.md`. What changes would you like to make?

**User:** The data collection section is too technical

**Claude:** Can you elaborate? What specifically makes it too technical?

**User:** Too much jargon, and no concrete examples

**Claude:** Got it. Would you like me to:
A) Simplify the language (reduce jargon)
B) Add concrete examples
C) Both

**User:** Both

**Claude:** For the examples - do you have specific examples in mind, or should I add placeholders for you to fill in?

**User:** I have examples from my research

**Claude:** Perfect. How many examples should I tell Prompt 3 to add?

**User:** Two examples

**Claude:** Where should they go in the section?

**User:** After the explanation of each survey method

**Claude:** Great. Anything else you want to change?

**User:** No, that's it

**Claude:** Here are the instructions I'll write to the _chg file:

```markdown
### [INSTRUCTIONS FOR THIS REVISION]

[Date: 2025-11-24]

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

**Claude:** ✓ Instructions written to `Manuscript/Chapters/Chapter_03/Chapter_03_chg.md`

[Commits the _chg file]

Apply changes now? (yes/no)

**User:** yes

**Claude:** [Executes Prompt 3: Change_by_Chg]

[Applies changes, creates second commit with modified content]

✓ Changes applied successfully!

---

## Example Full Session 2: Complex Edit with Anecdote

**User:** Execute Prompt 4

**Claude:** Which file do you want to edit?

**User:** Chapter 1 introduction

**Claude:** I'll work with `Manuscript/Chapters/Chapter_01/Chapter_01.md`. What changes would you like to make?

**User:** The introduction is too dry. I want to start with a compelling anecdote

**Claude:** Do you have a specific anecdote in mind, or would you like me to help develop one?

**User:** I have one - about a client who struggled with writer's block

**Claude:** Perfect. Before I write the instructions, I need to clarify a few things to ensure I don't fabricate details:

1. Is this a REAL client with a REAL story you want to share?
2. Do you have permission to share this story (privacy/consent)?
3. Or would you prefer a HYPOTHETICAL/GENERIC example?

**User:** It's a real client, and I have permission. I'll provide the details

**Claude:** Excellent. What should the anecdote illustrate?

**User:** That writer's block often comes from perfectionism, not lack of ideas

**Claude:** Should this anecdote replace the current opening paragraph, or come after the thesis statement?

**User:** Replace the current opening

**Claude:** Anything else you want to change in the introduction?

**User:** Yes, add a transition to the first section that's smoother

**Claude:** Where is the first section? What's its title?

**User:** Section 1.1 "Understanding the Problem"

**Claude:** Got it. Any other changes?

**User:** No, that's all

**Claude:** Here are the instructions I'll write:

```markdown
### [INSTRUCTIONS FOR THIS REVISION]

[Date: 2025-11-24]

**Changes requested:**

1. Replace opening paragraph with client anecdote about writer's block
   - **REAL CLIENT STORY** (user has permission to share)
   - Details to include: [USER WILL PROVIDE - do not fabricate]
   - Anecdote should illustrate: Writer's block comes from perfectionism, not lack of ideas
   - Placement: Replace current opening paragraph (lines 1-5)
   - Length: 150-200 words
   - Tone: Empathetic, relatable, concrete

2. Improve transition to Section 1.1 "Understanding the Problem"
   - Current transition is abrupt (line 12)
   - Create smoother flow from personal anecdote to broader analysis
   - Goal: Connect individual story to systemic issue
   - Length: 1-2 sentences

**Priority:** High
**Rationale:** Introduction needs to hook reader with concrete example before presenting thesis
**Estimated scope:** Minor revision (0.X.0)

**Anti-Hallucination Notes:**
- ⏳ Pending: User will provide real client anecdote details
- DO NOT fabricate client name, situation, or dialogue
- If user provides insufficient detail, ASK for more information
```

Do these accurately capture what you want? (yes/edit/cancel)

**User:** yes

**Claude:** ✓ Instructions written to `Manuscript/Chapters/Chapter_01/Chapter_01_chg.md`

[Commits]

Apply changes now? (yes/no)

**User:** no

**Claude:** Understood. Instructions are saved in the _chg file. When you're ready to apply these changes, execute Prompt 3 (Change_by_Chg).

**Next step:** Before running Prompt 3, you should provide the client anecdote details by editing the _chg file or having them ready when Prompt 3 asks.

✓ Prompt 4 complete. Instructions saved to `Chapter_01_chg.md`.

To free up tokens for your next task, you can say:
**'Clear Prompt 4 from context'**

---

## Example Full Session 3: TOC Edit with Warning

**User:** Execute Prompt 4

**Claude:** Which file do you want to edit?

**User:** Table of contents

**Claude:** ⚠️ WARNING: `Manuscript/_TOC_/TOC.md` is managed by Prompts 1 and 2. Direct edits may be overwritten when adding/reordering chapters.

**Recommended:**
- Use Prompt 2 (Add_Chapter) to add/reorder chapters
- Only use Prompt 4 for minor fixes (typos, formatting)

Do you still want to edit TOC directly? (yes/no)

**User:** yes, just fixing a typo

**Claude:** Understood. What changes would you like to make?

**User:** Chapter 5 title has a typo - "Implmentation" should be "Implementation"

**Claude:** Got it. Just to confirm - you only want to fix the typo in Chapter 5's title, correct?

**User:** Correct

**Claude:** Anything else?

**User:** No

**Claude:** Here are the instructions:

```markdown
### [INSTRUCTIONS FOR THIS REVISION]

[Date: 2025-11-24]

**Changes requested:**

1. Fix typo in Chapter 5 title
   - Current: "Implmentation Strategies"
   - Corrected: "Implementation Strategies"
   - Location: Chapter 05 heading (line ~45)

**Priority:** Low (typo fix)
**Rationale:** Correct spelling error
**Estimated scope:** Patch (0.0.X)

**Note:** This is a direct TOC edit. If chapters are added/reordered via Prompt 2, this change will need to be reapplied.
```

Do these accurately capture what you want? (yes/edit/cancel)

**User:** yes

**Claude:** ✓ Instructions written to `Manuscript/_TOC_/TOC_chg.md`

[Commits]

Apply changes now? (yes/no)

**User:** yes

**Claude:** [Executes Prompt 3]

✓ Typo fixed in TOC!

---

## Edge Cases and Troubleshooting

### Edge Case 1: Multiple Files in One Session

**Q:** Can I edit multiple files in one Prompt 4 session?

**A:** No. Prompt 4 handles one file per execution. The lock system prevents concurrent edits to multiple resources.

**Workflow for multiple files:**
1. Execute Prompt 4 for File A
2. Complete instructions, apply or save
3. Clear Prompt 4 from context
4. Execute Prompt 4 again for File B
5. Repeat

### Edge Case 2: User Changes Mind During Conversation

**User:** Actually, nevermind, I don't want to make those changes

**Claude:** No problem. I'll cancel this session without writing any instructions.

✓ Session cancelled. No changes made.

### Edge Case 3: User Wants to Edit Instructions After Seeing Them

**Claude:** [Shows instructions]

Do these accurately capture what you want? (yes/edit/cancel)

**User:** edit - I also want to add a new section

**Claude:** Understood. What new section would you like to add?

**User:** A section on best practices, after the examples

**Claude:** Got it. What should the best practices section cover?

[Conversation continues, instructions revised]

**Claude:** Here are the revised instructions:

[Shows updated instructions including new section]

Do these accurately capture what you want? (yes/edit/cancel)

**User:** yes

[Proceeds with commit]

### Edge Case 4: Lock Conflict

**Claude:** ⚠️ Chapter_03 is currently locked by another instance.

Lock details:
- Resource: Chapter_03
- Locked at: 2025-11-24 14:32:00 (3 minutes ago)
- Instance: Desktop-67890

Another editing operation may be in progress on this chapter.

Options:
1. Wait for lock to clear (checks every 5 seconds)
2. Cancel operation

Choose option (1-2):

**User:** 1

**Claude:** Waiting for lock to clear...

[Checks every 5 seconds]

✓ Lock cleared! Proceeding with Chapter 03 edit.

Which file do you want to edit?

**User:** Chapter 3

[Session continues normally]

### Edge Case 5: Stale Lock Override

**Claude:** ⚠️ Chapter_05 has a stale lock (older than 15 minutes).

Lock details:
- Resource: Chapter_05
- Locked at: 2025-11-24 14:00:00 (32 minutes ago)
- Instance: CLI-12345

This lock may be from a crashed instance.

Options:
1. Override stale lock and continue
2. Cancel operation

Choose option (1-2):

**User:** 1

**Claude:** ✓ Stale lock overridden. Proceeding with Chapter 05 edit.

[Continues normally]

---

## Anti-Hallucination Examples

### Example 1: User Wants Fabricated Statistics

**User:** Add some statistics about productivity gains

**Claude:** I can add placeholders for statistics, but I need to clarify:

1. Do you have specific statistics you want to include?
2. Or should I mark this as `[CITATION NEEDED]` for you to find later?

I cannot fabricate statistics - they must be real and cited.

**User:** I'll find them later

**Claude:** Perfect. I'll mark it as `[CITATION NEEDED: productivity gains statistics]` in the instructions.

### Example 2: User Wants Generic Example

**User:** Add an example of someone using this technique

**Claude:** I can add a placeholder for an example. To clarify:

1. Do you have a REAL example from your experience?
2. Should this be a HYPOTHETICAL example (clearly labeled)?
3. Should this be a GENERIC example (anonymous, no specific details)?

**User:** Make it generic

**Claude:** Understood. I'll mark it as `[GENERIC EXAMPLE: technique application]` so Prompt 3 knows to create a generic scenario without fabricating specific people or details.

### Example 3: User Provides Quote Without Source

**User:** Add this quote: "The best time to plant a tree was 20 years ago..."

**Claude:** That's a great quote! Do you know the source/attribution?

**User:** I think it's a Chinese proverb?

**Claude:** I'll mark it as `[VERIFY QUOTE: Chinese proverb - "The best time to plant a tree..."]` so you can confirm the attribution before Prompt 3 applies it.

---

## Advanced Workflows

### Workflow 1: Batch Editing with Deferred Execution

**Goal:** Prepare instructions for multiple chapters, then apply all at once

**Steps:**
1. Execute Prompt 4 for Chapter 1
   - Write instructions
   - Say "no" to immediate application
   - Clear Prompt 4 from context

2. Execute Prompt 4 for Chapter 2
   - Write instructions
   - Say "no" to immediate application
   - Clear Prompt 4 from context

3. Repeat for all chapters

4. Execute Prompt 3 repeatedly to apply all changes:
   - Prompt 3 for Chapter 1
   - Prompt 3 for Chapter 2
   - Etc.

**Benefits:**
- Plan all changes in one session
- Review all instructions before applying
- Apply changes when you have time

### Workflow 2: Iterative Refinement

**Goal:** Apply changes, review, refine, apply again

**Steps:**
1. Execute Prompt 4
   - Write initial instructions
   - Apply immediately

2. Review the applied changes

3. Execute Prompt 4 again
   - Add refinement instructions
   - Apply immediately

4. Repeat until satisfied

**Note:** Each iteration creates a new version in the _chg file's Version History.

### Workflow 3: Style Override During Editing

**Goal:** Apply a section-level style override while editing

**Steps:**
1. Execute Prompt 4

2. In conversation, mention: "For this section, use Technical Precision style instead of the book default"

3. Claude writes instructions including:
   ```markdown
   **Style Override:**
   - Add section-level style markers:
     ```html
     <!-- STYLE_OVERRIDE: Technical Precision -->
     [Section content]
     <!-- END_STYLE_OVERRIDE -->
     ```
   - Register override in Style_Overrides.md
   ```

4. Apply changes

**Note:** Prompt 3 will handle the override registration automatically.

---

## Prompt 4 vs Prompt 3 Decision Matrix

| Scenario | Use Prompt 4 | Use Prompt 3 |
|----------|--------------|--------------|
| Not sure what changes to make | ✅ Yes | ❌ No |
| Need to explore options | ✅ Yes | ❌ No |
| Want AI to help structure ideas | ✅ Yes | ❌ No |
| Know exactly what to change | ⚠️ Optional | ✅ Yes |
| Already wrote instructions | ❌ No | ✅ Yes |
| Want to discuss changes first | ✅ Yes | ❌ No |
| Want immediate execution | ⚠️ Optional | ✅ Yes |
| Editing multiple files in sequence | ✅ Yes (one at a time) | ✅ Yes (one at a time) |

---

## Common Mistakes

### Mistake 1: Trying to Edit Multiple Files at Once

**Wrong:**
> "Edit Chapter 3 and Chapter 5"

**Right:**
> "Edit Chapter 3" [complete session] → "Edit Chapter 5" [new session]

### Mistake 2: Being Too Vague

**Wrong:**
> "Make it better"

**Right:**
> "The introduction is too technical. Simplify the language and add a concrete example after paragraph 2."

### Mistake 3: Not Clearing Context After Completion

**Impact:** Wastes 2,000+ tokens per completed session

**Fix:** After Prompt 4 completes, say "Clear Prompt 4 from context"

### Mistake 4: Forgetting to Provide Real Examples

**Wrong:** Approve instructions with `[PROVIDE REAL EXAMPLE]` then expect Prompt 3 to fabricate

**Right:** Before running Prompt 3, prepare your real examples so you can provide them when asked

---

## Performance Notes

**Token Usage (v0.14.0):**
- Core prompt: ~2,000 tokens
- Reference (this file): ~6,000 tokens (loaded on-demand)
- Total if needed: ~8,000 tokens (vs 53,000 in v0.13.0)

**Best Practice:**
- Only load this reference file if you need detailed examples
- For typical editing sessions, core prompt is sufficient
- Clear context after completion to reclaim tokens

---

## Module References

**Prompt 4 uses these Process/_COMMON modules:**
- Module 02: Desktop Compatibility
- Module 03: Anti-Hallucination Protocols
- Module 04: File Operations Library
- Module 05: Git Integration Module
- Module 08: Semantic Versioning Guide
- Module 10: Style Consistency Protocol
- Module 11: Interactive Patterns
- Module 14: Enforcement Rules
- Module 18: Lock Management Module

**Load these on-demand if you encounter issues or need specific protocol details.**

---

## Version History

**v0.14.0 (2025-11-24):**
- Split into core + reference for 95% token reduction
- Streamlined workflow documentation
- Added session cleanup instructions

**v0.13.0 (2025-11-23):**
- Added lock management system
- mkdir syntax fix for cross-platform compatibility

**v0.11.0 (original):**
- Initial Interactive Change workflow

---

**Version:** 0.14.0
**Last Updated:** 2025-11-24
**For Core Workflow:** See `Prompt_4_Interactive_Change.md`
