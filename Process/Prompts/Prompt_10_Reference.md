# Prompt 10 Reference Documentation

**Version:** 0.14.5
**Purpose:** Detailed dashboard examples and analysis details

---

## Overview

This reference provides detailed dashboard examples and analysis criteria. Load when:
- First time using Prompt 10
- Need detailed report format
- Understanding metrics calculations
- Customizing dashboard output

**For core workflow:** See `Prompt_10_Dashboard.md`

---

## Full Dashboard Example

```markdown
# Progress Dashboard

**Generated:** 2025-11-24 14:30:00
**Report Type:** Detailed

---

## Summary Statistics

| Metric | Current | Target | Progress |
|--------|---------|--------|----------|
| Total Words | 45,230 | 60,000 | 75% |
| Chapters | 10 / 12 | - | 83% |
| Front Matter | 3 / 4 | - | 75% |
| Back Matter | 2 / 3 | - | 67% |
| Overall | - | - | 76% |

---

## Chapter Status

| Ch | Title | Status | Words | Target | % | Version |
|----|-------|--------|-------|--------|---|---------|
| 01 | Introduction | Final | 4,200 | 4,000 | 105% | 2.3.1 |
| 02 | Background | Revised | 5,100 | 5,000 | 102% | 2.1.0 |
| 03 | Methodology | Review | 6,800 | 7,000 | 97% | 1.5.0 |
| 04 | Analysis | Draft | 5,500 | 6,000 | 92% | 1.2.0 |
| 05 | Case Studies | Draft | 4,200 | 8,000 | 53% | 1.0.0 |
| 06 | Results | Draft | 3,800 | 5,000 | 76% | 1.1.0 |
| 07 | Discussion | Draft | 4,500 | 5,000 | 90% | 1.0.0 |
| 08 | Implications | Draft | 3,200 | 4,000 | 80% | 1.0.0 |
| 09 | Future Work | Draft | 2,100 | 3,000 | 70% | 1.0.0 |
| 10 | Conclusions | Draft | 2,500 | 3,000 | 83% | 1.0.0 |
| 11 | - | Not Started | 0 | 5,000 | 0% | - |
| 12 | - | Not Started | 0 | 5,000 | 0% | - |

---

## Git Status

**Current Branch:** main

**Uncommitted Changes:** 3 files
- Chapter_05.md
- Chapter_05_chg.md
- TOC.md

⚠️ Action: Commit these changes

**Unpushed Commits:** 2 commits ahead of origin/main
- a1b2c3d Update Chapter 04
- e4f5g6h Fix cross-references

⚠️ Action: Push to backup

**Recent Commits (last 5):**
1. [2025-11-24] Update Chapter 04 v1.2.0
2. [2025-11-23] Add Chapter 10 - Conclusions
3. [2025-11-22] Consistency fixes
4. [2025-11-21] Update Chapter 03
5. [2025-11-20] Add Appendix A

**Tags:**
- v0.5.0 (2025-11-01) - Half draft
- first-draft (2025-11-15) - Initial draft

---

## Active Locks

| Resource | Instance | Locked At | Age | Status |
|----------|----------|-----------|-----|--------|
| Chapter_03 | CLI-12345 | 14:25:00 | 5 min | 🔒 Active |
| StyleSystem | Desktop-67890 | 12:00:00 | 150 min | ⚠️ STALE |

⚠️ 1 stale lock detected. Use "clear all locks" to reset.

---

## Quote/Epigraph Status

| Status | Count | Chapters |
|--------|-------|----------|
| ✓ Verified | 4 | 1, 2, 3, 4 |
| ⚠ Needs Citation | 2 | 5, 6 |
| ⏳ Pending | 4 | 7, 8, 9, 10 |

**Quote Completion:** 40% (4/10 verified)

**Chapters Needing Work:**
- Chapter 5: Has quote but needs citation verification
- Chapter 6: Has quote but needs citation verification
- Chapters 7-10: No quotes assigned yet

---

## Style Distribution

**Book-Level Style:** Conversational Expert

**Chapter Overrides:** 2 of 10 (20%)
- Chapter 03: Technical Precision (methodology)
- Chapter 05: Narrative Storyteller (case studies)

**Section Overrides:** 3 sections
- Chapter 02, lines 145-230: Technical Precision
- Chapter 04, lines 89-156: Narrative Storyteller
- Chapter 04, lines 420-485: Academic Authority

**Threshold Status:** ✓ Below 30%

**Style Transitions:**
- Chapter 02→03: Medium severity (undocumented)
- Chapter 03→04: Low severity (documented)
- Chapter 04→05: High severity (undocumented)
- Chapter 05→06: Medium severity (undocumented)

**Undocumented Transitions:** 3 (requires attention)

---

## Visual Assets

**Registry Mode:** Single

**Figure Summary:**
| Status | Count | % |
|--------|-------|---|
| 📝 Text-based | 8 | 57% |
| 🖼️ Professional | 6 | 43% |
| **Total** | 14 | 100% |

**Distribution:**
| Chapter | Figures | Types |
|---------|---------|-------|
| 03 | 4 | 2 📝, 2 🖼️ |
| 04 | 3 | 1 📝, 2 🖼️ |
| 05 | 4 | 3 📝, 1 🖼️ |
| 06 | 3 | 2 📝, 1 🖼️ |

**Chapters Needing Visuals:** 01, 02, 07, 08, 09, 10

**High-Priority Upgrades:** 3
- fig-03-02: Data table (upgrade priority: High)
- fig-05-01: Process flowchart (upgrade priority: High)
- fig-06-03: Comparison chart (upgrade priority: High)

**Registry Health:** ✓ Valid

---

## Pending Revisions

**High Priority:** 3 items
1. Chapter 05: Complete case study section
2. Chapter 03: Address reviewer feedback
3. Chapter 04: Add missing citations

**Medium Priority:** 5 items
- Chapter 06: Expand results discussion
- Chapter 07: Add future research directions
- ...

**Low Priority:** 8 items
- Various typo fixes and formatting

---

## Milestones

- [x] First Draft Complete (25%) - Achieved 2025-11-15
- [ ] Structural Edit Complete (50%) - Current: 40%
- [ ] Copy Edit Complete (75%)
- [ ] Final Proofread Complete (100%)

**Current Progress:** 76% overall, 40% toward structural edit

---

## Recommendations

### Immediate Actions
1. ⚠️ Commit 3 uncommitted files
2. ⚠️ Push 2 unpushed commits
3. ⚠️ Clear stale StyleSystem lock

### This Week
1. Complete Chapter 05 (Case Studies) - 47% remaining
2. Verify quotes for Chapters 5-6
3. Document style transitions (Chapters 02-03, 04-05, 05-06)

### Next Milestone
1. Finish Chapters 11-12
2. Upgrade high-priority visual assets
3. Run Prompt 8 (Consistency) before tagging v1.0.0

---

## Issues Requiring Attention

❌ **Critical:**
- None

⚠️ **Warnings:**
1. Chapter 05 significantly behind (53% of target)
2. 3 undocumented style transitions
3. 1 stale lock (StyleSystem)

ℹ️ **Info:**
- 6 chapters have no visual assets
- 4 chapters need quotes
```

---

## Metrics Calculations

### Word Count Progress

```
Progress % = (Current Words / Target Words) × 100
```

### Chapter Completion Status

| Status | Criteria |
|--------|----------|
| Not Started | 0 words |
| Draft | < 75% of target |
| Review | 75-99% of target |
| Revised | 100%+ and has revisions |
| Final | 100%+ and marked final |

### Overall Completion

```
Overall % = (Completed Chapters / Total Chapters) × Weight
+ (Word Count Progress × Weight)
+ (Quote Verification % × Weight)
```

---

## Troubleshooting

### "Cannot read metadata"

**Cause:** Missing or corrupt config files

**Solution:**
1. Check `.config/metadata.json`
2. Verify JSON syntax
3. Re-run Prompt 1 if needed

### "Git status unavailable"

**Cause:** Not in git repository

**Solution:**
1. Run `git init`
2. Create initial commit

### "Dashboard not saving"

**Cause:** Directory doesn't exist

**Solution:**
1. Create `Manuscript/Dashboard/`
2. Re-run dashboard

---

**Version:** 0.14.5
**For Core Workflow:** See `Prompt_10_Dashboard.md`
