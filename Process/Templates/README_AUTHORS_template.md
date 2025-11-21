# AI-Assisted Nonfiction Book Authoring Framework

**Version:** {{VERSION}}
**Your Partner in Writing Excellence**

---

## Welcome to Your Book Project

This framework provides everything you need to write, organize, and publish a professional nonfiction book with AI assistance. It combines structured workflows, version control, and intelligent prompts to help you focus on writing while maintaining quality and consistency.

---

## Quick Start

**You've already installed the framework!** Here's what to do next:

### 1. Understand What You Have

Your project now contains:

- **Process/** - The framework (16 conversational prompts + documentation)
- **.claude/agents/** - Your AI writing assistant for book sessions
- **.config/** - Configuration files (manifest, project settings, metadata)
- **Your book content** - Chapters, TOC, metadata (created during initialization)

### 2. Daily Writing Workflow

**This is how you'll work 80% of the time:**

1. **Write instructions** in a chapter's `_chg.md` file
2. **Commit the instructions** to git
3. **Execute Prompt 3** (Modify File) via Claude Code
4. **AI applies changes**, archives instructions, commits results
5. **Review and repeat**

Example:
```
1. Open: Manuscript/Chapters/Chapter_03/Chapter_03_Analysis_chg.md
2. Write in [INSTRUCTIONS FOR THIS REVISION] section:
   "Add example using survey data. Clarify statistical approach."
3. Commit: git commit -am "Add revision instructions for Chapter 3"
4. Run: Process/Prompts/Prompt_3_Change_by_Chg.md in Claude Code
5. Done! Chapter updated, changes tracked, ready for next revision.
```

### 3. Essential Prompts

| Prompt | When to Use | Frequency |
|--------|-------------|-----------|
| **Prompt 3: Modify File** | Revise any content | Daily - multiple times |
| **Prompt 8: Dashboard** | Check progress | Weekly |
| **Prompt 6: Consistency** | Find issues | Weekly |
| **Prompt 5: Compile** | Review full manuscript | Monthly |

See `Process/Prompts/QUICK_REFERENCE.md` for complete workflows.

---

## The 10 Prompts

Your framework includes 10 conversational Execute prompts. Simply copy the prompt file and paste it into Claude Code.

### Content Creation
- **Prompt 1: Initialize** - Set up new book (already completed!)
- **Prompt 2: Add Chapter** - Create new chapters
- **Prompt 3: Modify File** - Your primary revision tool (use this daily)
- **Prompt 4: Integrate Inbox** - Process drafted content

### Quality & Progress
- **Prompt 6: Consistency** - Find terminology, style, and fact issues
- **Prompt 8: Dashboard** - View progress and statistics

### Output
- **Prompt 5: Compile** - Generate full manuscript draft
- **Prompt 7: Export** - Create DOCX/PDF for publication

### Maintenance
- **Prompt 9: Git** - Version control operations
- **Prompt 10: Update Change Tracking** - Sync change files

---

## Writing Style System

Your framework includes 9 professionally curated writing styles:

- Academic Authority
- Conversational Expert
- Narrative Storyteller
- Business Professional
- Technical Precision
- Investigative Journalist
- Practical Guide
- Inspirational Teacher
- Scientific Communicator

**You selected your style during initialization.** It's configured in `Manuscript/Style/Style_Guide.md`.

The framework automatically:
- Checks your writing against your style (Prompt 3)
- Analyzes style consistency across chapters (Prompt 6)
- Applies your style during AI writing assistance

**Change your style:** Edit `Manuscript/Style/Style_Guide.md` or create custom styles in `Manuscript/Style/Custom_Styles.md`

---

## Key Features

### Change Tracking System
Every content file has a corresponding `_chg.md` file that tracks:
- Version history with rationale
- Rewrite instructions for AI
- Auto-archiving of completed changes
- Full audit trail

### Quote Management
Manage chapter epigraphs with verification:
- Search for quotes via web (book-writing-assistant agent)
- Verify attributions
- Track verification status (✓ Verified, ⚠ Needs Citation, ⏳ Pending)
- Auto-insert into compiled manuscripts

### Git Version Control
All changes are tracked in git:
- Prompts auto-commit with descriptive messages
- Branch for experiments
- Tag milestones
- Push to remote for cloud backup
- Full rollback capability

### AI Assistant Integration
`.claude/agents/book-writing-assistant.md` provides:
- Context-aware writing sessions
- Quote search and management
- Style consistency checking
- Automatic change tracking synchronization

---

## Common Workflows

### Weekly Review
```
1. Prompt 8 (Dashboard) → Check progress
2. Prompt 6 (Consistency) → Find issues
3. Prompt 3 (Modify File) → Fix issues
4. Prompt 9 (Git) → Push to backup
```

### Adding a Chapter
```
1. Prompt 2 (Add Chapter) → Create placeholder
2. Prompt 3 (Modify File) → Write content
3. Prompt 6 (Consistency) → Verify quality
```

### Milestone (25%, 50%, 75%, 100%)
```
1. Prompt 8 (Dashboard) → Verify completion %
2. Prompt 6 (Consistency) → Full check
3. Fix critical issues with Prompt 3
4. Prompt 5 (Compile) → Generate draft
5. Prompt 9 (Git) → Create tag (v1.0.0)
```

---

## Documentation

- **Quick Reference:** `Process/Prompts/QUICK_REFERENCE.md` - Essential workflows
- **Complete Guide:** `Process/AI-Assisted_Nonfiction_Authoring_Process.md` - Full documentation
- **Anti-Hallucination:** `Process/Anti-Hallucination_Guidelines.md` - Prevents AI fabrication
- **Style Library:** `Process/Style_Examples.md` - All 9 framework styles

---

## Updating the Framework

When new framework versions are released:

1. **Commit your work**: `git commit -am "Save work before update"`
2. **Create backup** of your entire project directory
3. Visit: https://github.com/scooter-indie/author-nonfiction/releases
4. Download latest `nonfiction-vX.Y.Z.zip`
5. Extract with overwrite to your project root
6. Run `execute configure.md` in Claude Code
7. Review changelog and verify updates
8. Your book content is preserved; only framework files update

**Check your current version:**
```bash
cat .config/manifest.json
```

**Current version:** {{VERSION}}

---

## Best Practices

### Daily Habits
- ✓ Commit frequently (after each logical change)
- ✓ Push to remote daily (cloud backup)
- ✓ Use Prompt 3 for all content revisions
- ✓ Write specific instructions in `_chg` files

### Weekly Habits
- ✓ Run Prompt 8 (Dashboard) to track progress
- ✓ Run Prompt 6 (Consistency) to catch issues early
- ✓ Review git log to see your work history
- ✓ Ensure remote backup is up-to-date

### Quality Control
- ✓ Run consistency check before compiling
- ✓ Fix critical and high-priority issues first
- ✓ Use style system to maintain voice
- ✓ Verify quote attributions before export

### Collaboration
- ✓ Use git branches for experimental rewrites
- ✓ Tag milestones (first-draft, revised-draft)
- ✓ Share compiled drafts from Drafts/ directory
- ✓ Keep Process/ directory in sync with team

---

## Support and Resources

**Framework Issues or Questions:**
- GitHub Issues: https://github.com/scooter-indie/author-nonfiction/issues
- Releases: https://github.com/scooter-indie/author-nonfiction/releases

**Git Help:**
- Git Basics: https://git-scm.com/book/en/v2/Getting-Started-Git-Basics
- GitHub Help: https://docs.github.com/

**Claude Code:**
- Documentation: https://code.claude.com/docs

---

## Your Book Content

**Remember:** The framework (Process/ directory) is separate from your book content.

**Framework files:** Process/, .claude/, scripts/
**Your book:** Everything else (Manuscript/, .config/, README.md)

Updates to the framework don't affect your book content. Your writing is always preserved.

---

## Ready to Write?

**Start here:**
1. Open `Process/Prompts/QUICK_REFERENCE.md` to learn the workflows
2. Review your `Project_Metadata.md` to see your book goals
3. Check `TOC/TOC.md` to see your chapter structure
4. Write revision instructions in a chapter's `_chg.md` file
5. Execute Prompt 3 to apply those instructions
6. Repeat until your book is complete!

**Your framework version:** {{VERSION}}
**Installed on:** {{INSTALL_DATE}}

---

*Happy writing! The framework is here to support your creative vision.*
