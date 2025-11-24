# Execute Prompt 3: Change by Chg

**Version:** 0.13.0
**DESKTOP-FRIENDLY:** Works in Claude Desktop with MCP Filesystem + single copy/paste git commit at end

**FIRST ACTION - MANDATORY:**
1. Read `Process/_COMMON/18_Lock_Management_Module.md`
2. Read `Process/Anti-Hallucination_Guidelines.md` in full before proceeding with ANY other actions or questions.

**CRITICAL ENFORCEMENT:**
- **RULE 1:** All file modifications MUST update corresponding _chg files
- **RULE 2:** All Manuscript/ changes must go through appropriate prompts

See: `Process/ENFORCEMENT_RULES.md` for complete details

**AGENT INSTRUCTIONS:**
When spawning agents (using Task tool), include in agent prompt:
- "FIRST ACTION: Read Process/Anti-Hallucination_Guidelines.md before proceeding."

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

### Step 0: Lock Management

**Initialize Lock System:**

1. Check if `.locks/` directory exists
   - If not: Create `.locks/` directory using bash: `mkdir -p .locks`
   - **CRITICAL:** Use `mkdir -p` (bash/sh command), NOT Windows CMD syntax (`if not exist`)


2. Check if `.locks/locks.json` exists
   - If not: Create with empty structure:
     ```json
     {
       "locks": []
     }
     ```

**Generate Instance ID:**

Create unique instance identifier for this session:
- Format: `CLI-[5-digit-random]` or `Desktop-[5-digit-random]`
- Example: `CLI-12345`, `Desktop-67890`
- Reuse same ID for all locks in this session

**Determine Required Resources:**

Identify which chapter(s) will be modified by reading the _chg file path provided by user.
- Example: `Chapter_03_chg.md` → Resource: `Chapter_03`

**Acquire Lock for Chapter:**

Resources needed for this prompt: `Chapter_XX` (for each chapter being modified)

1. Read `.locks/locks.json`

2. Check if `Chapter_XX` is locked:
   - Search `locks` array for entry where `"resource": "Chapter_XX"`

3. **If lock exists:**
   - Calculate age: `current_time - lock.timestamp`

   - **If age < 15 minutes:**
     ```
     ⚠️ Chapter_XX is currently locked by another instance.

     Lock details:
     - Resource: Chapter_XX
     - Locked at: [timestamp] ([X] minutes ago)
     - Instance: [instance]

     Another editing operation may be in progress on this chapter.

     Options:
     1. Wait for lock to clear (checks every 5 seconds)
     2. Cancel operation

     Choose option (1-2):
     ```

   - **If age >= 15 minutes:**
     ```
     ⚠️ Chapter_XX has a stale lock (older than 15 minutes).

     Lock details:
     - Resource: Chapter_XX
     - Locked at: [timestamp] ([X] minutes ago)
     - Instance: [instance]

     This lock may be from a crashed instance.

     Options:
     1. Override stale lock and continue
     2. Cancel operation

     Choose option (1-2):
     ```

4. **If user chooses to wait (Option 1):**
   - Poll every 5 seconds
   - Re-check `.locks/locks.json`
   - If lock cleared: Proceed to acquire
   - If timeout (2 minutes): Ask to cancel or override

5. **If user cancels:**
   - Exit prompt without changes

6. **If no lock OR override approved:**
   - Add lock entry:
     ```json
     {
       "resource": "Chapter_XX",
       "timestamp": "[ISO-8601-timestamp]",
       "instance": "[instance_id]"
     }
     ```
   - Write updated JSON to `.locks/locks.json`
   - Proceed with modifications

---

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
7. **Anti-Hallucination Verification** (CRITICAL - see below):
   - If content includes examples, anecdotes, or personal stories → ASK for real experience vs hypothetical
   - If content includes statistics or data → REQUEST source or use placeholders
   - If content includes quotes → REQUEST source or mark ⏳ Pending verification
   - Show examples with clear labels before finalizing
8. **Hierarchical style consistency check** (v0.10.1+): Resolve and apply active style (see below)
   - Check for section override markers in content
   - Check for chapter override file (Chapter_XX_style.md)
   - Fall back to book-level (Style_Guide.md)
   - Report active style source
   - Verify changes align with active style
9. **Auto-archive**: Move completed instructions to Version History with proper version increment
10. **Clear instructions section**: Leave it ready for your next revision
11. Update file metadata (word count, status, etc.)
12. Validate for broken cross-references
13. **Refresh PROJECT_CONTEXT.md**: Update if significant changes (new chapters, major version bump, or user requests)
14. Create git commit with descriptive message including version
15. Generate modification report

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

## Anti-Hallucination Verification (CRITICAL)

**This step prevents fabricated content from entering your book.**

### When This Step Triggers

I will pause and verify with you if the generated content contains:
- **Personal stories or anecdotes** (e.g., "I've worked with authors who...", "In my experience...")
- **Specific examples** (e.g., named people, companies, case studies)
- **Statistics or percentages** (e.g., "47% of authors...", "Studies show...")
- **Direct quotes** (e.g., attributed to named individuals)
- **Claims about observations** (e.g., "I hear that...", "Authors tell me...")

### What I'll Ask You

**For examples/anecdotes:**
> "This section includes [description of example]. Is this:
> - A) Based on YOUR real experience? (I'll use it as written)
> - B) Should be a HYPOTHETICAL scenario? (I'll add 'Imagine...' or 'Consider...')
> - C) Should be GENERIC? (I'll use 'Many authors...' without specifics)"

**For statistics/data:**
> "This includes the statistic: '[statistic]'. Do you have:
> - A) A verified source I should cite?
> - B) Should I use a general statement instead? (e.g., 'Many...' or 'Research suggests...')
> - C) Should I mark it [CITATION NEEDED] for you to verify later?"

**For quotes:**
> "This includes a quote from '[person]'. Do you have:
> - A) The verified source? (I'll mark it ✓ Verified)
> - B) Should I mark it ⏳ Pending for later verification?
> - C) Should I remove the quote entirely?"

### Content Labels I'll Use

Before finalizing content, I'll show you examples with clear labels:

✅ **REAL EXPERIENCE:**
> "Based on my experience as a software engineer and manager, I noticed that version control tools built for code don't translate well to prose..."

✅ **HYPOTHETICAL SCENARIO:**
> "Imagine a healthcare consultant writing a book about patient communication. She might struggle with..."

✅ **GENERIC STATEMENT:**
> "Many nonfiction authors face challenges with version control when collaborating with editors..."

✅ **CITATION NEEDED:**
> "[CITATION NEEDED: Recent surveys suggest that approximately 60% of authors use Google Docs for manuscript version control]"

✅ **PENDING VERIFICATION:**
> ⏳ "The best preparation for tomorrow is doing your best today." — H. Jackson Brown Jr. (Source: TBD)

❌ **NEVER FABRICATED:**
> ~~"I've worked with dozens of authors who've told me..."~~ (Unless this is YOUR true experience)
> ~~"Sarah, a healthcare consultant I know..."~~ (Unless Sarah is a real person you know)
> ~~"Studies show that 73% of writers..."~~ (Unless you provide the study)

### Your Options

When I ask for verification, you can:

1. **Confirm it's real**: "Yes, that's my actual experience"
2. **Request changes**: "Make it hypothetical instead"
3. **Provide source**: "The source is [book/article/URL]"
4. **Mark for later**: "Mark it for citation later"
5. **Remove it**: "Skip that example entirely"

### Why This Matters

**From your recent experience:**
- Version 1.1.0: AI created "Sarah" (fabricated person) ❌
- Version 1.2.0: AI claimed "frustrations I hear" (fabricated data) ❌
- Version 1.3.0: AI used YOUR real background (authentic) ✅

This verification step prevents those hallucinations by **asking you first** instead of assuming.

---

## Hierarchical Style Consistency Check (v0.10.1+)

**After applying your modifications, I'll resolve the active style using the hierarchical system and verify alignment.**

### Step 1: Resolve Active Style

I'll determine which style applies to the modified content using cascading inheritance:

1. **Check for section-level override**:
   - Scan content for `<!-- STYLE_OVERRIDE: StyleName -->` markers
   - If modification is within override markers → use that style

2. **Check for chapter-level override**:
   - Look for `Chapter_XX_style.md` in the chapter directory
   - If exists → use chapter override style

3. **Fall back to book-level style**:
   - Load `Manuscript/Style/Style_Guide.md`
   - Use book-level default style

**I'll report which style is active and why:**
```
Active Style: Technical Precision (chapter override)
Source: Manuscript/Chapters/Chapter_05/Chapter_05_style.md
Inheritance: Chapter override (not using book-level Conversational Expert)
```

### Step 2: Load Active Style Configuration

From the resolved style source, I'll extract:
- Style name and characteristics
- DO/DON'T guidelines
- Voice, tone, and pacing parameters

### Step 3: Analyze Modified Content

Using the active style configuration, I'll check:

1. **Content analysis:**
   - **Person consistency**: First/second/third person usage
   - **Formality level**: Matches configured formality
   - **Paragraph length**: Checks against style guidelines (if specified)
   - **Sentence complexity**: Simple vs. complex based on style
   - **Terminology**: Technical terms explained when style requires it
   - **Passive voice**: Flags excessive use if style discourages it

2. **Compare against DO/DON'T lists**
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

## Git Commit Format (For Claude Desktop Users)

When providing the git commit command at the end, format it like this:

**For Claude Desktop users, provide:**

Go to Claude Code CLI and say:
```
Run: git add [file-path] [file-path]_chg.md && git commit -m '[Description] v[version]

[Details of changes made]

🤖 Generated with Claude Desktop

Co-Authored-By: Claude <noreply@anthropic.com>'
```

**The instruction "Go to Claude Code CLI and say:" must be OUTSIDE the code block.**
**Only the command starting with "Run:" should be inside the code block.**

---

## Release Locks

**CRITICAL:** Release locks even if operation fails or errors occur.

**Release acquired lock:**

1. Read `.locks/locks.json`

2. Remove lock entry:
   - Filter `locks` array to remove where `"resource": "Chapter_XX"` AND `"instance": "[your_instance_id]"`

3. Write updated JSON to `.locks/locks.json`

**Confirmation:**
```
✓ Lock released: Chapter_XX
```

---

## Lock Management Notes

**Concurrency Support (v0.13.0+):**
- This prompt locks `Chapter_XX` to prevent concurrent edits
- Lock is held from Step 0 through completion
- Lock is released even if modification fails
- Stale locks (>15 minutes) can be overridden
- See `Process/_COMMON/18_Lock_Management_Module.md` for complete details

---

## Ready to Begin?

**Which file should I modify?** (Provide the path to the content file, e.g., `Manuscript/Chapters/Chapter_05/Chapter_05_Analysis.md`)

---

**Version:** 0.13.0
**Last Updated:** 2025-11-23

*Reference: Process/AI-Assisted_Nonfiction_Authoring_Process.md (Prompt 3)*

---

## Session Cleanup

**After this prompt completes:**

Tell user: "✓ Prompt 3 Change by Chg complete.

To free up tokens for your next task, you can say:
**'Clear Prompt 3 Change by Chg from context'**

This will reclaim tokens for your next operation."
