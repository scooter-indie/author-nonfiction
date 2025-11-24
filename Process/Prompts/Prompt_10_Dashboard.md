# Execute Prompt 10: Progress Dashboard

**Version:** 0.13.0

**DESKTOP-FRIENDLY:** Works in Claude Desktop with optional copy/paste git commit at end

**BEFORE PROCEEDING:**
1. Read `Process/_COMMON/18_Lock_Management_Module.md`
2. Read and apply `Process/Anti-Hallucination_Guidelines.md`

**CRITICAL ENFORCEMENT:**
- **RULE 1:** All file modifications MUST update corresponding _chg files
- **RULE 2:** All Manuscript/ changes must go through appropriate prompts

See: `Process/ENFORCEMENT_RULES.md` for complete details

**NOTE:** This is mostly a read-only analysis operation. Updates PROJECT_CONTEXT.md (no _chg required for this file)

**Claude Desktop Compatibility:**
- ✅ All analysis via MCP Filesystem
- ✅ Optional git commit at end (single copy/paste)
- ✅ No bash commands required
- 📋 Works 95% in Desktop

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
   - Read metadata from all content files (including all appendices in BackMatter/)
   - Parse all change tracking files
   - Analyze git repository state
   - Collect statistics

2. **Calculate Metrics**:
   - Total word count (current vs. target)
   - Words per chapter AND per appendix
   - Overall completion percentage
   - Target vs. actual comparison
   - Version numbers for each file (chapters, appendices, front matter, back matter)
   - Completion rate per chapter and appendix
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
   - Appendices complete: [N] / [total]
   - Front matter status
   - Back matter status (Glossary, Bibliography, Index, etc.)
   - Overall completion percentage

5. **Refresh PROJECT_CONTEXT.md**: Automatically update with latest project state for Claude Desktop session resumption

   **Chapter Status Table**
   | Chapter | Title | Status | Words | Target | % |
   |---------|-------|--------|-------|--------|---|
   | 01 | [title] | Draft | [N] | [N] | XX% |
   | 02 | [title] | Review | [N] | [N] | XX% |

   **Appendix Status Table**
   | Appendix | Title | Status | Words | Target | % |
   |----------|-------|--------|-------|--------|---|
   | A | [title] | Draft | [N] | [N] | XX% |
   | B | [title] | Review | [N] | [N] | XX% |

   **Recent Activity (Git Log)**
   - Last 10 commits with dates and messages

   **Git Status**
   - Current branch
   - Total commits
   - Latest tag
   - Uncommitted changes (if any)
   - Unpushed commits (if any)

   **Active Locks (Concurrency - v0.13.0+)**

   Check if `.locks/locks.json` exists and read current locks:

   - **If no locks:**
     ```
     Active Locks: None
     ```

   - **If locks exist:**
     For each lock in the `locks` array, calculate age and determine status:

     ```
     Active Locks: [N] active

     | Resource | Instance | Locked At | Age | Status |
     |----------|----------|-----------|-----|--------|
     | Chapter_03 | CLI-12345 | 2025-11-23 14:30 | 5 min | 🔒 Active |
     | StyleSystem | Desktop-67890 | 2025-11-23 13:00 | 95 min | ⚠️ STALE |
     ```

     **Status indicators:**
     - 🔒 Active: Lock age < 15 minutes
     - ⚠️ STALE: Lock age >= 15 minutes (can be overridden)

     **If stale locks detected:**
     ```
     ⚠️ STALE LOCKS DETECTED

     [N] locks are older than 15 minutes and may be from crashed instances.

     To clear all stale locks, you can either:
     1. Execute "Clear All Locks" command (see below)
     2. Manually delete `.locks/locks.json` and restart operations
     ```

   **Clear All Locks Command:**

   Add this as an available action the user can request:

   - If user says "clear all locks" or "clear locks":
     1. Read `.locks/locks.json`
     2. Display all current locks
     3. Ask: "Clear all [N] locks? This will allow other instances to proceed. (yes/no)"
     4. If yes:
        - Write empty structure to `.locks/locks.json`:
          ```json
          {
            "locks": []
          }
          ```
        - Display: `✓ All locks cleared ([N] locks removed)`
     5. If no: Cancel

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

   **Style Distribution (v0.10.1+)**
   - Book-level style: [Style name from Style_Guide.md]
   - Chapter overrides: [N] of [Total] chapters ([XX]%)
   - Section overrides: [N] sections across [N] chapters
   - Override threshold status: [Below/At/Above 30%]
   - Style transitions detected: [N] chapter-level, [N] section-level
   - Undocumented transitions: [N] (requires attention)

   **Chapters with style overrides:**
   - Chapter [XX]: [Override style name] ([Rationale if brief])
   - Chapter [XX]: [Override style name]

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

## Save Dashboard and Update README.md (v0.12.8+)

**After generating the dashboard report:**

### Step 1: Create Dashboard Directory (if needed)

```bash
mkdir -p Manuscript/Dashboard
```

### Step 2: Check for Existing Dashboard

**If `Manuscript/Dashboard/Dashboard.md` already exists:**

Ask the user to commit it to git first (safety measure):

```
⚠️ Existing dashboard will be overwritten.

Would you like to commit the current dashboard before proceeding?

A) Yes - commit current dashboard first
B) No - proceed with overwrite (changes may be lost)
```

**If user selects A:**
```bash
git add Manuscript/Dashboard/Dashboard.md README.md
git commit -m "Save dashboard before update [CONFIRMED_DATE]

🤖 Generated with Claude Code

Co-Authored-By: Claude <noreply@anthropic.com>"
```

Then proceed to Step 3.

**If user selects B or no existing dashboard:**
Proceed directly to Step 3.

### Step 3: Save Dashboard

Write the complete dashboard report to `Manuscript/Dashboard/Dashboard.md`.

**Note:** There is only ONE dashboard file. Always overwrites.

### Step 4: Update README.md

**Follow `Process/_COMMON/17_README_Management_Module.md` to regenerate README.md.**

1. Read `.config/metadata.json` for Project Information
2. Read init.json or PROJECT_CONTEXT.md for About This Book
3. Scan `Manuscript/Reports/` for all reports (ai-detection-*.md and consistency-*.md)
4. Check if `Manuscript/Dashboard/Dashboard.md` exists (yes, we just created it)
5. Regenerate README.md with:
   - **Dashboard link** (if this is first dashboard creation, add the link)
   - Updated Project Information (if needed)
   - Preserved report tables (if exist)
   - All metadata sections

**Dashboard link format:**
```markdown
## Dashboard

📊 [View Current Dashboard](Manuscript/Dashboard/Dashboard.md)
```

### Step 5: Inform User

Display message:
```
✓ Dashboard saved: Manuscript/Dashboard/Dashboard.md
✓ README.md updated with dashboard link
```

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

## Git Commit Format (For Claude Desktop Users)

When providing an optional git commit command at the end, format it like this:

**For Claude Desktop users, provide:**

Go to Claude Code CLI and say:
```
Run: git add PROJECT_CONTEXT.md && git commit -m 'Update project dashboard [date]

Generated comprehensive progress report.

🤖 Generated with Claude Desktop

Co-Authored-By: Claude <noreply@anthropic.com>'
```

**The instruction "Go to Claude Code CLI and say:" must be OUTSIDE the code block.**
**Only the command starting with "Run:" should be inside the code block.**

---

## Ready to Begin?

**Would you like a Summary or Detailed report?**

---

## Lock Management Notes

**Concurrency Support (v0.13.0+):**
- This prompt is **READ-ONLY** for analysis - NO locks are acquired during scanning
- Displays active locks in the dashboard (from `.locks/locks.json`)
- Provides "Clear All Locks" command for recovery from stale locks
- Stale lock detection (locks older than 15 minutes)
- Safe to run alongside other prompts without conflicts
- See `Process/_COMMON/18_Lock_Management_Module.md` for complete details

---

**Version:** 0.13.0
**Last Updated:** 2025-11-23

---

*Reference: Process/AI-Assisted_Nonfiction_Authoring_Process.md (Prompt 10)*
