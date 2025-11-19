# Framework Enforcement Rules

**Status:** Active Rules - Must Be Enforced
**Created:** 2025-11-19
**Framework Version:** 0.10.0+

---

## Purpose

This document defines **mandatory enforcement rules** that must be applied across all prompts and AI interactions within the framework. These rules ensure data integrity, proper change tracking, and correct workflow routing.

---

## RULE 1: Automatic _chg File Updates

### Statement

**WHENEVER the AI updates any file in the Manuscript/ directory, it MUST also update the corresponding _chg.md file.**

This rule applies to ALL file modifications, regardless of how they were initiated.

### Scope

**Files covered:**
- All content files in `Manuscript/Chapters/Chapter_XX/Chapter_XX.md`
- All files in `Manuscript/FrontMatter/`
- All files in `Manuscript/BackMatter/`
- `Manuscript/_TOC_/TOC.md`
- `Manuscript/Quotes/Chapter_Quotes.md`
- `Manuscript/Style/Style_Guide.md`
- `Manuscript/Style/Custom_Styles.md`
- Any other content files in `Manuscript/`

**_chg files:**
- `Manuscript/Chapters/Chapter_XX/Chapter_XX_chg.md`
- `Manuscript/FrontMatter/[filename]_chg.md`
- `Manuscript/BackMatter/[filename]_chg.md`
- `Manuscript/_TOC_/TOC_chg.md`
- `Manuscript/Quotes/Chapter_Quotes_chg.md`
- `Manuscript/Style/Style_Guide_chg.md`
- `Manuscript/Style/Custom_Styles_chg.md`

### Enforcement

**MANDATORY UPDATE:**
When ANY of these actions occur:
- ✅ Content is added to a file
- ✅ Content is removed from a file
- ✅ Content is modified in a file
- ✅ File structure is changed (headings, sections)
- ✅ Formatting is changed
- ✅ Cross-references are updated
- ✅ Metadata is updated

**The AI MUST:**
1. Document the change in the corresponding _chg.md file
2. Add entry to Version History section
3. Increment version number appropriately
4. Include:
   - Version number (N.M.P)
   - Date (YYYY-MM-DD)
   - Brief description
   - Type of change
   - Scope of change
   - Rationale

**Format:**
```markdown
### Version N.M.P - YYYY-MM-DD - [Brief Description]

**Type:** [Content Addition | Content Deletion | Structural Change | Refinement | Content Update]
**Scope:** [Affected sections]
**Priority:** [Low | Medium | High]
**Rationale:** [Why this change was made]

**Changes Made:**
- [Detailed list of modifications]
- [What was added/removed/changed]
- [Impact on content]
```

### Exceptions

**NONE.**

There are NO exceptions to this rule. Every file modification must be tracked.

Even if:
- ❌ The change is "minor" (still track it)
- ❌ The change is "just formatting" (still track it)
- ❌ The change is "automated" (still track it)
- ❌ The user didn't explicitly ask for tracking (still track it)

### Implementation Across Prompts

**Prompts that MUST enforce this rule:**

**Prompt 1 (Initialize):**
- When creating initial files, create corresponding _chg files
- Initialize Version History: "Version 1.0.0 - [DATE] - Initial creation"

**Prompt 2 (Add Chapter):**
- When creating new chapter file, create _chg file with initial entry
- When updating TOC, update TOC_chg.md
- When adding quote entry, update Chapter_Quotes_chg.md

**Prompt 3 (Modify File):**
- ALREADY ENFORCES THIS - maintains as primary example
- After applying modifications, auto-archive to Version History
- Increment version number based on change scope

**Prompt 4 (Integrate Inbox):**
- When integrating content into existing files, update their _chg files
- When creating new content files, create their _chg files
- Document source: "Integrated from Inbox/[filename]"

**Prompt 5 (Compile):**
- Does NOT modify source files, only creates compiled draft
- Exception: No _chg updates required

**Prompt 6 (Consistency):**
- Does NOT modify files, only reports issues
- Exception: No _chg updates required

**Prompt 7 (Export):**
- Does NOT modify source files, only creates exports
- Exception: No _chg updates required

**Prompt 8 (Dashboard):**
- When updating PROJECT_CONTEXT.md, document change (but no _chg file for this)
- Exception: Dashboard reports don't modify Manuscript/ files

**Prompt 9 (Git):**
- Does NOT modify content files
- Exception: No _chg updates required

**Prompt 10 (Update Tracking):**
- This prompt CREATES _chg entries for files modified outside the framework
- Automatically generates Version History entries from git diffs

### Validation

**To verify compliance:**

1. After ANY prompt execution that modifies files, check:
   ```bash
   git status
   ```

2. Verify BOTH files are staged:
   ```
   modified:   Manuscript/Chapters/Chapter_03/Chapter_03.md
   modified:   Manuscript/Chapters/Chapter_03/Chapter_03_chg.md
   ```

3. If only content file is modified → **VIOLATION**

4. The git commit should include both files:
   ```bash
   git add Manuscript/Chapters/Chapter_03/Chapter_03.md \
           Manuscript/Chapters/Chapter_03/Chapter_03_chg.md
   ```

### Consequences of Violation

**If this rule is violated:**
- ❌ Change tracking is lost
- ❌ Version history is incomplete
- ❌ Prompt 10 must reconstruct history from git (extra work)
- ❌ User loses visibility into what changed and why
- ❌ Auditing and rollback become difficult

**Recovery:**
- Run Prompt 10 (Update Change Tracking) to reconstruct missing entries
- This scans git history and creates _chg entries retroactively

---

## RULE 2: Workflow Routing - All Manuscript Changes Through Prompts

### Statement

**ANY change requested that will act upon a file in the Manuscript/ directory MUST be routed through an appropriate Execute Prompt.**

Direct file modifications outside the prompt system are **PROHIBITED**.

### Scope

**Files covered:**
- Everything in `Manuscript/` directory tree
- All subdirectories: Chapters/, FrontMatter/, BackMatter/, _TOC_/, Quotes/, Style/, Inbox/, Drafts/, Exports/

**Operations covered:**
- Creating files
- Modifying files
- Deleting files
- Moving files
- Renaming files

### Routing Table

**User Request → Correct Prompt**

| User Request | Route To | Rationale |
|-------------|----------|-----------|
| "Create my book project" | Prompt 1 | Initializes complete structure |
| "Add a new chapter" | Prompt 2 | Handles chapter creation and renumbering |
| "Modify Chapter 3" | Prompt 3 | Primary content modification workflow |
| "Update the introduction" | Prompt 3 | Any content change goes through Prompt 3 |
| "Fix typos in Chapter 5" | Prompt 3 | Even minor edits use Prompt 3 |
| "Add content from my draft" | Prompt 4 | Integrates inbox content |
| "Integrate these notes" | Prompt 4 | Integrates inbox content |
| "Compile the manuscript" | Prompt 5 | Creates full draft from source files |
| "Check for consistency issues" | Prompt 6 | Read-only analysis, reports issues |
| "Export to DOCX" | Prompt 7 | Creates exports, doesn't modify source |
| "Show me project status" | Prompt 8 | Read-only dashboard |
| "Commit these changes" | Prompt 9 | Git operations only |
| "Sync change tracking" | Prompt 10 | Updates _chg files from git history |

### Examples of Correct Routing

**Example 1: User asks to modify content**
```
User: "Can you update Chapter 3 to include a new example?"

CORRECT Response:
"I'll help you modify Chapter 3. Please use Prompt 3 (Modify File):

1. Open Manuscript/Chapters/Chapter_03/Chapter_03_chg.md
2. Add your instructions in the [INSTRUCTIONS FOR THIS REVISION] section
3. Commit the _chg file
4. Execute Prompt 3

Would you like me to guide you through this process?"

INCORRECT Response:
"Sure, I'll update Chapter 3 right now..." [directly edits file]
```

**Example 2: User asks to add content from notes**
```
User: "I have some notes in a file. Can you add them to Chapter 5?"

CORRECT Response:
"I'll help you integrate that content. Please use Prompt 4 (Integrate Inbox):

1. Place your notes file in Manuscript/Inbox/
2. Execute Prompt 4
3. Choose the target location (Chapter 5)

This ensures proper integration and change tracking."

INCORRECT Response:
"Sure, paste the notes here and I'll add them..." [attempts direct modification]
```

**Example 3: User asks to create a new chapter**
```
User: "I need to add a new Chapter 4 about methodology"

CORRECT Response:
"I'll help you add a new chapter. Please use Prompt 2 (Add Chapter):

Execute Prompt 2 and I'll guide you through:
- Chapter title
- Position in the book
- Initial content structure

This ensures proper chapter numbering and TOC updates."

INCORRECT Response:
"I'll create Chapter 4 for you..." [attempts direct file creation]
```

### Enforcement Across All Prompts

**When AI detects a Manuscript/ modification request outside a prompt:**

**RESPONSE TEMPLATE:**
```markdown
I cannot modify Manuscript/ files directly. This change should go through [Prompt X].

Here's how:

1. [Step 1 for using the appropriate prompt]
2. [Step 2]
3. [Step 3]

This ensures:
✅ Proper change tracking
✅ Version history maintained
✅ Git commits with correct format
✅ Cross-references updated
✅ Validation performed

Would you like me to guide you through [Prompt X]?
```

### Special Cases

**Case 1: User explicitly asks to bypass prompts**
```
User: "Just modify the file directly, don't make me use a prompt"

Response:
"I understand you want a quick change, but the framework enforces
proper change tracking for important reasons:

1. Version history preservation
2. Audit trail of all changes
3. Ability to rollback if needed
4. Consistent git commit messages
5. Validation of cross-references

The prompts make this fast and easy. Prompt 3 takes less than 2 minutes.

Would you like me to walk you through Prompt 3?"
```

**Case 2: User is in middle of debugging and needs quick test**
```
User: "I'm debugging an issue. Can you just quickly test something in Chapter 2?"

Response:
"For debugging purposes, I recommend:

1. Make test changes manually (outside framework)
2. Test your hypothesis
3. Once confirmed, run Prompt 10 to sync change tracking
4. Or revert test changes and use Prompt 3 for final fix

This lets you experiment while keeping the framework clean."
```

**Case 3: User wants to batch multiple changes**
```
User: "I need to fix typos in Chapters 1, 3, and 5"

Response:
"For multiple changes, you have two options:

Option A: Use Prompt 3 three times (maintains granular history)
Option B: Use Prompt 3 once and list all changes in the _chg instructions

I recommend Option A for clear version history, but Option B works
if the changes are all related (e.g., 'Fix formatting throughout')."
```

### Exceptions

**Files NOT subject to this rule:**
- `Process/` directory (framework files)
- `Research/` directory (user research files)
- Root-level config files (`Project_Config.md`, `Project_Metadata.md`, etc.)
- `.git/` directory
- `.claude/` directory
- Any files outside `Manuscript/`

**These can be modified directly** because they don't require the same change tracking system.

### Validation

**To verify compliance:**

1. When user requests Manuscript/ file changes, AI MUST respond with prompt routing
2. AI should NEVER directly write/edit Manuscript/ files in response to user requests
3. Exception: When executing a prompt, modifications are allowed (that's the whole point)

### Consequences of Violation

**If this rule is violated:**
- ❌ Changes bypass validation
- ❌ No change tracking entry created
- ❌ No version increment
- ❌ Git commit format incorrect
- ❌ Cross-references may break
- ❌ User confused about workflow
- ❌ Inconsistent experience

**Recovery:**
- Run Prompt 10 to reconstruct change tracking
- Manually fix git commit messages if needed
- Re-educate user on correct workflow

---

## Implementation Requirements

### For All Prompts

Each prompt file should include:

1. **At the top:** Reference to these enforcement rules
   ```markdown
   **CRITICAL ENFORCEMENT:**
   - RULE 1: All file modifications MUST update corresponding _chg files
   - RULE 2: All Manuscript/ changes must go through appropriate prompts

   See: Process/ENFORCEMENT_RULES.md
   ```

2. **In workflow steps:** Explicit _chg update step
   ```markdown
   Then I'll:
   ...
   8. Update corresponding _chg.md file with version entry
   9. Increment version number appropriately
   ...
   ```

3. **Before git commit:** Verify both files staged
   ```markdown
   Before creating git commit, I will verify:
   - Content file modified: [filename].md
   - Change tracking updated: [filename]_chg.md
   - Both files ready for commit
   ```

### For System Instructions

**Update `system-instructions.md` with:**

```markdown
## CRITICAL ENFORCEMENT RULES

1. **RULE 1: Automatic _chg Updates**
   - WHENEVER I modify any file in Manuscript/, I MUST update its _chg.md file
   - Document version, date, changes, rationale
   - NO EXCEPTIONS

2. **RULE 2: Workflow Routing**
   - ALL Manuscript/ changes MUST go through appropriate Execute Prompts
   - I MUST NOT directly modify Manuscript/ files outside prompts
   - Route user requests to correct prompt (see routing table)

See: ENFORCEMENT_RULES.md for complete details
```

### For AI Behavior

**When Claude executes any prompt:**

**Pre-execution check:**
- ✅ Verify this is a legitimate prompt execution (not ad-hoc request)
- ✅ Confirm user has followed correct routing
- ✅ If not: redirect to appropriate prompt

**During execution:**
- ✅ Track all file modifications
- ✅ Update corresponding _chg files immediately after content changes
- ✅ Include all required metadata (version, date, type, scope, rationale)

**Post-execution check:**
- ✅ Verify every modified Manuscript/ file has updated _chg file
- ✅ Include both in git commit
- ✅ Generate report showing what was tracked

---

## Audit and Compliance

### Self-Check Questions

**After any AI interaction with the framework:**

1. Did I modify any files in Manuscript/?
   - If YES → Did I update the corresponding _chg files?

2. Did the user ask me to modify Manuscript/ files outside a prompt?
   - If YES → Did I route them to the appropriate prompt?

3. Did I create any new content files?
   - If YES → Did I also create their _chg files?

4. Did I perform any git commits involving Manuscript/ files?
   - If YES → Did I include both content and _chg files?

### Violation Detection

**Signs of Rule 1 violation:**
```bash
# Only content file modified
git status
modified:   Manuscript/Chapters/Chapter_03/Chapter_03.md
# Missing: Manuscript/Chapters/Chapter_03/Chapter_03_chg.md
```

**Signs of Rule 2 violation:**
- User asks: "Can you update Chapter 3?"
- AI responds: "Sure, I'll update it now..." [directly edits]
- No prompt execution occurred

### Remediation

**If Rule 1 violated:**
1. Stop immediately
2. Update the missing _chg file with proper entry
3. Amend the git commit to include both files
4. OR: Run Prompt 10 to reconstruct tracking

**If Rule 2 violated:**
1. Undo any direct modifications made
2. Respond with correct prompt routing
3. Guide user through appropriate prompt
4. Document the mistake to avoid repetition

---

## Examples of Correct Enforcement

### Example 1: Prompt 3 Execution (Correct)

**User action:**
1. Edits `Chapter_05_chg.md` with instructions
2. Commits the _chg file
3. Executes Prompt 3

**AI behavior:**
1. ✅ Reads instructions from _chg file
2. ✅ Applies modifications to Chapter_05.md
3. ✅ Updates Chapter_05_chg.md with Version History entry
4. ✅ Increments version: 1.2.3 → 1.3.0
5. ✅ Provides git commit command for BOTH files
6. ✅ Report shows both files updated

**Git commit:**
```bash
git add Manuscript/Chapters/Chapter_05/Chapter_05.md \
        Manuscript/Chapters/Chapter_05/Chapter_05_chg.md
git commit -m "Update Chapter 5 with case studies v1.3.0"
```

**Result:** ✅ COMPLIANT

---

### Example 2: Ad-Hoc Request (Correct Routing)

**User request:**
"Can you add a section about data validation to Chapter 3?"

**AI response:**
```
I'll help you add that section to Chapter 3. To maintain proper change
tracking, please use Prompt 3 (Modify File):

1. Open: Manuscript/Chapters/Chapter_03/Chapter_03_chg.md

2. Add this instruction:
   ```
   ### [INSTRUCTIONS FOR THIS REVISION]

   Add new section "Data Validation" after "Data Collection" section.

   Content to include:
   - Validation criteria
   - Quality checks
   - Error handling
   ```

3. Commit the _chg file:
   ```
   git add Manuscript/Chapters/Chapter_03/Chapter_03_chg.md
   git commit -m "Add instructions for data validation section"
   ```

4. Execute Prompt 3

Would you like me to draft the content for that section while you set
this up?
```

**Result:** ✅ COMPLIANT (routed to prompt, didn't directly modify)

---

### Example 3: Prompt 2 Execution (Correct)

**User action:**
Executes Prompt 2 to add new Chapter 4

**AI behavior:**
1. ✅ Creates `Manuscript/Chapters/Chapter_04/Chapter_04.md`
2. ✅ Creates `Manuscript/Chapters/Chapter_04/Chapter_04_chg.md` with initial entry:
   ```markdown
   ### Version 1.0.0 - 2025-11-19 - Initial chapter creation

   **Type:** Content Addition
   **Scope:** New chapter
   **Priority:** High
   **Rationale:** Adding methodology chapter as Chapter 4

   **Changes Made:**
   - Created initial chapter structure
   - Added placeholder sections
   - Integrated with TOC
   ```
3. ✅ Updates `Manuscript/_TOC_/TOC.md`
4. ✅ Updates `Manuscript/_TOC_/TOC_chg.md`
5. ✅ Updates `Manuscript/Quotes/Chapter_Quotes.md`
6. ✅ Updates `Manuscript/Quotes/Chapter_Quotes_chg.md`
7. ✅ Provides git commit with all 6 files

**Result:** ✅ COMPLIANT

---

## Summary

**RULE 1: Automatic _chg Updates**
- ✅ ALWAYS update _chg files when modifying Manuscript/ files
- ✅ Document version, date, type, scope, rationale
- ✅ NO EXCEPTIONS

**RULE 2: Workflow Routing**
- ✅ ALL Manuscript/ changes through appropriate prompts
- ✅ Route user requests correctly
- ✅ NEVER directly modify outside prompts

**These rules are MANDATORY and MUST be enforced across:**
- All 10 Execute Prompts
- All AI interactions with the framework
- All system instructions and configurations

**Compliance ensures:**
- Complete change history
- Proper version tracking
- Consistent git commits
- Validated modifications
- Auditable workflow
- User confidence in the framework

---

**Status:** ACTIVE - MUST BE ENFORCED
**Created:** 2025-11-19
**Framework Version:** 0.10.0+
**Applies To:** All current and future prompts
