# Style Consistency Protocol

**Framework Version:** 0.10.1
**Module:** Writing Style Validation
**Purpose:** Ensure consistency with configured writing style (hierarchical system)

---

## Overview

Validates content against the project's configured writing style using a hierarchical inheritance system. Used by Prompts 3, 6, and 11 to maintain consistent voice, tone, and approach across book, chapter, and section levels.

**Hierarchical Style System (v0.10.1+):**
```
Book Style (Global Default)
  ↓ inherits
Chapter Style (Optional Override)
  ↓ inherits
Section Style (Optional Override)
```

---

## What to Check

### 1. Person Consistency
- First person (I, we, my, our)
- Second person (you, your)
- Third person (he, she, they, the author)

**Verify:** Matches configured style preference

### 2. Formality Level
- Academic/scholarly language
- Professional/business language
- Conversational/casual language
- Technical/precise language

**Verify:** Matches configured style formality

### 3. Paragraph Length
- Short (2-4 sentences)
- Medium (5-8 sentences)
- Long (9+ sentences)

**Verify:** Matches configured preference (if specified)

### 4. Sentence Complexity
- Simple sentences
- Compound sentences
- Complex sentences with subordinate clauses

**Verify:** Matches configured complexity level

### 5. Technical Terminology
- Explained on first use
- Used without explanation (assumes expertise)
- Avoided in favor of plain language

**Verify:** Matches configured approach

### 6. Passive Voice
- Acceptable/preferred
- Limited use
- Avoided entirely

**Verify:** Matches configured preference

---

## Style Resolution Algorithm (Hierarchical)

**For any given content location, determine active style:**

### Step 1: Check for Section-Level Override

```markdown
1. Scan content for section override markers:
   <!-- STYLE_OVERRIDE: StyleName -->
   ...content...
   <!-- END_STYLE_OVERRIDE -->

2. If inside override markers:
   → Use specified section style
   → Skip to Step 4

3. If no section override:
   → Continue to Step 2
```

### Step 2: Check for Chapter-Level Override

```markdown
1. Check if `Chapter_XX_style.md` exists in chapter directory

2. If exists:
   → Load chapter style configuration
   → Use as active style
   → Skip to Step 4

3. If not exists:
   → Continue to Step 3
```

### Step 3: Use Book-Level Style (Default)

```markdown
1. Load `Manuscript/Style/Style_Guide.md`
2. Use book-level style as active style
3. Continue to Step 4
```

### Step 4: Apply Active Style

```markdown
1. Extract style characteristics (person, tone, formality, etc.)
2. Extract DO/DON'T lists
3. Perform consistency check against active style
4. Report findings
```

**Example Resolution:**

```
Location: Manuscript/Chapters/Chapter_05/Chapter_05.md, Line 150

Check 1: Section override?
  → Lines 145-230 marked with <!-- STYLE_OVERRIDE: Technical Precision -->
  → YES: Active Style = Technical Precision

Check 2: (Skipped - section override found)
Check 3: (Skipped - section override found)

Apply: Technical Precision style characteristics
```

---

## Checking Against DO/DON'T Lists

**Procedure:**

1. **Resolve active style** using hierarchical algorithm (above)
2. Extract DO list (preferred patterns) from active style
3. Extract DON'T list (patterns to avoid) from active style
4. Scan modified content
5. Flag violations
6. Report findings with style source (book/chapter/section)

**Example DO/DON'T:**

```markdown
DO:
- Use active voice
- Address reader as "you"
- Use concrete examples
- Keep paragraphs to 5-8 sentences
- Explain jargon on first use

DON'T:
- Use passive voice excessively
- Use "one" as pronoun
- Use academic jargon without explanation
- Write paragraphs longer than 10 sentences
- Assume reader knows technical terms
```

---

## Issue Severity Levels

### Minor
- Note in report, continue
- Doesn't block operation
- User can address later

**Examples:**
- Single passive voice instance in active voice style
- One long paragraph in short paragraph style
- Inconsistent hyphenation of compound word

### Moderate
- Flag and ask for correction preference
- Pause for user decision
- Offer quick fix

**Examples:**
- Multiple passive voice instances
- Paragraph significantly longer than style preference
- Technical term used without explanation

### Significant
- Highlight and offer specific revisions
- Must be addressed before continuing
- Violates core style principle

**Examples:**
- Wrong person throughout (first person in third person book)
- Formal academic tone in conversational book
- Multiple DON'T list violations

---

## Remediation Options

### Option 1: Automatic Corrections
- AI applies fixes preserving meaning
- Shows changes to user
- User approves/rejects

**Example:**
```
Found 3 passive voice instances. Convert to active?

Before: "The data was collected over six months."
After: "We collected the data over six months."

Apply? (Yes/No/Show all)
```

### Option 2: Manual Review
- Flag issues with locations
- User fixes manually
- Run check again after

**Example:**
```
Style issues detected:

1. Line 45: Passive voice: "The results were analyzed..."
   Suggestion: Convert to active voice

2. Line 102: Paragraph length: 12 sentences (style prefers 5-8)
   Suggestion: Split into two paragraphs

Address these manually and run Prompt 3 again.
```

### Option 3: Intentional Variation
- User confirms exception
- Document in style guide
- Skip this instance

**Example:**
```
Passive voice detected, but you've marked this as intentional variation.
Documented: "Passive acceptable in methodology sections"
Proceeding...
```

### Option 4: Update Style Guide
- Pattern represents evolved preference
- Update style guide with new rule
- Apply consistently going forward

**Example:**
```
You're consistently using "we" now, but style guide says "I."

Update style guide to allow "we"? (Yes/No)

If yes:
- Update Manuscript/Style/Style_Guide.md
- Update Manuscript/Style/Style_Guide_chg.md
- Apply "we" throughout existing content? (Yes/No)
```

---

## When to Check

### Prompt 3 (Modify File)
**After applying modifications (Step 8):**

```markdown
8. **Style consistency check**:
   - Load Manuscript/Style/Style_Guide.md
   - Check modified content against DO/DON'T lists
   - Check person, formality, complexity
   - Flag violations
   - Offer remediation options
   - Proceed based on user decision
```

### Prompt 6 (Consistency Checker)
**During full consistency analysis:**

```markdown
Style Consistency Analysis:

Checking all chapters against configured style...

**Person Consistency:**
- Style preference: Second person ("you")
- Violations: 3 instances in Chapter 4 (uses "one")

**Formality Level:**
- Style preference: Conversational
- Violations: 2 instances in Chapter 7 (academic jargon)

**DO/DON'T List:**
- DON'T violations: 5 instances
  - Chapter 2, Line 45: Passive voice
  - Chapter 5, Line 102: "One might argue..."

**Recommendations:**
[Detailed list of suggested fixes]
```

---

## Style Transition Detection (v0.10.1+)

**Purpose:** Detect and warn about abrupt style changes that may confuse readers.

### Transition Types

**1. Chapter-to-Chapter Transitions**

```markdown
Detect when adjacent chapters use different styles:

Chapter_05:
  - Active Style: Conversational Expert (book-level)

Chapter_06:
  - Active Style: Technical Precision (chapter override)

→ Transition detected: Conversational Expert → Technical Precision
→ Issue warning with severity level
```

**2. Section-to-Section Transitions**

```markdown
Detect when sections within a chapter switch styles:

Chapter_03, Lines 1-120:
  - Active Style: Business Professional (book-level)

Chapter_03, Lines 121-250:
  - Active Style: Technical Precision (section override)

Chapter_03, Lines 251-end:
  - Active Style: Business Professional (book-level, override ended)

→ Two transitions detected in single chapter
→ Issue warning with line numbers
```

### Transition Severity

**Low Severity (Informational):**
- Related styles (e.g., Conversational Expert → Business Professional)
- Short section override (<500 words)
- Documented transition strategy in Style_Overrides.md

**Medium Severity (Warning):**
- Significantly different styles (e.g., Academic Authority → Narrative Storyteller)
- Multiple transitions in single chapter (>3)
- No documented transition strategy

**High Severity (Requires Attention):**
- Opposing styles (e.g., Technical Precision → Inspirational Teacher)
- Very frequent transitions (>5 in a chapter)
- Transitions without clear purpose

### Transition Warning Format

```markdown
⚠️ **Style Transition Detected**

Location: Chapter_05 → Chapter_06

From: Conversational Expert (book-level)
To: Technical Precision (chapter override)

Severity: Medium

Recommendation:
- Add transition paragraph at end of Chapter_05 to preview technical content
- Open Chapter_06 with acknowledgment of technical depth
- Document transition strategy in Style_Overrides.md

Documented strategy: [None / Show strategy from Style_Overrides.md]

Action: (Continue/Document Strategy/Revise Content)
```

### Override Threshold Warning (30%)

```markdown
If chapter overrides exceed 30% of total chapters:

⚠️ **High Override Usage Detected**

Total Chapters: 10
Chapters with Overrides: 4 (40%)
Threshold: 30%

This suggests the book-level style may not be appropriate for the majority
of your content. Consider:

1. Changing book-level style to most common override style
2. Re-evaluating chapter override necessity
3. Creating a hybrid custom style that accommodates variations

Current Distribution:
- Conversational Expert (book): 6 chapters (60%)
- Technical Precision (override): 3 chapters (30%)
- Narrative Storyteller (override): 1 chapter (10%)

Recommendation: Consider changing book-level to Conversational Expert
and removing 3 chapter overrides, keeping only the Narrative chapter override.

Action: (Keep Current/Review Overrides/Change Book Style)
```

---

## Style Check Report Format

### Basic Report (Single File)

```markdown
**Style Consistency Check**

File: Manuscript/Chapters/Chapter_05/Chapter_05.md

**Active Style Resolution:**
✓ Section override detected: Lines 145-230 (Technical Precision)
✓ Chapter override: None
✓ Book-level style: Conversational Expert

**Active Styles in This File:**
- Lines 1-144: Conversational Expert (book-level)
- Lines 145-230: Technical Precision (section override)
- Lines 231-end: Conversational Expert (book-level)

Results (by section):

**Section 1 (Lines 1-144): Conversational Expert**
✅ Person: Consistent (second person throughout)
✅ Formality: Consistent (conversational tone)
⚠️ Paragraph length: 1 paragraph exceeds preference
✅ Technical terms: Explained on first use

**Section 2 (Lines 145-230): Technical Precision**
✅ Person: Consistent (third person)
✅ Formality: Consistent (technical tone)
✅ Paragraph length: All within preference
⚠️ Passive voice: 2 instances (acceptable for this style)
✅ Technical terms: Used without explanation (appropriate for style)

**Section 3 (Lines 231-end): Conversational Expert**
✅ Person: Consistent (second person throughout)
✅ Formality: Consistent (conversational tone)

**Transitions:**
⚠️ Transition at Line 145: Conversational Expert → Technical Precision
  → Severity: Medium
  → Recommendation: Add bridging sentence before override

⚠️ Transition at Line 231: Technical Precision → Conversational Expert
  → Severity: Medium
  → Recommendation: Add summary sentence after override

Issues requiring attention:
1. Line 89: Long paragraph (10 sentences, style prefers 5-8)
   → Suggest: Split after sentence 6

2. Line 145: Abrupt style transition
   → Suggest: Add: "Let's examine the technical implementation:"

3. Line 231: Abrupt style transition
   → Suggest: Add: "Now that we've covered the technical details, let's return to..."

Proceed with these issues? (Yes/Revise/Skip)
```

### Comprehensive Report (Full Book - Prompt 6 or 11)

```markdown
**Hierarchical Style Consistency Report**

Book: [Title]
Total Chapters: 10
Scan Date: [Date]

**Style Distribution:**

Book-Level Style: Conversational Expert
Chapter Overrides: 2 (20%)
Section Overrides: 5 across 3 chapters

| Chapter | Active Style | Source | Override File |
|---------|-------------|--------|---------------|
| 01 | Conversational Expert | Book | - |
| 02 | Conversational Expert | Book | - |
| 03 | Technical Precision | Chapter | Chapter_03_style.md |
| 04 | Conversational Expert | Book | - |
| 05 | Conversational Expert (3 section overrides) | Mixed | - |
| 06 | Conversational Expert | Book | - |
| 07 | Narrative Storyteller | Chapter | Chapter_07_style.md |
| 08 | Conversational Expert | Book | - |
| 09 | Conversational Expert | Book | - |
| 10 | Conversational Expert | Book | - |

**Override Analysis:**
✅ Override percentage: 20% (below 30% threshold)

**Style Transitions:**

Chapter-Level Transitions: 4
⚠️ Chapter 02 → 03: Conversational Expert → Technical Precision
  - Documented strategy: Yes
  - Severity: Low

⚠️ Chapter 03 → 04: Technical Precision → Conversational Expert
  - Documented strategy: Yes
  - Severity: Low

⚠️ Chapter 06 → 07: Conversational Expert → Narrative Storyteller
  - Documented strategy: No
  - Severity: Medium
  - **ACTION REQUIRED:** Document transition strategy

⚠️ Chapter 07 → 08: Narrative Storyteller → Conversational Expert
  - Documented strategy: No
  - Severity: Medium
  - **ACTION REQUIRED:** Document transition strategy

Section-Level Transitions: 10 (across 3 chapters)
[Detailed list if requested]

**Consistency Issues by Style:**

Conversational Expert (8 chapters):
- Minor issues: 12
- Moderate issues: 3
- Significant issues: 0

Technical Precision (1 chapter):
- Minor issues: 2
- Moderate issues: 0
- Significant issues: 0

Narrative Storyteller (1 chapter):
- Minor issues: 4
- Moderate issues: 1
- Significant issues: 0

**Top Issues:**
1. Chapter 05, Line 89: Paragraph length (moderate)
2. Chapter 06 → 07: Undocumented transition (moderate)
3. Chapter 07 → 08: Undocumented transition (moderate)
4. Chapter 02, Line 45: Passive voice (minor)
5. Chapter 09, Line 150: Passive voice (minor)

**Recommendations:**
1. Document transition strategies for Chapter 06→07 and 07→08
2. Address moderate issues in Chapter 05
3. Consider bulk passive voice review in Chapters 02, 09

Next Steps: (Address All/Select Issues/Export Report)
```

---

## Integration with Prompts

### Prompt 3 Implementation (v0.10.1+)

```markdown
### Then I'll:

...
6. Apply the specified modifications
7. **Anti-Hallucination Verification** (CRITICAL)
8. **Hierarchical style consistency check**:
   a. Resolve active style using hierarchical algorithm:
      - Check for section override markers
      - Check for chapter override file (Chapter_XX_style.md)
      - Fall back to book-level (Style_Guide.md)
   b. Report active style source
   c. Check person, formality, DO/DON'T lists against active style
   d. Detect style transitions within file
   e. Flag violations (minor/moderate/significant)
   f. Offer remediation if needed
   g. Wait for user approval if issues found
9. **Auto-archive**: Move completed instructions to Version History
...
```

### Prompt 6 Implementation (v0.10.1+)

```markdown
**Hierarchical Style Consistency Check:**
   a. Scan all chapters for style configuration:
      - Load Manuscript/Style/Style_Guide.md (book-level)
      - Scan for Chapter_XX_style.md files (chapter overrides)
      - Scan content for section override markers
   b. Build style distribution map
   c. Calculate override percentages
   d. Detect chapter-to-chapter transitions
   e. Detect section-level transitions
   f. Check content against active styles
   g. Build comprehensive hierarchical report:
      - Style distribution table
      - Override analysis with threshold check
      - Transition map with severity levels
      - Consistency issues by style
      - Top issues requiring attention
   h. Provide chapter-by-chapter breakdown
   i. Suggest bulk fixes where appropriate
```

### Prompt 11 Implementation (New - v0.10.1+)

```markdown
**Style Manager Operations:**

1. **Add Chapter Override:**
   - Select chapter
   - Select style (framework or custom)
   - Create Chapter_XX_style.md from template
   - Update Style_Overrides.md registry
   - Report impact

2. **Remove Chapter Override:**
   - Select chapter with override
   - Confirm removal
   - Delete Chapter_XX_style.md
   - Update Style_Overrides.md registry
   - Report chapters now using book-level style

3. **Scan Section Overrides:**
   - Read all chapter content files
   - Detect <!-- STYLE_OVERRIDE: --> markers
   - Validate markers (properly closed, valid styles)
   - Update Style_Overrides.md registry with locations
   - Report findings

4. **Validate Override Registry:**
   - Check all chapter override files exist
   - Check all referenced styles exist
   - Check section markers are properly closed
   - Check for orphaned files
   - Check for missing registry entries
   - Report errors and offer fixes

5. **View Style Distribution:**
   - Load registry
   - Generate distribution report
   - Show override percentage vs. threshold
   - Display style transition map
   - Provide recommendations

6. **Analyze Transitions:**
   - Detect chapter-to-chapter transitions
   - Detect section-level transitions
   - Assign severity levels
   - Check for documented strategies
   - Report undocumented transitions
   - Suggest transition improvements
```

---

## Section Override Marker Syntax

**Valid Syntax:**

```markdown
<!-- STYLE_OVERRIDE: StyleName -->
Content using StyleName characteristics...
Multiple paragraphs allowed...
<!-- END_STYLE_OVERRIDE -->
```

**Rules:**
1. StyleName must match a style from Style_Guide.md, Custom_Styles.md, or Style_Examples.md
2. Opening and closing tags must match
3. Nesting is NOT allowed
4. Markers must be on their own lines
5. Content between markers inherits from StyleName

**Invalid Examples:**

```markdown
<!-- STYLE_OVERRIDE: FakeStyle -->  ← Style doesn't exist
Content...
<!-- END_STYLE_OVERRIDE -->

<!-- STYLE_OVERRIDE: Style1 -->
Outer content...
<!-- STYLE_OVERRIDE: Style2 -->  ← Nesting not allowed
Inner content...
<!-- END_STYLE_OVERRIDE -->
More outer content...
<!-- END_STYLE_OVERRIDE -->

<!-- STYLE_OVERRIDE: Technical Precision -->
Content...
[Missing closing tag]  ← Unclosed marker
```

---

## Validation Error Messages

### Undefined Style

```markdown
❌ **Undefined Style Reference**

Location: Manuscript/Chapters/Chapter_05/Chapter_05_style.md
Style: "Fake Style Name"

This style is not defined in:
- Manuscript/Style/Style_Guide.md
- Manuscript/Style/Custom_Styles.md
- Process/Style_Examples.md (framework styles)

Actions:
1. Check spelling of style name
2. Create custom style in Custom_Styles.md
3. Select different style from available options

Available framework styles:
- Academic Authority
- Conversational Expert
- Narrative Storyteller
- Business Professional
- Technical Precision
- Investigative Journalist
- Practical Guide
- Inspirational Teacher
- Scientific Communicator
```

### Unclosed Section Override

```markdown
❌ **Unclosed Section Override Marker**

Location: Manuscript/Chapters/Chapter_03/Chapter_03.md:145
Style: Technical Precision

Opening marker found without matching closing tag.

<!-- STYLE_OVERRIDE: Technical Precision -->  ← Line 145
Content here...
[Content continues but no END_STYLE_OVERRIDE found]

Action Required:
Add closing marker: <!-- END_STYLE_OVERRIDE -->
```

### Nested Section Overrides

```markdown
❌ **Nested Section Override Detected**

Location: Manuscript/Chapters/Chapter_07/Chapter_07.md:200-250

Outer override: Narrative Storyteller (Line 180)
Inner override: Technical Precision (Line 200)

Nested overrides are not supported. Please flatten structure:

Option A: Close outer before opening inner
<!-- STYLE_OVERRIDE: Narrative Storyteller -->
Content...
<!-- END_STYLE_OVERRIDE -->

<!-- STYLE_OVERRIDE: Technical Precision -->
Content...
<!-- END_STYLE_OVERRIDE -->

Option B: Remove inner override and use single style
```

### Missing Chapter Override File

```markdown
❌ **Missing Chapter Override File**

Chapter: Chapter_05
Listed in: Manuscript/Style/Style_Overrides.md
Expected file: Manuscript/Chapters/Chapter_05/Chapter_05_style.md

Registry shows chapter has override, but file not found.

Actions:
1. Create file from template (Prompt 11 → Add Chapter Override)
2. Remove registry entry (chapter reverts to book-level style)
```

### Orphaned Chapter Override File

```markdown
⚠️ **Orphaned Chapter Override File**

File: Manuscript/Chapters/Chapter_08/Chapter_08_style.md
Status: Exists but not registered in Style_Overrides.md

This file exists but is not being used. Either:

1. Register it (Prompt 11 → Validate Registry → Auto-register)
2. Delete it (file has no effect without registry entry)

Current status: Chapter_08 is using book-level style (Conversational Expert)
```

---

**Module Version:** 0.10.1
**Last Updated:** 2025-11-19
**Status:** Active
**See Also:**
- `Process/Style_Examples.md`
- `Templates/Style_Guide_Template.md`
- `Templates/Chapter_Style_Template.md`
- `Templates/Style_Overrides_Template.md`
- `Proposal/HIERARCHICAL_STYLE_SYSTEM.md`
