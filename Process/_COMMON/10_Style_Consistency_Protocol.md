# Style Consistency Protocol

**Framework Version:** 0.10.0
**Module:** Writing Style Validation
**Purpose:** Ensure consistency with configured writing style

---

## Overview

Validates content against the project's configured writing style. Used by Prompts 3 and 6 to maintain consistent voice, tone, and approach.

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

## Checking Against DO/DON'T Lists

**Procedure:**

1. Load `Manuscript/Style/Style_Guide.md`
2. Extract DO list (preferred patterns)
3. Extract DON'T list (patterns to avoid)
4. Scan modified content
5. Flag violations
6. Report findings

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

## Style Check Report Format

```markdown
**Style Consistency Check**

Configuration: {Style name from Style_Guide.md}

Checking: {filename}

Results:
✅ Person: Consistent (second person throughout)
✅ Formality: Consistent (conversational tone)
⚠️ Paragraph length: 2 paragraphs exceed preference (8-10 sentences vs. 5-8)
⚠️ Passive voice: 3 instances (DON'T list violation)
✅ Technical terms: All explained on first use

Issues requiring attention:
1. Line 45: Passive voice: "The survey was distributed..."
   → Suggest: "We distributed the survey..."

2. Line 102: Long paragraph (10 sentences)
   → Suggest: Split after sentence 6

Proceed with these issues? (Yes/Revise/Skip)
```

---

## Integration with Prompts

### Prompt 3 Implementation

```markdown
### Then I'll:

...
6. Apply the specified modifications
7. **Anti-Hallucination Verification** (CRITICAL)
8. **Style consistency check**: Verify changes align with Style_Guide.md
   - Load style configuration
   - Check person, formality, DO/DON'T lists
   - Flag violations (minor/moderate/significant)
   - Offer remediation if needed
   - Wait for user approval if issues found
9. **Auto-archive**: Move completed instructions to Version History
...
```

### Prompt 6 Implementation

```markdown
**Style Consistency Check:**
   - Load Manuscript/Style/Style_Guide.md
   - Check all content against configured style
   - Build comprehensive report:
     - Person consistency across all chapters
     - Formality level consistency
     - DO/DON'T list violations
     - Common patterns
   - Provide chapter-by-chapter breakdown
   - Suggest bulk fixes where appropriate
```

---

**Module Version:** 0.10.0
**Last Updated:** 2025-11-19
**Status:** Active
**See Also:** `Process/Style_Examples.md`, `Templates/Style_Guide_Template.md`
