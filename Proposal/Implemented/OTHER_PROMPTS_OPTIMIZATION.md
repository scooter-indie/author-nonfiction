# Other Prompts Optimization Proposal

**Status:** Proposal
**Target Version:** 0.14.5
**Created:** 2025-11-24
**Goal:** Optimize remaining 15 prompts after Prompt 4 refactor

---

## Overview

After successful Prompt 4 optimization (578 lines → 250 lines, 95% token reduction), this proposal targets the remaining 15 prompts for similar optimization strategies.

**Target prompts:**
- Prompts 1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16

---

## Analysis of Current Prompt Sizes

| Prompt | Lines | Est. Tokens | Primary Bloat Source |
|--------|-------|-------------|---------------------|
| Prompt 1 (Initialize) | 815 | ~25,000 | Step-by-step content generation instructions |
| Prompt 2 (Add Chapter) | 450 | ~15,000 | Detailed renumbering logic |
| Prompt 3 (Change by Chg) | 520 | ~18,000 | Embedded anti-hallucination examples |
| Prompt 5 (Scan Edits) | 380 | ~12,000 | Git diff parsing details |
| Prompt 6 (Integrate Inbox) | 420 | ~14,000 | Multiple workflow examples |
| Prompt 7 (Compile) | 480 | ~16,000 | Multiple compilation modes |
| Prompt 8 (Consistency) | 650 | ~20,000 | Extensive validation rules |
| Prompt 9 (Export) | 520 | ~15,000 | Format-specific instructions |
| Prompt 10 (Dashboard) | 400 | ~12,000 | Report generation templates |
| Prompt 11 (Style Manager) | 580 | ~16,000 | Override management workflows |
| Prompt 12 (Git Operations) | 350 | ~10,000 | Git command examples |
| Prompt 13 (AI Detection) | 550 | ~18,000 | Analysis criteria and scoring |
| Prompt 14 (Citation Finder) | 720 | ~22,000 | WebSearch workflows + verification |
| Prompt 15 (Visual Content) | 680 | ~20,000 | Visual generation templates |
| Prompt 16 (Image Manager) | 850 | ~25,000 | Registry coordination workflows |

**Total:** ~254,000 tokens if all loaded simultaneously

---

## Optimization Strategy Matrix

### Category 1: High-Value Refactors (Similar to Prompt 4)

**Candidates: Prompts 8, 13, 14, 15, 16**

These prompts have extensive examples and detailed workflows that can be split into core + reference.

#### Prompt 8 (Consistency Checker)

**Current:** 650 lines, ~20,000 tokens
**Target:** 200 lines core + 450 lines reference
**Strategy:**
- Core: Validation categories, quick checklist
- Reference: Detailed rules, examples of violations, fix suggestions

**Estimated savings:** 15,000 tokens (75% reduction)

#### Prompt 13 (AI Detection Analysis)

**Current:** 550 lines, ~18,000 tokens
**Target:** 180 lines core + 370 lines reference
**Strategy:**
- Core: Scoring criteria, workflow steps
- Reference: Detailed indicators, example flagged passages, rewriting guidelines

**Estimated savings:** 13,500 tokens (75% reduction)

#### Prompt 14 (Citation Finder)

**Current:** 720 lines, ~22,000 tokens
**Target:** 220 lines core + 500 lines reference
**Strategy:**
- Core: WebSearch workflow, verification steps
- Reference: Citation format examples, troubleshooting, edge cases

**Estimated savings:** 16,500 tokens (75% reduction)

#### Prompt 15 (Visual Content Suggester)

**Current:** 680 lines, ~20,000 tokens
**Target:** 200 lines core + 480 lines reference
**Strategy:**
- Core: Analysis workflow, visual type selection
- Reference: ASCII diagram templates, table format examples, flowchart syntax

**Estimated savings:** 15,000 tokens (75% reduction)

#### Prompt 16 (Image Manager)

**Current:** 850 lines, ~25,000 tokens
**Target:** 250 lines core + 600 lines reference
**Strategy:**
- Core: Registry workflow, validation steps
- Reference: Image format guidelines, migration examples, troubleshooting

**Estimated savings:** 18,750 tokens (75% reduction)

**Category 1 Total Savings:** ~79,000 tokens

---

### Category 2: Medium-Value Refactors

**Candidates: Prompts 1, 3, 6, 7, 9, 11**

These prompts have moderate bloat from detailed instructions that can be condensed.

#### Prompt 1 (Initialize)

**Current:** 815 lines, ~25,000 tokens
**Target:** 300 lines core + 515 lines reference
**Strategy:**
- Core: Q&A workflow, bash script calls, essential steps
- Reference: Detailed JSON structures, file format examples
- **NOTE:** Already optimized with generate-content.sh in v0.14.0

**Estimated additional savings:** 10,000 tokens (40% reduction)

#### Prompt 3 (Change by Chg)

**Current:** 520 lines, ~18,000 tokens
**Target:** 250 lines core + 270 lines reference
**Strategy:**
- Core: Read _chg file, apply changes, commit workflow
- Reference: Anti-hallucination examples, edge cases, troubleshooting

**Estimated savings:** 8,000 tokens (45% reduction)

#### Prompt 6 (Integrate Inbox)

**Current:** 420 lines, ~14,000 tokens
**Target:** 200 lines core + 220 lines reference
**Strategy:**
- Core: Inbox processing workflow, file type handling
- Reference: Integration examples for different content types

**Estimated savings:** 6,500 tokens (45% reduction)

#### Prompt 7 (Compile)

**Current:** 480 lines, ~16,000 tokens
**Target:** 220 lines core + 260 lines reference
**Strategy:**
- Core: Bash script call, basic compilation modes
- Reference: Format-specific options, troubleshooting

**Estimated savings:** 7,000 tokens (45% reduction)

#### Prompt 9 (Export)

**Current:** 520 lines, ~15,000 tokens
**Target:** 240 lines core + 280 lines reference
**Strategy:**
- Core: Export workflow, tool detection, format selection
- Reference: Pandoc/Typst command examples, format-specific guidance

**Estimated savings:** 6,750 tokens (45% reduction)

#### Prompt 11 (Style Manager)

**Current:** 580 lines, ~16,000 tokens
**Target:** 270 lines core + 310 lines reference
**Strategy:**
- Core: Override operations (add/remove/analyze), registry updates
- Reference: Detailed workflows, distribution analysis, validation examples

**Estimated savings:** 7,200 tokens (45% reduction)

**Category 2 Total Savings:** ~45,000 tokens

---

### Category 3: Low-Value Refactors (Already Concise)

**Candidates: Prompts 2, 5, 10, 12**

These prompts are relatively concise or have minimal separable content.

#### Prompt 2 (Add Chapter)

**Current:** 450 lines, ~15,000 tokens
**Optimization:** Streamline renumbering logic, condense examples
**Target:** 320 lines
**Estimated savings:** 5,000 tokens (33% reduction)

#### Prompt 5 (Scan User Edits)

**Current:** 380 lines, ~12,000 tokens
**Optimization:** Condense git diff examples
**Target:** 280 lines
**Estimated savings:** 3,500 tokens (30% reduction)

#### Prompt 10 (Dashboard)

**Current:** 400 lines, ~12,000 tokens
**Optimization:** Template report structures in reference
**Target:** 280 lines core + 120 lines reference
**Estimated savings:** 4,000 tokens (33% reduction)

#### Prompt 12 (Git Operations)

**Current:** 350 lines, ~10,000 tokens
**Optimization:** Condense git command examples
**Target:** 250 lines
**Estimated savings:** 3,000 tokens (30% reduction)

**Category 3 Total Savings:** ~15,500 tokens

---

## Total Optimization Impact

| Category | Prompts | Current Tokens | After Optimization | Savings |
|----------|---------|---------------|-------------------|---------|
| Category 1 (High) | 5 prompts | 105,000 | 26,000 | **79,000 (75%)** |
| Category 2 (Medium) | 6 prompts | 104,000 | 59,000 | **45,000 (43%)** |
| Category 3 (Low) | 4 prompts | 49,000 | 33,500 | **15,500 (32%)** |
| **Total** | **15 prompts** | **258,000** | **118,500** | **139,500 (54%)** |

**Combined with Prompt 4 optimization:**
- **All 16 prompts:** 311,000 → 120,500 tokens
- **Total reduction:** 190,500 tokens (61% reduction)

---

## Implementation Priority

### Phase 1: High-Value Refactors (Target: v0.14.5)

**Priority 1: Prompts with Most Usage**
1. Prompt 8 (Consistency) - Used at milestones
2. Prompt 3 (Change by Chg) - Used frequently for edits
3. Prompt 16 (Image Manager) - Used when managing images

**Priority 2: Complex Workflows**
4. Prompt 14 (Citation Finder) - Complex WebSearch workflows
5. Prompt 15 (Visual Content) - Complex template generation
6. Prompt 13 (AI Detection) - Extensive analysis criteria

**Estimated time:** 12-15 hours

### Phase 2: Medium-Value Refactors (Target: v0.15.1)

7. Prompt 11 (Style Manager) - Used occasionally
8. Prompt 9 (Export) - Used at milestones
9. Prompt 7 (Compile) - Used regularly
10. Prompt 6 (Integrate Inbox) - Used periodically
11. Prompt 1 (Initialize) - Already optimized, minor cleanup
12. Prompt 10 (Dashboard) - Used weekly

**Estimated time:** 8-10 hours

### Phase 3: Low-Value Refactors (Target: v0.15.2)

13. Prompt 2 (Add Chapter) - Used occasionally
14. Prompt 5 (Scan Edits) - Used periodically
15. Prompt 12 (Git Operations) - Used at milestones

**Estimated time:** 4-5 hours

---

## Implementation Template

For each prompt refactor, follow this template:

### 1. Create Core Version

**File:** `Prompt_X_[Name].md`

**Structure:**
```markdown
# Execute Prompt X: [Name]

**Version:** 0.14.5
**⚡ Token Efficient:** ~[target] tokens (X% reduction from v0.14.0)

---

## Quick Start

[1-2 paragraph overview]

### Workflow (N Steps)

1. [Step 1]
2. [Step 2]
...

---

## Step 0: [If applicable - Lock Management]

---

## Step 1: [Core Step]

[Essential instructions only]

---

[Additional core steps...]

---

## Session Cleanup

[Standard cleanup section]

---

## Important Notes

[Critical information only]

---

📖 **For detailed examples and troubleshooting:** See `Process/Prompts/Prompt_X_Reference.md`

[Other module references]

---

**Version:** 0.14.5
**Last Updated:** [date]
**Token Efficiency:** X% reduction
```

### 2. Create Reference Version

**File:** `Prompt_X_Reference.md`

**Structure:**
```markdown
# Prompt X Reference Documentation

**Version:** 0.14.5
**Purpose:** Detailed examples, edge cases, and troubleshooting

---

## Overview

[Description of what this reference covers]

---

## Example Full Session 1: [Scenario]

[Detailed walkthrough]

---

## Example Full Session 2: [Scenario]

[Detailed walkthrough]

---

## Edge Cases and Troubleshooting

### Edge Case 1: [Scenario]
[Solution]

---

## Advanced Workflows

[Complex workflow examples]

---

## Module References

[Links to relevant Process/_COMMON modules]

---

**Version:** 0.14.5
**For Core Workflow:** See `Prompt_X_[Name].md`
```

### 3. Test Both Files

- [ ] Core prompt executes workflow correctly
- [ ] Reference provides helpful examples when needed
- [ ] Token usage meets target reduction
- [ ] No functionality lost

### 4. Update Documentation

- [ ] Add reference file to framework manifest
- [ ] Update CLAUDE.md if needed
- [ ] Note optimization in prompt header

---

## Measurement and Success Criteria

### Token Usage Targets

| Prompt Category | Current Avg | Target Avg | Reduction |
|-----------------|-------------|------------|-----------|
| High-value | 21,000 | 5,200 | 75% |
| Medium-value | 17,300 | 9,800 | 43% |
| Low-value | 12,250 | 8,400 | 31% |

### User Experience Metrics

**Success criteria:**
1. ✅ All prompts execute workflows correctly
2. ✅ Reference docs provide sufficient detail
3. ✅ Users report faster session startup
4. ✅ Users can work longer without hitting token limits
5. ✅ No increase in user errors or confusion

### Performance Tracking

**Measure after each phase:**
- Average token usage per prompt type
- Number of prompts users load per session
- Session longevity (operations before token limit)
- User satisfaction with new structure

---

## Risk Mitigation

### Risk 1: Loss of Context for Complex Operations

**Mitigation:**
- Keep all detailed information in reference files
- Core prompts explicitly link to reference
- Reference files are easy to load on-demand

### Risk 2: Users Don't Know When to Load Reference

**Mitigation:**
- Core prompts mention when reference is needed
- Add "📖 See reference for..." prompts throughout core
- Document common scenarios requiring reference

### Risk 3: Increased Maintenance Burden

**Mitigation:**
- Use consistent template for all refactors
- Keep core/reference sync checklist
- Test both files together

---

## Testing Strategy

### Per-Prompt Testing

For each refactored prompt:

1. **Functional Test:**
   - Execute with typical use case
   - Verify all steps complete correctly
   - Check output files/commits

2. **Token Test:**
   - Measure actual token usage
   - Compare to target reduction
   - Verify reference loads separately

3. **Reference Test:**
   - Load reference when needed
   - Verify examples are helpful
   - Check troubleshooting works

### Integration Testing

After all refactors:

1. **Multi-Prompt Session:**
   - Load 3-4 different prompts in one session
   - Verify token budget improvements
   - Test context clearing between prompts

2. **Complete Workflow:**
   - Run full book workflow (Init → Edit → Consistency → Export)
   - Measure total token usage
   - Compare to v0.14.0 baseline

---

## Documentation Updates

### CLAUDE.md Updates

Add section:
```markdown
## Prompt Reference Files (v0.14.5+)

Many prompts have been split into core + reference for better token efficiency:

**Core files:** Essential workflow (load every time)
**Reference files:** Detailed examples (load when needed)

### When to Load Reference

- **Never needed:** Simple, typical usage
- **Helpful:** First time using a prompt
- **Required:** Encountering errors or edge cases

### Loading Reference

Say: "Load Prompt X Reference" or "Show me Prompt X examples"

The reference file will load on-demand without affecting your core workflow.
```

### README.md Updates

Update performance claims:
```markdown
## Performance (v0.14.5)

**Token Efficiency:**
- Framework overhead: 2-5% of session (vs 40% in v0.13.0)
- Prompt 4: 2,000 tokens (95% reduction)
- Average prompt: 8,000 tokens (55% reduction)
- Available for content: 195,000+ tokens (97%+)

**Execution Speed:**
- Prompt 1 (Initialize): 5-10 seconds (85% faster)
- Prompt 4 (Interactive): Instant load (95% reduction)
- Session startup: ~3,000 tokens (framework core)
```

---

## Timeline Estimate

### Phase 1: High-Value Refactors
- **Prompts:** 8, 3, 16, 14, 15, 13
- **Time:** 12-15 hours
- **Completion:** Week 1-2

### Phase 2: Medium-Value Refactors
- **Prompts:** 11, 9, 7, 6, 1, 10
- **Time:** 8-10 hours
- **Completion:** Week 3

### Phase 3: Low-Value Refactors
- **Prompts:** 2, 5, 12
- **Time:** 4-5 hours
- **Completion:** Week 4

**Total: 24-30 hours over 4 weeks**

---

## Backward Compatibility

**No breaking changes:**
- Old prompt files can be kept as `Prompt_X_[Name]_v014.md.bak`
- Reference files are additive (new files only)
- Users can choose when to adopt new structure
- Gradual migration supported

---

## Conclusion

This optimization will deliver **54% reduction** in token usage across all 15 remaining prompts, combined with Prompt 4's 95% reduction for an overall **61% reduction** across all 16 core prompts.

**Total Impact:**
- **190,500 tokens saved** across all prompts
- **97%+ of session tokens** available for content work
- **Faster session startup** and longer working sessions
- **No loss of functionality** - all information preserved in reference files

**Effort:** 24-30 hours total implementation
**ROI:** Massive - benefits every user session, enables longer working sessions

---

**Status:** Proposal for v0.14.5
**Dependencies:** Phase 2 of PROMPT_TOKEN_OPTIMIZATION.md
**Est. Start Date:** After Phase 2 completion
**Est. Completion:** 4 weeks
