# Workflow Patterns

**Framework Version:** 0.10.0
**Module:** Common Workflow Sequences
**Purpose:** Standardized workflow patterns across prompts

---

## Safety Commit Pattern

**Use before:** Major operations with file modifications

**Prompts:** 2, 4

```markdown
1. Check git status
2. If uncommitted changes → Warn user, recommend commit
3. Create safety commit:
   ```
   git add .
   git commit -m "Safety commit before {operation}"
   ```
4. Proceed with operation
5. Create commit of changes after operation
```

**Rationale:** Provides rollback point if operation fails or user wants to undo.

---

## Read-Modify-Archive Pattern

**Use for:** Content modifications with instruction tracking

**Prompts:** 3, 10

```markdown
1. Read _chg file instructions from [INSTRUCTIONS FOR THIS REVISION]
2. Validate instructions are non-empty
3. Apply modifications to content file
4. Update _chg file:
   - Create version entry in Version History
   - Include original instructions
   - List actual changes made
   - Increment version number
5. Archive completed instructions:
   - Move to Version History section
   - Clear [INSTRUCTIONS FOR THIS REVISION]
   - Add placeholder: "[Ready for next revision]"
6. Commit both files together
7. Generate report
```

---

## Validate-Update-Report Pattern

**Use for:** Analysis and reporting operations

**Prompts:** 5, 6, 8

```markdown
1. Validate all required files exist
2. Perform analysis/generation:
   - Read all relevant files
   - Process data
   - Calculate metrics
   - Generate outputs
3. Create reports/outputs
4. Optional: Update PROJECT_CONTEXT.md
5. Optional: Commit results
6. Display report to user
```

---

## Create-Initialize-Commit Pattern

**Use for:** Creating new content structures

**Prompts:** 1, 2

```markdown
1. Validate prerequisites (directory structure, etc.)
2. Create content file(s)
3. Create corresponding _chg file(s) with initial version entry:
   ```
   ### Version 1.0.0 - {DATE} - Initial creation
   ```
4. Update related files (TOC, Quotes, cross-references)
5. Update related _chg files
6. Validate all created successfully
7. Commit all files together with descriptive message
8. Generate confirmation report
```

---

## Scan-Process-Archive Pattern

**Use for:** Batch processing of files

**Prompts:** 4, 10

```markdown
1. Scan directory/repository for files to process
2. Analyze each file:
   - Determine type/category
   - Assess priority
   - Identify destination
3. For each file:
   - Process according to type
   - Update related files
   - Update _chg files
4. Archive/move processed files
5. Commit all changes
6. Generate summary report
```

---

## Interactive-Execute-Confirm Pattern

**Use for:** User-driven workflows

**Prompts:** 1, 2, 3, 4, 7, 9

```markdown
1. Ask questions (sequential or branching)
2. Collect all user input
3. Show summary of planned actions
4. Ask for confirmation
5. If confirmed:
   - Execute workflow
   - Report progress
   - Handle errors gracefully
6. Generate final report
7. Suggest next steps
```

---

## Pre-Check-Operate-Validate Pattern

**Use for:** Operations requiring validation

**Prompts:** 2, 3, 4

```markdown
1. Pre-operation checks:
   - File existence validation
   - Git status check
   - Structure validation
2. Perform operation
3. Post-operation validation:
   - Files created/modified successfully
   - _chg files updated
   - Cross-references valid
   - No broken links
4. If validation fails:
   - Rollback changes
   - Report error
   - Suggest fixes
5. If validation passes:
   - Commit
   - Report success
```

---

## Compile-Assemble-Export Pattern

**Use for:** Generating compiled/exported outputs

**Prompts:** 5, 7

```markdown
1. Gather all source files
2. Validate completeness
3. Assemble in correct order:
   - Front matter
   - Chapters (with epigraphs if verified)
   - Back matter
4. Apply formatting
5. Process special elements (citations, images, etc.)
6. Generate output file(s)
7. Validate output
8. Report statistics
9. Optional: Create git commit (if source files modified)
```

---

## Recursive Update Pattern

**Use for:** Cascading updates (renumbering, cross-references)

**Prompts:** 2, 4

```markdown
1. Identify all affected files
2. Build update map (old → new values)
3. For each affected file:
   - Read file
   - Apply updates
   - Validate changes
   - Update _chg file
4. Verify all references updated
5. Scan for any missed references
6. Commit all modified files together
7. Report changes
```

---

## Incremental Build Pattern

**Use for:** Building up complex structures

**Prompts:** 1, 8

```markdown
1. Create base structure
2. For each component:
   - Create files/directories
   - Initialize with templates
   - Add to parent structure
3. Link components together
4. Validate structure complete
5. Initialize configuration
6. Create initial git commit
7. Generate overview report
```

---

## Review-Fix-Recheck Pattern

**Use for:** Consistency checking and fixing

**Prompts:** 6

```markdown
1. Scan all content for issues
2. Categorize by severity:
   - Critical
   - Warning
   - Suggestion
3. Generate report
4. For each issue:
   - Show location
   - Explain problem
   - Suggest fix
5. User decides:
   - Fix automatically
   - Fix manually
   - Skip
   - Update rules
6. Apply fixes
7. Re-run checks to verify
8. Report final status
```

---

## Recommended Frequency Pattern

**Use for:** Guiding users on when to use prompts

| Frequency | Prompts | Operations |
|-----------|---------|------------|
| **Daily** | 3 | Content modifications during active writing |
| **Weekly** | 6, 8 | Consistency check, progress dashboard |
| **As Needed** | 2, 4, 7, 10 | Add chapter, integrate content, export, sync tracking |
| **Milestones** | 5, 6, 9 | Compile draft, consistency check, create tag |
| **Once** | 1 | Initialize project |
| **Maintenance** | 9, 10 | Git operations, tracking sync |

---

## Milestone Workflow Pattern

**Use for:** 25%, 50%, 75%, 100% completion points

```markdown
**Milestone Checklist:**

Before milestone:
1. Run Prompt 8 (Dashboard) → Verify progress percentage
2. Run Prompt 6 (Consistency) → Fix all critical issues
3. Run Prompt 10 (Tracking) → Ensure all _chg files synced

At milestone:
4. Run Prompt 5 (Compile) → Generate full draft
5. Review compiled draft
6. Run Prompt 9 (Git Tag) → Create version tag

After milestone:
7. Run Prompt 9 (Push) → Backup to remote
8. Plan next phase
9. Update PROJECT_CONTEXT.md
```

---

## Daily Writing Session Workflow

```markdown
**Start of session:**
1. Run Prompt 8 (Dashboard) → See current status
2. Identify target chapter(s)

**During session:**
3. Write instructions in _chg files
4. Run Prompt 3 (Modify) for each chapter
5. Review changes
6. Fix any issues

**End of session:**
7. Run Prompt 9 (Commit) → Commit day's work
8. Optional: Run Prompt 9 (Push) → Backup
9. Note progress for next session
```

---

## Weekly Review Workflow

```markdown
**Weekly review:**
1. Run Prompt 8 (Dashboard) → Overall status
2. Run Prompt 6 (Consistency) → Find issues
3. Fix critical issues using Prompt 3
4. Run Prompt 10 (Tracking) → Sync any manual edits
5. Run Prompt 5 (Compile) → Review full draft
6. Plan next week's writing goals
7. Run Prompt 9 (Commit and Push) → Backup
```

---

**Module Version:** 0.10.0
**Last Updated:** 2025-11-19
**Status:** Active
