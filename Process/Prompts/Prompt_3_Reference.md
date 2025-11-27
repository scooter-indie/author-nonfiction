# Prompt 3 Reference Documentation

**Version:** 0.14.4
**Purpose:** Detailed examples, edge cases, and troubleshooting for Change by Chg workflow

---

## Overview

This reference provides detailed examples for the Change by Chg workflow. Load this file when you need:
- First time using Prompt 3
- Encountering edge cases
- Troubleshooting issues
- Understanding anti-hallucination verification in depth

**For core workflow:** See `Prompt_3_Change_by_Chg.md`

---

## Example _chg File Structure

```markdown
# Chapter 03: Methods - Change Tracking

## FILE INFORMATION

- **Content File:** `Chapter_03_Methods.md`
- **Current Version:** 1.2.0
- **Status:** Draft
- **Word Count:** 3,450

---

## REWRITE INSTRUCTIONS

### [INSTRUCTIONS FOR THIS REVISION]

Update the introduction to:
- Lead with the surprising statistic about remote work adoption
- Add context about post-pandemic workplace changes
- Connect to the book's main thesis more explicitly
- Fix the transition to the first section

Priority: High
Rationale: Current intro is weak and doesn't hook the reader

---

## VERSION HISTORY

### Version 1.2.0 (2025-11-20)
**Changes:**
- Expanded data collection methodology section
- Added three new subsections on qualitative methods
- Fixed cross-references to Chapter 2

### Version 1.1.0 (2025-11-18)
**Changes:**
- Initial draft of methodology framework
- Added section on mixed methods approach
```

---

## After Execution: Auto-Archive Result

```markdown
## REWRITE INSTRUCTIONS

### [INSTRUCTIONS FOR THIS REVISION]

[Ready for next revision - add instructions above]

---

## VERSION HISTORY

### Version 1.3.0 (2025-11-24)
**Changes:**
- Updated introduction with remote work statistics
- Added post-pandemic workplace context
- Strengthened connection to main thesis
- Improved transition to first section

**Previous instructions archived:**
> Update the introduction to:
> - Lead with the surprising statistic about remote work adoption
> - Add context about post-pandemic workplace changes
> - Connect to the book's main thesis more explicitly
> - Fix the transition to the first section

### Version 1.2.0 (2025-11-20)
...
```

---

## Anti-Hallucination Verification: Detailed Examples

### Example 1: Personal Story Verification

**Generated content:**
> "In my experience working with dozens of authors, I've noticed that version control is often their biggest challenge..."

**Claude asks:**
> This section includes a personal experience about working with authors. Is this:
> - A) Based on YOUR real experience? (I'll use it as written)
> - B) Should be a HYPOTHETICAL scenario? (I'll add 'Imagine...')
> - C) Should be GENERIC? (I'll use 'Many authors...' without specifics)

**User responds:** "B - make it hypothetical"

**Revised content:**
> "Imagine a consultant who works with multiple authors. They might notice that version control is often their clients' biggest challenge..."

---

### Example 2: Statistics Verification

**Generated content:**
> "Studies show that 73% of nonfiction authors struggle with maintaining consistent voice across chapters."

**Claude asks:**
> This includes the statistic: "73% of nonfiction authors struggle with voice consistency". Do you have:
> - A) A verified source I should cite?
> - B) Should I use a general statement instead? (e.g., 'Many authors...')
> - C) Should I mark it [CITATION NEEDED] for you to verify later?

**User responds:** "B - use general statement"

**Revised content:**
> "Many nonfiction authors find it challenging to maintain consistent voice across chapters."

---

### Example 3: Quote Verification

**Generated content:**
> As Anne Lamott wrote in Bird by Bird, "Almost all good writing begins with terrible first efforts."

**Claude asks:**
> This includes a quote from Anne Lamott. Do you have:
> - A) The verified source? (I'll mark it ✓ Verified)
> - B) Should I mark it ⏳ Pending for later verification?
> - C) Should I remove the quote entirely?

**User responds:** "A - it's from Bird by Bird, page 25"

**Result:**
> As Anne Lamott wrote in *Bird by Bird*, "Almost all good writing begins with terrible first efforts." ✓ Verified (Lamott, 1994, p. 25)

---

### Example 4: Specific Example Verification

**Generated content:**
> "Consider Sarah, a healthcare consultant who struggled with organizing her book on patient communication..."

**Claude asks:**
> This section includes a specific person named "Sarah, a healthcare consultant". Is this:
> - A) A REAL person you know? (I'll keep the specifics)
> - B) Should be HYPOTHETICAL? (I'll add "Imagine a consultant named Sarah...")
> - C) Should be ANONYMOUS? (I'll use "a healthcare consultant" without name)

**User responds:** "C - make it anonymous"

**Revised content:**
> "Consider a healthcare consultant who struggled with organizing her book on patient communication..."

---

## Content Labels Reference

### ✅ REAL EXPERIENCE
Use when user confirms content reflects their actual experience:
> "Based on my fifteen years as a software engineer and manager, I noticed that version control tools built for code don't translate well to prose..."

### ✅ HYPOTHETICAL SCENARIO
Use signal words like "Imagine," "Consider," "Suppose":
> "Imagine a healthcare consultant writing a book about patient communication. She might struggle with..."

### ✅ GENERIC STATEMENT
Use collective language without specific claims:
> "Many nonfiction authors face challenges with version control when collaborating with editors..."

### ✅ [CITATION NEEDED]
Use when stat/claim needs verification:
> "[CITATION NEEDED: Recent surveys suggest that approximately 60% of authors use Google Docs for manuscript version control]"

### ⏳ Pending Verification
Use for quotes awaiting source confirmation:
> ⏳ "The best preparation for tomorrow is doing your best today." — H. Jackson Brown Jr. (Source: TBD)

### ❌ NEVER USE (Fabricated)
These patterns should NEVER appear without verification:
- ~~"I've worked with dozens of authors who've told me..."~~
- ~~"Sarah, a healthcare consultant I know..."~~
- ~~"Studies show that 73% of writers..."~~
- ~~"In my experience helping authors..."~~

---

## Hierarchical Style Resolution: Detailed Examples

### Example 1: Section Override Active

**Content file contains:**
```markdown
The methodology follows standard practices...

<!-- STYLE_OVERRIDE: Technical Precision -->

## Technical Implementation Details

The API endpoints are structured as follows:
- GET /api/chapters - Returns chapter list
- POST /api/chapters - Creates new chapter
...

<!-- END_STYLE_OVERRIDE -->

The results demonstrate that...
```

**Style resolution:**
```
Active Style: Technical Precision (section override)
Source: Inline marker in content
Scope: Lines 5-15 only
Outside scope: Falls back to chapter or book style
```

---

### Example 2: Chapter Override Active

**Directory structure:**
```
Manuscript/Chapters/Chapter_05/
├── Chapter_05_Technical.md
├── Chapter_05_Technical_chg.md
└── Chapter_05_style.md          ← Chapter override
```

**Chapter_05_style.md contents:**
```markdown
# Chapter 5 Style Override

**Override Style:** Technical Precision
**Rationale:** This chapter covers API implementation details
**Book Style:** Conversational Expert (overridden for this chapter)
```

**Style resolution:**
```
Active Style: Technical Precision (chapter override)
Source: Manuscript/Chapters/Chapter_05/Chapter_05_style.md
Inheritance: Overrides book-level Conversational Expert
```

---

### Example 3: Book-Level Default (No Overrides)

**No section markers in content, no Chapter_XX_style.md file**

**Style resolution:**
```
Active Style: Conversational Expert (book-level default)
Source: Manuscript/Style/Style_Guide.md
Inheritance: No overrides active
```

---

## Style Issue Handling Examples

### Minor Issue (Note in Report)

**Issue:** Paragraph slightly exceeds recommended length
```
Style Check: Minor issue noted
- Paragraph on lines 45-52: 180 words (style suggests max 150)
- Action: Noted in report (no changes required)
```

### Moderate Issue (Ask User)

**Issue:** Person consistency violation
```
Style Check: Moderate issue found

Found 3 instances of first person ("I", "my") in content configured for third-person style.

Lines affected: 23, 45, 67

Options:
1. Fix automatically (convert to third person)
2. Leave as-is (intentional variation)
3. Review each instance

Choose option (1-3):
```

### Significant Drift (Highlight and Suggest)

**Issue:** Major style deviation
```
Style Check: Significant style drift detected

This section uses highly technical jargon without explanation:
- "API endpoint orchestration" (line 34)
- "microservice architecture" (line 41)
- "containerized deployment" (line 52)

Your Conversational Expert style emphasizes accessibility and explaining technical terms.

Suggestions:
1. Add brief explanations for each term
2. Use analogies to clarify concepts
3. Consider adding a glossary reference

Would you like me to apply these suggestions?
```

---

## Edge Cases and Troubleshooting

### Edge Case 1: Empty Instructions Section

**Scenario:** User runs Prompt 3 but `[INSTRUCTIONS FOR THIS REVISION]` is empty

**Response:**
```
The instructions section is empty. Please add your revision instructions to:

Manuscript/Chapters/Chapter_03/Chapter_03_Methods_chg.md

In the section marked:
### [INSTRUCTIONS FOR THIS REVISION]

Then run this prompt again.
```

---

### Edge Case 2: Content File Doesn't Exist

**Scenario:** User provides path to non-existent file

**Response:**
```
File not found: Manuscript/Chapters/Chapter_08/Chapter_08_Analysis.md

Possible issues:
1. Chapter hasn't been created yet (use Prompt 2 to add chapter)
2. Path is incorrect (check spelling and directory structure)
3. File was moved or renamed

Available chapters:
- Chapter_01_Introduction.md
- Chapter_02_Background.md
- Chapter_03_Methods.md
...
```

---

### Edge Case 3: Uncommitted Changes in Git

**Scenario:** Working directory has uncommitted changes

**Response:**
```
⚠️ Uncommitted changes detected in working directory

Files with changes:
- Manuscript/Chapters/Chapter_03/Chapter_03_Methods.md (modified)
- Manuscript/Chapters/Chapter_03/Chapter_03_Methods_chg.md (modified)

Options:
1. Commit current changes first, then proceed
2. Stash changes and proceed (can restore later)
3. Cancel and review changes manually

Choose option (1-3):
```

---

### Edge Case 4: Lock Conflict

**Scenario:** Another instance is editing the same chapter

**Response:**
```
⚠️ Chapter_03 is currently locked by another instance.

Lock details:
- Resource: Chapter_03
- Locked at: 2025-11-24T14:30:00Z (8 minutes ago)
- Instance: Desktop-45678

Another editing operation may be in progress.

Options:
1. Wait for lock to clear (checks every 5 seconds)
2. Cancel operation

Choose option (1-2):
```

---

### Edge Case 5: Style Guide Doesn't Exist

**Scenario:** No Style_Guide.md in project

**Response:**
```
No style guide found at Manuscript/Style/Style_Guide.md

Style consistency check will be skipped.

To enable style checking:
1. Run Prompt 1 (Initialize) to create style guide, OR
2. Create Manuscript/Style/Style_Guide.md manually
```

---

## Version Increment Guidelines

### Patch Increment (x.x.+1)
- Typo fixes
- Minor wording changes
- Formatting corrections
- Small clarifications

**Example:** 1.2.0 → 1.2.1

### Minor Increment (x.+1.0)
- New paragraphs or sections
- Significant rewrites
- Adding examples or explanations
- Structure changes within chapter

**Example:** 1.2.1 → 1.3.0

### Major Increment (+1.0.0)
- Complete chapter rewrite
- Fundamental approach change
- Breaking structural changes
- Major content pivot

**Example:** 1.3.0 → 2.0.0

---

## Module References

- **Lock Management:** Process/_COMMON/18_Lock_Management_Module.md
- **Anti-Hallucination:** Process/Anti-Hallucination_Guidelines.md
- **Semantic Versioning:** Process/_COMMON/08_Semantic_Versioning_Guide.md
- **Style System:** Process/_COMMON/10_Style_Consistency_Protocol.md
- **Git Integration:** Process/_COMMON/05_Git_Integration_Module.md

---

**Version:** 0.14.4
**For Core Workflow:** See `Prompt_3_Change_by_Chg.md`
