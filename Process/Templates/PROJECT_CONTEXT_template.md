# PROJECT CONTEXT
# AI-Assisted Nonfiction Authoring Framework

**Generated:** {DATE}
**Framework Version:** {FRAMEWORK_VERSION}
**Project Version:** {PROJECT_VERSION}

---

## Purpose of This File

This file provides complete context for resuming work on your book project in Claude Desktop or Claude Code. Upload this file at the start of each session along with appropriate System Instructions to enable Claude to immediately understand your project state and continue work.

**For Claude Desktop Users:**
1. Start new chat
2. **Upload this file (PROJECT_CONTEXT.md) to the Files area** (drag-and-drop or click paperclip icon)
3. Paste System Instructions in the message area (see Process/Prompts/README.md)
4. Send the message
5. Claude will read the file and have full context

**IMPORTANT:** Upload this file to the Files area, do NOT copy/paste its contents into your message.

---

## PART 1: FRAMEWORK OVERVIEW

### What This Framework Does

The **AI-Assisted Nonfiction Authoring Framework** is a comprehensive system for writing nonfiction books with AI assistance using Git version control and structured workflows.

**Core Principles:**
- **Modularity**: Each chapter is a separate file
- **Traceability**: All changes tracked with rationale
- **Quality**: Built-in validation and consistency checking
- **Safety**: Git version control with commits before major operations

**File Format:** All content in Markdown (`.md`) with change tracking files (`_chg.md`)

### Critical: Anti-Hallucination Guidelines

**ALWAYS apply these rules:**
- Never fabricate quotes, statistics, or citations
- Mark uncertain content clearly with ⚠️
- Use proper quote verification status: ⏳ Pending | ⚠ Needs Citation | ✓ Verified
- Never guess attributions
- When in doubt, ask the user

**Full guidelines:** `Process/Anti-Hallucination_Guidelines.md`

### 10 Core Prompts

1. **Initialize** - Create new book project
2. **Add Chapter** - Insert new chapter
3. **Modify File** - PRIMARY workflow for content changes
4. **Integrate Inbox** - Process inbox content
5. **Compile** - Generate complete manuscript
6. **Consistency** - Check for issues across book
7. **Export** - Export to DOCX/PDF/EPUB
8. **Dashboard** - Progress report and status
9. **Git Operations** - Version control operations
10. **Update Change Tracking** - Sync _chg files

**Primary workflow:** Use **Prompt 3** for all content modifications.

### Change Tracking Workflow

1. Author writes revision instructions in `[filename]_chg.md`
2. Author commits the _chg file
3. Execute Prompt 3
4. AI reads instructions from _chg file
5. AI applies changes to content file
6. AI auto-archives instructions to Version History
7. AI clears instruction section
8. AI commits to git with version info

**Version Format:** N.M.P (Major.Minor.Patch)
- **Major (N):** Structural changes affecting multiple chapters
- **Minor (M):** Significant content revisions
- **Patch (P):** Minor edits, typos, formatting

### Execute Prompts - Two Methods

**Method 1: Copy and Paste**
1. Open prompt file (e.g., `Process/Prompts/Prompt_3_Change_by_Chg.md`)
2. Copy entire contents
3. Paste into Claude
4. Follow interactive workflow

**Method 2: Direct Reference**
- "Execute Prompt 3"
- "Run Prompt 8 to show dashboard"
- "Execute Prompt 6 for consistency check"

---

## PART 2: THIS BOOK PROJECT

### Project Metadata

**Book Title:** {BOOK_TITLE}
**Subtitle:** {BOOK_SUBTITLE}
**Author:** {AUTHOR_NAME}
**Genre/Category:** {GENRE}
**Target Word Count:** {TARGET_WORD_COUNT}
**Current Word Count:** {CURRENT_WORD_COUNT}
**Project Version:** {PROJECT_VERSION}
**Last Updated:** {LAST_UPDATED}

### Writing Style

**Selected Style:** {STYLE_NAME}

{STYLE_DESCRIPTION}

**Key Characteristics:**
{STYLE_CHARACTERISTICS}

**Custom Instructions:**
{CUSTOM_STYLE_INSTRUCTIONS}

### Project Structure

**Home Directory:** `{PROJECT_HOME}`

```
{PROJECT_HOME}/
├── Chapters/           # Chapter content and change tracking
├── Front_Matter/       # Title, dedication, preface, etc.
├── Back_Matter/        # Appendices, bibliography, index
├── Quotes/             # Centralized quote/epigraph management
├── Drafts/             # Compiled manuscript versions
├── Exports/            # Published formats (DOCX, PDF, EPUB)
├── Inbox/              # Incoming content to integrate
├── Archive/            # Historical versions and removed content
├── Assets/             # Images, diagrams, tables
├── Process/            # Framework documentation and prompts
├── Style_Guide.md      # Project-specific style guide
├── manifest.json       # Project metadata
└── README_AUTHORS.md   # Project documentation
```

### Table of Contents

**Status Legend:** ✅ Complete | 🚧 In Progress | 📝 Outlined | ⭐ Not Started

{TOC_CONTENT}

**Chapter Count:** {CHAPTER_COUNT}
**Completion Status:** {COMPLETION_PERCENTAGE}%

### Quote Management

**Central Quote File:** `Quotes/Chapter_Quotes.md`

**Current Quote Status:**
- ✓ Verified: {VERIFIED_COUNT}
- ⏳ Pending: {PENDING_COUNT}
- ⚠ Needs Citation: {NEEDS_CITATION_COUNT}

**Recent Quotes:**
{RECENT_QUOTES}

### Current Version Status

**Current Version:** {PROJECT_VERSION}

**Version History Summary:**
{VERSION_HISTORY_SUMMARY}

**Last 3 Commits:**
{RECENT_COMMITS}

### Recent Activity

**Last Session:** {LAST_SESSION_DATE}

**Recent Changes:**
{RECENT_CHANGES}

**Files Modified Recently:**
{RECENTLY_MODIFIED_FILES}

### Pending Work

**Active _chg Files with Instructions:**
{PENDING_CHG_FILES}

**Consistency Issues (if any):**
{CONSISTENCY_ISSUES}

**Next Recommended Actions:**
{NEXT_ACTIONS}

### Project-Specific Conventions

**Terminology:**
{TERMINOLOGY_LIST}

**Character/Person Names:**
{PERSON_NAMES}

**Recurring Themes:**
{THEMES}

**Key Concepts:**
{KEY_CONCEPTS}

**Style Preferences:**
{STYLE_PREFERENCES}

**Citation Style:** {CITATION_STYLE}

### Important Project Files

**Must Reference:**
- `Style_Guide.md` - Project-specific style guide
- `Quotes/Chapter_Quotes.md` - Centralized quotes
- `manifest.json` - Project metadata
- `README_AUTHORS.md` - Project documentation

**Framework Reference:**
- `Process/Anti-Hallucination_Guidelines.md` - Critical accuracy rules
- `Process/Prompts/QUICK_REFERENCE.md` - Workflow guide
- `Process/Style_Examples.md` - Writing style library

### Git Status

**Current Branch:** {CURRENT_BRANCH}
**Remote:** {REMOTE_URL}
**Last Push:** {LAST_PUSH_DATE}

**Tags:**
{GIT_TAGS}

**Uncommitted Changes:**
{UNCOMMITTED_CHANGES}

---

## PART 3: SESSION STARTUP CHECKLIST

When starting a new Claude session with this file:

✅ **Framework context loaded** - Core principles and workflows understood
✅ **Project metadata loaded** - Book title, style, structure known
✅ **Current state loaded** - TOC, versions, recent activity known
✅ **Anti-Hallucination Guidelines active** - Accuracy rules in effect
✅ **Ready to work** - Can execute prompts or continue writing

### Quick Start Commands

**For immediate continuation:**
- "Show dashboard" (Prompt 8)
- "What should I work on next?"
- "Execute Prompt 3 to modify [filename]"
- "Check for consistency issues" (Prompt 6)
- "Show me pending _chg instructions"

**For review:**
- "Summarize the book's current state"
- "What chapters are complete?"
- "What are the recent changes?"

---

## PART 4: MAINTENANCE

### When This File Is Updated

This file is automatically regenerated/updated by:
- **Prompt 1** - Initial creation during project initialization
- **Prompt 3** - After significant content changes
- **Prompt 8** - When dashboard is run (updates statistics)
- **Prompt 10** - After change tracking synchronization

**Manual refresh:** Execute Prompt 8 with "Update PROJECT_CONTEXT.md" flag

### File Location

**Standard location:** `{PROJECT_HOME}/PROJECT_CONTEXT.md`

**Version:** This file corresponds to project version {PROJECT_VERSION}

---

## PART 5: CLAUDE DESKTOP WORKFLOW

### Recommended Session Workflow

1. **Start Session:**
   - Open Claude Desktop
   - Upload `PROJECT_CONTEXT.md`
   - Paste System Instructions (see below)

2. **Quick Check:**
   - Review "Recent Activity" section above
   - Check "Pending Work" section
   - Review "Next Recommended Actions"

3. **Begin Work:**
   - Execute appropriate prompt
   - Or give direct instructions
   - Claude has full context from this file

4. **End Session:**
   - Run Prompt 8 to update dashboard (auto-updates this file)
   - Commit changes with Prompt 9
   - This file is now current for next session

### System Instructions for Claude Desktop

See `Process/Prompts/README.md` for complete System Instructions to use with this file.

**Quick version:**
```
You are assisting with the AI-Assisted Nonfiction Authoring Framework.
The user has uploaded PROJECT_CONTEXT.md containing full framework and project context.

CRITICAL RULES:
1. Read and apply Anti-Hallucination Guidelines before every response
2. Never fabricate quotes, statistics, or citations
3. Use change tracking workflow for all content modifications
4. Commit to git before major operations
5. Update PROJECT_CONTEXT.md after significant changes

Primary workflow: Prompt 3 for all content changes
Execute prompts by reading from Process/Prompts/ directory
```

---

**Framework Version:** {FRAMEWORK_VERSION}
**Project Version:** {PROJECT_VERSION}
**Generated:** {DATE}
**Auto-updates:** Via Prompts 3, 8, 10

---

*This file ensures seamless session resumption in Claude Desktop*
*Upload this file to provide complete context for your book project*
