# Enforcement Rules Module

**Framework Version:** 0.10.0
**Module:** Enforcement Rules Integration
**Purpose:** Standardized enforcement rule notices and validation protocols

---

## Overview

This module provides standardized templates and procedures for integrating the two mandatory enforcement rules across all prompts. These rules ensure data integrity and consistent workflow routing.

**Source:** `Process/ENFORCEMENT_RULES.md` (complete rulebook)

---

## The Two Enforcement Rules

### RULE 1: Automatic _chg File Updates

**Statement:**
WHENEVER the AI updates any file in the Manuscript/ directory, it MUST also update the corresponding _chg.md file.

**Scope:**
- All content files in Manuscript/Chapters/
- All files in Manuscript/FrontMatter/
- All files in Manuscript/BackMatter/
- Manuscript/_TOC_/TOC.md
- Manuscript/Quotes/Chapter_Quotes.md
- Manuscript/Style/ files

**No Exceptions.**

### RULE 2: Workflow Routing

**Statement:**
ANY change requested that will act upon a file in the Manuscript/ directory MUST be routed through an appropriate Execute Prompt.

**Scope:**
- All Manuscript/ directory operations
- Creating, modifying, deleting, moving, renaming files
- Direct modifications outside prompts are PROHIBITED

---

## Standard Enforcement Notice

**Include this section in ALL 10 prompts** (after Anti-Hallucination reference, before additional headers):

```markdown
**CRITICAL ENFORCEMENT:**
- **RULE 1:** All file modifications MUST update corresponding _chg files
- **RULE 2:** All Manuscript/ changes must go through appropriate prompts

See: `Process/ENFORCEMENT_RULES.md` for complete details
```

---

## Enforcement Notes by Prompt Type

### For File-Modifying Prompts (1, 2, 3, 4, 10)

**Add this note after the enforcement notice:**

```markdown
**NOTE:** This prompt updates _chg files as part of the standard workflow
```

**Workflow Integration:**

Include explicit _chg update steps:

```markdown
### Then I'll:

1. [Validate and prepare]
2. [Perform file operations]
3. **Update corresponding _chg file(s) with version entry**
4. **Increment version number appropriately (N.M.P)**
5. [Continue workflow]
6. Create git commit (includes both content and _chg files)
7. [Generate report]
```

### For Read-Only/Export Prompts (5, 6, 7, 8, 9)

**Add this note after the enforcement notice:**

For read-only analysis:
```markdown
**NOTE:** This is a read-only analysis operation. No _chg updates are required (reports findings only, does not modify files)
```

For export operations:
```markdown
**NOTE:** This is an export operation. No _chg updates are required (creates formatted exports, does not modify source files)
```

For compilation:
```markdown
**NOTE:** This is a read-only compilation operation. No _chg updates are required (drafts are generated, source files are not modified)
```

For git operations:
```markdown
**NOTE:** This handles git operations only. No _chg updates are required (version control operations, does not modify content files)
```

For dashboard (special case):
```markdown
**NOTE:** This is mostly a read-only analysis operation. Updates PROJECT_CONTEXT.md (no _chg required for this file)
```

---

## Routing Response Templates

### Template 1: Redirect to Appropriate Prompt

**Use when:** User asks to modify Manuscript/ files directly

**Response:**
```markdown
I cannot modify Manuscript/ files directly. This change should go through Prompt {NUMBER} ({PROMPT_NAME}).

Here's how:

1. {STEP_1}
2. {STEP_2}
3. {STEP_3}

This ensures:
✅ Proper change tracking
✅ Version history maintained
✅ Git commits with correct format
✅ Cross-references updated
✅ Validation performed

Would you like me to guide you through Prompt {NUMBER}?
```

**Example Variables:**
- `{NUMBER}`: 3
- `{PROMPT_NAME}`: Modify Target File
- `{STEP_1}`: Open the _chg file for the content you want to modify
- `{STEP_2}`: Add your instructions in [INSTRUCTIONS FOR THIS REVISION]
- `{STEP_3}`: Execute Prompt 3

### Template 2: Routing Table Reference

**Use when:** User is unsure which prompt to use

**Response:**
```markdown
For {OPERATION_TYPE}, use Prompt {NUMBER} ({PROMPT_NAME}).

**Common operations:**
| What You Want | Use Prompt |
|---------------|------------|
| Create new chapter | Prompt 2 (Add Chapter) |
| Modify existing content | Prompt 3 (Modify File) |
| Add content from files | Prompt 4 (Integrate Inbox) |
| Check for issues | Prompt 6 (Consistency) |
| Generate full manuscript | Prompt 5 (Compile) |
| Export to DOCX/PDF | Prompt 7 (Export) |

Would you like me to walk you through Prompt {NUMBER}?
```

### Template 3: Enforcement Explanation

**Use when:** User asks to bypass enforcement rules

**Response:**
```markdown
I understand you want a quick change, but the framework enforces proper change tracking for important reasons:

1. **Version history preservation** - Every change documented
2. **Audit trail** - Know who changed what and why
3. **Rollback capability** - Undo mistakes easily
4. **Consistency** - Cross-references stay valid
5. **Validation** - Catch errors before they spread

The prompts make this fast and easy. Prompt {NUMBER} takes less than 2 minutes.

Would you like me to walk you through it?
```

---

## Validation Protocols

### Pre-Commit Validation

**Before creating any git commit that includes Manuscript/ files:**

```markdown
Verify both files are staged:
- Content file: {CONTENT_FILE_PATH}
- Change tracking: {CONTENT_FILE_PATH}_chg.md

✅ Both files ready for commit
```

**Implementation:**
```markdown
Before creating git commit, I will verify:
- Content file modified: {filename}.md
- Change tracking updated: {filename}_chg.md
- Both files ready for commit
```

### Post-Execution Validation

**After any prompt execution that modifies files:**

```markdown
Validation checklist:
✅ Content file modified: {FILENAME}
✅ _chg file updated: {FILENAME}_chg.md
✅ Version entry added to Version History
✅ Version number incremented: {OLD_VERSION} → {NEW_VERSION}
✅ Git commit includes both files
✅ Change type documented: {CHANGE_TYPE}
```

### Workflow Validation

**At start of file-modifying prompts:**

```markdown
1. Verify this is the correct prompt for this operation
2. Check if user should be routed elsewhere
3. Confirm Manuscript/ files will be tracked properly
4. Proceed with workflow
```

---

## _chg File Update Protocol

### Standard Update Format

**For ALL file modifications in Manuscript/:**

```markdown
### Version {N.M.P} - {YYYY-MM-DD} - {Brief Description}

**Type:** {Content Addition | Content Deletion | Structural Change | Refinement | Content Update}
**Scope:** {Affected sections}
**Priority:** {Low | Medium | High}
**Rationale:** {Why this change was made}

**Changes Made:**
- {Detailed list of modifications}
- {What was added/removed/changed}
- {Impact on content}
```

### Version Increment Rules

**Major (N.0.0):**
- Structural changes affecting multiple chapters
- Chapter reordering
- Major reorganization

**Minor (0.M.0):**
- Significant content additions
- Significant content deletions
- New sections added
- Sections removed

**Patch (0.0.P):**
- Minor edits and refinements
- Typo corrections
- Formatting adjustments
- Small clarifications

### Auto-Archive Procedure

**For Prompt 3 (Modify File):**

1. Read instructions from `[INSTRUCTIONS FOR THIS REVISION]` section
2. Apply modifications to content file
3. Move completed instructions to `## VERSION HISTORY` section
4. Add version entry with instructions preserved
5. Clear `[INSTRUCTIONS FOR THIS REVISION]` section
6. Leave ready for next revision

---

## Prompt-Specific Enforcement

### Prompt 1 (Initialize)

**Enforcement:**
- Creates all initial _chg files
- Initializes with Version 1.0.0 entries
- Documents "Initial creation"

**Workflow Integration:**
```markdown
7. Create Manuscript/_TOC_/TOC.md and TOC_chg.md
8. Create Manuscript/Quotes/Chapter_Quotes.md and Chapter_Quotes_chg.md
9. Create front matter files with corresponding _chg files
10. Create back matter files with corresponding _chg files
```

### Prompt 2 (Add Chapter)

**Enforcement:**
- Creates new chapter _chg file
- Updates TOC_chg.md
- Updates Chapter_Quotes_chg.md

**Workflow Integration:**
```markdown
8. Create chapter files: Chapter_XX.md and Chapter_XX_chg.md
9. Update Manuscript/_TOC_/TOC.md
10. AI updates Manuscript/_TOC_/TOC_chg.md (AI-managed only)
11. Add quote entry to Manuscript/Quotes/Chapter_Quotes.md
12. Update Manuscript/Quotes/Chapter_Quotes_chg.md
```

### Prompt 3 (Modify File)

**Enforcement:**
- Primary example of Rule 1
- Auto-archives to Version History
- Increments version based on change scope

**Workflow Integration:**
```markdown
6. Apply the specified modifications
7. **Anti-Hallucination Verification** (CRITICAL)
8. **Style consistency check**
9. **Auto-archive**: Move completed instructions to Version History
10. **Clear instructions section**: Leave ready for next revision
11. Update file metadata (word count, status, etc.)
```

### Prompt 4 (Integrate Inbox)

**Enforcement:**
- Updates _chg files for modified content
- Creates _chg files for new content
- Documents source: "Integrated from Inbox/{filename}"

**Workflow Integration:**
```markdown
5. Execute integration based on your choices
   - Integrate content into target files
   - **Update change tracking files for all modified files**
   - **Create _chg files for any new content files**
   - Document source in _chg: "Integrated from Inbox/{filename}"
```

### Prompt 10 (Update Change Tracking)

**Enforcement:**
- This prompt IS the enforcement mechanism
- Reconstructs missing _chg entries
- Syncs from git history

**Workflow Integration:**
```markdown
1. Find all _chg file pairs
2. Check for changes in git (uncommitted, staged, unpushed)
3. **Auto-update _chg files for any out-of-sync content**
4. Generate version entries from git diffs
5. Show summary of all updates made
```

### Prompts 5, 6, 7, 8, 9

**Enforcement:**
- Explicitly state NO _chg updates required
- Read-only or export operations
- No Manuscript/ source file modifications

---

## Compliance Checklist

**For prompt authors/maintainers:**

- [ ] Enforcement notice included in header
- [ ] Enforcement note explains _chg behavior
- [ ] Workflow steps include _chg updates (if applicable)
- [ ] Git commit validation included (if applicable)
- [ ] Routing responses available (if user tries direct modification)
- [ ] Pre-commit validation implemented
- [ ] Post-execution validation implemented
- [ ] _chg file format follows standard template
- [ ] Version increment logic follows semantic versioning

---

## Testing Enforcement

### Test 1: Rule 1 Compliance

**Execute file-modifying prompt:**
```bash
git status
```

**Expected result:**
```
modified:   Manuscript/Chapters/Chapter_03/Chapter_03.md
modified:   Manuscript/Chapters/Chapter_03/Chapter_03_chg.md
```

**PASS:** Both files modified
**FAIL:** Only content file modified → VIOLATION

### Test 2: Rule 2 Compliance

**Attempt direct modification:**
```
User: "Can you update Chapter 3 to add a new section?"
```

**Expected response:**
```
I cannot modify Manuscript/ files directly. This change should go through Prompt 3 (Modify File).

Here's how:
[Routing instructions]
```

**PASS:** Redirects to appropriate prompt
**FAIL:** Attempts direct modification → VIOLATION

### Test 3: Git Commit Validation

**Check git commit:**
```bash
git log -1 --name-only
```

**Expected result:**
```
commit [hash]
Author: [name]
Date: [date]

Update Chapter 3 with case studies v1.3.0

Manuscript/Chapters/Chapter_03/Chapter_03.md
Manuscript/Chapters/Chapter_03/Chapter_03_chg.md
```

**PASS:** Both files in commit
**FAIL:** Only one file in commit → VIOLATION

---

## Recovery Procedures

### If Rule 1 Violated (Missing _chg update)

**Immediate action:**
1. Stop further operations
2. Update missing _chg file with proper entry
3. Amend git commit to include both files
4. OR: Run Prompt 10 to reconstruct tracking

**Command:**
```bash
# Option A: Amend commit
git add [filename]_chg.md
git commit --amend --no-edit

# Option B: Run Prompt 10
Execute Prompt 10 (Update Change Tracking)
```

### If Rule 2 Violated (Direct modification attempt)

**Immediate action:**
1. Undo any direct modifications made
2. Respond with correct prompt routing
3. Guide user through appropriate prompt
4. Document for learning

---

## Success Metrics

**100% compliance achieved when:**
- ✅ ALL file modifications include _chg updates
- ✅ ALL Manuscript/ changes routed through prompts
- ✅ ZERO missing _chg entries
- ✅ ZERO direct modifications outside prompts
- ✅ ALL git commits include both files
- ✅ ALL version history complete and accurate

---

**Module Version:** 0.10.0
**Last Updated:** 2025-11-19
**Status:** Active
**See Also:** `Process/ENFORCEMENT_RULES.md` (complete rulebook)
