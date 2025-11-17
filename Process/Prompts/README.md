# Prompt Files for AI-Assisted Nonfiction Authoring

This directory contains ready-to-use prompt files for working with AI assistants on nonfiction book projects.

## Directory Structure

```
Prompts/
├── README.md (this file)
├── Standalone/          # Complete prompts, ready to copy/paste
└── Templates/           # Fillable templates with [FILL IN] markers
```

## How to Use

### Standalone Prompts
1. Navigate to `Standalone/`
2. Open the desired prompt file
3. Copy the entire content
4. Paste into Claude Code
5. The AI will execute the prompt as written

### Template Prompts
1. Navigate to `Templates/`
2. Open the desired template file
3. Search for `[FILL IN:` markers
4. Replace each marker with your specific information
5. Copy the completed prompt
6. Paste into Claude Code

## Available Prompts

### Core Workflow Prompts

1. **Prompt 1: Initialize Project Structure**
   - Standalone: `Standalone/01_Initialize_Project.md`
   - Template: `Templates/01_Initialize_Project_Template.md`
   - Purpose: Create initial project structure and TOC

2. **Prompt 2: Add New TOC Entry**
   - Standalone: `Standalone/02_Add_TOC_Entry.md`
   - Template: `Templates/02_Add_TOC_Entry_Template.md`
   - Purpose: Insert new chapter with automatic reorganization

3. **Prompt 3: Modify Target File**
   - Standalone: `Standalone/03_Modify_File.md`
   - Template: `Templates/03_Modify_File_Template.md`
   - Purpose: Apply specific revisions to a file

4. **Prompt 4: Integrate Content from Inbox**
   - Standalone: `Standalone/04_Integrate_Inbox.md`
   - Template: `Templates/04_Integrate_Inbox_Template.md`
   - Purpose: Process and integrate files from Inbox, including TOC files

5. **Prompt 5: Compile Manuscript**
   - Standalone: `Standalone/05_Compile_Manuscript.md`
   - Template: `Templates/05_Compile_Manuscript_Template.md`
   - Purpose: Generate single compiled document

6. **Prompt 6: Consistency Checker**
   - Standalone: `Standalone/06_Consistency_Check.md`
   - Template: `Templates/06_Consistency_Check_Template.md`
   - Purpose: Scan for consistency issues

7. **Prompt 7: Export and Format**
   - Standalone: `Standalone/07_Export_Format.md`
   - Template: `Templates/07_Export_Format_Template.md`
   - Purpose: Generate output in various formats

8. **Prompt 8: Progress Dashboard**
   - Standalone: `Standalone/08_Progress_Dashboard.md`
   - Template: `Templates/08_Progress_Dashboard_Template.md`
   - Purpose: Generate comprehensive status report

9. **Prompt 9: Git Operations**
   - Standalone: `Standalone/09_Git_Operations.md`
   - Template: `Templates/09_Git_Operations_Template.md`
   - Purpose: Perform git version control operations

## Tips for Best Results

1. **Always specify the working directory** in your prompts or ensure Claude Code is in the correct directory

2. **Reference the Anti-Hallucination Guidelines** - All prompts include this reference automatically

3. **Use templates for repeated tasks** - Fill in the template once, save your customized version elsewhere for reuse

4. **Chain prompts when needed** - Some workflows naturally combine multiple prompts (e.g., Prompt 4 → Prompt 3)

5. **Check git status before major operations** - Run Prompt 9 (Git Status) before running Prompts 2, 4, or 5

## Customization

Feel free to:
- Create your own prompt variations
- Combine prompts for common workflows
- Add project-specific details to templates
- Save customized versions outside this directory

## Anti-Hallucination Guidelines

All prompts automatically reference `Process/Anti-Hallucination_Guidelines.md` to ensure factual accuracy and proper handling of uncertainty during content generation.
