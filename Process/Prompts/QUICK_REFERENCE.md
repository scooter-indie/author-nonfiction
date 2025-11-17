# Quick Reference Guide for Prompts

## When to Use Each Prompt

### Starting a New Book Project
→ **Prompt 1: Initialize Project Structure**
- Use: When starting a brand new book
- Template: `Templates/01_Initialize_Project_Template.md`

### Adding Content

#### Adding a New Chapter
→ **Prompt 2: Add New TOC Entry**
- Use: When you need to insert a new chapter
- Template: `Templates/02_Add_TOC_Entry_Template.md`

#### Processing Files from Inbox
→ **Prompt 4: Integrate Content from Inbox**
- Use: When you have TOC files, drafts, or references to import
- Standalone: `Standalone/04_Integrate_Inbox.md`

#### Editing Existing Content
→ **Prompt 3: Modify Target File**
- Use: When you need to revise a specific chapter or section
- Template: `Templates/03_Modify_File_Template.md`

### Quality Control

#### Check for Consistency Issues
→ **Prompt 6: Consistency Checker**
- Use: After major writing sessions or before compilation
- Standalone: `Standalone/06_Consistency_Check.md`
- Frequency: Weekly or at 25%, 50%, 75% milestones

#### Track Progress
→ **Prompt 8: Progress Dashboard**
- Use: To see overall project status
- Standalone: `Standalone/08_Progress_Dashboard.md`
- Frequency: Weekly or after major changes

### Compilation and Export

#### Create Full Draft
→ **Prompt 5: Compile Manuscript**
- Use: When you want to review the complete book
- Template: `Templates/05_Compile_Manuscript_Template.md`
- Frequency: Monthly or at major milestones

#### Export to Other Formats
→ **Prompt 7: Export and Format**
- Use: When preparing for submission or publication
- Template: `Templates/07_Export_Format_Template.md`
- Use after: Prompt 6 (consistency check) and final review

### Version Control

#### Git Operations
→ **Prompt 9: Git Operations**
- Use: For commits, tags, branches, history, push/pull
- Template: `Templates/09_Git_Operations_Template.md`
- Use frequently: After each work session or major change

## Common Workflows

### Daily Writing Workflow
1. **Prompt 9**: Check git status
2. Write/edit content in specific chapter
3. **Prompt 3**: Make targeted revisions if needed
4. **Prompt 9**: Commit changes

### Weekly Review Workflow
1. **Prompt 8**: Generate progress dashboard
2. **Prompt 6**: Run consistency check
3. **Prompt 5**: Compile manuscript for review
4. Fix identified issues using **Prompt 3**
5. **Prompt 9**: Commit and push changes

### Milestone Workflow (25%, 50%, 75%, 100%)
1. **Prompt 8**: Progress dashboard
2. **Prompt 6**: Full consistency check
3. **Prompt 5**: Compile complete manuscript
4. Review and revise using **Prompt 3**
5. **Prompt 9**: Create milestone tag (e.g., v1.0.0)
6. **Prompt 9**: Push to remote backup

### Integration Workflow (New Content)
1. Place content file(s) in `Inbox/`
2. **Prompt 4**: Integrate from Inbox
3. Follow AI recommendations or provide guidance
4. **Prompt 6**: Check consistency after integration
5. **Prompt 3**: Make adjustments if needed

### Publication Prep Workflow
1. **Prompt 8**: Verify 100% completion
2. **Prompt 6**: Final consistency check
3. Fix all issues using **Prompt 3**
4. **Prompt 5**: Compile final manuscript
5. **Prompt 7**: Export to required format(s)
6. **Prompt 9**: Tag as publication-ready

## Template vs. Standalone

### Use Templates When:
- You need to provide specific information (chapter titles, file paths, etc.)
- The prompt requires your decision on multiple options
- You want to save a customized version for reuse

### Use Standalone When:
- The prompt doesn't require custom input
- You want the AI to analyze and recommend options
- You're ready to interact with the AI during execution

## Tips

1. **Always check git status first** - Use Prompt 9 before major operations
2. **Reference the main process document** - All prompts link to detailed workflows
3. **Save customized templates** - Keep filled-in templates outside this directory for reuse
4. **Chain prompts logically** - Some workflows naturally combine prompts
5. **Use the Anti-Hallucination Guidelines** - All prompts reference this automatically

## File Naming Legend

- `01-09`: Prompt number
- `_Template`: Fillable version with [FILL IN] markers
- No suffix: Ready-to-use standalone version

## Need Help?

- Read: `Process/AI-Assisted_Nonfiction_Authoring_Process.md`
- Check: `Process/Anti-Hallucination_Guidelines.md`
- Review: This directory's `README.md`
