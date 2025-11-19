# Quick Reference Guide - Execute Prompts

## Claude Desktop vs. Claude Code CLI Compatibility

### DESKTOP-READY (100% Claude Desktop - No CLI needed)
- ✅ **Prompt 6** - Consistency checks (read-only analysis)

### DESKTOP-FRIENDLY (95%+ Desktop - Single git command at end)
- ✅ **Prompt 2** - Add new chapter (file operations + git at end)
- ✅ **Prompt 3** - Modify file (PRIMARY WORKFLOW)
- ✅ **Prompt 4** - Integrate Inbox content
- ✅ **Prompt 8** - Progress dashboard
- ✅ **Prompt 10** - Update change tracking

### CLI-ONLY (Must use Claude Code CLI)
- 🔧 **Prompt 1** - Initialize project (git operations throughout)
- 🔧 **Prompt 5** - Compile manuscript (bulk file operations)
- 🔧 **Prompt 7** - Export to DOCX/PDF/EPUB (requires pandoc)
- 🔧 **Prompt 9** - Git operations (direct git commands)

**Note:** DESKTOP-FRIENDLY prompts work in Claude Desktop but provide a git command to copy/paste into Claude Code CLI at the end.

---

## At a Glance

| Prompt | Purpose | When to Use | Interaction Level |
|--------|---------|-------------|-------------------|
| 1 | Initialize Project | Starting new book | High - many questions |
| 2 | Add Chapter | Need new chapter | Medium - 4-6 questions |
| 3 | Modify File | **PRIMARY REVISION WORKFLOW** | Low - reads _chg file |
| 4 | Integrate Inbox | Process inbox files | Medium - per-file decisions |
| 5 | Compile Manuscript | Create full draft | Low - use defaults or customize |
| 6 | Consistency Check | Find issues | Medium - scope and check types |
| 7 | Export | Create DOCX/PDF/EPUB | Low - use defaults or customize |
| 8 | Dashboard | Check progress | Minimal - summary or detailed |
| 9 | Git Operations | Version control | Medium - varies by operation |
| 10 | Update Change Tracking | Sync _chg files | Minimal - automatic scan |

---

## When to Use Each Prompt

### Starting New Work
→ **Prompt 1: Initialize** - Brand new book project

### Daily Content Work
→ **Prompt 3: Modify File** - Your main workflow
- Edit _chg file with instructions
- Execute Prompt 3
- AI reads and applies changes
- Auto-commits to git

### Adding Content
→ **Prompt 2: Add Chapter** - New chapter (interactive or from draft)
→ **Prompt 4: Integrate Inbox** - Process inbox files

### Quality Control
→ **Prompt 6: Consistency** - Weekly or at milestones
→ **Prompt 8: Dashboard** - Weekly progress check

### Compilation & Export
→ **Prompt 5: Compile** - Review full manuscript
→ **Prompt 7: Export** - Publication formats

### Version Control & Tracking
→ **Prompt 9: Git** - Commit, tag, push, status, etc.
→ **Prompt 10: Update Change Tracking** - Sync _chg files with changes

---

## Writing Style System

The framework includes a comprehensive writing style system with 9 curated professional styles:

**Framework Styles Available:**
- Academic Authority
- Conversational Expert
- Narrative Storyteller
- Business Professional
- Technical Precision
- Investigative Journalist
- Practical Guide
- Inspirational Teacher
- Scientific Communicator

**How It Works:**
1. **Prompt 1 (Initialize)** asks you to select a style during project setup
2. Creates `Manuscript/Style/Style_Guide.md` with your active configuration
3. **Prompt 3 (Modify File)** automatically checks modified content against your style
4. **Prompt 6 (Consistency)** analyzes entire book for style alignment
5. **Book-writing-assistant agent** applies your style to all writing assistance

**Quick Actions:**
- **Select style**: Use Prompt 1 during initialization
- **Create custom style**: Edit `Manuscript/Style/Custom_Styles.md`
- **Change your style**: Edit `Manuscript/Style/Style_Guide.md`
- **Check style consistency**: Use Prompt 6 with style analysis

---

## Common Workflows

### Daily Writing Session

**Goal**: Write content, revise, commit, backup

```
1. Check git status
   → Prompt 9 (Git) → Status

2. Work on content in your editor

3. Write revision instructions in _chg files
   → Edit Manuscript/Chapters/Chapter_XX/Chapter_XX_chg.md
   → Add instructions to [INSTRUCTIONS FOR THIS REVISION]
   → Commit _chg file

4. Execute revisions
   → Prompt 3 (Modify File) for each chapter
   → AI reads _chg, applies changes, commits

5. Push to remote
   → Prompt 9 (Git) → Push
```

**Time**: 5-10 minutes for prompts, rest is your writing

---

### Weekly Review

**Goal**: Check progress, find issues, compile for review

```
1. Generate progress report
   → Prompt 8 (Dashboard) → Detailed

2. Run consistency checks
   → Prompt 6 (Consistency) → All chapters, all checks

3. Compile full manuscript
   → Prompt 5 (Compile) → Use defaults

4. Review compiled draft, note issues

5. Fix issues
   → Add instructions to _chg files
   → Prompt 3 (Modify File) for each

6. Commit and push
   → Prompt 9 (Git) → Status
   → Prompt 9 (Git) → Push
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
   → Prompt 4 (Integrate Inbox)

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
1. Check completion status
   → Prompt 8 (Dashboard) → Detailed
   → Review chapter status table
   → Note completion percentage

2. Run full consistency check
   → Prompt 6 (Consistency) → All chapters, all types

3. Fix all critical and high-priority issues
   → Add fixes to _chg files
   → Prompt 3 (Modify File) for each issue

4. Compile milestone version
   → Prompt 5 (Compile) → v[X].0.0

5. Create git tag
   → Prompt 9 (Git) → Create Tag
   → Tag name: v1.0.0 or first-draft
   → Message: "Completed first draft" or "[XX]% milestone"

6. Push with tags
   → Prompt 9 (Git) → Push
   → Include tags? → Yes
```

**Time**: 1-2 hours depending on issues found

---

### Publication Preparation

**Goal**: Finalize content, export for publisher

```
1. Verify 100% completion
   → Prompt 8 (Dashboard) → Detailed
   → Check all chapters show "Final" status
   → Verify no placeholders

2. Final consistency check
   → Prompt 6 (Consistency) → All chapters, all types
   → Should find zero critical issues

3. Fix any remaining issues
   → Prompt 3 (Modify File)

4. Compile final manuscript
   → Prompt 5 (Compile) → v[final].0.0
   → Publication-Ready format

5. Export to required format(s)
   → Prompt 7 (Export)
   → Format: DOCX and/or PDF
   → Use publication settings

6. Tag as publication-ready
   → Prompt 9 (Git) → Create Tag
   → Tag name: publication-v1
   → Message: "Ready for submission"

7. Push with tags
   → Prompt 9 (Git) → Push with tags
```

**Time**: 2-3 hours for thorough final check

---

## The Primary Workflow: Prompt 3

**This is how you'll spend 80% of your time revising content.**

### Step-by-Step

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
   Copy: Process/Prompts/Prompt_3_Modify_File.md
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
2. Prompt 3 (Modify File) - Fill in content
```

### Integrate → Consistency → Fix
```
1. Prompt 4 (Integrate Inbox) - Add new content
2. Prompt 6 (Consistency) - Check for issues
3. Prompt 3 (Modify File) - Fix issues found
```

### Dashboard → Consistency → Compile
```
1. Prompt 8 (Dashboard) - Check status
2. Prompt 6 (Consistency) - Full check
3. Prompt 5 (Compile) - If ready, compile
```

---

## Quick Decision Tree

**"What prompt do I need?"**

```
Do you have a project yet?
├─ No → Prompt 1 (Initialize)
└─ Yes ↓

What do you want to do?
├─ Modify existing content → Prompt 3 (Modify File)
├─ Add new chapter → Prompt 2 (Add Chapter)
├─ Process inbox files → Prompt 4 (Integrate Inbox)
├─ Check progress → Prompt 8 (Dashboard)
├─ Find problems → Prompt 6 (Consistency)
├─ Review full book → Prompt 5 (Compile)
├─ Export for pub → Prompt 7 (Export)
└─ Git operations → Prompt 9 (Git)
```

---

## Frequency Recommendations

| Prompt | Frequency | Why |
|--------|-----------|-----|
| 1 | Once per book | Project initialization |
| 2 | As needed | When adding chapters |
| 3 | **Daily-multiple times** | **Main revision workflow** |
| 4 | Weekly or as needed | When inbox has content |
| 5 | Weekly-monthly | Regular manuscript reviews |
| 6 | Weekly | Catch issues early |
| 7 | At milestones | Publication preparation |
| 8 | Weekly | Progress monitoring |
| 9 | Daily (status, push) | Version control hygiene |

---

## Tips for Success

### For Prompt 3 (Your Main Tool)
1. **Be specific in _chg instructions**: More detail = better results
2. **Commit _chg before executing**: Creates audit trail
3. **One focus per revision**: Don't try to fix everything at once
4. **Use Priority markers**: High/Medium/Low helps AI understand urgency

### For All Prompts
1. **Read the Anti-Hallucination Guidelines**: Prevents fabricated content
2. **Push to remote daily**: Cloud backup via Prompt 9
3. **Run Prompt 8 weekly**: Stay aware of progress
4. **Run Prompt 6 before compiling**: Catch issues before full review
5. **Use default settings**: Stored in Project_Config.md, save time

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
**Solution**: Check the decision tree above or start with Prompt 8 (Dashboard)

**Problem**: Prompt 3 isn't understanding my instructions
**Solution**: Be more specific in _chg file, use examples

**Problem**: Too many issues from Prompt 6
**Solution**: Tackle high-priority first, use Prompt 3 iteratively

**Problem**: Forgot to commit _chg file
**Solution**: Commit it now, re-run Prompt 3

**Problem**: Lost track of progress
**Solution**: Prompt 8 (Dashboard) shows everything

---

## Remember

**The core loop is simple:**
1. Write instructions in _chg file
2. Commit _chg file
3. Execute Prompt 3
4. AI applies, archives, commits
5. Repeat

Everything else supports this core workflow.
