# Execute Prompt 1: Initialize Project Structure

**Version:** 0.12.1
**Compatibility:** HYBRID (Desktop Q&A → CLI execution)

**Workflow:**
- **Claude Desktop:** Interactive Q&A creates `.config/init.json` → instructs user to switch to CLI
- **Claude Code CLI:** Reads `.config/init.json` → runs bash script → completes AI tasks

**FIRST ACTION - MANDATORY:**
Use the Read tool to read `Process/Anti-Hallucination_Guidelines.md` in full before proceeding with ANY other actions or questions.

**CRITICAL ENFORCEMENT:**
- **RULE 1:** All file modifications MUST update corresponding _chg files
- **RULE 2:** All Manuscript/ changes must go through appropriate prompts

See: `Process/ENFORCEMENT_RULES.md` for complete details

**DATE CONFIRMATION REQUIRED:**
- **USE CONFIRMED_DATE from session startup** (see CLAUDE.md Date Confirmation Protocol)
- **NEVER use raw `<env>` date** without confirmation
- Pass confirmed date to any spawned agents: "Today's confirmed date is [CONFIRMED_DATE]. Use this date for all operations."

---

## What This Does

Creates a complete nonfiction book project structure in ~5-10 seconds:
- Complete directory structure (11 directories)
- Configuration files (JSON-based in `.config/`)
- Table of contents
- Writing style setup
- Git repository
- Initial commit and v1.0.0 tag

**New in v0.12.1:**
- ⚡ **10x faster** (~5-10 seconds vs ~30-60 seconds)
- 📁 **Centralized config** - All JSON configs in `.config/` directory
- 🔧 **Bash script automation** - Structure creation via `scripts/init.sh`
- 🎨 **Hybrid workflow** - Q&A in Desktop, execution in CLI

---

## Execution Flow

### Step 1: Environment Detection

**Check if `.config/init.json` exists:**

- **YES (CLI execution mode):**
  - Skip to Step 3 (run bash script)
  - User has already completed Q&A in Desktop

- **NO (Q&A mode):**
  - Proceed to Step 2
  - Collect metadata interactively

### Step 2: Interactive Q&A (Desktop or CLI)

**Ask the following questions one at a time:**

1. **What is the working title of your book?**
   - Store as: `title`

2. **What is your name (author)?**
   - Store as: `author`

3. **What is the target total word count?**
   - Store as: `targetWordCount`

4. **Who is the target audience?**
   - Store as: `targetAudience`

5. **What is the book's purpose or main thesis?**
   - Store as: `purpose`

6. **What is your target completion date?**
   - Store as: `targetCompletionDate`

7. **Do you have an existing TOC file?**
   - If YES: Ask for path, read file, parse chapters
   - If NO: Continue to question 8
   - Store path as: `tocFilePath` (or empty if no file)

8. **If no TOC file: How many chapters and what are their topics/titles?**
   - Store count
   - Ask for chapter titles (list)
   - Store as: `chapters` array with `{number, title}`

9. **Writing style selection:**
   - Present 9 options from `Process/Style_Examples.md`:
     1. Academic Authority
     2. Conversational Expert
     3. Narrative Storyteller
     4. Business Professional
     5. Technical Precision
     6. Investigative Journalist
     7. Practical Guide
     8. Inspirational Teacher
     9. Scientific Communicator
   - Store as: `style`

### Step 2b: Create .config directory and all JSON files

**Create `.config/` directory if it doesn't exist**

**Write all 5 configuration files:**

**1. `.config/init.json` (user answers from Q&A):**

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "description": "Initialization configuration from Prompt 1 Q&A session",
  "title": "[user's answer]",
  "author": "[user's answer]",
  "targetWordCount": "[user's answer]",
  "targetAudience": "[user's answer]",
  "purpose": "[user's answer]",
  "targetCompletionDate": "[user's answer]",
  "tocFilePath": "[path to TOC file or empty]",
  "chapters": [
    {"number": 1, "title": "[chapter 1 title]"},
    {"number": 2, "title": "[chapter 2 title]"}
  ],
  "style": "[selected style name]",
  "createdDate": "[CONFIRMED_DATE in YYYY-MM-DD format]",
  "frameworkVersion": "0.12.1"
}
```

**2. `.config/project.json` (project settings):**

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "description": "Project configuration and settings (replaces Project_Config.md)",
  "initialized": false,
  "settings": {
    "prompt_9_verbose": true
  },
  "frameworkVersion": "0.12.1",
  "createdDate": "[CONFIRMED_DATE]",
  "lastModified": "[CONFIRMED_DATE]"
}
```

**3. `.config/metadata.json` (book metadata populated from init.json):**

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "description": "Project metadata (replaces Project_Metadata.md)",
  "book": {
    "title": "[from init.json]",
    "subtitle": "",
    "author": "[from init.json]",
    "publisher": "",
    "isbn": "",
    "targetAudience": "[from init.json]",
    "genre": "",
    "description": "[purpose from init.json]",
    "keywords": []
  },
  "version": {
    "current": "1.0.0",
    "history": []
  },
  "dates": {
    "started": "[CONFIRMED_DATE]",
    "firstDraft": "",
    "published": "",
    "targetCompletion": "[targetCompletionDate from init.json]"
  },
  "stats": {
    "totalChapters": [chapter count from init.json],
    "totalWords": 0,
    "targetWordCount": "[targetWordCount from init.json]",
    "completionPercentage": 0
  }
}
```

**4. `.config/manifest.json` (framework tracking):**

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "description": "Framework installation manifest",
  "frameworkVersion": "0.12.1",
  "installedDate": "[CONFIRMED_DATE]",
  "lastUpdated": "[CONFIRMED_DATE]",
  "installationMethod": "Prompt 1",
  "configureCompleted": false,
  "toolsAvailable": {
    "git": true,
    "pandoc": false,
    "typst": false
  }
}
```

**5. `.config/migrations.json` (copy from template):**

Copy `Process/Templates/.config/migrations.json` to `.config/migrations.json`

### Step 2c: Environment-Specific Next Steps

**If in Claude Desktop:**
- Display message:
  ```
  ✓ Configuration files created in .config/

  To complete initialization:
  1. Open Claude Code CLI in your project directory
  2. Say: "execute Prompt 1"

  Claude Code will complete the setup in ~5-10 seconds.
  ```
- **STOP HERE** - Do not proceed to Step 3

**If in Claude Code CLI:**
- Proceed immediately to Step 3

### Step 3: Run Bash Script (CLI ONLY)

**Execute the initialization script:**

```bash
bash scripts/init.sh .config/init.json
```

**The script will:**
1. Validate preconditions (config exists, git installed, templates present)
2. Create 10-directory Manuscript structure
3. Copy 5 template files (visual assets, EPUB templates, .gitignore)
4. Initialize git repository
5. Display verbose progress

**Expected output:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Nonfiction Framework Initialization Script v0.12.1
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Validating preconditions...
✓ Config file found
✓ Valid JSON config
✓ Git is installed
✓ Process/Templates directory found
✓ All required templates found
✓ All preconditions met

Creating directory structure...
✓ Created: Manuscript/Chapters
✓ Created: Manuscript/FrontMatter
...

Copying templates...
✓ Copied: Manuscript/images/Image_Registry.md
✓ Copied: Manuscript/FrontMatter/Copyright.md
...

Initializing git repository...
✓ Git repository initialized

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ Initialization script completed successfully
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Note:** The `.config/` directory and all JSON files were already created in Step 2b.

### Step 4: AI-Generated Content (CLI ONLY)

**Now complete the AI-required tasks:**

**4a. Run tool detection script:**

Run tool detection to update manifest with available export tools:
```bash
bash scripts/detect-tools.sh .config/manifest.json
```

This will detect pandoc/typst and update `toolsAvailable` automatically.

**4b. Generate Style_Guide.md**

Read the selected style from `Process/Style_Examples.md` and create:

**`Manuscript/Style/Style_Guide.md`:**

```markdown
# Writing Style Guide

**Book:** [title from init.json]
**Style:** [style name from init.json]
**Last Updated:** [CONFIRMED_DATE]

---

## Selected Style: [Style Name]

[Full style definition from Process/Style_Examples.md]

---

## Style Application

This style is your **book-level default**. All chapters and sections inherit this style unless explicitly overridden.

**Hierarchical Style System:**
- **Book level** (this file): Default for entire book
- **Chapter level** (optional): Override for specific chapters
- **Section level** (optional): Override for specific sections

See `Manuscript/Style/Style_Overrides.md` for override registry.

---

*This style guide ensures consistent voice throughout your book*
```

**4c. Generate Style_Overrides.md**

Copy from `Process/Templates/Style_Overrides_Template.md` and customize:

**`Manuscript/Style/Style_Overrides.md`:**

Include book-level style at top, empty override sections.

**4d. Generate TOC.md and TOC_chg.md**

**`Manuscript/_TOC_/TOC.md`:**

```markdown
# Table of Contents

**Book:** [title from init.json]
**Author:** [author from init.json]
**Last Updated:** [CONFIRMED_DATE]

⚠️ **WARNING:** This file is managed by Prompts 1 and 2. Direct edits may be overwritten. Use Prompt 2 to add/reorder chapters.

---

[For each chapter in init.json chapters array:]
## Chapter [number]: [title]

**Status:** Not Started
**Word Count:** 0
**Last Modified:** N/A

---
```

**`Manuscript/_TOC_/TOC_chg.md`:**

```markdown
# TOC Change Tracking

**Version:** 1.0.0
**Last Updated:** [CONFIRMED_DATE]

---

## Instructions for Next Revision

[Leave empty - ready for user to add TOC modification instructions]

---

## Version History

### v1.0.0 - [CONFIRMED_DATE]
- Initial TOC created with [X] chapters
- Chapters: [list chapter titles]
```

**4e. Generate Chapter_Quotes.md and Chapter_Quotes_chg.md**

**`Manuscript/Quotes/Chapter_Quotes.md`:**

```markdown
# Chapter Quotes (Epigraphs)

**Book:** [title from init.json]
**Last Updated:** [CONFIRMED_DATE]

**Status Legend:**
- ⏳ **Pending** - Quote selected, needs verification
- ⚠ **Needs Citation** - Verified but incomplete citation
- ✓ **Verified** - Fully verified with proper attribution

---

[For each chapter:]
## Chapter [number]: [title]

**Status:** ⏳ Pending
**Quote:** [Leave empty]
**Attribution:** [Leave empty]
**Source:** [Leave empty]

---
```

**`Manuscript/Quotes/Chapter_Quotes_chg.md`:**

```markdown
# Chapter Quotes Change Tracking

**Version:** 1.0.0
**Last Updated:** [CONFIRMED_DATE]

---

## Instructions for Next Revision

[Leave empty]

---

## Version History

### v1.0.0 - [CONFIRMED_DATE]
- Initial quotes file created
- [X] chapter quote placeholders created
```

**4f. Generate USAGE_GUIDE.md**

**`USAGE_GUIDE.md`** (project root):

```markdown
# Quick Start Guide

**Book:** [title from init.json]
**Author:** [author from init.json]
**Framework Version:** 0.12.1
**Initialized:** [CONFIRMED_DATE]

---

## Your Book Project is Ready!

This project has been initialized with:
- ✓ [X] chapter structure
- ✓ Writing style: [style name]
- ✓ Git repository (v1.0.0)
- ✓ Configuration files
- ✓ Change tracking system

---

## Next Steps

### 1. Create Your First Chapter

```
Execute Prompt 2 to add Chapter 1
```

Prompt 2 will create the chapter directory and files.

### 2. Start Writing

Use **Prompt 3** (automated) or **Prompt 4** (interactive) to write content:

**Prompt 3:** Write instructions in `_chg` files, execute Prompt 3
**Prompt 4:** Discuss changes interactively, AI writes instructions

### 3. Track Progress

```
Execute Prompt 10 for dashboard
```

Shows word counts, completion %, next steps.

### 4. Check Consistency

```
Execute Prompt 8
```

Validates terminology, style, cross-references.

---

## 16 Framework Prompts

**Core Writing:**
1. Initialize - ✓ COMPLETED
2. Add Chapter
3. Change by Chg (automated workflow)
4. Interactive Change (conversational workflow)
5. Scan For User Edits
6. Integrate Inbox

**Production:**
7. Compile Manuscript
8. Consistency Checker
9. Export (DOCX/PDF/EPUB)
10. Progress Dashboard

**Advanced:**
11. Style Manager
12. Git Operations
13. AI Detection Analysis
14. Citation Finder
15. Visual Content Suggester
16. Image Manager

---

## Configuration Files

All config files are in `.config/` directory:
- `init.json` - Initialization metadata
- `project.json` - Project settings
- `metadata.json` - Book metadata
- `manifest.json` - Framework tracking
- `migrations.json` - Version migrations

---

## Resources

- **Full Documentation:** `Process/AI-Assisted_Nonfiction_Authoring_Process.md`
- **Quick Reference:** `Process/Prompts/QUICK_REFERENCE.md`
- **Prompt Guide:** `Process/Prompts/README.md`
- **Anti-Hallucination Rules:** `Process/Anti-Hallucination_Guidelines.md`

---

**Happy writing!**
```

**4g. Generate PROJECT_CONTEXT.md**

Use template from `Process/Templates/PROJECT_CONTEXT_template.md`, fill in metadata from init.json.

### Step 5: Git Commit and Tag (CLI ONLY)

**Commit all files:**

```bash
git add -A
git commit -m "Initialize book project: [title from init.json]

- Created [X]-chapter structure
- Selected writing style: [style name]
- Initialized with framework v0.12.1
- Created on [CONFIRMED_DATE]

🤖 Generated with Claude Code

Co-Authored-By: Claude <noreply@anthropic.com>"
```

**Create initial tag:**

```bash
git tag -a v1.0.0 -m "Initial project structure for [title]

[X] chapters planned
Framework v0.12.1
Initialized [CONFIRMED_DATE]"
```

### Step 6: Mark Initialization Complete (CLI ONLY)

**Update `.config/project.json`:**

Set `initialized: true` and update `lastModified`:

```json
{
  "initialized": true,
  "settings": {
    "prompt_9_verbose": true
  },
  "frameworkVersion": "0.12.1",
  "createdDate": "[original date]",
  "lastModified": "[CONFIRMED_DATE]"
}
```

### Step 7: Final Commit (CLI ONLY)

```bash
git add .config/project.json
git commit -m "Mark initialization complete

🤖 Generated with Claude Code

Co-Authored-By: Claude <noreply@anthropic.com>"
```

### Step 8: Display Completion Report

**Show success message:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ Project initialized successfully!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Book: [title]
Author: [author]
Chapters: [X]
Style: [style name]
Framework: v0.12.1

Time elapsed: ~5-10 seconds

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Next steps:
  1. Execute Prompt 2 to add your first chapter
  2. Execute Prompt 10 to see your dashboard
  3. Read USAGE_GUIDE.md for complete guide

Git status:
  • Initial commit created
  • Tagged as v1.0.0
  • [X] files tracked
```

---

## Re-Initialization (Smart Merge)

**If `.config/project.json` exists with `initialized: true`:**

The bash script will:
- ✓ Preserve all user content (Manuscript/Chapters/, Drafts/, etc.)
- ✓ Update framework files (.config/, templates)
- ✓ Skip git init if .git exists
- ⚠ Warn that project is already initialized

**Claude will ask:**
```
This project is already initialized.

Options:
1. Update framework files only (preserves all content)
2. Full re-initialization (DESTRUCTIVE - will reset config)
3. Cancel

Which option?
```

**Option 1:** Run script, update configs, preserve content
**Option 2:** Delete .config/, run full initialization
**Option 3:** Exit without changes

---

## Anti-Hallucination Note

**When generating any content during initialization:**
- Follow the verification protocol detailed in Prompt 3's Anti-Hallucination Verification section
- **ASK the user** before creating examples or claiming their experiences
- **Use clear labels**: REAL (user-confirmed) vs HYPOTHETICAL vs GENERIC
- **Never fabricate** specific people, statistics, or quotes

**Specific to Prompt 1:**
- DO NOT generate sample chapter content
- DO NOT create example quotes/epigraphs
- DO NOT fabricate book descriptions or marketing copy
- ONLY use data explicitly provided by user in Q&A

---

## Troubleshooting

### "Config file not found"
- Ensure you completed Step 2 (Q&A) before running in CLI
- Check that `.config/init.json` exists

### "Git not installed"
- Install git: https://git-scm.com/
- Restart terminal after installation

### "Templates not found"
- Ensure you're in the project root directory
- Verify `Process/Templates/` directory exists
- Re-extract framework if templates are missing

### "Already initialized" warning
- See "Re-Initialization (Smart Merge)" section above
- Choose option based on your needs

---

## Files Created

**Configuration (`.config/`):**
- init.json
- project.json
- metadata.json
- manifest.json
- migrations.json (copied from framework)

**Manuscript Structure:**
- Manuscript/Chapters/ (empty)
- Manuscript/FrontMatter/Copyright.md
- Manuscript/BackMatter/About_Author.md
- Manuscript/BackMatter/Bibliography/ (empty)
- Manuscript/Quotes/Chapter_Quotes.md
- Manuscript/Quotes/Chapter_Quotes_chg.md
- Manuscript/Style/Style_Guide.md
- Manuscript/Style/Style_Overrides.md
- Manuscript/Style/epub-style.css
- Manuscript/_TOC_/TOC.md
- Manuscript/_TOC_/TOC_chg.md
- Manuscript/Inbox/ (empty)
- Manuscript/Drafts/ (empty)
- Manuscript/Exports/ (empty)
- Manuscript/images/ (empty except Image_Registry.md)
- Manuscript/images/Image_Registry.md

**Root Files:**
- USAGE_GUIDE.md
- PROJECT_CONTEXT.md
- .gitignore

**Total:** ~20 files, 11 directories

---

**Version:** 0.12.1
**Last Updated:** 2025-11-21
**Execution Time:** ~5-10 seconds (v0.12.1) vs ~30-60 seconds (v0.12.1)
