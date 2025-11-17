# Execute Prompt 3: Modify Target File

**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`

---

## What This Does

I will modify a content file based on instructions you've written in its corresponding `_chg.md` file. This is the **primary workflow for content revisions**.

---

## How This Works

### Your Workflow:

1. **Edit the _chg file**: Open the change tracking file for the content you want to modify (e.g., `Chapters/Chapter_03_Methods_chg.md`)

2. **Add instructions**: In the `[INSTRUCTIONS FOR THIS REVISION]` section, write what changes you want:
   ```markdown
   ### [INSTRUCTIONS FOR THIS REVISION]

   Rewrite the "Data Collection" section to:
   - Add example of survey design
   - Include reference to Johnson (2023) study
   - Clarify the sampling methodology
   ```

3. **Commit the _chg file**: Save and commit your instructions to git

4. **Execute this prompt**: Copy this file and paste into Claude Code

### My Workflow:

**Questions I'll ask:**

1. Which file should I modify? (e.g., `Chapters/Chapter_03_Methods.md`)
2. Should I analyze the content before making changes? (Yes/No)

**Then I'll:**

1. Read the corresponding `_chg.md` file
2. Extract instructions from `[INSTRUCTIONS FOR THIS REVISION]` section
3. Validate the target file exists and check current version
4. Check git status for uncommitted changes
5. Optionally analyze content for consistency issues (if you said yes)
6. Apply the specified modifications
7. **Auto-archive**: Move completed instructions to Version History with proper version increment
8. **Clear instructions section**: Leave it ready for your next revision
9. Update file metadata (word count, status, etc.)
10. Validate for broken cross-references and style consistency
11. Create git commit with descriptive message including version
12. Generate modification report

---

## Example _chg File Section

```markdown
## REWRITE INSTRUCTIONS

### [INSTRUCTIONS FOR THIS REVISION]

Update the introduction to:
- Lead with the surprising statistic about remote work adoption
- Add context about post-pandemic workplace changes
- Connect to the book's main thesis more explicitly
- Fix the transition to the first section

Priority: High
Rationale: Current intro is weak and doesn't hook the reader
```

After I execute, this becomes:

```markdown
## REWRITE INSTRUCTIONS

### [INSTRUCTIONS FOR THIS REVISION]

[Ready for next revision - add instructions above]
```

And the completed instructions are moved to Version History with version 1.X.0 or X.0.0 depending on scope.

---

## Important Notes

- **Single source of truth**: The _chg file contains your instructions
- **Auto-archive**: I automatically move completed instructions to Version History
- **Version increment**: I choose appropriate version number (Major.Minor.Patch)
- **Git commit**: I create a commit with the changes and version info

---

## Ready to Begin?

**Which file should I modify?** (Provide the path to the content file, e.g., `Chapters/Chapter_05_Analysis.md`)

---

*Reference: Process/AI-Assisted_Nonfiction_Authoring_Process.md (Prompt 3)*
