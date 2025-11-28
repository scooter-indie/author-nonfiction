# Execute Prompt 1: Initialize Project Structure

**Version:** 0.16.0
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

**Multi-Book Support (v0.15.0+):** Automatically detects operating mode and creates books in appropriate location.

---

## Workflow (10 Steps)

1. **Verify Session Context**
2. Lock ProjectConfig
3. Detect environment
4. Interactive Q&A
5. **Disclaimer Acknowledgment (REQUIRED)**
6. Create config files
7. Run initialization script
8. Generate content
9. Git commit and tag
10. Release lock

---

## Step 0: Verify Session Context

**Verify /fw-init has been run:**

The `/fw-init` command sets session context at startup:
- `CONFIG_ROOT` - Current working directory (.config/)
- `FW_ROOT` - Path to framework installation (from fw-location.json)
- `BOOKS_ROOT` - Path to books directory (from settings.json)

**If not set:** Check for `fw-location.json` in current directory
- If exists → Valid CONFIG_ROOT
- If not exists → Error: "Run /fw-init from CONFIG_ROOT first"

**Store context for this prompt:**
- `FW_ROOT` - Framework location
- `BOOKS_ROOT` - Books directory
- `BOOK_PATH` - To be created for new book

---

## Step 1: Lock Management

**Acquire lock:**
1. Generate instance ID: `CLI-[5-digit]` or `Desktop-[5-digit]`
2. Lock `ProjectConfig`

See: Prompt_Essentials.md → Lock Management

---

## Step 2: Environment Detection

**Check for existing book selection:**
- If `ACTIVE_BOOK` set and `[BOOK_PATH]/.config/init.json` exists → Skip to Step 6 (CLI execution)
- If creating new book → Proceed to Step 3 (Q&A)

---

## Step 3: Interactive Q&A

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

## Step 4: Disclaimer Acknowledgment (REQUIRED)

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

## Step 5: Create Config Files

### Multi-Book Mode

**Create book directory and config:**

1. **Convert title to directory name:**
   - "My Amazing Book" → `My-Amazing-Book`
   - Spaces to hyphens, remove special characters
   - Check for conflicts with existing directories

2. **Create book directory structure:**
   ```
   BOOKS_ROOT/[Book-Name]/
   ├── .config/
   ├── Manuscript/
   └── Research/
   ```

3. **Create 4 files in `[Book-Name]/.config/`:**
   - `init.json` - Q&A answers
   - `project.json` - Project settings
   - `metadata.json` - Book metadata
   - `manifest.json` - Framework tracking (includes `frameworkRoot` pointing to FW_ROOT)

4. **Update books-registry.json:**
   ```json
   {
     "id": "my-amazing-book",
     "title": "My Amazing Book",
     "author": "Author Name",
     "directory": "My-Amazing-Book",
     "created": "[CONFIRMED_DATE]",
     "lastAccessed": "[CONFIRMED_DATE]",
     "status": "in-progress"
   }
   ```

5. **Set as active book:** Update `activeBook` in registry

---

## Step 6: Desktop Handoff

**If in Claude Desktop:**
```
✓ Configuration files created in .config/

To complete initialization:
1. Open Claude Code CLI
2. Say: "execute Prompt 1"
```
**STOP HERE** - Do not proceed to Step 7

**If in CLI:** Continue to Step 7

---

## Step 7: Run Init Script (CLI)

```bash
bash [FW_ROOT]/scripts/init.sh [BOOK_PATH]/.config/init.json [FW_ROOT]
```

**Parameters:**
- `[BOOK_PATH]/.config/init.json` - Config file location
- `[FW_ROOT]` - Framework root (for reading templates)

**Script creates:**
- 10-directory Manuscript structure
- 5 template files

---

## Step 8: Generate Content (CLI)

```bash
bash [FW_ROOT]/scripts/generate-content.sh [BOOK_PATH]/.config/init.json [FW_ROOT]
bash [FW_ROOT]/scripts/detect-tools.sh [BOOK_PATH]/.config/manifest.json
```

**Generates:**
- Style_Guide.md, Style_Overrides.md
- TOC.md, TOC_chg.md
- Chapter_Quotes.md
- USAGE_GUIDE.md, PROJECT_CONTEXT.md, README.md
- All chapter files (Chapter_XX.md + _chg.md)

---

## Step 9: Git Commit, Tag & Push (CLI)

**Note:** Git operations happen at PROJECT_ROOT level (parent of .config/, BOOKS_ROOT/, FW_ROOT/).

```bash
cd [CONFIG_ROOT]/..
git add BOOKS_ROOT/[Book-Name]/
git commit -m "Initialize book: [title]

- Created [X]-chapter structure
- Selected style: [style name]
- Disclaimer acknowledged (v1.0)
- Framework v0.15.0

🤖 Generated with Claude Code

Co-Authored-By: Claude <noreply@anthropic.com>"
```

**Tag convention:** `[book-id]-v1.0.0` (e.g., `my-amazing-book-v1.0.0`)

```bash
git tag -a [book-id]-v1.0.0 -m "Initial project structure for [title]"
```

**Push to remote (if configured):**
```bash
# Check if remote exists and push
if git remote get-url origin &>/dev/null; then
    git push -u origin main --tags
fi
```

**Mark complete:**
Update `.config/project.json`: `initialized: true`

---

## Step 10: Completion Report

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ Book initialized successfully!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Book: [title]
Author: [author]
Location: [BOOKS_ROOT]/[Book-Name]/
Chapters: [X]
Style: [style name]
Framework: v0.15.0 (at [FW_ROOT])

Registry updated:
  • Book added to books-registry.json
  • Set as active book

Next steps:
  1. Execute Prompt 2 to add your first chapter
  2. Execute Prompt 10 to see your dashboard
  3. Read USAGE_GUIDE.md for complete guide
  4. Say "switch to [Book Name]" to change books

Git status:
  • Initial commit created
  • Tagged as [book-id]-v1.0.0
  • [If remote configured: Pushed to origin]
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

**Book Directory (`[BOOKS_ROOT]/[Book-Name]/`):**
- `.config/` - init.json, project.json, metadata.json, manifest.json
- `Manuscript/` - Chapters/, FrontMatter/, BackMatter/, Style/, _TOC_/, Quotes/, images/, Inbox/, Drafts/, Exports/
- `Research/`
- PROJECT_CONTEXT.md, README.md, USAGE_GUIDE.md

**Registry Updated:**
- `books-registry.json` (in CONFIG_ROOT) - New book entry added

**Note:** Framework files remain at FW_ROOT (not copied to book directory)

---

📖 **For detailed Q&A and config formats:** See `Process/Prompts/Prompt_1_Reference.md`

📖 **For style catalog:** See `Process/Styles/Style_Catalog.md`

---

**Version:** 0.16.0
**Last Updated:** 2025-11-28
**Token Efficiency:** 70% reduction

---

## Session Cleanup

Tell user: "✓ Prompt 1 Initialize complete.

**IMPORTANT:** Run `/fw-init` now to load your new project context.

To free up tokens, say: **'Clear Prompt 1 from context'**"
