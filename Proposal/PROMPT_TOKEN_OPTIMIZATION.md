# Prompt Token Optimization

**Status:** Proposal
**Target Version:** 0.14.0
**Created:** 2025-11-24
**Performance Goal:** 60-70% reduction in prompt token usage

---

## Problem Statement

**Prompt 4 (Interactive Change) consumes 53,000 tokens** - 66% of a typical session's token budget.

**User Impact:**
- Prompt 1: ~25,000 tokens (initialization, needed once)
- Prompt 4: ~53,000 tokens (interactive editing, used repeatedly)
- **Total:** 78,000 tokens before any actual work
- Only 119,000 tokens remaining for content generation

**Root Causes:**
1. **Redundant mandatory reads:** Every prompt requires reading Lock Management + Anti-Hallucination modules
2. **Embedded instructions:** Large example conversations and workflows embedded in prompts
3. **Context retention:** Prompt stays in context after execution completes
4. **No cleanup:** Old prompts accumulate in session without release

---

## Solution 1: Modular Prompt Structure (RECOMMENDED)

### Overview

Split prompts into **core instructions** (loaded every time) and **reference documentation** (loaded on-demand).

### Architecture

```
Prompt_4_Interactive_Change.md (CORE - 150 lines, ~2,000 tokens)
├── Essential workflow only
├── "See Prompt_4_Reference.md for examples"
└── "See Process/_COMMON/18_Lock_Management_Module.md for lock details"

Prompt_4_Reference.md (REFERENCE - 400 lines, loaded on-demand)
├── Detailed examples
├── Edge cases
├── Troubleshooting
└── Full workflow documentation
```

### Implementation

**New Prompt 4 Structure:**

```markdown
# Execute Prompt 4: Interactive Change

**Version:** 0.14.0
**Token Efficient:** ~2,000 tokens (vs 53,000 in v0.13.0)

---

## Quick Start

1. **Lock chapter** (see Process/_COMMON/18_Lock_Management_Module.md)
2. **Ask user:** "Which file do you want to edit?"
3. **Read file** and have **conversational discussion**
4. **Write instructions** to `_chg.md` file
5. **Ask:** "Apply changes now? (y/n)"
   - Yes → Execute Prompt 3
   - No → Instructions saved for later
6. **Release lock**

---

## Anti-Hallucination Protocol

**MANDATORY:** Read Process/Anti-Hallucination_Guidelines.md before generating content.

Key rules:
- ASK before creating examples/anecdotes/statistics
- NEVER fabricate quotes or specific people
- Label all content: REAL vs HYPOTHETICAL vs GENERIC

---

## Instruction Format

Write to `[filename]_chg.md` under "## Instructions for Next Revision":

```
### Change Request: [Brief title]

**Requested:** [CONFIRMED_DATE]

[Clear, actionable instructions...]

**Anti-Hallucination Notes:**
- [Any HYPOTHETICAL/GENERIC content to avoid]
```

---

## Git Commit Format

```bash
git add [file] && git commit -m "Interactive edit: [brief description]

[Details]

🤖 Generated with Claude Code

Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

## Session Cleanup

**After execution completes:**

Say to user: "✓ Prompt 4 complete. You can now say 'clear Prompt 4 from context' to free up tokens for the next task."

---

📖 **For detailed examples and troubleshooting:** See `Process/Prompts/Prompt_4_Reference.md`

**Version:** 0.14.0
```

**Estimated token reduction:** 53,000 → 2,000 tokens (96% reduction)

---

## Solution 2: Context Cleanup Protocol

### Add to ALL Prompts

Add this section at the end of every prompt:

```markdown
## Session Cleanup

**IMPORTANT:** After this prompt completes successfully, tell the user:

"✓ [Prompt Name] complete. This prompt is no longer needed in context.

To free up tokens for your next task, you can say:
'Remove [Prompt Name] from context' or 'Clear prompts'"

**Why this matters:**
- Prompts can consume 2,000-50,000 tokens each
- Keeping completed prompts in context wastes token budget
- Clearing completed prompts leaves more room for content work
```

### User-Facing Documentation

Update CLAUDE.md with:

```markdown
## Token Management Best Practices

### Clear Completed Prompts

After a prompt completes, clear it from context:

**Option 1 - Specific:**
- "Clear Prompt 1 from context"
- "Remove Prompt 4 from session"

**Option 2 - All prompts:**
- "Clear all framework prompts"
- "Reset context, keep only my content"

**When to clear:**
- ✅ After Prompt 1 (initialization) completes
- ✅ After Prompt 4 (interactive editing) completes
- ✅ After Prompt 8 (consistency check) completes
- ✅ After Prompt 10 (dashboard) completes
- ⚠️ Keep Prompt 3 if you'll apply multiple _chg files

**Token savings:**
- Prompt 1: Saves ~25,000 tokens
- Prompt 4: Saves ~53,000 tokens (or ~2,000 with v0.14.0 optimization)
- Total: Up to 80,000+ tokens reclaimed
```

---

## Solution 3: Lazy Module Loading

### Current Problem

Every prompt has:
```markdown
**FIRST ACTION - MANDATORY:**
1. Read Process/_COMMON/18_Lock_Management_Module.md
2. Read Process/Anti-Hallucination_Guidelines.md
```

This loads ~10,000 tokens at the start of every prompt execution.

### Solution

Replace with:
```markdown
**FIRST ACTION - MANDATORY:**
1. Acknowledge: "I have access to lock management and anti-hallucination protocols"
2. Only read full modules if encountering issues or edge cases

**Modules available:**
- Lock management: Process/_COMMON/18_Lock_Management_Module.md
- Anti-hallucination: Process/Anti-Hallucination_Guidelines.md
- [Load on-demand when needed]
```

Claude already has these protocols loaded from FRAMEWORK_CORE.md (via /fw-init), so re-reading them is redundant.

**Token savings:** ~10,000 tokens per prompt execution

---

## Solution 4: Common Module Consolidation

### Current State

Each prompt reads modules independently:
- 18_Lock_Management_Module.md
- Anti-Hallucination_Guidelines.md
- Various other modules

### Solution

Create **Prompt_Essentials.md** that gets loaded ONCE at session start:

```markdown
# Prompt Essentials

**Load this once per session, referenced by all prompts**

## Lock Management Quick Reference
[Core lock operations only - 500 tokens]

## Anti-Hallucination Rules
[Essential rules only - 500 tokens]

## Git Commit Format
[Standard format - 200 tokens]

## Style Resolution
[Quick reference - 300 tokens]

**Total:** ~1,500 tokens (vs 10,000+ from individual modules)
```

All prompts reference this instead of loading full modules.

---

## Implementation Priority

### Phase 1: Quick Wins (v0.14.0)

**1. Add Context Cleanup Protocol** ⚡ HIGHEST IMPACT
- Add cleanup instructions to all 16 prompts
- Document in CLAUDE.md
- **Effort:** 2 hours
- **Token Savings:** Up to 80,000 tokens per session

**2. Refactor Prompt 4** ⚡ HIGH IMPACT
- Split into Prompt_4 (core) + Prompt_4_Reference (documentation)
- **Effort:** 3 hours
- **Token Savings:** 51,000 tokens (53,000 → 2,000)

### Phase 2: Module Optimization (v0.14.1)

**3. Lazy Module Loading**
- Remove mandatory module reads from prompt headers
- **Effort:** 1 hour
- **Token Savings:** ~10,000 tokens per prompt execution

**4. Common Module Consolidation**
- Create Prompt_Essentials.md
- Update all prompts to reference it
- **Effort:** 4 hours
- **Token Savings:** ~8,500 tokens per prompt

---

## Expected Token Budget After Optimization

### Current (v0.13.0)
```
Session Startup (fw-init):     3,000 tokens
Prompt 1 (Initialize):        25,000 tokens
Prompt 4 (Interactive):       53,000 tokens
                              ─────────────
Total before work:            81,000 tokens
Available for content:       119,000 tokens (60%)
```

### After Phase 1 (v0.14.0)
```
Session Startup (fw-init):     3,000 tokens
Prompt 1 (Initialize):        25,000 tokens  [cleared after execution]
Prompt 4 (Interactive):        2,000 tokens  [cleared after execution]
                              ─────────────
Active context:                5,000 tokens  (Prompt 4 only, Prompt 1 cleared)
Available for content:       195,000 tokens (98%)
```

### After Phase 2 (v0.14.1)
```
Session Startup (fw-init):     3,000 tokens
Prompt Essentials (loaded once): 1,500 tokens
Prompt 1 (Initialize):        10,000 tokens  [cleared]
Prompt 4 (Interactive):        2,000 tokens  [cleared]
                              ─────────────
Active context:                4,500 tokens
Available for content:       195,500 tokens (98%)
```

**Total Improvement:** 81,000 → 4,500 tokens (94% reduction)

---

## Implementation Checklist

### Phase 1 (v0.14.0)

**Context Cleanup Protocol:**
- [ ] Add cleanup section to all 16 prompts
- [ ] Update CLAUDE.md with token management section
- [ ] Test cleanup workflow in session

**Refactor Prompt 4:**
- [ ] Create Prompt_4_Interactive_Change.md (core - 150 lines)
- [ ] Create Prompt_4_Reference.md (documentation - 400 lines)
- [ ] Move examples/troubleshooting to reference
- [ ] Test with typical editing session
- [ ] Verify token usage is ~2,000 tokens

### Phase 2 (v0.14.1)

**Lazy Module Loading:**
- [ ] Remove mandatory reads from all prompt headers
- [ ] Add "modules available" reference sections
- [ ] Test that protocols still work correctly

**Common Module Consolidation:**
- [ ] Create Process/Prompts/Prompt_Essentials.md
- [ ] Extract core sections from common modules
- [ ] Update all 16 prompts to reference Prompt_Essentials
- [ ] Test all prompts with new structure

---

## Risks and Mitigations

### Risk 1: Loss of Important Information
**Mitigation:**
- Keep all documentation in reference files
- Prompts explicitly point to reference docs
- No information is deleted, just reorganized

### Risk 2: Users Don't Clear Context
**Mitigation:**
- Prompts explicitly tell users to clear context
- Document benefits clearly (token savings)
- Make it easy: "Just say: clear Prompt X"

### Risk 3: Breaking Existing Workflows
**Mitigation:**
- Phase rollout allows testing
- Keep old prompts available temporarily
- Document migration clearly

---

## Success Metrics

**Acceptance Criteria:**
1. ✅ Prompt 4 uses <3,000 tokens (vs 53,000)
2. ✅ Session has >195,000 tokens available for content (vs 119,000)
3. ✅ All prompts have context cleanup instructions
4. ✅ No loss of functionality
5. ✅ Users can easily clear completed prompts

**Performance Target:**
- **94% reduction in framework token overhead**
- **98% of session tokens available for content work**

---

## User Experience Impact

### Before (v0.13.0)
```
User: "Let's work on Chapter 5"
Claude: [Loads 53,000 token Prompt 4]
Claude: [Has 119,000 tokens left for editing]
User: [Can do 2-3 revision cycles before hitting limit]
```

### After (v0.14.0)
```
User: "Let's work on Chapter 5"
Claude: [Loads 2,000 token Prompt 4]
Claude: [Has 195,000 tokens left for editing]
User: [Can do 10+ revision cycles in one session]
```

**Result:** Users can work longer without session resets.

---

## Backward Compatibility

**No breaking changes:**
- Old prompts still work (just verbose)
- Reference documentation preserves all information
- Users can choose when to clear context
- Gradual adoption possible

---

## Conclusion

This optimization delivers **94% reduction in framework token overhead** through:
1. Context cleanup protocol (saves up to 80,000 tokens)
2. Modular prompt structure (saves 51,000 tokens on Prompt 4)
3. Lazy module loading (saves ~10,000 tokens per execution)
4. Common module consolidation (saves ~8,500 tokens)

**Total Impact:** Framework goes from consuming 40% of session tokens to just 2%, leaving 98% for actual content work.

**Effort:** 10 hours total implementation
**ROI:** Massive - benefits every user session

---

**Status:** Ready for implementation in v0.14.0 (Phase 1)
**Estimated Completion:** 3 days (Phase 1), 1 week (Phase 2)
