# Execute Prompt 13: AI Detection Analysis

**Version:** 0.16.1
**⚡ Token Efficient:** ~4,500 tokens (75% reduction from v0.14.0)
**CLI-ONLY:** Requires bulk file analysis

**FIRST ACTION - MANDATORY:**
Reference `Process/Prompts/Prompt_Essentials.md` (loaded once per session via /fw-init)

---

## Quick Start

Analyzes chapters for AI-generated text indicators and provides recommendations to make content sound authentically yours. This is about ensuring your voice shines through, not detecting AI use.

### Key Insight

Your expertise and unique perspective are the value. This analysis helps remove generic patterns that weaken your authentic voice.

---

## Workflow (5 Steps)

1. Ask scope and analysis depth
2. Scan for AI indicators
3. Score and flag passages
4. Generate rewrite suggestions
5. Save report

---

## Step 1: Questions

**Ask user:**

1. **Scope:** Which chapters?
2. **Analysis depth:**
   - Quick scan (basic scoring)
   - Standard (detailed report)
   - Comprehensive (rewrite suggestions)

3. **Focus areas:** (or all)
   - Generic language/clichés
   - Missing personal voice
   - Repetitive patterns
   - Sentence uniformity
   - Hedging overuse

---

## Step 2: AI Indicators to Scan

### 7 Indicator Categories

| Category | Indicators | Impact |
|----------|------------|--------|
| Generic Transitions | "Moreover", "Furthermore", "It's worth noting" | Sounds robotic |
| Repetitive Patterns | Same openings, formulaic structures | Monotonous |
| Hedging Overuse | "might", "could", "possibly" (>5/page) | Undermines authority |
| Vague Examples | "many people", "some experts" | Lacks credibility |
| Formal Stiffness | Jargon, passive voice (>20%) | Creates distance |
| Missing Voice | No first-person, no anecdotes | Sounds generic |
| Sentence Uniformity | All sentences same length/structure | Artificial flow |

📖 **For detailed indicator descriptions:** See `Process/Prompts/Prompt_13_Reference.md`

---

## Step 3: Scoring System

### Per-Passage Score (0-100)

| Score | Rating | Meaning |
|-------|--------|---------|
| 90-100 | Excellent | Authentic, engaging |
| 75-89 | Good | Minor improvements possible |
| 60-74 | Fair | Some AI patterns detected |
| 40-59 | Needs Work | Multiple issues flagged |
| 0-39 | Significant | Major revision recommended |

### Chapter Score

Average of all passage scores, weighted by:
- Introduction: 1.5x (first impressions)
- Body: 1.0x
- Conclusion: 1.2x (lasting impact)

---

## Step 4: Flag and Suggest

**Flag format:**
```markdown
⚠️ AI INDICATOR: [category]
Location: Chapter_XX.md:line
Passage: "[flagged text]"
Issue: [specific problem]
Suggestion: [how to fix]
```

**Rewrite suggestions include:**
- Concrete alternative phrasing
- Voice injection opportunities
- Personal anecdote hooks
- Specificity improvements

---

## Step 5: Save Report

1. Create `Manuscript/Reports/` if needed
2. Save as `ai-detection-YYYY-MM-DD.md`
3. Update README.md with report link

---

## Output Report Format

```markdown
# AI Detection Analysis Report

**Date:** 2025-11-24
**Chapters:** 1-5
**Depth:** Standard

---

## Executive Summary

**Overall Score:** 72/100 (Fair)
**Passages Flagged:** 23
**Priority Rewrites:** 8

---

## Chapter Scores

| Chapter | Score | Rating | Top Issue |
|---------|-------|--------|-----------|
| 1 | 85 | Good | Minor hedging |
| 2 | 68 | Fair | Generic transitions |
| 3 | 75 | Good | - |
| 4 | 62 | Fair | Missing voice |
| 5 | 70 | Fair | Repetitive patterns |

---

## High-Priority Flags

### Chapter 2, Lines 45-60
**Issue:** Generic transition overuse
**Passage:** "Furthermore, it's important to note that..."
**Suggestion:** Delete transition, start with the point

### Chapter 4, Lines 120-135
**Issue:** Missing personal voice
**Passage:** "Many experts agree that..."
**Suggestion:** Add your specific expertise: "In my 15 years..."

---

## Recommendations

1. **Immediate:** Rewrite 8 high-priority passages
2. **This week:** Review Chapter 4 for voice
3. **Ongoing:** Vary sentence structure in Chapter 5
```

---

## Rewrite Workflow

**Use Prompt 3 or 4 to apply fixes:**

1. Review flagged passages
2. Write revision instructions
3. Execute changes
4. Re-run AI Detection to verify improvement

**Example instruction:**
```
Rewrite lines 45-60:
- Remove "Furthermore" and "It's important to note"
- Start directly with the key point
- Add one specific example from my consulting work
```

---

📖 **For detailed indicators and examples:** See `Process/Prompts/Prompt_13_Reference.md`

---

**Version:** 0.16.1
**Last Updated:** 2025-11-24
**Token Efficiency:** 75% reduction

---

## Session Cleanup

Tell user: "✓ Prompt 13 AI Detection complete.

To free up tokens, say: **'Clear Prompt 13 from context'**"
