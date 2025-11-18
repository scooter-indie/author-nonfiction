# Execute Prompt 8: Progress Dashboard

**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`

---

## What This Does

I will generate a comprehensive status report showing your book project's current state, progress, and next steps. This is a read-only analysis.

---

## How This Works

I'll scan all your project files, analyze metrics, and create a dashboard showing where you are and what's next.

### Question I'll ask:

1. **Report type**: Summary or Detailed?
   - **Summary**: High-level overview, key metrics, top priorities
   - **Detailed**: Complete analysis with chapter-by-chapter breakdown

### Then I'll:

1. **Scan All Files**:
   - Scan Manuscript/ directory structure (Chapters/, FrontMatter/, BackMatter/, Quotes/, etc.)
   - Read metadata from all content files
   - Parse all change tracking files
   - Analyze git repository state
   - Collect statistics

2. **Calculate Metrics**:
   - Total word count (current vs. target)
   - Words per chapter
   - Overall completion percentage
   - Target vs. actual comparison
   - Version numbers for each file
   - Completion rate per chapter
   - Quote/epigraph verification status

3. **Status Analysis**:
   - Files by status (Draft, Review, Revised, Final)
   - Pending revisions count (from all _chg files)
   - Recent activity from git log (last 7-30 days)
   - Git repository statistics (commits, branches, tags)

4. **Generate Dashboard** with:

   **Summary Statistics**
   - Total word count: [current] / [target] ([percentage]%)
   - Chapters complete: [N] / [total]
   - Front matter status
   - Back matter status
   - Overall completion percentage

   **Chapter Status Table**
   | Chapter | Title | Status | Words | Target | % |
   |---------|-------|--------|-------|--------|---|
   | 01 | [title] | Draft | [N] | [N] | XX% |
   | 02 | [title] | Review | [N] | [N] | XX% |

   **Recent Activity (Git Log)**
   - Last 10 commits with dates and messages

   **Git Status**
   - Current branch
   - Total commits
   - Latest tag
   - Uncommitted changes (if any)
   - Unpushed commits (if any)

   **Pending Revisions**
   - High priority: [N] items
   - Medium priority: [N] items
   - Low priority: [N] items
   - Summary of what needs attention

   **Quote/Epigraph Status**
   - Verified (✓): [N] / [Total] chapters ([XX]%)
   - Needs Citation (⚠): [N] chapters
   - Pending (⏳): [N] chapters
   - Overall quote completion: [XX]%

   **Chapters needing quote work:**
   - Chapter [XX]: [Status and what's needed]
   - Chapter [XX]: [Status and what's needed]

   **Milestones**
   - [ ] First Draft Complete (25%)
   - [ ] Structural Edit Complete (50%)
   - [ ] Copy Edit Complete (75%)
   - [ ] Final Proofread Complete (100%)

   **Recommended Next Steps**
   1. [Specific action based on current state]
   2. [Next priority]
   3. [Upcoming milestone]

   **Issues Requiring Attention**
   - [Any problems found during analysis]
   - [Missing content]
   - [Inconsistencies]

---

## When to Use

**Recommended frequency:**
- **Weekly**: During active writing
- **After major changes**: Adding chapters, reorganizations
- **At milestones**: 25%, 50%, 75%, 100% completion
- **Before compilation**: Prior to Prompt 5
- **Before export**: Prior to Prompt 7

---

## What to Do With Results

Use the dashboard to:
1. Track progress toward completion
2. Identify chapters needing attention
3. See pending revisions across all files
4. Monitor git activity and backup status
5. Plan your next work session
6. Identify blockers or issues

---

## Ready to Begin?

**Would you like a Summary or Detailed report?**

---

*Reference: Process/AI-Assisted_Nonfiction_Authoring_Process.md (Prompt 8)*
