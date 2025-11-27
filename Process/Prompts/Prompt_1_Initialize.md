# Execute Prompt 1: Initialize Project Structure

**Version:** 0.14.4
**⚡ Token Efficient:** ~5,500 tokens (70% reduction from v0.14.0)
**HYBRID:** Desktop Q&A → CLI execution

**FIRST ACTION - MANDATORY:**
Reference `Process/Prompts/Prompt_Essentials.md` (loaded once per session via /fw-init)

---

## Quick Start

Creates complete nonfiction book project:
- Directory structure (11 directories)
- Configuration files (JSON in `.config/`)
- Style setup, TOC, initial chapters
- Git repository with v1.0.0 tag

**Performance:** 85-90% faster with batch content generation

---

## Workflow (9 Steps)

1. Lock ProjectConfig
2. Detect environment
3. Interactive Q&A
4. **Disclaimer Acknowledgment (REQUIRED)**
5. Create config files
6. Run initialization script
7. Generate content
8. Git commit and tag
9. Release lock

---

## Step 0: Lock Management

**Acquire lock:**
1. Generate instance ID: `CLI-[5-digit]` or `Desktop-[5-digit]`
2. Lock `ProjectConfig`

See: Prompt_Essentials.md → Lock Management

---

## Step 1: Environment Detection

**Check `.config/init.json`:**
- **Exists:** Skip to Step 5 (CLI execution)
- **Not exists:** Proceed to Step 2 (Q&A)

---

## Step 2: Interactive Q&A

**Ask one at a time:**

1. **Working title?**
2. **Author name?**
3. **Target word count?**
4. **Target audience?**
5. **Book purpose/thesis?**
6. **Target completion date?** (YYYY-MM-DD format)
   - **VALIDATE:** Date must be in the future (after CONFIRMED_DATE)
   - If date is in the past or today, ask again: "That date is in the past. Please provide a future date."
7. **Existing TOC file?** (path or no)
8. **If no TOC:** Number and titles of chapters?
9. **Writing style?** Present in TWO steps:

   **Step A - Show categories:**
   ```
   5 style categories available:
   1. Academic & Research (4 styles)
   2. Business & Professional (2 styles)
   3. Narrative & Storytelling (4 styles)
   4. Personal Development (3 styles)
   5. Cultural & Social Commentary (6 styles)

   Which category? (1-5, or "all" to see everything)
   ```

   **Step B - Show styles in selected category** (or all if requested)

---

## Step 3: Disclaimer Acknowledgment (REQUIRED)

**STOP and display the following:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️  DISCLAIMER ACKNOWLEDGMENT REQUIRED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Before creating your book project, you must acknowledge
the framework disclaimer.
```

**Then read and display the full contents of `Process/DISCLAIMER.md`**

**After displaying disclaimer, ask:**

```
To proceed, type exactly: I acknowledge the disclaimer
```

**If user does NOT acknowledge:**
- Do NOT proceed with project creation
- Remind user that acknowledgment is required
- Wait for acknowledgment or user cancellation

**If user acknowledges:**
- Record in `.config/init.json`:
  ```json
  {
    "disclaimer_acknowledged": true,
    "disclaimer_version": "1.0",
    "acknowledged_date": "[CONFIRMED_DATE]"
  }
  ```
- Proceed to Step 4 (Create Config Files)

---

## Step 4: Create Config Files

**Prerequisite:** `.config/manifest.json` must exist (created by configure.md).
If it doesn't exist, tell user: "Please run configure.md first to set up the framework."

**Create 4 files in `.config/`:**

**1. `.config/init.json`** - Q&A answers
**2. `.config/project.json`** - Project settings
**3. `.config/metadata.json`** - Book metadata
**4. `.config/migrations.json`** - Copy from template

**Note:** manifest.json already exists from configure.md - do not overwrite it.

---

## Step 5: Desktop Handoff

**If in Claude Desktop:**
```
✓ Configuration files created in .config/

To complete initialization:
1. Open Claude Code CLI
2. Say: "execute Prompt 1"
```
**STOP HERE** - Do not proceed to Step 6

**If in CLI:** Continue to Step 6

---

## Step 6: Run Init Script (CLI)

```bash
bash scripts/init.sh .config/init.json
```

**Script creates:**
- 10-directory Manuscript structure
- 5 template files
- Git repository initialization

---

## Step 7: Generate Content (CLI)

```bash
bash scripts/generate-content.sh .config/init.json
bash scripts/detect-tools.sh .config/manifest.json
```

**Generates:**
- Style_Guide.md, Style_Overrides.md
- TOC.md, TOC_chg.md
- Chapter_Quotes.md
- USAGE_GUIDE.md, PROJECT_CONTEXT.md, README.md
- All chapter files (Chapter_XX.md + _chg.md)

---

## Step 8: Git Commit & Tag (CLI)

```bash
git add -A
git commit -m "Initialize book project: [title]

- Created [X]-chapter structure
- Selected style: [style name]
- Disclaimer acknowledged (v1.0)
- Framework v0.14.4

🤖 Generated with Claude Code

Co-Authored-By: Claude <noreply@anthropic.com>"

git tag -a v1.0.0 -m "Initial project structure"
```

**Mark complete:**
Update `.config/project.json`: `initialized: true`

---

## Step 9: Completion Report

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ Project initialized successfully!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Book: [title]
Author: [author]
Chapters: [X]
Style: [style name]
Framework: v0.14.4

Next steps:
  1. Execute Prompt 2 to add your first chapter
  2. Execute Prompt 10 to see your dashboard
  3. Read USAGE_GUIDE.md for complete guide

Git status:
  • Initial commit created
  • Tagged as v1.0.0
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Release `ProjectConfig` lock.

---

## Re-Initialization

**If `initialized: true` in project.json:**

```
This project is already initialized.

Options:
1. Update framework files only (preserves content)
2. Full re-initialization (DESTRUCTIVE)
3. Cancel
```

---

## Files Created

**Configuration (`.config/`):**
- init.json, project.json, metadata.json, migrations.json
- (manifest.json already exists from configure.md)

**Manuscript Structure:**
- Chapters/, FrontMatter/, BackMatter/, Style/
- _TOC_/, Quotes/, images/, Inbox/, Drafts/, Exports/

**Root Files:**
- USAGE_GUIDE.md, PROJECT_CONTEXT.md, README.md, .gitignore

**Total:** ~20 files, 11 directories

---

📖 **For detailed Q&A and config formats:** See `Process/Prompts/Prompt_1_Reference.md`

📖 **For style catalog:** See `Process/Styles/Style_Catalog.md`

---

**Version:** 0.14.4
**Last Updated:** 2025-11-24
**Token Efficiency:** 70% reduction

---

## Session Cleanup

Tell user: "✓ Prompt 1 Initialize complete.

**IMPORTANT:** Run `/fw-init` now to load your new project context.

To free up tokens, say: **'Clear Prompt 1 from context'**"
