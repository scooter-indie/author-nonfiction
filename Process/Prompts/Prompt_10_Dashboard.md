# Execute Prompt 10: Progress Dashboard

**Version:** 0.14.4
**⚡ Token Efficient:** ~4,500 tokens (70% reduction from v0.14.0)
**DESKTOP-FRIENDLY:** Works 95% in Desktop (read-only)

**FIRST ACTION - MANDATORY:**
Reference `Process/Prompts/Prompt_Essentials.md` (loaded once per session via /fw-init)

---

## Quick Start

Generates comprehensive project status report. Read-only analysis - no locks required. Updates PROJECT_CONTEXT.md for session resumption.

**Use:** Weekly, after major changes, at milestones, before compilation/export

---

## Workflow (4 Steps)

1. Ask report type
2. Scan all files
3. Generate dashboard
4. Save and update README

---

## Step 1: Questions

**Ask user:**
1. **Report type?**
   - Summary: Key metrics, top priorities
   - Detailed: Complete chapter-by-chapter breakdown

---

## Step 2: Scan & Calculate

**Scan:**
- Manuscript/ directory structure
- All content files and _chg files
- Git repository state
- Locks status

**Calculate:**
- Word counts (current vs target)
- Completion percentages
- Pending revisions
- Quote verification status
- Style distribution
- Visual assets status

---

## Step 3: Dashboard Contents

### Summary Statistics
- Total word count: [current] / [target] ([%])
- Chapters complete: [N] / [total]
- Overall completion percentage

### Chapter Status Table
| Chapter | Title | Status | Words | Target | % |
|---------|-------|--------|-------|--------|---|

### Git Status
- Current branch
- Uncommitted/unpushed changes
- Recent commits (last 5)
- Latest tag

### Active Locks
| Resource | Instance | Age | Status |
|----------|----------|-----|--------|
| Chapter_03 | CLI-12345 | 5 min | 🔒 Active |

### Quote Status
- Verified (✓): [N] / [Total]
- Needs Citation (⚠): [N]
- Pending (⏳): [N]

### Style Distribution
- Book-level style: [Name]
- Override percentage: [%]
- Threshold status: [Below/At/Above 30%]

### Visual Assets
- Registry mode: [Single / Split]
- Total figures: [N]
- 📝 Text-based: [N]
- 🖼️ Professional: [N]

### Milestones
- [ ] First Draft (25%)
- [ ] Structural Edit (50%)
- [ ] Copy Edit (75%)
- [ ] Final Proofread (100%)

### Recommendations
1. [Specific action]
2. [Next priority]
3. [Upcoming milestone]

---

## Step 4: Save & Update

**Save dashboard:**
```
Manuscript/Dashboard/Dashboard.md
```

**Update README.md:**
Add/update dashboard link:
```markdown
## Dashboard
📊 [View Current Dashboard](Manuscript/Dashboard/Dashboard.md)
```

**Refresh PROJECT_CONTEXT.md:**
Update with latest project state for session resumption.

---

## Clear Locks Command

**If user says "clear all locks":**
1. Display all current locks
2. Confirm: "Clear all [N] locks? (yes/no)"
3. If yes: Write empty structure to `.locks/locks.json`
4. Display: `✓ All locks cleared`

---

📖 **For detailed report examples:** See `Process/Prompts/Prompt_10_Reference.md`

---

**Version:** 0.14.4
**Last Updated:** 2025-11-24
**Token Efficiency:** 70% reduction

---

## Session Cleanup

Tell user: "✓ Prompt 10 Dashboard complete.

To free up tokens, say: **'Clear Prompt 10 from context'**"
