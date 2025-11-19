# Execute Prompt 3: Modify Target File

**DESKTOP-FRIENDLY:** Works in Claude Desktop with MCP Filesystem + single copy/paste git commit at end

**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`

---

## What This Does

I will modify a content file based on instructions you've written in its corresponding `_chg.md` file. This is the **primary workflow for content revisions**.

**Claude Desktop Compatibility:**
- ✅ All file operations via MCP Filesystem connector
- ✅ Single git commit command provided as copy/paste at end
- ✅ No bash commands required
- 📋 Works 95% in Desktop

---

## How This Works

### Your Workflow:

1. **Edit the _chg file**: Open the change tracking file for the content you want to modify (e.g., `Manuscript/Chapters/Chapter_03/Chapter_03_Methods_chg.md`)

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

1. Which file should I modify? (e.g., `Manuscript/Chapters/Chapter_03/Chapter_03_Methods.md`)
2. Should I analyze the content before making changes? (Yes/No)

**Then I'll:**

1. Read the corresponding `_chg.md` file
2. Extract instructions from `[INSTRUCTIONS FOR THIS REVISION]` section
3. Validate the target file exists and check current version
4. Check git status for uncommitted changes
5. Optionally analyze content for consistency issues (if you said yes)
6. Apply the specified modifications
7. **Style consistency check**: Verify changes align with Manuscript/Style/Style_Guide.md (see below)
8. **Auto-archive**: Move completed instructions to Version History with proper version increment
9. **Clear instructions section**: Leave it ready for your next revision
10. Update file metadata (word count, status, etc.)
11. Validate for broken cross-references
12. **Refresh PROJECT_CONTEXT.md**: Update if significant changes (new chapters, major version bump, or user requests)
13. Create git commit with descriptive message including version
14. Generate modification report

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

## Style Consistency Check

**After applying your modifications, I'll verify style alignment with your configured writing style.**

### What I Check

If `Manuscript/Style/Style_Guide.md` exists in your project, I'll automatically:

1. **Load your active style configuration**
   - Read selected style from Style_Guide.md
   - Extract DO/DON'T guidelines
   - Note voice, tone, and pacing parameters

2. **Analyze modified/added content for:**
   - **Person consistency**: First/second/third person usage
   - **Formality level**: Matches configured formality
   - **Paragraph length**: Checks against style guidelines (if specified)
   - **Sentence complexity**: Simple vs. complex based on style
   - **Terminology**: Technical terms explained when style requires it
   - **Passive voice**: Flags excessive use if style discourages it

3. **Compare against DO/DON'T lists**
   - Check for violations of style DON'Ts
   - Verify adherence to style DOs

### What Happens If Issues Found

**Minor inconsistencies:**
- I'll note them in the modification report
- Example: "Paragraph on lines 45-52 is 180 words (style suggests max 150)"

**Moderate issues:**
- I'll flag them and ask if you want corrections
- Example: "Found 3 instances of first person in a third-person style section"
- **You choose:** "Fix automatically" or "Leave as-is (intentional variation)"

**Significant drift:**
- I'll highlight major deviations
- Example: "This section uses highly technical jargon without explanation, but your style emphasizes accessibility"
- Offer specific revision suggestions

### Your Options

When style issues are detected:

**Option 1: Apply automatic corrections**
- I'll adjust the text to match your style guide
- Preserve your meaning and content
- Show you what was changed

**Option 2: Review manually**
- I'll show you the issues
- You fix them yourself
- Rerun if needed

**Option 3: Skip - Intentional variation**
- Mark as intentional in the report
- Useful when a specific section requires different style
- Document the exception

**Option 4: Update style guide**
- If the "violation" reflects your evolved preference
- Update Manuscript/Style/Style_Guide.md
- Continue with modification

### Style Check is Optional

- If no Manuscript/Style/Style_Guide.md exists, this step is skipped
- You can temporarily disable by saying "skip style check"
- Useful when experimenting with different voices for specific sections

---

## Important Notes

- **Single source of truth**: The _chg file contains your instructions
- **Auto-archive**: I automatically move completed instructions to Version History
- **Version increment**: I choose appropriate version number (Major.Minor.Patch)
- **Style consistency**: I check against Manuscript/Style/Style_Guide.md if it exists
- **Git commit**: I create a commit with the changes and version info

---

## Ready to Begin?

**Which file should I modify?** (Provide the path to the content file, e.g., `Manuscript/Chapters/Chapter_05/Chapter_05_Analysis.md`)

---

*Reference: Process/AI-Assisted_Nonfiction_Authoring_Process.md (Prompt 3)*
