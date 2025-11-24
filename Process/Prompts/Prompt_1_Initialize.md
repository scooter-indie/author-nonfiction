# Execute Prompt 1: Initialize Project Structure

**Version:** 0.14.0
**Compatibility:** HYBRID (Desktop Q&A → CLI execution)
**⚡ Performance:** 85-90% faster with batch content generation

**Workflow:**
- **Claude Desktop:** Interactive Q&A creates `.config/init.json` → instructs user to switch to CLI
- **Claude Code CLI:** Reads `.config/init.json` → runs bash script → completes AI tasks

**FIRST ACTION - MANDATORY:**
1. Read `Process/_COMMON/18_Lock_Management_Module.md`
2. Read `Process/Anti-Hallucination_Guidelines.md` in full before proceeding with ANY other actions or questions.

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

Creates a complete nonfiction book project structure:
- Complete directory structure (11 directories)
- Configuration files (JSON-based in `.config/`)
- Table of contents
- Writing style setup
- Git repository
- Initial commit and v1.0.0 tag

**🚀 NEW in v0.14.0:**
- ⚡ **85-90% Faster Initialization** - Batch content generation via `scripts/generate-content.sh`
- 📦 **Single Command** - All 29 files generated in <1 second
- 🎯 **Reduced Operations** - From 35-40 tool calls to 5-8 operations

**Previous updates:**
- v0.12.9: README.md management, Dashboard & Reports organization
- v0.12.7: Template-based USAGE_GUIDE.md, centralized .config/, bash automation
- v0.12.1: Hybrid workflow (Desktop Q&A → CLI execution)

---

## Execution Flow

### Step 0: Lock Management

**Initialize Lock System:**

1. Check if `.locks/` directory exists
   - If not: Create `.locks/` directory using bash: `mkdir -p .locks`
   - **CRITICAL:** Use `mkdir -p` (bash/sh command), NOT Windows CMD syntax (`if not exist`)

2. Check if `.locks/locks.json` exists
   - If not: Create with empty structure:
     ```json
     {
       "locks": []
     }
     ```

**Generate Instance ID:**

Create unique instance identifier for this session:
- Format: `CLI-[5-digit-random]` or `Desktop-[5-digit-random]`
- Example: `CLI-12345`, `Desktop-67890`
- Reuse same ID for all locks in this session

**Acquire Lock: ProjectConfig**

Resources needed for this prompt: `ProjectConfig`

1. Read `.locks/locks.json`

2. Check if `ProjectConfig` is locked:
   - Search `locks` array for entry where `"resource": "ProjectConfig"`

3. **If lock exists:**
   - Calculate age: `current_time - lock.timestamp`

   - **If age < 15 minutes:**
     ```
     ⚠️ ProjectConfig is currently locked by another instance.

     Lock details:
     - Resource: ProjectConfig
     - Locked at: [timestamp] ([X] minutes ago)
     - Instance: [instance]

     Another initialization may be in progress.

     Options:
     1. Wait for lock to clear (checks every 5 seconds)
     2. Cancel operation

     Choose option (1-2):
     ```

   - **If age >= 15 minutes:**
     ```
     ⚠️ ProjectConfig has a stale lock (older than 15 minutes).

     Lock details:
     - Resource: ProjectConfig
     - Locked at: [timestamp] ([X] minutes ago)
     - Instance: [instance]

     This lock may be from a crashed instance.

     Options:
     1. Override stale lock and continue
     2. Cancel operation

     Choose option (1-2):
     ```

4. **If user chooses to wait (Option 1):**
   - Poll every 5 seconds
   - Re-check `.locks/locks.json`
   - If lock cleared: Proceed to acquire
   - If timeout (2 minutes): Ask to cancel or override

5. **If user cancels:**
   - Exit prompt without changes

6. **If no lock OR override approved:**
   - Add lock entry:
     ```json
     {
       "resource": "ProjectConfig",
       "timestamp": "[ISO-8601-timestamp]",
       "instance": "[instance_id]"
     }
     ```
   - Write updated JSON to `.locks/locks.json`
   - Proceed with initialization

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
   - Read `Process/Styles/Style_Catalog.md` to load the catalog
   - Present category-based selection:
     ```
     I've loaded 19 writing styles organized into 5 categories:

     1. Academic & Research (4 styles)
     2. Business & Professional (2 styles)
     3. Narrative & Storytelling (4 styles)
     4. Personal Development & How-To (3 styles)
     5. Cultural & Social Commentary (6 styles)

     Which category best fits your book? (1-5, or 'browse all')
     ```
   - When user selects category, show styles from that category
   - Offer to show example passages from individual style files (optional)
   - Once user selects style, store as: `style`

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
  "frameworkVersion": "0.13.0"
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
  "frameworkVersion": "0.13.0",
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
  "frameworkVersion": "0.13.0",
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

  Claude Code will complete the setup.
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
Nonfiction Framework Initialization Script v0.12.10
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

### Step 4: Generate All Content (CLI ONLY)

**⚡ NEW in v0.14.0: Batch content generation for 85-90% faster initialization**

**Execute the batch content generator:**

```bash
bash scripts/generate-content.sh .config/init.json
```

**This single command generates all content files:**
- Style_Guide.md, Style_Overrides.md
- TOC.md, TOC_chg.md
- Chapter_Quotes.md, Chapter_Quotes_chg.md
- USAGE_GUIDE.md, PROJECT_CONTEXT.md, README.md
- All chapter files (Chapter_XX.md + Chapter_XX_chg.md)

**Expected output:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Batch Content Generator v0.14.0
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Validating preconditions...
✓ Config file found
✓ jq is installed
✓ Valid JSON config
✓ All required fields present
✓ Process/Styles directory found
✓ All preconditions met

Parsing configuration...
✓ Configuration parsed
  • Title: [Your Book Title]
  • Author: [Your Name]
  • Style: [Selected Style]
  • Chapters: [N]

Locating style file...
✓ Style file found: [Category]/[Style].md

Generating content files...

✓ Generated Style_Guide.md
✓ Generated Style_Overrides.md
✓ Generated TOC.md
✓ Generated TOC_chg.md
✓ Generated Chapter_Quotes.md
✓ Generated Chapter_Quotes_chg.md
✓ Generated USAGE_GUIDE.md
✓ Generated PROJECT_CONTEXT.md
✓ Generated README.md
✓ Generated Chapter_01 files
✓ Generated Chapter_02 files
[... all chapters ...]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ Content generation complete
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Generated files:
  • Style_Guide.md, Style_Overrides.md
  • TOC.md, TOC_chg.md
  • Chapter_Quotes.md, Chapter_Quotes_chg.md
  • USAGE_GUIDE.md, PROJECT_CONTEXT.md, README.md
  • [N] chapter files (Chapter_XX.md + Chapter_XX_chg.md)

Total: [N] files created
```

**Then run tool detection:**

```bash
bash scripts/detect-tools.sh .config/manifest.json
```

This detects pandoc/typst and updates `toolsAvailable` in manifest.

<details>
<summary><strong>📖 Reference: What the script generates (click to expand)</strong></summary>

The `generate-content.sh` script creates all these files automatically. This section documents the file formats for reference only.

**Files Generated:**

1. **Manuscript/Style/Style_Guide.md** - Book's writing style with full style definition
2. **Manuscript/Style/Style_Overrides.md** - Style override registry (hierarchical system)
3. **Manuscript/_TOC_/TOC.md** - Table of contents with all chapters
4. **Manuscript/_TOC_/TOC_chg.md** - TOC change tracking file
5. **Manuscript/Quotes/Chapter_Quotes.md** - Chapter epigraph registry
6. **Manuscript/Quotes/Chapter_Quotes_chg.md** - Quotes change tracking
7. **USAGE_GUIDE.md** - Project usage guide with framework instructions
8. **PROJECT_CONTEXT.md** - Project context for Claude Desktop
9. **README.md** - Project README with metadata
10. **Manuscript/Chapters/Chapter_XX/Chapter_XX.md** - Each chapter content file
11. **Manuscript/Chapters/Chapter_XX/Chapter_XX_chg.md** - Each chapter change tracking

All files are generated from templates with variable substitution from `.config/init.json`.

See `scripts/generate-content.sh` source code for complete implementation details.

</details>

### Step 5: Git Commit and Tag (CLI ONLY)

**Commit all files:**

```bash
git add -A
git commit -m "Initialize book project: [title from init.json]

- Created [X]-chapter structure
- Selected writing style: [style name]
- Initialized with framework v0.12.10
- Created on [CONFIRMED_DATE]

🤖 Generated with Claude Code

Co-Authored-By: Claude <noreply@anthropic.com>"
```

**Create initial tag:**

```bash
git tag -a v1.0.0 -m "Initial project structure for [title]

[X] chapters planned
Framework v0.12.10
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
  "frameworkVersion": "0.13.0",
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
Framework: v0.12.10

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

### Step 8: Release Locks

**CRITICAL:** Release locks even if operation fails or errors occur.

**Release ProjectConfig lock:**

1. Read `.locks/locks.json`

2. Remove lock entry:
   - Filter `locks` array to remove where `"resource": "ProjectConfig"` AND `"instance": "[your_instance_id]"`

3. Write updated JSON to `.locks/locks.json`

**Confirmation:**
```
✓ Lock released: ProjectConfig
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

## Lock Management Notes

**Concurrency Support (v0.13.0+):**
- This prompt locks `ProjectConfig` to prevent simultaneous initialization
- Lock is held from Step 0 through Step 8
- Lock is released even if initialization fails
- Stale locks (>15 minutes) can be overridden
- See `Process/_COMMON/18_Lock_Management_Module.md` for complete details

---

**Version:** 0.13.0
**Last Updated:** 2025-11-23

---

## Session Cleanup

**After this prompt completes:**

Tell user: "✓ Prompt 1 Initialize complete.

To free up tokens for your next task, you can say:
**'Clear Prompt 1 Initialize from context'**

This will reclaim tokens for your next operation."
