# AI-Assisted Nonfiction Book Authoring Process

**Version:** 3.0.0
**Last Updated:** 2025-11-17
**Purpose:** A comprehensive, systematic approach to authoring nonfiction books with AI assistance using Git version control

---

## Table of Contents

1. [Overview](#overview)
2. [Directory Structure](#directory-structure)
3. [File Naming Conventions](#file-naming-conventions)
4. [Change Tracking System](#change-tracking-system)
5. [Core Prompts](#core-prompts)
6. [Workflow States](#workflow-states)
7. [Quality Control](#quality-control)
8. [Backup and Safety](#backup-and-safety)
9. [Getting Started](#getting-started)

---

## Overview

This process provides a structured framework for creating nonfiction books using AI assistance. All content is maintained in Markdown format for maximum portability and version control compatibility.

### Key Principles

- **Modularity**: Each chapter and section is a separate file
- **Traceability**: All changes are tracked with rationale
- **Flexibility**: Easy reorganization and restructuring
- **Quality**: Built-in validation and consistency checking
- **Safety**: Git version control with commits before major operations

### File Format

All content files are in Markdown (`.md`) format with accompanying change tracking files (`_chg.md`).

---

## Directory Structure

```
[working-title]/
├── README.md                          # Project overview and current status
├── Project_Config.md                  # Project settings and metadata
├── Project_Metadata.md                # Book details, audience, goals
├── USAGE_GUIDE.md                     # Step-by-step instructions
├── .gitignore                         # Git configuration (if using version control)
│
├── TOC/
│   ├── TOC.md                         # Table of contents
│   └── TOC_chg.md                     # TOC change tracking
│
├── FrontMatter/
│   ├── Title_Page.md
│   ├── Title_Page_chg.md
│   ├── Dedication.md
│   ├── Dedication_chg.md
│   ├── Acknowledgments.md
│   ├── Acknowledgments_chg.md
│   ├── Foreword.md
│   ├── Foreword_chg.md
│   ├── Preface.md
│   └── Preface_chg.md
│
├── Chapters/
│   ├── README.md                      # Chapter guidelines
│   ├── Chapter_01_[Title-Slug].md
│   ├── Chapter_01_[Title-Slug]_chg.md
│   ├── Chapter_02_[Title-Slug].md
│   ├── Chapter_02_[Title-Slug]_chg.md
│   └── ... (through Chapter_NN)
│
├── BackMatter/
│   ├── Appendix_A.md
│   ├── Appendix_A_chg.md
│   ├── Glossary.md
│   ├── Glossary_chg.md
│   ├── Bibliography.md
│   ├── Bibliography_chg.md
│   ├── Index.md
│   └── Index_chg.md
│
├── Assets/
│   ├── Images/
│   ├── Diagrams/
│   ├── Tables/
│   └── Charts/
│
├── Research/
│   ├── Sources/
│   ├── Notes/
│   └── References/
│
├── Inbox/
│   └── (New content awaiting integration)
│
└── Drafts/
    ├── Full_Draft_[YYYY-MM-DD].md
    └── (Compiled manuscript versions)
```

---

## File Naming Conventions

### Chapters

**Format:** `Chapter_[NN]_[Title-Slug].md`

- **NN**: Zero-padded chapter number (01-99)
- **Title-Slug**: Kebab-case chapter title (lowercase, hyphens)

**Examples:**
- `Chapter_01_Introduction-to-the-Topic.md`
- `Chapter_12_Advanced-Techniques.md`

### Change Files

**Format:** `[Original-Filename]_chg.md`

**Examples:**
- `Chapter_01_Introduction-to-the-Topic_chg.md`
- `TOC_chg.md`

### Draft Compilations

**Format:** `Full_Draft_[YYYY-MM-DD]_v[N.M.P].md`

**Examples:**
- `Full_Draft_2025-11-17_v1.0.0.md`
- `Full_Draft_2025-12-01_v1.2.5.md`

---

## Change Tracking System

### Version Numbering: N.M.P (Semantic Versioning)

- **Major (N)**: Structural changes affecting multiple chapters or TOC reorganization
- **Minor (M)**: Significant content revisions within a single chapter
- **Patch (P)**: Minor edits, typos, formatting corrections, copy edits

**Examples:**
- `1.0.0` → `2.0.0`: Added three new chapters and reorganized Part II
- `1.3.0` → `1.4.0`: Rewrote Chapter 5 with new examples
- `1.4.2` → `1.4.3`: Fixed typos in Chapter 5

### Change File Template

```markdown
# Change Tracking: [Target Filename]

**Document Version:** N.M.P  
**Target File:** [e.g., Chapter_01_Introduction.md]  
**Last Modified:** [YYYY-MM-DD HH:MM:SS]  
**Current Word Count:** [count] (Delta: +/- [change])  
**Status:** [Draft | Review | Revised | Final]

---

## Version History (Most Recent First)

### Version N.M.P - [YYYY-MM-DD] - [Brief Description]

**Type:** [Content Addition | Content Revision | Reorganization | Correction | Style Edit]  
**Scope:** [Full Chapter | Section X | Paragraph Y-Z | Specific Element]  
**Priority:** [Critical | High | Medium | Low]  
**Rationale:** [Why this change was made]

**Changes Made:**
- [Specific change 1]
- [Specific change 2]
- [Specific change 3]

**Impact on Other Files:**
- [None | List affected files and required updates]

**Review Notes:**
- [Any concerns or items needing attention]

---

### Version N.M.P-1 - [YYYY-MM-DD] - [Brief Description]

[Previous version details...]

---

## Pending Revisions

### Revision ID: [REV-001]

**Priority:** [High | Medium | Low]  
**Proposed Change:** [Description of proposed revision]  
**Proposed By:** [Author | Editor | AI Suggestion | Reviewer Name]  
**Date Proposed:** [YYYY-MM-DD]  
**Status:** [Proposed | Approved | Rejected | In Progress | Implemented]  
**Target Completion:** [YYYY-MM-DD]

**Details:**
[More detailed description if needed]

**Dependencies:**
[Any other changes that must happen first or simultaneously]

---

## Style Guide References

[Link to style guide sections relevant to this document]

---

## Cross-References

**This file references:**
- [List of other chapters/sections referenced]

**This file is referenced by:**
- [List of other chapters/sections that reference this file]

---

## REWRITE INSTRUCTIONS

[CRITICAL: Keep all content in the target file unchanged, except as instructed below in the [INSTRUCTIONS FOR THIS REVISION] block. Each update to this file must be recorded in the Version History above with proper version increment.]

### [INSTRUCTIONS FOR THIS REVISION]

[Instructions will be added here as needed for each revision]

---

**[KEEP THIS INSTRUCTION IN EVERY CHANGE FILE]**

Always maintain the Version History section and add new [INSTRUCTIONS FOR THIS REVISION] blocks as needed. Archive completed instructions by moving them to the Version History.
```

---

## Core Prompts

### Prompt 1: Initialize Project Structure

**Purpose:** Create the initial project structure, table of contents, and placeholder files.

**Input Requirements:**
- Working title
- Number of chapters (estimated)
- Chapter topics/titles
- Target word count (total and per chapter)
- Target audience
- Book purpose/thesis

**Process:**

1. **Gather Information:**
   ```
   - Working Title: [title]
   - Author Name: [name]
   - Target Total Word Count: [count]
   - Estimated Chapters: [number]
   - Target Audience: [description]
   - Book Purpose: [thesis/goal]
   - Completion Target: [date]
   ```

2. **Check Inbox for Existing TOC:**
   - Scan `Inbox/` directory for TOC files
   - Look for files with names containing: "toc", "table-of-contents", "contents", "outline"
   - If found, analyze and parse the TOC structure
   - Support multiple formats:
     - Simple numbered/bulleted markdown lists
     - Structured chapter listings
     - Outline formats with sections and subsections
   - Extract chapter titles, order, and any additional metadata

3. **Interactive TOC Decision (if TOC found in Inbox):**
   - Display parsed TOC structure to user
   - Present options:
     - **Use Inbox TOC**: Create project structure from this TOC
     - **Modify Inbox TOC**: Allow edits before proceeding
     - **Ignore Inbox TOC**: Proceed with manual chapter input
   - If using Inbox TOC:
     - Validate structure (logical flow, numbering, completeness)
     - Identify any gaps or issues
     - Suggest improvements if needed
     - Get user confirmation before proceeding

4. **Create Directory Structure:**
   - Generate all directories as specified in [Directory Structure](#directory-structure)
   - Create placeholder README files

5. **Initialize Git Repository (if not already initialized):**
   - Check if `.git` directory exists
   - If not, run `git init`
   - Create `.gitignore` file with appropriate exclusions
   - Make initial commit with message: "Initial project structure"

6. **Generate Configuration Files:**
   - `Project_Config.md` with project settings
   - `Project_Metadata.md` with book details
   - `USAGE_GUIDE.md` with instructions
   - Git commit: "Add configuration files"

7. **Create Table of Contents:**
   - `TOC/TOC.md` with chapter listing (from Inbox TOC or manual input)
   - `TOC/TOC_chg.md` for tracking
   - If using Inbox TOC, archive original file to `Inbox/Processed_[date]/`
   - Git commit: "Create initial table of contents"

8. **Generate Chapter Placeholders:**
   - Create `Chapter_[NN]_[Title-Slug].md` for each chapter
   - Create corresponding `_chg.md` files
   - Initialize each with basic structure:
     ```markdown
     # Chapter [N]: [Title]
     
     **Status:** Draft  
     **Target Word Count:** [count]  
     **Current Word Count:** 0
     
     ## Key Points to Cover
     - [Point 1]
     - [Point 2]
     
     ## Section 1: [Title]
     
     [Content placeholder]
     
     ## Section 2: [Title]
     
     [Content placeholder]
     ```

9. **Create Front Matter Placeholders:**
   - Generate files in `FrontMatter/` directory
   - Initialize with basic structure
   - Git commit: "Add front matter placeholders"

10. **Create Back Matter Placeholders:**
    - Generate files in `BackMatter/` directory
    - Initialize Bibliography with citation format notes
    - Git commit: "Add back matter placeholders"

11. **Final Setup:**
    - Tag initial version: `git tag v1.0.0`
    - Generate project summary report

**Output:**
- Complete directory structure
- All placeholder files with change tracking files
- Configuration files
- Initialized git repository with initial commits
- Confirmation report with file listing

---

### Prompt 2: Add New TOC Entry

**Purpose:** Insert a new chapter or section into the existing structure with automatic reorganization.

**Input Requirements:**
- New chapter/section title
- Desired position (chapter number or "after Chapter X")
- Estimated word count
- Key topics to cover
- Rationale for addition

**Process:**

1. **Pre-Operation Git Commit:**
   - Ensure all current changes are committed
   - Create commit: "Pre-reorganization state before adding [chapter title]"
   - Optionally create branch for major reorganizations

2. **Validate Insertion Point:**
   - Verify position makes logical sense
   - Check for flow disruption
   - Suggest alternative positions if needed

3. **Impact Analysis:**
   - Identify all files requiring updates
   - Calculate renumbering requirements
   - Assess cross-reference impacts

4. **Update TOC:**
   - Modify `TOC/TOC.md` with new entry
   - Update version in `TOC/TOC_chg.md`
   - Document rationale
   - Git commit: "Update TOC with new chapter entry"

5. **Reorganize Files:**
   - Rename affected chapter files (increment numbers)
   - Update both `.md` and `_chg.md` files
   - Maintain chronological sequence
   - Git stage all renames

6. **Create New Chapter Files:**
   - Generate `Chapter_[NN]_[Title-Slug].md`
   - Generate `Chapter_[NN]_[Title-Slug]_chg.md`
   - Initialize with structure template
   - Git add new files

7. **Update Cross-References:**
   - Scan all files for chapter references
   - Update chapter numbers in cross-references
   - Flag any ambiguous references for manual review
   - Git commit updated cross-references

8. **Update Configuration:**
   - Increment major version (N.0.0)
   - Update metadata with new chapter count
   - Update total target word count
   - Git commit: "Update configuration for new chapter"

9. **Final Commit and Tag:**
   - Create commit: "Add Chapter [NN]: [Title]"
   - Tag if major milestone: `git tag v[N.0.0]`

10. **Generate Impact Report:**
    - List all modified files
    - Show before/after structure
    - Note any manual review items
    - Git log summary

**Output:**
- Reorganized chapter files with updated numbering
- New chapter placeholder files
- Updated TOC
- Impact report
- Git history with clear commit trail

---

### Prompt 3: Modify Target File

**Purpose:** Apply specific revisions to a target file with proper change tracking.

**Input Requirements:**
- Target file path
- Modification instructions (specific changes to make)
- Rationale for changes
- Priority level

**Process:**

1. **Validate Target:**
   - Confirm file exists
   - Check current version number
   - Review pending revisions
   - Check git status for uncommitted changes

2. **Pre-Modification State:**
   - If significant changes, commit current state first
   - Or create a feature branch for experimental edits

3. **Analysis Mode (Optional):**
   - Review content for potential issues
   - Check consistency with other chapters
   - Flag style deviations
   - Suggest improvements

4. **Apply Modifications:**
   - Make specified changes to target `.md` file
   - Maintain formatting consistency
   - Preserve cross-references

5. **Update Change File:**
   - Increment version appropriately
   - Add entry to Version History
   - Document all changes made
   - Note rationale
   - Update word count

6. **Validation:**
   - Check for broken cross-references
   - Verify heading hierarchy
   - Confirm style consistency
   - Run spell check (if available)

7. **Git Commit:**
   - Stage modified files
   - Create commit with descriptive message
   - Include version change in commit message
   - Example: "Update Chapter 05 v1.4.0: Revise examples section"

8. **Generate Modification Report:**
   - Summary of changes
   - Before/after word count
   - Any warnings or concerns
   - Git diff summary

**Output:**
- Modified target file
- Updated change tracking file
- Modification report
- Git commit record

---

### Prompt 4: Integrate New Content from Inbox

**Purpose:** Process files in the Inbox directory and integrate them into the appropriate locations.

**Input Requirements:**
- File(s) in `Inbox/` directory
- User guidance on destination (optional)
- Integration preferences

**Process:**

1. **Scan Inbox:**
   - List all files in `Inbox/`
   - Analyze content of each file
   - Identify file types:
     - **TOC/Outline files** (priority handling)
     - Regular content files
     - Reference materials
     - Assets (images, diagrams, etc.)

2. **Special Handling for TOC Files:**

   **If TOC/Outline file detected:**
   - Parse content flexibly, supporting formats:
     - Simple numbered lists (1. Chapter Title, 2. Chapter Title)
     - Bulleted lists with hierarchy
     - Markdown headers as structure
     - Outline formats with nested items
     - Informal note formats with chapter ideas

   - **Extract structure:**
     - Chapter titles/topics
     - Subsection information (if present)
     - Ordering/numbering
     - Any notes or descriptions

   - **Present to User:**
     - Display parsed structure
     - Offer options:
       - **Merge with existing TOC**: Integrate new chapters into current structure
       - **Replace existing TOC**: Complete reorganization
       - **Create parallel outline**: Save as alternative structure in Research/
       - **Ignore**: Skip TOC processing

   - **If User selects Merge:**
     - Show current TOC alongside new TOC
     - Identify conflicts, duplicates, gaps
     - Suggest merge strategy (where new chapters fit)
     - Allow user to adjust positions
     - Execute merge using Prompt 2 workflow for each new chapter

   - **If User selects Replace:**
     - Backup existing TOC structure to Research/Archived_TOC_[date]/
     - Identify chapters to keep, rename, or remove
     - Generate reorganization plan
     - Execute complete restructure
     - Update all cross-references

   - **Git commits during TOC processing:**
     - "Pre-TOC update state"
     - "Update TOC structure from Inbox"
     - "Reorganize chapters for new TOC"
     - "Update cross-references for new structure"

3. **Regular Content Analysis:**
   - Present file summaries to user
   - Suggest appropriate integration points:
     - New chapter
     - Addition to existing chapter
     - Appendix material
     - Bibliography entries
     - Research/reference material

4. **User Decision:**
   - Confirm destination
   - Specify integration method:
     - Replace section
     - Insert at position
     - Append to chapter
     - Merge with existing content

5. **Pre-Integration Git State:**
   - Commit any uncommitted changes first
   - Create commit: "Pre-integration state before processing Inbox"

6. **Integration Options:**

   **Option A: New Chapter**
   - Use Prompt 2 workflow
   - Create new chapter from content

   **Option B: Insert into Existing Chapter**
   - Use Prompt 3 workflow
   - Merge content at specified position

   **Option C: Update Front/Back Matter**
   - Apply to appropriate section
   - Update change tracking

   **Option D: Move to Research**
   - Relocate to appropriate Research subfolder
   - Update research index

7. **Update References:**
   - Add bibliography entries if needed
   - Update cross-references
   - Link to assets if applicable

8. **Version Control:**
   - Update appropriate change tracking files
   - Increment versions
   - Document integration
   - Git commit: "Integrate [filename] from Inbox"

9. **Clean Inbox:**
   - Archive processed file with timestamp
   - Move to `Inbox/Processed_[date]/`
   - Keep Inbox/ clean for new content

10. **Generate Integration Report:**
    - Summary of actions taken
    - Updated file locations
    - Required follow-up actions
    - Git log of changes

**Output:**
- Integrated content in target location(s)
- Updated change tracking
- Archived inbox file
- Integration report
- Git commit history of integration

---

### Prompt 5: Compile Complete Manuscript

**Purpose:** Generate a single Markdown file from all current content, including placeholders.

**Input Requirements:**
- Version number for compiled draft
- Include placeholders? (yes/no)
- Include change tracking notes? (yes/no)
- Format options (basic/formatted/publication-ready)

**Process:**

1. **Validation Check:**
   - Verify all chapter files exist
   - Check for missing cross-references
   - Identify incomplete sections

2. **Assembly Order:**
   - Front Matter (in order)
   - Table of Contents (generated fresh)
   - Chapters (in numerical order)
   - Back Matter (in order)

3. **Content Processing:**
   - Read each file in sequence
   - Strip change tracking metadata
   - Process cross-references
   - Insert page break markers
   - Handle asset references

4. **Table of Contents Generation:**
   - Auto-generate TOC from headings
   - Include page number placeholders
   - Link to sections (if digital)

5. **Placeholder Handling:**
   ```markdown
   [PLACEHOLDER: Content pending - Target word count: XXX]
   ```

6. **Statistics Generation:**
   - Total word count
   - Completed vs. placeholder ratio
   - Chapter-by-chapter breakdown
   - Target vs. actual analysis

7. **Formatting Options:**

   **Basic:**
   - Simple concatenation
   - Minimal formatting
   
   **Formatted:**
   - Proper heading hierarchy
   - Page break markers
   - Consistent spacing
   
   **Publication-Ready:**
   - Full formatting
   - Bibliography formatted
   - Asset placeholders with captions
   - Index references

8. **Metadata Header:**
   ```markdown
   # [Working Title]
   
   **Author:** [Name]  
   **Version:** [N.M.P]  
   **Compiled:** [YYYY-MM-DD HH:MM:SS]  
   **Total Word Count:** [count]  
   **Completion:** [percentage]%  
   **Status:** [Draft/Review/Final]
   ```

9. **Save Compiled Draft:**
   - Filename: `Full_Draft_[date]_v[version].md`
   - Save to `Drafts/` directory

10. **Generate Report:**
    - Compilation statistics
    - Missing content warnings
    - Consistency issues
    - Recommended next steps

**Output:**
- Single compiled Markdown file
- Statistics report
- Issue/warning log

---

### Prompt 6: Consistency Checker

**Purpose:** Scan all content for consistency issues and potential problems.

**Input Requirements:**
- Scope (all chapters, specific chapters, or specific elements)
- Check types (terminology, cross-references, style, facts)

**Process:**

1. **Terminology Consistency:**
   - Build terminology index
   - Flag variations (e.g., "email" vs. "e-mail")
   - Check capitalization consistency
   - Identify acronym usage

2. **Cross-Reference Validation:**
   - List all internal references
   - Verify target exists
   - Check for broken links
   - Flag ambiguous references

3. **Style Consistency:**
   - Heading hierarchy
   - List formatting
   - Quote style
   - Number formatting
   - Date formatting

4. **Fact Consistency:**
   - Track claims made across chapters
   - Flag contradictions
   - Note statistics used multiple times
   - Verify consistent citations

5. **Tone/Voice Analysis:**
   - Assess formality level consistency
   - Check person perspective (1st, 2nd, 3rd)
   - Note tense consistency
   - Identify outlier sections

6. **Generate Report:**
   ```markdown
   # Consistency Check Report
   
   **Date:** [YYYY-MM-DD]
   **Scope:** [description]
   
   ## Critical Issues
   - [Issue with location and description]
   
   ## Warnings
   - [Warning with location and description]
   
   ## Suggestions
   - [Improvement suggestion]
   
   ## Terminology Index
   - [Term]: Used [N] times across [chapters]
     - Variations found: [list]
   ```

**Output:**
- Comprehensive consistency report
- Prioritized issue list
- Suggested corrections

---

### Prompt 7: Export and Format

**Purpose:** Generate output files in various formats from the source Markdown.

**Input Requirements:**
- Target format(s): Markdown, DOCX, PDF, EPUB, LaTeX
- Formatting preferences
- Include elements (cover, TOC, index, etc.)

**Process:**

1. **Pre-Export Validation:**
   - Run consistency checker
   - Verify all cross-references
   - Check for placeholder content
   - Validate asset references

2. **Compile Source:**
   - Use Prompt 5 to generate single Markdown
   - Apply formatting rules

3. **Format-Specific Processing:**

   **Markdown Export:**
   - Clean compilation
   - Format for GitHub/GitLab/Static site
   - Include metadata frontmatter
   
   **DOCX Export:**
   - Prepare for Pandoc conversion
   - Style mapping
   - Handle images and tables
   
   **PDF Export:**
   - LaTeX intermediate format
   - Page layout configuration
   - Typography settings
   
   **EPUB Export:**
   - Structure for e-readers
   - Metadata for book stores
   - Navigation structure

4. **Bibliography Formatting:**
   - APA, MLA, Chicago, or specified style
   - Alphabetical ordering
   - Proper citation format

5. **Asset Handling:**
   - Copy images to export package
   - Convert formats if needed
   - Optimize for target medium

6. **Generate Export Package:**
   - Main document file(s)
   - Assets folder
   - README with export info
   - Style files if applicable

**Output:**
- Formatted document(s) in requested format(s)
- Asset package
- Export report

---

### Prompt 8: Progress Dashboard

**Purpose:** Generate a comprehensive status report of the project.

**Input Requirements:**
- Report type (summary/detailed)
- Focus areas (optional)

**Process:**

1. **Scan All Files:**
   - Read metadata from all content files
   - Parse change tracking files
   - Collect statistics

2. **Calculate Metrics:**
   - Total word count
   - Words per chapter
   - Completion percentage
   - Target vs. actual comparison
   - Version numbers

3. **Status Analysis:**
   - Files by status (Draft/Review/Revised/Final)
   - Pending revisions count
   - Recent activity from git log (last 7-30 days)
   - Git repository statistics (commits, branches, tags)

4. **Generate Dashboard:**
   ```markdown
   # Project Progress Dashboard
   
   **Project:** [Working Title]  
   **Generated:** [YYYY-MM-DD HH:MM:SS]  
   **Overall Completion:** [XX]%
   
   ## Summary Statistics
   
   - **Total Word Count:** [current] / [target] ([XX]%)
   - **Chapters Complete:** [N] / [total]
   - **Front Matter:** [status]
   - **Back Matter:** [status]
   
   ## Chapter Status
   
   | Chapter | Title | Status | Words | Target | % |
   |---------|-------|--------|-------|--------|---|
   | 01 | [title] | Draft | [N] | [N] | XX% |
   | 02 | [title] | Review | [N] | [N] | XX% |
   
   ## Recent Activity (From Git Log)

   - [Date]: [Commit message]
   - [Date]: [Commit message]

   ## Git Status

   - **Current Branch:** [branch name]
   - **Commits:** [N] total
   - **Latest Tag:** [tag]
   - **Uncommitted Changes:** [Yes/No]
   
   ## Pending Revisions
   
   - **High Priority:** [N] items
   - **Medium Priority:** [N] items
   - **Low Priority:** [N] items
   
   ## Milestones
   
   - [ ] First Draft Complete
   - [ ] Structural Edit Complete
   - [ ] Copy Edit Complete
   - [ ] Final Proofread Complete
   
   ## Recommended Next Steps
   
   1. [Action item]
   2. [Action item]
   
   ## Issues Requiring Attention
   
   - [Issue description]
   ```

**Output:**
- Comprehensive progress report
- Visual progress indicators
- Actionable next steps

---

### Prompt 9: Git Operations

**Purpose:** Manually perform git version control operations on the project.

**Input Requirements:**
- Operation type (commit, tag, branch, log, status, push, pull)
- Additional parameters specific to operation
- Optional commit message or tag name

**Process:**

**Operation: Commit Current Changes**

1. **Review Uncommitted Changes:**
   - Run `git status` to show modified files
   - Run `git diff` to show detailed changes
   - Present summary to user

2. **Interactive Staging:**
   - Ask user which files to include
   - Allow selective staging
   - Option to commit all changes

3. **Commit Message:**
   - Prompt user for commit message
   - Suggest message based on changed files
   - Follow format: "[Action]: [Brief description]"
   - Examples:
     - "Update: Chapter 03 v1.5.0 - Add examples"
     - "Edit: Fix typos in Chapters 01-03"
     - "Reorganize: Move Chapter 07 to Chapter 05"

4. **Execute Commit:**
   - Stage selected files
   - Create commit with message
   - Display commit hash and summary

**Operation: Create Tag**

1. **Tag Information:**
   - Tag name (e.g., v1.0.0, first-draft)
   - Optional annotation message
   - Target commit (default: current HEAD)

2. **Execute Tag:**
   - Create tag: `git tag -a <tagname> -m "<message>"`
   - Confirm creation
   - List all tags

**Operation: Branch Management**

1. **Branch Operations:**
   - Create new branch
   - Switch to existing branch
   - List all branches
   - Merge branch into current
   - Delete branch

2. **For New Branch:**
   - Branch name (e.g., draft-chapter-12, restructure-part-2)
   - Create and optionally switch to new branch

3. **For Merge:**
   - Identify source and target branches
   - Check for conflicts
   - Execute merge
   - Handle conflicts if present

**Operation: View History**

1. **Display Options:**
   - Last N commits (default: 10)
   - Commits for specific file
   - Commits by date range
   - Commits with diffs

2. **Format Output:**
   - One-line summary: `git log --oneline -N`
   - Detailed: `git log -N`
   - With changes: `git log -p -N`
   - File-specific: `git log -- path/to/file`

**Operation: Push to Remote**

1. **Remote Check:**
   - Verify remote repository configured
   - Check branch tracking
   - Identify unpushed commits

2. **Push:**
   - Push current branch: `git push`
   - Push with tags: `git push --tags`
   - Push new branch: `git push -u origin <branch>`

**Operation: Pull from Remote**

1. **Pre-Pull Check:**
   - Warn if uncommitted changes exist
   - Suggest stashing or committing first

2. **Pull:**
   - Fetch and merge: `git pull`
   - Handle merge conflicts if any

**Operation: Status Report**

1. **Collect Information:**
   - Current branch
   - Uncommitted changes
   - Unpushed commits
   - Recent commits (last 5)
   - Tags
   - Remote status

2. **Generate Report:**
   ```markdown
   # Git Repository Status

   **Branch:** main
   **Uncommitted Changes:** 3 files modified
   **Unpushed Commits:** 2

   ## Recent Commits
   - [hash] Update Chapter 05 v1.3.0
   - [hash] Add Appendix B
   - [hash] Fix cross-references

   ## Tags
   - v1.0.0 (initial structure)
   - first-draft (complete draft)

   ## Remote
   - URL: [repository URL]
   - Status: Up to date / 2 commits ahead
   ```

**Output:**
- Operation result
- Status confirmation
- Relevant git output
- Next recommended steps

---

## Workflow States

Each content file progresses through defined states:

### 1. **Draft**
- Initial content creation
- Rough organization
- Placeholder sections allowed
- Focus: Getting ideas down

### 2. **Review**
- Content complete (no major placeholders)
- Ready for structural assessment
- May have minor gaps
- Focus: Big picture structure

### 3. **Revised**
- Structural changes implemented
- Content refined
- Ready for copy editing
- Focus: Polish and clarity

### 4. **Final**
- All edits complete
- Proofread and approved
- No further changes expected
- Focus: Publication ready

### State Transitions

Track state changes in the change file:

```markdown
### Version 1.5.0 - 2025-11-17 - Status Change: Draft → Review

**Type:** Status Change  
**Rationale:** All major sections complete, ready for structural review
```

---

## Quality Control

### Automated Checks

1. **File Integrity:**
   - All expected files exist
   - No orphaned change tracking files
   - Proper file naming

2. **Cross-Reference Validation:**
   - All internal links valid
   - Chapter references correct
   - Asset references valid

3. **Consistency:**
   - Use Prompt 6 regularly
   - Term usage
   - Style adherence

4. **Completeness:**
   - Word count targets
   - All placeholders addressed
   - Required sections present

### Manual Review Checkpoints

1. **After Initial TOC (Milestone 1):**
   - Structure makes sense
   - Logical flow
   - Appropriate scope

2. **At 25% Completion (Milestone 2):**
   - Writing style established
   - Tone consistent
   - Early chapters strong

3. **At 50% Completion (Milestone 3):**
   - Structure still working
   - May need reorganization
   - Bibliography growing

4. **At 75% Completion (Milestone 4):**
   - All chapters drafted
   - Consistency check
   - Cross-reference audit

5. **First Complete Draft (Milestone 5):**
   - Full manuscript review
   - Structural edit
   - Major revisions identified

6. **Pre-Final (Milestone 6):**
   - Copy edit complete
   - Proofreading
   - Final consistency check

---

## Backup and Safety

### Git Version Control (Required)

All projects must use Git for version control. This replaces the previous snapshot system and provides superior tracking, branching, and rollback capabilities.

### Git Workflow Best Practices

**Commit before major operations:**
- TOC reorganization
- Chapter addition/deletion
- Major content modifications
- Bulk operations
- Starting experimental edits

**Commit strategy:**
- Commit frequently (after each logical change)
- Use descriptive commit messages
- Include version numbers in messages when updating change files
- Tag major milestones (v1.0.0, v2.0.0, etc.)

**Example commit messages:**
- "Update Chapter 03 v1.5.0: Add case study examples"
- "Reorganize TOC: Move Chapter 07 to Chapter 05"
- "Add Chapter 12: Future Trends"
- "Copy edit: Chapters 01-05"

### Repository Setup

1. **Initialize Repository:**
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   ```

2. **.gitignore Template:**
   ```
   # Temporary files
   *.tmp
   *.bak
   ~*
   
   # Editor files
   .vscode/
   .idea/
   *.swp
   
   # OS files
   .DS_Store
   Thumbs.db
   
   # Build artifacts
   build/
   dist/
   
   # Optional: Compiled drafts (if too large)
   # Drafts/Full_Draft_*.md
   ```

3. **Branching Strategy:**
   - `main`: Stable, reviewed content
   - `draft-[chapter-name]`: Experimental chapter drafts
   - `restructure`: Major reorganization work
   - Merge branches when content is reviewed and stable

4. **Tagging Strategy:**
   - Tag major milestones: `v1.0.0`, `v2.0.0`
   - Tag completed drafts: `first-draft`, `revised-draft`, `final-draft`
   - Tag submission versions: `submission-v1`, `submission-v2`

5. **Useful Git Commands:**
   ```bash
   # View recent activity
   git log --oneline -10

   # See what changed in a specific commit
   git show <commit-hash>

   # Restore a file from a previous commit
   git checkout <commit-hash> -- path/to/file

   # Create a branch for experimental work
   git checkout -b experiment-chapter-reorg

   # View uncommitted changes
   git diff

   # View changes in a specific file over time
   git log -p -- path/to/file
   ```

### Remote Backup (Highly Recommended)

1. **GitHub/GitLab/Bitbucket:**
   - Create private repository
   - Push regularly: `git push origin main`
   - Provides cloud backup and access from multiple devices
   - Enable issues for tracking revision tasks

2. **Additional Backups:**
   - Weekly: Export to cloud storage (Dropbox, Google Drive, etc.)
   - Monthly: Archive entire project folder to external drive
   - Before major milestones: Create ZIP archive of entire project

---

## Getting Started

### Quick Start Guide

1. **Prepare Your Concept:**
   - Working title
   - Core thesis/purpose
   - Target audience
   - Estimated chapter list
   - Target word count

2. **Run Prompt 1: Initialize Project**
   - Provide required information
   - Review generated structure
   - Customize as needed

3. **Review Generated Files:**
   - Check `Project_Config.md`
   - Review `TOC/TOC.md`
   - Examine chapter placeholders

4. **Start Writing:**
   - Choose a chapter to begin
   - Update status in change file
   - Write content in chapter file
   - Track changes in change file

5. **Regular Maintenance:**
   - Run Prompt 8 weekly (Progress Dashboard)
   - Run Prompt 6 at milestones (Consistency Checker)
   - Commit changes frequently with descriptive messages
   - Push to remote repository regularly

6. **Compile and Review:**
   - Use Prompt 5 periodically
   - Review compiled manuscript
   - Identify issues and gaps

### Best Practices

1. **Change Tracking:**
   - Update change files immediately
   - Be specific about rationale
   - Track even small changes

2. **Version Numbers:**
   - Increment appropriately
   - Document in change file
   - Update Project_Config.md

3. **Cross-References:**
   - Use consistent format: `(see Chapter X)`
   - Update when reorganizing
   - Validate regularly

4. **Assets:**
   - Store in Assets/ directory
   - Use descriptive filenames
   - Reference with relative paths

5. **Bibliography:**
   - Add sources as you use them
   - Use consistent citation format
   - Keep separate notes in Research/

6. **Backups:**
   - Use Git for all version control
   - Push to remote repository regularly
   - Maintain additional backups to cloud storage
   - Archive complete project at major milestones

---

## Troubleshooting

### Common Issues

**Problem:** Chapter numbers out of sync  
**Solution:** Use Prompt 2 to reorganize, or manually rename with proper sequencing

**Problem:** Broken cross-references after reorganization  
**Solution:** Run Prompt 6 with cross-reference check, then use Prompt 3 to fix

**Problem:** Inconsistent terminology  
**Solution:** Run Prompt 6, create style guide, use find-replace carefully

**Problem:** Lost changes or want to undo recent edits
**Solution:** Use `git log` to find the commit, then `git checkout <commit-hash> -- <file>` to restore, or `git revert <commit-hash>` to undo a commit

**Problem:** Placeholder content in final draft  
**Solution:** Run Prompt 8 to identify, then use Prompt 3 to complete sections

---

## Additional Resources

### Recommended Tools

- **Markdown Editors:** Typora, Obsidian, VS Code with Markdown extensions
- **Version Control:** Git (required) with GitHub/GitLab/Bitbucket (recommended)
- **Conversion:** Pandoc for format conversion
- **Bibliography:** Zotero, Mendeley
- **Writing:** Grammarly, ProWritingAid (for final polish)

### Style Guides

Include links to relevant style guides in `Project_Config.md`:
- Chicago Manual of Style
- AP Style
- MLA Style
- APA Style
- Custom organizational style guide

---

## Appendix: Configuration File Templates

### Project_Config.md Template

```markdown
# Project Configuration

**Project Name:** [Working Title]  
**Author:** [Author Name]  
**Version:** 1.0.0  
**Created:** [YYYY-MM-DD]  
**Last Updated:** [YYYY-MM-DD]

## Project Settings

- **Working Title:** [title]
- **Target Total Word Count:** [number]
- **Target Completion Date:** [YYYY-MM-DD]
- **Primary Format:** Markdown
- **Export Formats:** [list]

## Structure Settings

- **Chapter Prefix:** Chapter_
- **Zero Padding:** 2 (01-99)
- **Chapter Title Format:** Kebab-case
- **Change File Suffix:** _chg

## Versioning

- **Current Version:** 1.0.0
- **Versioning Scheme:** Semantic (Major.Minor.Patch)
- **Change Tracking:** Enabled

## Style Guide

- **Citation Style:** [APA/MLA/Chicago/Other]
- **Heading Style:** [ATX/Setext]
- **List Style:** [Dash/Asterisk]
- **Emphasis:** [Asterisk/Underscore]

## Backup Settings

- **Auto-Snapshot:** Before major operations
- **Snapshot Retention:** Last 10
- **Git Integration:** [Yes/No]

## Custom Settings

[Add any project-specific settings]
```

### Project_Metadata.md Template

```markdown
# Project Metadata

## Book Information

**Working Title:** [title]  
**Subtitle:** [subtitle]  
**Author:** [name]  
**Genre:** [nonfiction category]  
**Target Publication Date:** [YYYY-MM-DD]

## Target Audience

**Primary Audience:** [description]  
**Secondary Audience:** [description]  
**Assumed Knowledge Level:** [beginner/intermediate/advanced]

## Book Purpose

**Main Thesis:** [2-3 sentence summary]

**Key Objectives:**
- [Objective 1]
- [Objective 2]
- [Objective 3]

**Unique Value Proposition:** [What makes this book different/necessary]

## Scope

**Topics Included:**
- [Topic 1]
- [Topic 2]

**Topics Explicitly Excluded:**
- [Topic 1]
- [Topic 2]

## Target Specifications

**Total Word Count Target:** [number]  
**Estimated Page Count:** [number] (based on [words per page])  
**Number of Chapters:** [number]  
**Average Words per Chapter:** [number]

## Tone and Style

**Voice:** [First/Second/Third person]  
**Tone:** [Formal/Conversational/Academic/etc.]  
**Style Notes:** [Any specific stylistic choices]

## Market Positioning

**Comparable Titles:**
- [Title 1] by [Author]
- [Title 2] by [Author]

**Competitive Advantages:**
- [Advantage 1]
- [Advantage 2]

## Timeline

**Start Date:** [YYYY-MM-DD]  
**First Draft Target:** [YYYY-MM-DD]  
**Revision Completion:** [YYYY-MM-DD]  
**Final Manuscript:** [YYYY-MM-DD]

## Notes

[Any additional notes about the project]
```

---

## Version History

### Version 3.0.0 - 2025-11-17
- **BREAKING CHANGE:** Replaced snapshot system with Git version control (required)
- Added Prompt 9: Git Operations for manual version control
- Extended Prompt 1: Initialize to check /Inbox for existing TOC files
- Extended Prompt 4: Integrate from Inbox with special TOC handling and flexible parsing
- Updated all prompts (1-8) to use git commits instead of snapshots
- Removed Snapshots/ directory from structure
- Added comprehensive git workflow best practices
- Added branching and tagging strategies
- Updated backup procedures to emphasize remote repositories
- Enhanced Progress Dashboard (Prompt 8) with git log integration

### Version 2.0.0 - 2025-11-17
- Complete rewrite of authoring process
- Enhanced directory structure
- Improved change tracking system
- Added 8 core prompts
- Added workflow states
- Added quality control measures
- Added backup and safety procedures
- Added configuration templates

---

## License and Usage

This process document is designed to be cloned and customized for individual book projects. Modify as needed to suit your specific requirements.

---

**End of Document**
