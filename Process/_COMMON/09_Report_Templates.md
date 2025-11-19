# Report Templates

**Framework Version:** 0.10.0
**Module:** Standardized Reporting Formats
**Purpose:** Consistent statistics and report displays

---

## Word Count Display

```markdown
**Word Count:**
Current: {X} words
Target: {Y} words
Progress: {Z}% ({X}/{Y})
Remaining: {Y-X} words
```

**Example:**
```markdown
**Word Count:**
Current: 32,450 words
Target: 50,000 words
Progress: 65% (32,450/50,000)
Remaining: 17,550 words
```

---

## Completion Status

```markdown
**Completion Status:**
✅ Complete: {count} sections
🚧 In Progress: {count} sections
⏳ Pending: {count} sections

Overall: {percent}% complete
```

**Example:**
```markdown
**Completion Status:**
✅ Complete: 8 chapters
🚧 In Progress: 3 chapters
⏳ Pending: 2 chapters

Overall: 73% complete
```

---

## File Status List

```markdown
{Filename} - v{version} ({word_count} words) {status_icon}
```

**Status icons:**
- ✅ Complete
- 🚧 In Progress
- ⏳ Pending
- ⚠️ Needs Attention

**Example:**
```markdown
Manuscript/Chapters/Chapter_01/Chapter_01.md - v1.3.0 (2,847 words) ✅
Manuscript/Chapters/Chapter_02/Chapter_02.md - v1.1.0 (1,923 words) 🚧
Manuscript/Chapters/Chapter_03/Chapter_03.md - v1.0.0 (450 words) ⏳
```

---

## Statistics Summary

```markdown
**Project Statistics:**

Total Word Count: {X} words
Total Chapters: {Y}
Average Words/Chapter: {Z}
Completion: {P}%

Target: {target} words
Remaining: {remaining} words
Estimated completion: {date}
```

**Example:**
```markdown
**Project Statistics:**

Total Word Count: 32,450 words
Total Chapters: 13
Average Words/Chapter: 2,496
Completion: 65%

Target: 50,000 words
Remaining: 17,550 words
Estimated completion: 2025-12-15
```

---

## Milestone Tracking

```markdown
**Milestones:**
{icon} {percent}% - {status} ({date})
```

**Icons:**
- ◯ Not Reached
- ◉ Reached
- ◎ Current Goal

**Example:**
```markdown
**Milestones:**
◉ 25% - Reached (2025-10-15)
◉ 50% - Reached (2025-11-01)
◎ 75% - Current Goal (Target: 2025-11-30)
◯ 100% - Not Reached (Target: 2025-12-31)
```

---

## Progress Bar

```markdown
Progress: [{'='*int(percent/2)}{' '*(50-int(percent/2))}] {percent}%
```

**Example:**
```markdown
Progress: [==================================                ] 68%
```

---

## Chapter Breakdown Table

```markdown
| Chapter | Title | Version | Words | Target | % | Status |
|---------|-------|---------|-------|--------|---|--------|
| {XX} | {Title} | v{N.M.P} | {X} | {Y} | {Z}% | {Icon} |
```

**Example:**
```markdown
| Chapter | Title | Version | Words | Target | % | Status |
|---------|-------|---------|-------|--------|---|--------|
| 01 | Introduction | v1.5.0 | 3,200 | 3,000 | 107% | ✅ |
| 02 | Background | v1.2.0 | 2,400 | 3,500 | 69% | 🚧 |
| 03 | Methodology | v1.0.0 | 450 | 4,000 | 11% | ⏳ |
```

---

## Quote Status Report

```markdown
**Quote/Epigraph Status:**
Total chapters: {X}
With epigraphs: {Y} ({percent}%)

Status breakdown:
✓ Verified: {A} ({percent}%)
⚠ Needs Citation: {B} ({percent}%)
⏳ Pending: {C} ({percent}%)
```

**Example:**
```markdown
**Quote/Epigraph Status:**
Total chapters: 13
With epigraphs: 10 (77%)

Status breakdown:
✓ Verified: 6 (46%)
⚠ Needs Citation: 2 (15%)
⏳ Pending: 2 (15%)
```

---

## Consistency Report

```markdown
**Consistency Check Results:**

Category: {category}
Issues Found: {count}

{Severity Icon} {Issue description} (Location: {file}:{line})
```

**Severity icons:**
- ❌ Critical
- ⚠️ Warning
- ℹ️ Suggestion

**Example:**
```markdown
**Consistency Check Results:**

Category: Terminology
Issues Found: 5

⚠️ "email" vs. "e-mail" used inconsistently (12 instances)
   Locations: Chapter 3 (5x), Chapter 7 (4x), Chapter 10 (3x)
   Suggestion: Standardize to "email"

ℹ️ "work-from-home" vs. "remote work" variation
   Locations: Chapter 2, Chapter 5
   Suggestion: Choose one primary term
```

---

## Git Status Report

```markdown
**Git Repository Status:**

Current branch: {branch}
Latest commit: {hash} ({date})
Uncommitted changes: {count} files

Recent commits:
- {hash}: {message} ({date})
- {hash}: {message} ({date})
- {hash}: {message} ({date})
```

---

## Validation Results

```markdown
**Validation Results: {PASS | PASS with Warnings | FAIL}**

Critical checks: {pass_count}/{total_count} passed

{icon} {check_name}: {result}
```

**Example:**
```markdown
**Validation Results: PASS with Warnings**

Critical checks: 8/8 passed

✅ File structure: Valid
✅ All chapters exist: Valid
✅ TOC consistency: Valid
✅ Cross-references: Valid
⚠️ Placeholder content: 3 markers found
⚠️ Citations needed: 2 quotes
✅ Version numbering: Valid
✅ Git status: Clean
```

---

## Next Steps Recommendations

```markdown
**Recommended Next Steps:**

Priority: {High | Medium | Low}
{icon} {Action description}
```

**Icons:**
- 🎯 High priority
- 📌 Medium priority
- 📝 Low priority

**Example:**
```markdown
**Recommended Next Steps:**

Priority: High
🎯 Complete Chapter 3 (currently 11% done)
🎯 Add citations for 2 quotes

Priority: Medium
📌 Run consistency checker
📌 Update PROJECT_CONTEXT.md

Priority: Low
📝 Consider adding more examples to Chapter 5
📝 Review style consistency in Chapter 8
```

---

## Operation Summary

```markdown
**Operation: {operation_name}**

Status: {Success | Partial Success | Failed}
Duration: {duration}

Files modified: {count}
- {file1}
- {file2}

Changes made:
- {change1}
- {change2}

Next: {next_action}
```

---

## Dashboard Report (Comprehensive)

```markdown
# Project Dashboard
**Generated:** {YYYY-MM-DD HH:MM}
**Framework Version:** 0.10.0

---

## Overview

{Statistics Summary}

---

## Progress

{Completion Status}
{Milestone Tracking}
{Progress Bar}

---

## Chapters

{Chapter Breakdown Table}

---

## Quote/Epigraph Status

{Quote Status Report}

---

## Recent Activity

{Git Status Report}

---

## Issues & Recommendations

{Validation Results}
{Next Steps Recommendations}

---

**Last Updated:** {timestamp}
```

---

**Module Version:** 0.10.0
**Last Updated:** 2025-11-19
**Status:** Active
