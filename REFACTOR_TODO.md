# Prompt Refactoring TODO - Framework v0.9.2+

**Status:** Analysis Complete - Not Yet Implemented
**Created:** 2025-11-19
**Target Version:** 0.10.0 or later

---

## Executive Summary

Analysis of all 10 prompts reveals **2,500-3,500 lines of duplicated content** (40-50% of total) that could be extracted into shared core modules. This refactoring would:

- ✅ Reduce maintenance burden (single source of truth)
- ✅ Improve consistency across prompts
- ✅ Shrink average prompt size from ~1,100 lines to ~600 lines
- ✅ Enable faster updates and bug fixes
- ✅ Create reusable building blocks for future prompts

**Estimated effort:** Medium-Large (10-15 patterns to extract, 10 prompts to refactor)

---

## Current Duplication Analysis

### High-Priority Patterns (100% of prompts affected)

| Pattern | Prompts | Lines | Impact |
|---------|---------|-------|--------|
| Desktop Compatibility Headers | 10/10 | ~100 | HIGH |
| Anti-Hallucination References | 10/10 | ~200+ | HIGH |
| Workflow Structure Template | 10/10 | ~600 | HIGH |
| Interactive Questions Pattern | 10/10 | ~350 | MEDIUM |
| Documentation Sections/Metadata | 10/10 | ~75 | LOW |
| Interaction & Confirmation Flows | 10/10 | ~450 | MEDIUM |

**Subtotal:** 1,775 lines of duplicated content in universal patterns

### Medium-Priority Patterns (40-90% of prompts)

| Pattern | Prompts | Lines | Impact |
|---------|---------|-------|--------|
| File Operation Workflows | 7/10 | ~400 | MEDIUM |
| Validation & Safety Checks | 9/10 | ~150 | MEDIUM |
| Quote Management | 6/10 | ~240 | MEDIUM |
| Version Numbering Logic | 6/10 | ~120 | MEDIUM |
| Report Templates | 6/10 | ~300 | MEDIUM |
| Git Commit Format | 4/10 | ~100 | MEDIUM |
| Recommended Frequency/Usage | 4/10 | ~30 | LOW |
| PROJECT_CONTEXT Updates | 3/10 | ~100+ | MEDIUM |
| Style Consistency Checking | 2/10 | ~120 | MEDIUM |

**Subtotal:** 1,560 lines of duplicated content in shared patterns

**Total Estimated Duplication:** 3,335 lines across 10 prompts

---

## Proposed Core Library Structure

Create `Process/_COMMON/` directory with modular components:

```
Process/_COMMON/
├── README.md                           # Index and usage guide
├── 01_Prompt_Structure_Template.md    # Master template for all prompts
├── 02_Desktop_Compatibility_Module.md # Compatibility headers and specs
├── 03_Anti_Hallucination_Protocols.md # Three-level protocol system
├── 04_File_Operations_Library.md      # Standardized file operations
├── 05_Git_Integration_Module.md       # Git commands, formats, workflows
├── 06_Validation_Protocols.md         # Safety checks and validation
├── 07_Quote_Management_System.md      # Quote tracking and verification
├── 08_Semantic_Versioning_Guide.md    # Version numbering rules
├── 09_Report_Templates.md             # Statistics and report formats
├── 10_Style_Consistency_Protocol.md   # Style checking workflows
├── 11_Interactive_Patterns.md         # Question/confirmation templates
├── 12_Workflow_Patterns.md            # Common workflow sequences
└── 13_PROJECT_CONTEXT_Protocol.md     # When and how to update context
```

---

## Detailed Refactoring Plan

### PATTERN 1: Desktop Compatibility Headers

**Current state:** Each prompt has 8-12 lines of compatibility declaration

**Example from Prompt 3:**
```markdown
**DESKTOP-FRIENDLY:** Works in Claude Desktop with MCP Filesystem + single copy/paste git commit at end

**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`

**Claude Desktop Compatibility:**
- ✅ All file operations via MCP Filesystem connector
- ✅ Single git commit command provided as copy/paste at end
- ✅ No bash commands required
- 📋 Works 95% in Desktop
```

**Proposed solution:**
- File: `02_Desktop_Compatibility_Module.md`
- Contains three templates:
  - **DESKTOP-READY** (100% - no git): Prompts 5, 6
  - **DESKTOP-FRIENDLY** (95% - git at end): Prompts 1, 2, 3, 4, 7, 8, 10
  - **CLI-ONLY** (must use CLI): Prompt 9
- Variables: `{COMPATIBILITY_TYPE}`, `{FEATURES_LIST}`, `{PERCENTAGE}`
- Each prompt includes: `[Include: Desktop-Compatibility-{TYPE}]`

**Lines saved:** 80-100 lines (8-10 per prompt × 10 prompts, minus 1 shared module)

---

### PATTERN 2: Anti-Hallucination References

**Current state:** Multiple implementations
- Basic reference (Prompts 6, 7, 8, 9, 10): 1 line
- Contextual note (Prompts 1, 4, 5): 7-10 lines
- Comprehensive verification (Prompt 3): 75 lines

**Example from Prompt 3 (lines 103-177):**
```markdown
## Anti-Hallucination Verification (CRITICAL)

**This step prevents fabricated content from entering your book.**

### When This Step Triggers
...
### What I'll Ask You
...
### Content Labels I'll Use
...
```

**Proposed solution:**
- File: `03_Anti_Hallucination_Protocols.md`
- Three levels:
  - **Level 1 - Reference Only:** Single line reference
  - **Level 2 - Contextual Note:** Brief warning + reference (7-10 lines)
  - **Level 3 - Comprehensive Verification:** Full protocol (75 lines)
- Each prompt includes appropriate level: `[Include: Anti-Hallucination-Level-{N}]`
- Variables: `{CONTENT_TYPE}` (e.g., "style examples", "inbox content", "chapter content")

**Lines saved:** 150-200 lines (comprehensive section avoided in 7 prompts, contextual avoided in 5)

---

### PATTERN 3: Workflow Structure Template

**Current state:** All 10 prompts follow identical 8-section structure:
1. Title: `# Execute Prompt [N]: [Description]`
2. Desktop compatibility header
3. "What This Does"
4. "How This Works"
5. "Questions I'll ask" / "Then I'll"
6. Additional sections (varies)
7. "Ready to Begin?"
8. Reference footer

**Proposed solution:**
- File: `01_Prompt_Structure_Template.md`
- Master template with clear variable markers:
  ```markdown
  # Execute Prompt {PROMPT_NUMBER}: {PROMPT_NAME}

  [Include: Desktop-Compatibility-{TYPE}]

  [Include: Anti-Hallucination-Level-{LEVEL}]

  ---

  ## What This Does

  {WHAT_THIS_DOES}

  ---

  ## How This Works

  {HOW_THIS_WORKS}

  ### Questions I'll ask:

  {QUESTIONS_LIST}

  ### Then I'll:

  {WORKFLOW_STEPS}

  ---

  {ADDITIONAL_SECTIONS}

  ---

  ## Ready to Begin?

  {READY_PROMPT}

  ---

  *Reference: Process/AI-Assisted_Nonfiction_Authoring_Process.md (Prompt {PROMPT_NUMBER})*
  ```

**Lines saved:** 50-70 lines per prompt in boilerplate = 500-700 lines

---

### PATTERN 4: Git Commit Format Instructions

**Current state:** Prompts 2, 3, 8, 10 each have 20-25 lines of identical formatting instructions

**Example from Prompt 2 (lines 84-106):**
```markdown
## Git Commit Format (For Claude Desktop Users)

When providing the git commit command at the end, format it like this:

**For Claude Desktop users, provide:**

Go to Claude Code CLI and say:
```
Run: git add [files] && git commit -m '[message]'
```

**The instruction "Go to Claude Code CLI and say:" must be OUTSIDE the code block.**
```

**Proposed solution:**
- File: `05_Git_Integration_Module.md`
- Contains:
  - Standard format instructions (always the same)
  - Command templates for different scenarios:
    - New chapter: `git add Manuscript/Chapters/Chapter_XX/ Manuscript/_TOC_/ Manuscript/Quotes/`
    - Modify file: `git add [file-path] [file-path]_chg.md`
    - Dashboard update: `git add PROJECT_CONTEXT.md`
    - Tracking sync: `git add [list of _chg.md files]`
  - Placeholder section: `{FILE_SPECIFIC_NOTES}`
- Each prompt includes: `[Include: Git-Commit-Format with template={TEMPLATE_NAME} and notes={NOTES}]`

**Lines saved:** 60-80 lines (prompts 2, 3, 8, 10 each avoid 20-25 lines)

---

### PATTERN 5: File Operation Workflows

**Current state:** 7 prompts describe similar file operations

**Common operations identified:**
- Read _chg files (Prompts 2, 3, 4, 10)
- Update TOC (Prompts 1, 2, 4)
- Update cross-references (Prompts 2, 4)
- Auto-archive instructions (Prompt 3)
- Update PROJECT_CONTEXT.md (Prompts 1, 3, 8)
- Create git commits (Prompts 1, 2, 3, 4, 8, 10)

**Proposed solution:**
- File: `04_File_Operations_Library.md`
- Standardized protocols:
  - **Read _chg File Protocol:**
    1. Read `[filename]_chg.md`
    2. Extract `[INSTRUCTIONS FOR THIS REVISION]` section
    3. Validate non-empty
    4. Return instructions for processing

  - **Write Modified Content Protocol:**
    1. Validate target file exists
    2. Apply modifications
    3. Increment version number (see Semantic Versioning Guide)
    4. Update metadata
    5. Write file

  - **Update TOC Protocol:**
    1. Read `Manuscript/_TOC_/TOC.md`
    2. Apply modifications
    3. Update `Manuscript/_TOC_/TOC_chg.md` (AI-managed only)
    4. Validate chapter numbering consistency

  - **Auto-Archive Protocol:**
    1. Extract completed instructions from `[INSTRUCTIONS FOR THIS REVISION]`
    2. Append to `## VERSION HISTORY` section with version and date
    3. Clear `[INSTRUCTIONS FOR THIS REVISION]` section
    4. Mark ready for next revision

  - **Update Cross-References Protocol:**
    1. Scan all content files for references to modified/moved content
    2. Update chapter references (Chapter_XX → Chapter_YY)
    3. Update file paths if changed
    4. Validate all links resolve

  - **Create Git Commit Protocol:**
    1. Stage specified files: `git add [files]`
    2. Format commit message with:
       - Brief description
       - Details section
       - Version info (if applicable)
       - Co-authorship attribution
    3. Execute commit
    4. Verify success

**Lines saved:** 300-400 lines (50-80 per prompt × 7 prompts, minus shared module)

---

### PATTERN 6: Validation & Safety Checks

**Current state:** 9 prompts include similar validation steps

**Common validations:**
- File existence checks
- Git status verification
- Directory structure validation
- Cross-reference validation
- Placeholder content detection

**Proposed solution:**
- File: `06_Validation_Protocols.md`
- Protocols:
  - **File Existence Validation:**
    ```
    1. Check if file exists at specified path
    2. If not found: Error with clear message
    3. If found: Proceed
    ```

  - **Git Status Validation:**
    ```
    1. Run: git status --porcelain
    2. If uncommitted changes: Warn user, require commit first
    3. If clean: Proceed
    ```

  - **Directory Structure Validation:**
    ```
    1. Verify Manuscript/ directory exists
    2. Verify required subdirectories: Chapters/, _TOC_/, Quotes/, Style/
    3. If missing: Error with setup instructions
    ```

  - **Cross-Reference Validation:**
    ```
    1. Extract all internal links (Chapter_XX, see X.Y, etc.)
    2. Verify target files/sections exist
    3. Report broken links
    ```

  - **Content Validation:**
    ```
    1. Scan for [PLACEHOLDER] markers
    2. Scan for [TODO] markers
    3. Scan for [CITATION NEEDED] markers
    4. Report findings with locations
    ```

**Lines saved:** 90-150 lines (10-20 per prompt × 9 prompts, minus shared module)

---

### PATTERN 7: Quote Management System

**Current state:** 6 prompts reference quote management with variations

**Usage:**
- Prompt 1: Creates initial quote file
- Prompt 2: Adds quote entry for new chapter
- Prompt 3: Can modify quotes
- Prompt 5: Inserts verified quotes as epigraphs
- Prompt 6: Validates quote verification status
- Prompt 8: Reports quote metrics

**Proposed solution:**
- File: `07_Quote_Management_System.md`
- Contains:
  - **Status Code System:**
    - ⏳ Pending verification
    - ⚠ Needs proper citation
    - ✓ Verified with source

  - **Required Fields:**
    ```
    Chapter: [number]
    Quote: "[text]"
    Author: [name]
    Source: [book/article/speech]
    Year: [YYYY]
    Page: [optional]
    Bibliography: [citation]
    Status: [⏳/⚠/✓]
    ```

  - **Verification Progression:**
    1. Initial entry: Status ⏳ (Pending)
    2. User provides citation: Status ⚠ (Needs verification)
    3. Source verified: Status ✓ (Verified)

  - **Epigraph Insertion Format:**
    ```markdown
    # Chapter X: [Title]

    > [Quote text]
    >
    > — [Author], *[Source]* ([Year])

    [Chapter content begins...]
    ```

  - **Validation Checklist:**
    - All chapters have quote entry (or "No epigraph" marker)
    - All quotes have required fields
    - All ✓ quotes have proper bibliography entries
    - No fabricated quotes or attributions

  - **Metrics Calculation:**
    - Total chapters with epigraphs: X/Y (Z%)
    - Verified: A (B%)
    - Pending: C (D%)
    - Needs citation: E (F%)

**Lines saved:** 180-240 lines (30-50 per prompt × 6 prompts, minus shared module)

---

### PATTERN 8: Semantic Versioning Guide

**Current state:** 6 prompts reference version numbering with varying detail

**Most comprehensive (Prompt 10, lines 49-52):**
```markdown
- Major version (X.0.0) for structural changes
- Minor version (0.X.0) for content additions/deletions
- Patch version (0.0.X) for refinements/updates
```

**Proposed solution:**
- File: `08_Semantic_Versioning_Guide.md`
- Contains:
  - **Version Format:** N.M.P (Major.Minor.Patch)

  - **When to Increment MAJOR (X.0.0):**
    - Structural changes affecting multiple chapters
    - Chapter reordering
    - Major reorganization of content
    - Breaking changes to format/structure

  - **When to Increment MINOR (0.X.0):**
    - Content additions (new sections, significant expansions)
    - Content deletions (removing sections)
    - Adding/removing chapters
    - Significant content revisions

  - **When to Increment PATCH (0.0.X):**
    - Minor edits and refinements
    - Typo corrections
    - Formatting adjustments
    - Small clarifications
    - Grammar fixes

  - **Change Type Classifications:**
    - Content Addition
    - Content Deletion
    - Structural Change
    - Refinement
    - Content Update

  - **Examples:**
    ```
    1.0.0 → 1.0.1: Fixed typos in Chapter 3
    1.0.1 → 1.1.0: Added new section on methodology
    1.1.0 → 2.0.0: Reorganized all chapters by theme
    ```

**Lines saved:** 70-120 lines (20-30 per prompt × 6 prompts, minus shared module)

---

### PATTERN 9: Report Templates

**Current state:** 6 prompts generate reports with overlapping formats

**Report types:**
- Prompt 1: Confirmation report
- Prompt 5: Compilation statistics
- Prompt 6: Consistency report
- Prompt 8: Comprehensive dashboard
- Prompt 9: Status report
- Prompt 10: Synchronization summary

**Proposed solution:**
- File: `09_Report_Templates.md`
- Templates:
  - **Word Count Display:**
    ```
    Current: [X] words
    Target: [Y] words
    Progress: [Z]% ([X]/[Y])
    ```

  - **Completion Status:**
    ```
    ✅ Complete: [count] sections
    🚧 In Progress: [count] sections
    ⏳ Pending: [count] sections
    ```

  - **File Status List:**
    ```
    Manuscript/Chapters/Chapter_01/Chapter_01.md - v1.3.0 (2,847 words) ✅
    Manuscript/Chapters/Chapter_02/Chapter_02.md - v1.1.0 (1,923 words) 🚧
    ```

  - **Statistics Summary:**
    ```
    Total Word Count: [X]
    Total Chapters: [Y]
    Average Words/Chapter: [Z]
    Completion: [P]%
    ```

  - **Milestone Tracking:**
    ```
    ◯ 25% - Not Reached
    ◉ 50% - Reached (2025-11-15)
    ◯ 75% - Not Reached
    ◯ 100% - Not Reached
    ```

**Lines saved:** 200-300 lines (50-100 per prompt × 6 prompts, minus shared module)

---

### PATTERN 10: Style Consistency Protocol

**Current state:** Prompts 3 and 6 have detailed style checking sections

**Prompt 3:** 70 lines of style checking workflow
**Prompt 6:** 11 lines of style validation reference

**Proposed solution:**
- File: `10_Style_Consistency_Protocol.md`
- Contains:
  - **What to Check:**
    - Person consistency (first/second/third)
    - Formality level matches configured style
    - Paragraph length (if specified in style)
    - Sentence complexity
    - Technical terminology explanation
    - Passive voice usage

  - **Checking Against DO/DON'T Lists:**
    1. Load active style from `Manuscript/Style/Style_Guide.md`
    2. Extract DO list and DON'T list
    3. Scan modified content for violations
    4. Flag matches

  - **Issue Severity Levels:**
    - **Minor:** Note in report, continue
    - **Moderate:** Flag and ask for correction preference
    - **Significant:** Highlight and offer specific revisions

  - **Remediation Options:**
    - Option 1: Apply automatic corrections (preserve meaning)
    - Option 2: Review manually (user fixes)
    - Option 3: Skip - Intentional variation (document exception)
    - Option 4: Update style guide (evolved preference)

  - **When to Check:**
    - Prompt 3: After applying modifications (step 8)
    - Prompt 6: During consistency check workflow

**Lines saved:** 80-120 lines (avoiding duplication between Prompts 3 and 6)

---

### PATTERN 11: Interactive Patterns

**Current state:** All 10 prompts use question/answer patterns with variations

**Common patterns:**
- Sequential questions (Prompt 1: 9 questions)
- Branching decisions (Prompt 2: interactive vs. inbox)
- Option selection (Prompt 7: export formats)
- Confirmation requests (Prompt 9: destructive operations)

**Proposed solution:**
- File: `11_Interactive_Patterns.md`
- Templates:
  - **Sequential Question Template:**
    ```
    **Questions I'll ask:**

    1. [Question 1]
    2. [Question 2]
    3. [Question 3]
    ...
    ```

  - **Branching Decision Template:**
    ```
    **Initial Question:** [Question]

    **If Option A:**
    - [Sub-question 1]
    - [Sub-question 2]

    **If Option B:**
    - [Different sub-question]
    ```

  - **Menu Selection Template:**
    ```
    **Select an option:**
    1. [Option 1] - [Description]
    2. [Option 2] - [Description]
    3. [Option 3] - [Description]
    ```

  - **Confirmation Pattern:**
    ```
    **I will perform the following actions:**
    - [Action 1]
    - [Action 2]

    **This operation is [reversible/irreversible].**

    **Proceed? (Yes/No)**
    ```

**Lines saved:** 300-400 lines (30-40 per prompt × 10 prompts, minus shared module)

---

### PATTERN 12: Workflow Patterns

**Current state:** Common workflow sequences repeated across prompts

**Common sequences:**
- Pre-operation safety commit (Prompts 2, 4)
- Read → Modify → Archive → Commit (Prompts 3, 10)
- Validate → Update → Report (Prompts 5, 6, 8)

**Proposed solution:**
- File: `12_Workflow_Patterns.md`
- Standard sequences:
  - **Safety Commit Pattern:**
    ```
    1. Check git status
    2. Create commit of current state
    3. Proceed with operation
    4. Create commit of changes
    ```

  - **Read-Modify-Archive Pattern:**
    ```
    1. Read _chg file instructions
    2. Apply modifications to content file
    3. Archive completed instructions to Version History
    4. Clear instruction section
    5. Commit changes
    ```

  - **Validate-Update-Report Pattern:**
    ```
    1. Validate all files exist
    2. Perform updates
    3. Generate statistics
    4. Create report
    5. Optional: Commit results
    ```

**Lines saved:** 100-150 lines (shared workflow descriptions)

---

### PATTERN 13: PROJECT_CONTEXT Protocol

**Current state:** 3 prompts update PROJECT_CONTEXT.md with different triggers

**Usage:**
- Prompt 1: Creates during initialization
- Prompt 3: Updates if significant changes
- Prompt 8: Automatically updates with dashboard

**Proposed solution:**
- File: `13_PROJECT_CONTEXT_Protocol.md`
- Contains:
  - **When to Update (Triggers):**
    - Always: During initialization (Prompt 1)
    - Always: During dashboard generation (Prompt 8)
    - Conditional: After significant changes (Prompt 3)
      - New chapters added/removed
      - Major version bump (X.0.0)
      - User explicitly requests update

  - **What to Include:**
    ```markdown
    # PROJECT CONTEXT
    **Generated:** [DATE]
    **Framework Version:** [VERSION]
    **Project Version:** [VERSION]

    ## PART 1: FRAMEWORK OVERVIEW
    [Framework summary]

    ## PART 2: THIS BOOK PROJECT
    [Project metadata, TOC, recent activity]

    ## PART 3: CURRENT STATE
    [Progress metrics, pending work]
    ```

  - **Update Procedure:**
    1. Read current PROJECT_CONTEXT.md (if exists)
    2. Gather latest project state
    3. Update relevant sections
    4. Write updated file
    5. Note in operation report

**Lines saved:** 50-100 lines (avoiding repeated implementation logic)

---

### PATTERN 14: Workflow Structure Template (Expanded)

**Current observation:** Beyond basic structure, prompts share markdown formatting conventions

**Proposed addition to Pattern 3:**
- Heading hierarchy standards
- Code block conventions (bash vs. markdown vs. json)
- Example formatting (good/bad examples pattern)
- Warning/note box formats
- List formatting (numbered vs. bullet)

**Lines saved:** Additional 100-150 lines in formatting consistency

---

### PATTERN 15: Recommended Usage Frequency

**Current state:** 4 prompts mention when to use them

**Examples:**
- Prompt 6: "Weekly, at milestones, before compilation/export"
- Prompt 8: "Weekly check-ins, after major changes"
- Prompt 9: Workflows for daily/weekly/milestones

**Proposed solution:**
- File: `12_Workflow_Patterns.md` (addition)
- Section: **Recommended Prompt Frequency**
  - **Daily:** Prompt 3 (content modifications)
  - **Weekly:** Prompts 6 (consistency), 8 (dashboard)
  - **As Needed:** Prompts 2 (add chapter), 4 (inbox), 7 (export), 10 (tracking sync)
  - **Milestones (25%, 50%, 75%, 100%):**
    - Prompt 6 (consistency)
    - Prompt 5 (compile)
    - Prompt 9 (tag version)
  - **At Initialization:** Prompt 1
  - **Maintenance:** Prompt 9 (git operations)

**Lines saved:** 20-30 lines (avoiding repetition across prompts)

---

## Implementation Phases

### Phase 0: Enforcement Rules Integration (CRITICAL - FIRST)
**Estimated effort:** 1-2 days

**MUST BE DONE FIRST - These are mandatory compliance rules**

1. **Add enforcement references to ALL 10 prompts:**
   - Add at top of each prompt:
     ```markdown
     **CRITICAL ENFORCEMENT:**
     - RULE 1: All file modifications MUST update corresponding _chg files
     - RULE 2: All Manuscript/ changes must go through appropriate prompts

     See: ENFORCEMENT_RULES.md for complete details
     ```

2. **Add _chg update steps to workflow sections:**
   - Prompts 1, 2, 3, 4, 10 explicitly document _chg updates
   - Prompts 5, 6, 7, 8, 9 explicitly state "No _chg updates (read-only/export)"
   - Include validation check before git commits

3. **Update system-instructions.md:**
   - Add CRITICAL ENFORCEMENT RULES section
   - Reference ENFORCEMENT_RULES.md
   - Include both Rule 1 and Rule 2 summaries

4. **Add routing validation:**
   - Each prompt includes check: "Is this the correct prompt for this operation?"
   - If user attempted direct modification outside prompts, redirect

5. **Test enforcement:**
   - Verify Rule 1: All file modifications update _chg files
   - Verify Rule 2: Direct modifications are rejected with routing guidance
   - Validate git commits include both content and _chg files

**Expected impact:**
- Zero tolerance for change tracking violations
- Consistent workflow routing
- Improved data integrity

**Deliverables:**
- All 10 prompts updated with enforcement notices
- system-instructions.md updated
- Validation procedures in place

---

### Phase 1: Foundation (High Priority)
**Estimated effort:** 2-3 days

1. Create `Process/_COMMON/` directory structure
2. Extract and document:
   - `01_Prompt_Structure_Template.md` (includes enforcement rule references)
   - `02_Desktop_Compatibility_Module.md`
   - `03_Anti_Hallucination_Protocols.md`
3. **NEW:** Create `14_Enforcement_Rules_Module.md`
   - Standardized enforcement notice templates
   - Routing response templates
   - Validation check procedures
4. Update Prompts 1-3 to use new modules
5. Test with real use cases
6. Validate no functionality lost
7. **VALIDATE:** Enforcement rules properly integrated

**Expected savings:** 400-500 lines

---

### Phase 2: Core Operations (High Priority)
**Estimated effort:** 3-4 days

1. Create and document:
   - `04_File_Operations_Library.md` (includes mandatory _chg update steps)
   - `05_Git_Integration_Module.md` (includes validation: both files in commit)
   - `06_Validation_Protocols.md` (includes enforcement rule validation)
2. Update Prompts 2, 3, 4, 9, 10 to use new modules
3. Test file operations and git workflows
4. Validate safety checks work
5. **VALIDATE:** _chg files always updated with content files

**Expected savings:** 500-600 lines

**CRITICAL:** File Operations Library MUST enforce Rule 1 (auto _chg updates)

---

### Phase 3: Content Management (Medium Priority)
**Estimated effort:** 2-3 days

1. Create and document:
   - `07_Quote_Management_System.md` (includes _chg update for Chapter_Quotes.md)
   - `08_Semantic_Versioning_Guide.md`
   - `10_Style_Consistency_Protocol.md`
2. Update Prompts 1, 2, 3, 5, 6, 8, 10
3. Test quote and version workflows
4. Validate style checking
5. **VALIDATE:** Quote updates tracked in Chapter_Quotes_chg.md

**Expected savings:** 300-400 lines

---

### Phase 4: Reporting & Interaction (Medium Priority)
**Estimated effort:** 2-3 days

1. Create and document:
   - `09_Report_Templates.md`
   - `11_Interactive_Patterns.md` (includes routing validation patterns)
   - `12_Workflow_Patterns.md` (includes enforcement in all workflows)
   - `13_PROJECT_CONTEXT_Protocol.md`
2. Update all 10 prompts for consistency
3. Test interactive flows
4. Validate reporting formats
5. **VALIDATE:** Routing responses redirect to correct prompts

**Expected savings:** 600-700 lines

---

### Phase 5: Documentation & Testing (Essential)
**Estimated effort:** 2-3 days

1. Create comprehensive `_COMMON/README.md` (includes enforcement rules section)
2. Document module inclusion syntax
3. Create module usage examples (with enforcement rule examples)
4. Test all 10 prompts end-to-end
5. **CRITICAL:** Test enforcement rules:
   - Attempt direct Manuscript/ modification → Should be rejected
   - Modify file without updating _chg → Should fail validation
   - Verify routing responses redirect properly
6. Update main framework documentation
7. Migration guide for existing projects
8. **NEW:** Create enforcement compliance test suite

**NEW DELIVERABLES:**
- Enforcement rules compliance test suite
- Validation checklist for each prompt
- Examples of correct/incorrect enforcement

---

## Total Estimated Effort

**Time:** 12-18 days (2.5-3.5 weeks)
- Phase 0 (Enforcement): 1-2 days
- Phase 1 (Foundation): 2-3 days
- Phase 2 (Core Ops): 3-4 days
- Phase 3 (Content): 2-3 days
- Phase 4 (Reporting): 2-3 days
- Phase 5 (Testing): 2-3 days

**Lines saved:** 1,800-2,200 lines (50-60% reduction in duplication)
**Prompts updated:** All 10 (with enforcement rules first)
**New modules created:** 14 (13 original + 1 enforcement module)
**Enforcement rules:** 2 critical rules integrated throughout

---

## Benefits

### Maintainability
- ✅ Single source of truth for common patterns
- ✅ Bug fixes propagate to all prompts automatically
- ✅ Consistency enforced by shared modules
- ✅ Easier to update when framework evolves
- ✅ **NEW:** Enforcement rules integrated throughout (no violations possible)

### User Experience
- ✅ More concise prompts (easier to read)
- ✅ Consistent behavior across all prompts
- ✅ Clearer separation of concerns
- ✅ Better documentation structure
- ✅ **NEW:** Reliable change tracking (no missing _chg entries)
- ✅ **NEW:** Clear workflow routing (always use correct prompt)

### Development Velocity
- ✅ Faster to create new prompts (use templates)
- ✅ Faster to fix bugs (fix once, apply everywhere)
- ✅ Easier to test (test modules independently)
- ✅ Clearer architecture
- ✅ **NEW:** Enforcement rules prevent common mistakes

### Code Quality
- ✅ DRY principle applied
- ✅ Modular design
- ✅ Separation of concerns
- ✅ Reusable components
- ✅ **NEW:** Zero tolerance for data integrity violations

### Data Integrity (NEW)
- ✅ **100% change tracking compliance** (Rule 1 enforced)
- ✅ **Consistent workflow routing** (Rule 2 enforced)
- ✅ **Audit trail preservation** (every change documented)
- ✅ **Rollback capability** (complete version history)
- ✅ **User confidence** (framework works as documented)

---

## Risks & Mitigation

### Risk 1: Breaking Existing Functionality
**Mitigation:**
- Comprehensive testing after each phase
- Maintain backward compatibility during transition
- Keep original prompts as backup until verified

### Risk 2: Increased Complexity (Indirection)
**Mitigation:**
- Clear documentation of module inclusion syntax
- Provide examples of module usage
- Create README with quick reference

### Risk 3: Module Interdependencies
**Mitigation:**
- Keep modules independent where possible
- Document dependencies clearly
- Use simple variable substitution, not complex logic

### Risk 4: Migration Burden for Users
**Mitigation:**
- This is framework-internal only (no user impact)
- Users still execute same prompts
- No migration needed for existing projects

### Risk 5: File Size Limitations in Claude Desktop
**Issue:**
- Prompt 5 (Compile) reads and combines all manuscript files into a single compiled draft
- Large manuscripts (50,000+ words) may exceed Claude Desktop + MCP Filesystem limits
- MCP Filesystem has performance degradation with very large file operations

**Mitigation:**
- **Document clearly:** Prompt 5 REQUIRES Claude Code CLI for large manuscripts
- Update Prompt 5 header to include:
  ```markdown
  **IMPORTANT:** For manuscripts over 30,000 words, use Claude Code CLI instead of Claude Desktop.
  Claude Desktop + MCP Filesystem may encounter performance issues or timeouts with large file operations.
  ```
- Add file size check to Prompt 5 workflow:
  1. Calculate total manuscript size before compilation
  2. If > 30,000 words, warn user to use Claude Code CLI
  3. If in Claude Desktop and large file detected, provide clear instructions to switch
- Update INSTALLATION.md to note Prompt 5 limitation
- Consider future optimization: Compile in chunks if in Claude Desktop

**Technical Details:**
- MCP Filesystem is optimized for typical file sizes (< 10,000 lines)
- Compiled manuscripts can be 50,000-100,000+ words (500-1000+ KB)
- Claude Desktop has context window considerations
- Claude Code CLI has better performance for large file operations

---

## Success Criteria

### Quantitative
- ✅ Reduce total prompt lines by 40-50% (from ~11,000 to ~6,000)
- ✅ Create 14 reusable modules (13 original + enforcement)
- ✅ All 10 prompts refactored and tested
- ✅ Zero functionality regressions
- ✅ **NEW:** 100% enforcement rule compliance across all prompts
- ✅ **NEW:** Zero _chg tracking violations in testing

### Qualitative
- ✅ Prompts are easier to read and understand
- ✅ Modules are well-documented with examples
- ✅ New contributors can understand architecture
- ✅ Future prompt creation is faster
- ✅ **NEW:** Users receive clear routing guidance when needed
- ✅ **NEW:** Change tracking is automatic and reliable

### Enforcement Compliance (NEW)
- ✅ **Rule 1:** Every file modification includes _chg update
- ✅ **Rule 2:** All Manuscript/ changes routed through prompts
- ✅ Validation tests pass for all 10 prompts
- ✅ Routing responses redirect correctly
- ✅ Git commits always include both content and _chg files

---

## Next Steps

1. **Review this analysis** with stakeholders
2. **Prioritize patterns** (if not all 15)
3. **CRITICAL:** **Execute Phase 0 FIRST** (enforcement rules integration)
   - Update all 10 prompts with enforcement notices
   - Update system-instructions.md
   - Create validation procedures
4. **Create Phase 1 modules** (foundation + enforcement module)
5. **Refactor Prompts 1-3** as proof of concept
6. **Validate approach** including enforcement compliance
7. **Continue with Phases 2-5** if successful

---

## Notes

- **Do NOT implement yet** - this is analysis and planning only
- Consider releasing as **v0.10.0** after completion (minor version bump)
- May want to create a **refactor branch** for development
- Keep original prompts in **archive/** during transition
- Add **REFACTOR_CHANGELOG.md** to track migration progress
- **CRITICAL:** Phase 0 (enforcement) MUST be completed first before other phases
- **IMPORTANT:** All phases must validate enforcement rule compliance
- **TECHNICAL LIMITATION:** Prompt 5 (Compile) requires Claude Code CLI for large manuscripts (30,000+ words)
  - Claude Desktop + MCP Filesystem cannot handle very large file operations efficiently
  - Update Prompt 5 documentation during refactoring to clearly state this requirement

---

## Related Documents

- **ENFORCEMENT_RULES.md** - Mandatory compliance rules (created 2025-11-19)
  - Rule 1: Automatic _chg file updates
  - Rule 2: Workflow routing through prompts
  - Must be integrated in Phase 0

---

**Delete or archive this file when refactoring is complete.**
**Created:** 2025-11-19
**Updated:** 2025-11-19 (added enforcement rules integration)
**Framework Version:** 0.9.2
**Target Version:** 0.10.0+
