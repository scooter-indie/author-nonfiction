# Quick Reference Guide - Execute Prompts

## Session Initialization (MANDATORY)

**🚨 BEFORE executing ANY prompts in Claude Code CLI, run:**

```
/fw-init
```

This command loads all framework documentation and activates the Anti-Hallucination Protocol. **Required at the start of every session.**

**See:** [Session Initialization in README.md](README.md#session-initialization-mandatory) for details.

---

## Claude Desktop vs. Claude Code CLI Compatibility

### DESKTOP-FRIENDLY (95%+ Desktop - Single git command at end)
- ✅ **Prompt 2** - Add new chapter
- ✅ **Prompt 3** - Change by Chg (AUTOMATED WORKFLOW)
- ✅ **Prompt 4** - Interactive Change (CONVERSATIONAL WORKFLOW)
- ✅ **Prompt 5** - Scan For User Edits (sync _chg files)
- ✅ **Prompt 6** - Integrate Inbox content
- ✅ **Prompt 10** - Progress dashboard

### HYBRID (50-80% Desktop - Multiple CLI interactions)
- ⚡ **Prompt 1** - Initialize project (file creation in Desktop, git via CLI throughout)
- ⚡ **Prompt 11** - Style Manager (single-file ops in Desktop, multi-file scans better in CLI)

### CLI-ONLY (Must use Claude Code CLI)
- 🔧 **Prompt 7** - Compile manuscript (bulk file operations)
- 🔧 **Prompt 8** - Consistency Checker (bulk file reads: 30-50+ files)
- 🔧 **Prompt 9** - Export to DOCX/PDF/EPUB (requires pandoc)
- 🔧 **Prompt 12** - Git operations (direct git commands)
- 🔧 **Prompt 13** - AI Detection Analysis (bulk chapter analysis)
- 🔧 **Prompt 14** - Citation Finder (requires WebSearch)
- 🔧 **Prompt 15** - Visual Content Suggester (bulk file operations, visual analysis)
- 🔧 **Prompt 16** - Image Manager (file operations, image handling)

**Notes:**
- **DESKTOP-FRIENDLY** prompts work in Claude Desktop, provide single git command at end
- **HYBRID** prompts work in both environments with multiple back-and-forth interactions
- **CLI-ONLY** prompts must be run entirely in Claude Code CLI

---

## At a Glance

| Prompt | Purpose | When to Use | Interaction Level |
|--------|---------|-------------|-------------------|
| 1 | Initialize Project | Starting new book | High - many questions |
| 2 | Add Chapter | Need new chapter | Medium - 4-6 questions |
| 3 | Change by Chg | **AUTOMATED WORKFLOW** | Low - reads _chg file |
| 4 | Interactive Change | **CONVERSATIONAL WORKFLOW** | High - discuss changes |
| 5 | Scan For User Edits | Sync _chg files | Minimal - automatic scan |
| 6 | Integrate Inbox | Process inbox files | Medium - per-file decisions |
| 7 | Compile Manuscript | Create full draft | Low - use defaults or customize |
| 8 | Consistency Check | Find issues | Medium - scope and check types |
| 9 | Export | Create DOCX/PDF/EPUB | Low - use defaults or customize |
| 10 | Dashboard | Check progress | Minimal - summary or detailed |
| 11 | Style Manager | Manage style overrides | Medium - operations vary |
| 12 | Git Operations | Version control | Medium - varies by operation |
| 13 | AI Detection Analysis | Ensure authentic voice | Minimal - automatic analysis |
| 14 | Citation Finder | Find and verify citations | Medium - source selection |
| 15 | Visual Content Suggester | Create text-based visuals | Medium - visual placement |
| 16 | Image Manager | Add/upgrade images | Medium - image operations |

---

## When to Use Each Prompt

### Starting New Work
→ **Prompt 1: Initialize** - Brand new book project

### Daily Content Work
→ **Prompt 3: Change by Chg** - Automated workflow (reads _chg file)
- Write instructions in _chg file
- Execute Prompt 3
- AI reads and applies changes
- Auto-commits to git

→ **Prompt 4: Interactive Change** - Conversational workflow (NEW v0.11.0)
- Discuss changes with AI
- AI writes instructions to _chg file
- Optionally execute Prompt 3 automatically

### Adding Content
→ **Prompt 2: Add Chapter** - New chapter (interactive or from draft)
→ **Prompt 6: Integrate Inbox** - Process inbox files

### Quality Control
→ **Prompt 8: Consistency** - Weekly or at milestones
→ **Prompt 10: Dashboard** - Weekly progress check
→ **Prompt 13: AI Detection Analysis** - Check authentic voice (v0.11.0)
→ **Prompt 14: Citation Finder** - Verify citations (v0.11.0)

### Visual Content (v0.12.7+)
→ **Prompt 15: Visual Content Suggester** - Create text-based visuals (tables, diagrams)
→ **Prompt 16: Image Manager** - Add professional images, upgrade text-based visuals

### Compilation & Export
→ **Prompt 7: Compile** - Review full manuscript
→ **Prompt 9: Export** - Publication formats

### Version Control & Tracking
→ **Prompt 12: Git** - Commit, tag, push, status, etc.
→ **Prompt 5: Scan For User Edits** - Sync _chg files with manual changes

### Style Management (v0.10.1+)
→ **Prompt 11: Style Manager** - Add/remove/analyze style overrides
- Add chapter-level style override
- Remove chapter-level override
- Scan section-level overrides
- Validate override registry
- View style distribution
- Analyze transitions
- Change book-level style

---

## Writing Style System - Hierarchical (v0.10.1+)

The framework includes 19 curated professional styles (v2.0) across 5 categories.

**Hierarchical System:**
Book Style (global) → Chapter Overrides (optional) → Section Overrides (optional)

**Quick Actions:**
- Select style: Prompt 1 (Initialize) or Prompt 11 (Style Manager)
- Add chapter override: Prompt 2 or Prompt 11
- View distribution: Prompt 10 or Prompt 11
- Check consistency: Prompt 8

**For complete style library and detailed usage, see Process/Styles/README.md**

---

## Common Workflows

### Daily Writing Session

**Goal**: Write content, revise, commit, backup

```
0. Initialize framework (if new session)
   → /fw-init

1. Check git status
   → Prompt 12 (Git) → Status

2. Work on content in your editor

3. OPTION A: Write revision instructions in _chg files
   → Edit Manuscript/Chapters/Chapter_XX/Chapter_XX_chg.md
   → Add instructions to [INSTRUCTIONS FOR THIS REVISION]
   → Commit _chg file
   → Execute Prompt 3 (Change by Chg) for each chapter
   → AI reads _chg, applies changes, commits

   OPTION B: Interactive conversational editing
   → Execute Prompt 4 (Interactive Change)
   → Discuss changes with AI
   → AI writes instructions to _chg file and optionally executes

4. Push to remote
   → Prompt 12 (Git) → Push
```

**Time**: 5-10 minutes for prompts, rest is your writing

---

### Weekly Review

**Goal**: Check progress, find issues, compile for review

```
0. Initialize framework (if new session)
   → /fw-init

1. Generate progress report
   → Prompt 10 (Dashboard) → Detailed

2. Run consistency checks
   → Prompt 8 (Consistency) → All chapters, all checks

3. Compile full manuscript
   → Prompt 7 (Compile) → Use defaults

4. Review compiled draft, note issues

5. Fix issues
   → Add instructions to _chg files
   → Prompt 3 (Change by Chg) for each
   → OR use Prompt 4 (Interactive Change) for conversational editing

6. Commit and push
   → Prompt 12 (Git) → Status
   → Prompt 12 (Git) → Push
```

**Time**: 20-30 minutes

---

### Adding a New Chapter

**Option A: Interactive (Quick Add)**

```
1. Execute add chapter prompt
   → Prompt 2 (Add Chapter)

2. Answer questions:
   - Interactive or from Inbox? → Interactive
   - Chapter title? → [your title]
   - Position? → after Chapter 5
   - Word count? → 3500
   - Key topics? → [list or skip]
   - Rationale? → [why adding]

3. AI reorganizes, creates files, commits
```

**Option B: From Inbox (Drafted Content)**

```
1. Place chapter draft in Manuscript/Inbox/

2. Execute integrate prompt
   → Prompt 6 (Integrate Inbox)

3. AI shows findings
   → Suggests: Create new chapter

4. Confirm position and integration method

5. AI creates chapter, commits
```

**Time**: 5 minutes interactive, 10 minutes from Inbox

---

### Milestone Workflow (25%, 50%, 75%, 100%)

**Goal**: Verify progress, check quality, tag milestone

```
0. Initialize framework (if new session)
   → /fw-init

1. Check completion status
   → Prompt 10 (Dashboard) → Detailed
   → Review chapter status table
   → Note completion percentage

2. Run full consistency check
   → Prompt 8 (Consistency) → All chapters, all types

3. Check for AI-generated text indicators
   → Prompt 13 (AI Detection Analysis)
   → Review authenticity scores
   → Rewrite any flagged passages

4. Add visual enhancements where needed
   → Prompt 15 (Visual Content Suggester)
   → Review suggested tables/diagrams
   → Insert chosen text-based visuals
   → Prompt 16 (Image Manager) to upgrade high-priority visuals

5. Verify all citations
   → Prompt 14 (Citation Finder)
   → Check factual claims
   → Add missing citations

6. Fix all critical and high-priority issues
   → Add fixes to _chg files
   → Prompt 3 (Change by Chg) for each issue
   → OR use Prompt 4 (Interactive Change) for conversational editing

7. Compile milestone version
   → Prompt 7 (Compile) → v[X].0.0

8. Create git tag
   → Prompt 12 (Git) → Create Tag
   → Tag name: v1.0.0 or first-draft
   → Message: "Completed first draft" or "[XX]% milestone"

9. Push with tags
   → Prompt 12 (Git) → Push
   → Include tags? → Yes
```

**Time**: 1-2 hours depending on issues found

---

### Publication Preparation

**Goal**: Finalize content, export for publisher

```
1. Verify 100% completion
   → Prompt 10 (Dashboard) → Detailed
   → Check all chapters show "Final" status
   → Verify no placeholders

2. Final consistency check
   → Prompt 8 (Consistency) → All chapters, all types
   → Should find zero critical issues

3. Final authenticity check
   → Prompt 13 (AI Detection Analysis)
   → Ensure authentic voice throughout

4. Fix any remaining issues
   → Prompt 3 (Change by Chg) or Prompt 4 (Interactive Change)

5. Compile final manuscript
   → Prompt 7 (Compile) → v[final].0.0
   → Publication-Ready format

6. Export to required format(s)
   → Prompt 9 (Export)
   → Format: DOCX and/or PDF
   → Use publication settings

7. Tag as publication-ready
   → Prompt 12 (Git) → Create Tag
   → Tag name: publication-v1
   → Message: "Ready for submission"

8. Push with tags
   → Prompt 12 (Git) → Push with tags
```

**Time**: 2-3 hours for thorough final check

---

## The Primary Workflows: Prompt 3 & Prompt 4

**Two approaches for revising content - choose based on your preference:**

### OPTION A: Prompt 3 (Change by Chg) - Automated Workflow

**This is the automated workflow for pre-written instructions.**

**Step-by-Step:**

1. **Identify what needs changing**
   - You review your content
   - You decide what to revise

2. **Write instructions in _chg file**
   ```
   Open: Manuscript/Chapters/Chapter_05/Chapter_05_Analysis_chg.md

   Find: ## REWRITE INSTRUCTIONS
         ### [INSTRUCTIONS FOR THIS REVISION]

   Write: Rewrite section 2 ("Data Analysis Methods") to:
          - Add example using the survey data
          - Clarify the statistical approach
          - Add reference to Smith (2024) paper
          - Improve transitions between paragraphs

          Priority: High
          Rationale: Current explanation is too abstract
   ```

3. **Commit the _chg file**
   ```
   git add Manuscript/Chapters/Chapter_05/Chapter_05_Analysis_chg.md
   git commit -m "Add revision instructions for Chapter 5"
   ```

4. **Execute Prompt 3**
   ```
   Copy: Process/Prompts/Prompt_3_Change_by_Chg.md
   Paste into Claude Code

   AI asks: "Which file should I modify?"
   You: "Manuscript/Chapters/Chapter_05/Chapter_05_Analysis.md"

   AI asks: "Should I analyze content first?"
   You: "Yes" or "No"

   AI: [Reads _chg file, confirms changes, executes]
   ```

5. **AI Auto-Completes**
   - Applies your instructions
   - Moves instructions to Version History
   - Clears [INSTRUCTIONS FOR THIS REVISION]
   - Updates metadata (word count, date)
   - Creates git commit
   - Reports results

6. **Result**
   - Chapter is revised
   - _chg file has new Version History entry
   - Instructions section is ready for next revision
   - Git has commit record

### OPTION B: Prompt 4 (Interactive Change) - Conversational Workflow

**This is the conversational workflow for interactive editing.**

**Step-by-Step:**

1. **Execute Prompt 4**
   ```
   Copy: Process/Prompts/Prompt_4_Interactive_Change.md
   Paste into Claude Code
   ```

2. **Discuss your changes**
   - Tell AI what you want to change
   - AI asks clarifying questions
   - You refine the approach together

3. **AI writes instructions**
   - AI drafts instructions to _chg file
   - You review and approve
   - AI writes to _chg file

4. **Optional: Execute immediately**
   - AI asks if you want to execute Prompt 3 now
   - If yes: AI applies changes automatically
   - If no: Instructions saved for later execution

5. **Result**
   - Instructions documented in _chg file
   - Optionally: Changes applied and committed
   - Full audit trail maintained

### Why This Works

✅ **Single source of truth**: Instructions in _chg file
✅ **Version tracked**: Instructions committed to git
✅ **Auditable**: Version History shows all changes
✅ **Repeatable**: Can iterate quickly
✅ **Clean**: Instructions auto-archived, ready for next

---

## Prompt Chaining

Some tasks naturally chain prompts:

### Add Chapter → Modify Content
```
1. Prompt 2 (Add Chapter) - Creates placeholder
2. Prompt 3 (Change by Chg) or Prompt 4 (Interactive Change) - Fill in content
```

### Integrate → Consistency → Fix
```
1. Prompt 6 (Integrate Inbox) - Add new content
2. Prompt 8 (Consistency) - Check for issues
3. Prompt 3 (Change by Chg) or Prompt 4 (Interactive Change) - Fix issues found
```

### Dashboard → Consistency → Authenticity → Compile
```
1. Prompt 10 (Dashboard) - Check status
2. Prompt 8 (Consistency) - Full check
3. Prompt 13 (AI Detection Analysis) - Check authentic voice
4. Prompt 7 (Compile) - If ready, compile
```

---

## Quick Decision Tree

**"What prompt do I need?"**

```
Do you have a project yet?
├─ No → Prompt 1 (Initialize)
└─ Yes ↓

What do you want to do?
├─ Modify existing content (automated) → Prompt 3 (Change by Chg)
├─ Modify existing content (interactive) → Prompt 4 (Interactive Change)
├─ Sync manual edits → Prompt 5 (Scan For User Edits)
├─ Add new chapter → Prompt 2 (Add Chapter)
├─ Process inbox files → Prompt 6 (Integrate Inbox)
├─ Review full book → Prompt 7 (Compile)
├─ Find problems → Prompt 8 (Consistency)
├─ Export for pub → Prompt 9 (Export)
├─ Check progress → Prompt 10 (Dashboard)
├─ Manage styles → Prompt 11 (Style Manager)
├─ Git operations → Prompt 12 (Git)
├─ Check authenticity → Prompt 13 (AI Detection Analysis)
├─ Find citations → Prompt 14 (Citation Finder)
├─ Add text visuals → Prompt 15 (Visual Content Suggester)
└─ Manage images → Prompt 16 (Image Manager)
```

---

## Frequency Recommendations

| Prompt | Frequency | Why |
|--------|-----------|-----|
| 1 | Once per book | Project initialization |
| 2 | As needed | When adding chapters |
| 3 | **Daily-multiple times** | **Automated revision workflow** |
| 4 | **Daily-multiple times** | **Interactive revision workflow** |
| 5 | After manual edits, weekly | Sync _chg files |
| 6 | Weekly or as needed | When inbox has content |
| 7 | Weekly-monthly | Regular manuscript reviews |
| 8 | Weekly | Catch issues early |
| 9 | At milestones | Publication preparation |
| 10 | Weekly | Progress monitoring |
| 11 | As needed | Style override management |
| 12 | Daily (status, push) | Version control hygiene |
| 13 | At milestones | Check authentic voice |
| 14 | During revision | Visual enhancement |
| 15 | As needed | Citation verification |

---

## Working with Multiple Instances (v0.13.0+)

**New in v0.13.0:** You can now run multiple Claude instances safely, working on different parts of your book simultaneously.

### How It Works

The framework uses a **resource-level lock system** to prevent editing conflicts:

- **Resource-level locks** - Locks individual chapters, style system, image registry, etc.
- **15-minute timeout** - Stale locks from crashed instances automatically expire
- **Override capability** - You can override stale locks when needed
- **Works everywhere** - Both Claude Code CLI and Claude Desktop

### Lock System Overview

**When you execute a prompt that modifies content:**
1. The prompt checks if that resource is locked
2. If unlocked, acquires lock and proceeds
3. If locked by another instance, offers options: wait, cancel, or override (if stale)
4. After completing work, releases the lock

**Resources that can be locked:**
- Individual chapters (`Chapter_01`, `Chapter_02`, etc.)
- `FrontMatter` - All front matter files
- `BackMatter` - All back matter files
- `StyleSystem` - Style guide and overrides
- `QuoteRegistry` - Chapter quotes file
- `ImageRegistry` - Image registry file(s)
- `ProjectConfig` - Project configuration files

### Working Safely with Multiple Instances

**Best Practices:**
- ✅ Work on **different chapters** in different instances - no conflicts
- ✅ Check Dashboard (Prompt 10) to see what's currently locked
- ✅ Wait for locks to clear rather than overriding active locks
- ✅ Use "Clear All Locks" after crashes to clean up stale locks

**Example Safe Workflow:**
```
Terminal 1: Edit Chapter 3 (acquires lock on Chapter_03)
Terminal 2: Edit Chapter 7 (acquires lock on Chapter_07)
→ No conflict, both work simultaneously
```

**Example Conflict Resolution:**
```
Terminal 1: Editing Chapter 5 (lock acquired)
Terminal 2: Tries to edit Chapter 5
→ Shows: "Chapter_05 is locked (3 minutes ago)"
→ Options: Wait | Cancel | Override (if stale)
→ Choose: Wait
→ Terminal 1 finishes, releases lock
→ Terminal 2 automatically acquires lock and proceeds
```

### Managing Locks

**Check Current Locks:**
- Run Prompt 10 (Dashboard) - shows all active and stale locks
- See which resources are locked and by which instance

**Clear Stale Locks:**
- Dashboard shows "Clear All Locks" option
- Removes all locks (use after crashes or when stuck)
- Requires confirmation

**Lock Timeout:**
- Locks older than 15 minutes are considered "stale"
- Stale locks can be overridden without waiting
- Helps recover from crashed instances

### Technical Details

**Lock storage:** `.locks/locks.json` (automatically created, added to `.gitignore`)

**Lock file not committed to git** - locks are local to your machine only

**Prompts that acquire locks:**
- Prompt 1 (Initialize), Prompt 2 (Add Chapter)
- Prompt 3 (Change by Chg), Prompt 4 (Interactive Change)
- Prompt 5 (Scan For User Edits), Prompt 6 (Integrate Inbox)
- Prompt 11 (Style Manager), Prompt 14 (Citation Finder)
- Prompt 15 (Visual Content Suggester), Prompt 16 (Image Manager)

**Prompts that don't need locks (read-only):**
- Prompt 7 (Compile), Prompt 8 (Consistency)
- Prompt 9 (Export), Prompt 10 (Dashboard)
- Prompt 12 (Git Operations), Prompt 13 (AI Detection)

**For complete lock system details:** See `Process/_COMMON/18_Lock_Management_Module.md`

---

## Tips for Success

### For Prompt 3 & 4 (Your Main Tools)
1. **Prompt 3 (automated)**: Write detailed _chg instructions, commit before executing
2. **Prompt 4 (interactive)**: Discuss changes conversationally, AI handles documentation
3. **Choose based on preference**: Both produce the same audit trail
4. **One focus per revision**: Don't try to fix everything at once
5. **Use Priority markers**: High/Medium/Low helps AI understand urgency

### For All Prompts
1. **Read the Anti-Hallucination Guidelines**: Prevents fabricated content
2. **Push to remote daily**: Cloud backup via Prompt 12
3. **Run Prompt 10 weekly**: Stay aware of progress
4. **Run Prompt 8 before compiling**: Catch issues before full review
5. **Run Prompt 13 at milestones**: Ensure authentic voice
6. **Use default settings**: Stored in .config/project.json, save time

### TOC Management
1. **Never edit TOC_chg.md manually**: AI-managed only
2. **Use Prompt 2 for new chapters**: Keeps TOC in sync
3. **No complete TOC files in Inbox after init**: Use Prompt 2 instead

---

## Example Instructions for _chg Files

### Good Examples

```markdown
### [INSTRUCTIONS FOR THIS REVISION]

Strengthen the opening paragraph:
- Start with the surprising statistic about remote work adoption
- Add emotional hook about changed workplace expectations
- Connect to reader's likely experience
- Lead into the chapter's main argument

Priority: High
Rationale: Current opening is weak, doesn't engage reader
```

```markdown
### [INSTRUCTIONS FOR THIS REVISION]

Add case study to section 3:
- Use the TechCorp example (fictional but realistic)
- Show how they implemented 4-day work week
- Include challenges and results
- Keep it brief (300-400 words)
- Add [CITATION NEEDED] marker for real-world similar case

Priority: Medium
Rationale: Section needs concrete example to illustrate points
```

### Less Effective

```markdown
### [INSTRUCTIONS FOR THIS REVISION]

Make it better
```
*Too vague - AI needs specific guidance*

```markdown
### [INSTRUCTIONS FOR THIS REVISION]

Rewrite everything and add 10 examples and fix all the problems
```
*Too broad - break into smaller, focused revisions*

---

## Getting Unstuck

**Problem**: Not sure which prompt to use
**Solution**: Check the decision tree above or start with Prompt 10 (Dashboard)

**Problem**: Prompt 3 isn't understanding my instructions
**Solution**: Be more specific in _chg file, use examples, OR try Prompt 4 for interactive discussion

**Problem**: Too many issues from Prompt 8
**Solution**: Tackle high-priority first, use Prompt 3 or 4 iteratively

**Problem**: Forgot to commit _chg file (Prompt 3 workflow)
**Solution**: Commit it now, re-run Prompt 3

**Problem**: Lost track of progress
**Solution**: Prompt 10 (Dashboard) shows everything

**Problem**: Manual edits not reflected in _chg files
**Solution**: Run Prompt 5 (Scan For User Edits) to sync

**Problem**: Content sounds too AI-generated
**Solution**: Run Prompt 13 (AI Detection Analysis), rewrite flagged passages

---

## Remember

**The core loop is simple (choose your workflow):**

**OPTION A: Automated (Prompt 3)**
1. Write instructions in _chg file
2. Commit _chg file
3. Execute Prompt 3 (Change by Chg)
4. AI applies, archives, commits
5. Repeat

**OPTION B: Interactive (Prompt 4)**
1. Execute Prompt 4 (Interactive Change)
2. Discuss changes with AI
3. AI writes to _chg file
4. Optionally execute immediately
5. Repeat

Everything else supports these core workflows.
