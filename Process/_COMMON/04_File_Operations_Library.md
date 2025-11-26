# File Operations Library

**Framework Version:** 0.10.0
**Module:** Standardized File Operations
**Purpose:** Common file operation protocols used across prompts

---

## Overview

This module defines standardized protocols for file operations that are used across multiple prompts. All file operations that modify Manuscript/ files MUST include corresponding _chg file updates (Enforcement Rule 1).

---

## Core Operations

### 1. Read _chg File Protocol

**Purpose:** Extract instructions from change tracking file

**Used by:** Prompts 2, 3, 4, 10

**Procedure:**
1. Verify _chg file exists at `{content_file_path}_chg.md`
2. Read file contents
3. Locate `[INSTRUCTIONS FOR THIS REVISION]` section
4. Extract all content between section header and next section
5. Validate non-empty
6. Return instructions for processing

**Error handling:**
- If _chg file missing → Error: "Change tracking file not found. Run Prompt 10 to create it."
- If instructions section empty → Prompt user: "No instructions found. Would you like to add them now?"
- If instructions section missing → Error: "Invalid _chg file format. Missing [INSTRUCTIONS FOR THIS REVISION] section."

**Example:**
```markdown
## REWRITE INSTRUCTIONS

### [INSTRUCTIONS FOR THIS REVISION]

Add new section on data validation after "Data Collection" section.

Include:
- Validation criteria
- Quality checks
- Error handling

Priority: High
```

---

### 2. Write Modified Content Protocol

**Purpose:** Apply modifications to content file with validation

**Used by:** Prompts 1, 2, 3, 4

**Procedure:**
1. Validate target file exists (or creating new file is intentional)
2. Prepare modifications
3. Apply modifications to content
4. **CRITICAL: Update corresponding _chg file (see Update _chg File Protocol)**
5. Update file metadata (word count, last modified date)
6. Write file to disk
7. Validate write success

**Error handling:**
- If file doesn't exist and not creating → Error: "Target file not found: {path}"
- If write fails → Error: "Failed to write file: {error}"
- If _chg update fails → Error: "Failed to update change tracking file" + rollback

**Atomic operation:**
- If _chg update fails, rollback content file modification
- Both files must update successfully or neither updates

---

### 3. Update _chg File Protocol

**Purpose:** Document changes in change tracking file (ENFORCEMENT RULE 1)

**Used by:** Prompts 1, 2, 3, 4, 10

**Procedure:**
1. Read current _chg file
2. Generate version entry:
   ```markdown
   ### Version {N.M.P} - {YYYY-MM-DD} - {Brief Description}

   **Type:** {Change Type}
   **Scope:** {Affected sections}
   **Priority:** {Low | Medium | High}
   **Rationale:** {Why this change was made}

   **Changes Made:**
   - {List of modifications}
   - {What was added/removed/changed}
   - {Impact on content}
   ```
3. Append to `## VERSION HISTORY` section
4. Increment version number in metadata
5. Write updated _chg file

**Version increment logic:** (see `08_Semantic_Versioning_Guide.md`)
- Major (N.0.0): Structural changes, reorganization
- Minor (0.M.0): Content additions/deletions
- Patch (0.0.P): Refinements, typo fixes

**Change types:**
- Content Addition
- Content Deletion
- Structural Change
- Refinement
- Content Update

**Error handling:**
- If version history section missing → Create it
- If version parsing fails → Default to 1.0.0
- If write fails → Propagate error to caller

---

### 4. Auto-Archive Instructions Protocol

**Purpose:** Move completed instructions to version history

**Used by:** Prompt 3 (primary), Prompt 10

**Procedure:**
1. Read _chg file
2. Extract content from `[INSTRUCTIONS FOR THIS REVISION]` section
3. Create version entry with instructions preserved:
   ```markdown
   ### Version {N.M.P} - {YYYY-MM-DD} - {Brief Description}

   **Type:** {Change Type}
   **Scope:** {Affected sections}
   **Priority:** {Priority from instructions}
   **Rationale:** {Rationale from instructions}

   **Instructions Given:**
   {Original instructions from user}

   **Changes Made:**
   - {List of actual modifications performed}
   ```
4. Append entry to `## VERSION HISTORY` section
5. Clear `[INSTRUCTIONS FOR THIS REVISION]` section
6. Add placeholder text: `[Ready for next revision - add instructions above]`
7. Write updated _chg file

**Result:** Clean separation between active instructions and historical changes

---

### 5. Update TOC Protocol

**Purpose:** Modify table of contents with proper tracking

**Used by:** Prompts 1, 2, 4

**Procedure:**
1. Read `Manuscript/_TOC_/TOC.md`
2. Apply modifications (add/remove/reorder entries)
3. **Update `Manuscript/_TOC_/TOC_chg.md`** (AI-managed, user should not edit)
4. Validate chapter numbering consistency
5. Write updated TOC.md
6. Write updated TOC_chg.md

**TOC entry format:**
```markdown
## Chapter {XX}: {Title}

**Status:** {Draft | Review | Revised | Final}
**Target Word Count:** {X} words
**Current Word Count:** {Y} words ({Z}%)
**Estimated Completion:** {Date}

Brief description of chapter content and objectives.
```

**TOC_chg.md update:**
```markdown
### Version {N.M.P} - {YYYY-MM-DD} - TOC Update: {Description}

**Type:** Structural Change
**Scope:** Table of Contents
**Priority:** High
**Rationale:** {Why TOC was updated}

**Changes Made:**
- {What was added/removed/reordered}
```

**Important:** TOC_chg.md is AI-managed only. Users should NOT edit this file manually.

---

### 6. Update Cross-References Protocol

**Purpose:** Update references when content is moved/renamed

**Used by:** Prompts 2, 4

**Procedure:**
1. Identify what changed (chapter numbers, file paths, section names)
2. Build search/replace map:
   - Old: `Chapter_03` → New: `Chapter_04`
   - Old: `see Chapter 3` → New: `see Chapter 4`
   - Old: `Section 3.2` → New: `Section 4.2`
3. Scan all content files for references:
   - All chapters
   - Front matter
   - Back matter
   - TOC
4. Apply updates to affected files
5. **Update _chg files for all modified files**
6. Validate all links resolve
7. Report changes made

**Reference patterns to check:**
- `Chapter_XX` (directory references)
- `Chapter XX:` (prose references)
- `see Chapter X` (cross-references)
- `Section X.Y` (section references)
- `figures/chapterXX_` (image references)

**Validation:**
- After updates, scan for broken references
- Report any unresolved links
- Suggest fixes for ambiguous cases

---

### 7. Update Quote Entry Protocol

**Purpose:** Add/modify chapter epigraph entries

**Used by:** Prompts 2, 3

**Procedure:**
1. Read `Manuscript/Quotes/Chapter_Quotes.md`
2. Locate entry for chapter (or create new entry)
3. Apply modifications
4. **Update `Manuscript/Quotes/Chapter_Quotes_chg.md`**
5. Validate quote format (see `07_Quote_Management_System.md`)
6. Write updated files

**Entry format:**
```markdown
## Chapter {XX}: {Chapter Title}

**Quote:** "{Quote text}"
**Author:** {Author name}
**Source:** {Book/article title}
**Year:** {YYYY}
**Page:** {Page number or N/A}
**Bibliography:** {Full citation}
**Status:** {⏳ Pending | ⚠ Needs Citation | ✓ Verified}
```

**_chg update:**
```markdown
### Version {N.M.P} - {YYYY-MM-DD} - Quote added/updated for Chapter {XX}

**Type:** Content Addition/Update
**Scope:** Chapter {XX} epigraph
**Priority:** Medium
**Rationale:** {Why quote was added/changed}

**Changes Made:**
- Added/Updated quote for Chapter {XX}
- Status: {Status}
```

---

### 8. Create Git Commit Protocol

**Purpose:** Create properly formatted git commits with both files

**Used by:** Prompts 1, 2, 3, 4, 8, 10

**Procedure:**
1. Stage specified files: `git add {files}`
2. **CRITICAL: Verify both content and _chg files are staged** (if modifying Manuscript/)
3. Format commit message:
   ```
   {Brief description}

   {Details section}

   {Version info (if applicable)}

   Co-Authored-By: Claude <noreply@anthropic.com>
   ```
4. Execute commit: `git commit -m "{message}"`
5. Verify success
6. Report commit hash and files included

**Validation before commit:**
```markdown
Verify both files are staged:
- Content file: {content_file_path}
- Change tracking: {content_file_path}_chg.md

✅ Both files ready for commit
```

**For Claude Desktop:**
Provide command in copy/paste format:
```
Go to Claude Code CLI and say:
```
Run: git add {files} && git commit -m "{message}"
```
```

**Commit message templates:**

**For new chapter:**
```
Add Chapter {XX}: {Title}

- Created chapter structure
- Added to TOC
- Added quote entry
- Renumbered affected chapters

Version: 1.0.0
```

**For content modification:**
```
Update {filename} v{version}

- {Change description}
- {Additional changes}

Type: {Change Type}
Scope: {Scope}
```

**For tracking sync:**
```
Sync change tracking files

- Updated {count} _chg files
- Reconstructed version history from git
- All files now in sync
```

---

### 9. Update PROJECT_CONTEXT Protocol

**Purpose:** Update session context file when significant changes occur

**Used by:** Prompts 1, 3, 8

**Triggers:**
- **Always:** During initialization (Prompt 1)
- **Always:** During dashboard generation (Prompt 8)
- **Conditional:** After significant changes (Prompt 3)
  - New chapters added/removed
  - Major version bump (X.0.0)
  - User explicitly requests update

**Procedure:**
1. Read current `PROJECT_CONTEXT.md` (if exists)
2. Gather latest project state:
   - Current word count and progress
   - Chapter status summary
   - Recent activity
   - Pending work
3. Update relevant sections:
   ```markdown
   # PROJECT CONTEXT
   **Generated:** {YYYY-MM-DD}
   **Framework Version:** {VERSION}
   **Project Version:** {VERSION}

   ## PART 1: FRAMEWORK OVERVIEW
   {Framework summary - usually static}

   ## PART 2: THIS BOOK PROJECT
   {Project metadata, TOC, structure}

   ## PART 3: CURRENT STATE
   {Progress metrics, recent changes, pending work}
   ```
4. Write updated file
5. Note in operation report: "PROJECT_CONTEXT.md updated"

**No _chg file required** for PROJECT_CONTEXT.md (it's a generated report, not authored content)

---

### 10. Validate File Existence Protocol

**Purpose:** Check if files exist before operations

**Used by:** All prompts

**Procedure:**
1. Check if file exists at specified path
2. If not found → Return error with clear message
3. If found → Return success, proceed

**Error messages:**
```
File not found: {path}

Expected location: {full_path}
Did you mean: {suggestions}

Troubleshooting:
- Verify path is correct
- Check if file was moved/renamed
- Run Prompt 8 (Dashboard) to see current structure
```

---

### 11. Validate Directory Structure Protocol

**Purpose:** Ensure required directories exist

**Used by:** Prompts 1, 2, 4

**Procedure:**
1. Verify Manuscript/ directory exists
2. Verify required subdirectories:
   - Chapters/
   - _TOC_/
   - Quotes/
   - Style/
   - FrontMatter/
   - BackMatter/
   - Inbox/
   - Drafts/
   - Exports/
3. If missing → Error with setup instructions
4. If all present → Proceed

**Error message:**
```
Project structure incomplete.

Missing: {list of missing directories}

Please run Prompt 1 (Initialize) to create proper structure.
```

---

## File Operation Best Practices

### Atomic Operations

**Always treat content + _chg as atomic unit:**
- Both files update together
- If one fails, rollback both
- Never leave them out of sync

### Error Handling

**Graceful degradation:**
- Validate before operating
- Provide clear error messages
- Suggest recovery steps
- Never leave project in inconsistent state

### Validation

**Always validate after writing:**
- File written successfully
- Content matches expected
- _chg file updated correctly
- Cross-references still valid

### Reporting

**After operations, always report:**
- What files were modified
- What changes were made
- Current version numbers
- Next steps for user

---

## Integration with Enforcement Rules

**RULE 1 Integration:**

Every file write to Manuscript/ MUST trigger _chg update:

```python
# Pseudocode
def write_content_file(path, content):
    validate_file_path(path)
    write_file(path, content)

    # MANDATORY: Update _chg file
    update_chg_file(
        path=f"{path}_chg.md",
        version=increment_version(current_version, change_type),
        change_type=analyze_change_type(diff),
        description=generate_description(diff),
        changes=list_changes(diff)
    )

    # Atomic check
    if not both_files_exist(path, f"{path}_chg.md"):
        rollback()
        raise Error("Atomic operation failed")
```

**RULE 2 Integration:**

All operations assume they're executing within a proper prompt:

```python
# Pseudocode
def modify_manuscript_file(path, modifications):
    # Verify executing within approved prompt
    if not is_prompt_execution():
        return routing_response("Use Prompt 3 to modify files")

    # Proceed with operation
    write_content_file(path, apply_modifications(modifications))
```

---

## Common Patterns

### Pattern 1: Read-Modify-Archive (Prompt 3)

```
1. Read _chg file instructions
2. Apply modifications to content file
3. Update _chg file with version entry
4. Archive completed instructions to Version History
5. Clear instruction section
6. Commit both files
```

### Pattern 2: Create-Initialize-Commit (Prompts 1, 2)

```
1. Create content file
2. Create _chg file with initial version entry
3. Update related files (TOC, Quotes)
4. Update related _chg files
5. Commit all files together
```

### Pattern 3: Sync-Update-Report (Prompt 10)

```
1. Scan for out-of-sync files
2. Generate version entries from git diffs
3. Update all _chg files
4. Report changes made
5. Optional commit
```

---

## Error Recovery

### Out-of-Sync Files

**Symptom:** Content file modified but _chg file not updated

**Recovery:**
```
1. Run Prompt 10 (Update Change Tracking)
2. Review generated version entries
3. Confirm accuracy
4. Commit _chg file updates
```

### Missing _chg Files

**Symptom:** Content file exists but no _chg file

**Recovery:**
```
1. Run Prompt 10 (Update Change Tracking)
2. AI generates _chg file with history from git
3. Initializes with current version
4. Commit new _chg file
```

### Corrupted _chg Files

**Symptom:** _chg file has invalid format

**Recovery:**
```
1. Backup corrupted _chg file
2. Run Prompt 10 to regenerate
3. Manually merge any valid content from backup
4. Commit corrected _chg file
```

---

**Module Version:** 0.10.0
**Last Updated:** 2025-11-19
**Status:** Active
**See Also:**
- `08_Semantic_Versioning_Guide.md` (version increment rules)
- `ENFORCEMENT_RULES.md` (mandatory _chg updates - Part 2: Integration Guide)
- `05_Git_Integration_Module.md` (commit formatting)
