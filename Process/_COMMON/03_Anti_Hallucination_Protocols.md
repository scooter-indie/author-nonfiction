# Anti-Hallucination Protocols

**Framework Version:** 0.10.0
**Module:** Anti-Hallucination Verification System
**Purpose:** Standardized protocols to prevent fabricated content

---

## Overview

This module defines three levels of anti-hallucination verification that prompts can use depending on their content generation requirements. These protocols ensure AI-generated content is accurate, verified, and properly labeled.

**Critical Rule:** NEVER fabricate examples, anecdotes, statistics, quotes, or personal experiences. ALWAYS ask the user first.

---

## Three Verification Levels

### Level 1: Reference Only

**Use Case:** Prompts that generate minimal or no new content.

**Content:**
```markdown
**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`
```

**When to Use:**
- Read-only analysis prompts (Prompt 6, 9)
- Report generation (Prompt 8)
- Git operations (Prompt 9)
- Export operations (Prompt 7)

**Current Prompts:**
- Prompt 6: Consistency Checker
- Prompt 7: Export and Format
- Prompt 8: Progress Dashboard
- Prompt 9: Git Operations
- Prompt 10: Update Change Tracking

---

### Level 2: Contextual Note

**Use Case:** Prompts that may generate content in specific contexts.

**Content:**
```markdown
## Anti-Hallucination Note

**When generating {CONTENT_TYPE}** (examples, anecdotes, statistics, or quotes):
- Follow the verification protocol detailed in Prompt 3's Anti-Hallucination Verification section
- **ASK the user** before creating examples or claiming their experiences
- **Use clear labels**: REAL (user-confirmed) vs HYPOTHETICAL vs GENERIC
- **Never fabricate** specific people, statistics, or quotes
```

**Variables:**
- `{CONTENT_TYPE}`: Describe the type of content this prompt might generate
  - "style examples"
  - "inbox content"
  - "initial chapter content"
  - "placeholder content"

**When to Use:**
- Prompts that create initial content with placeholders (Prompt 1)
- Prompts that process user-provided content (Prompt 4)
- Prompts that may generate samples (Prompt 5)

**Current Prompts:**
- Prompt 1: Initialize Project Structure
- Prompt 4: Integrate Content from Inbox
- Prompt 5: Compile Complete Manuscript

---

### Level 3: Comprehensive Verification

**Use Case:** Primary content generation prompt with extensive verification.

**Content:**
```markdown
## Anti-Hallucination Verification (CRITICAL)

**This step prevents fabricated content from entering your book.**

### When This Step Triggers

I will pause and ask for verification when the requested changes include:

**Category 1: Personal Content**
- Examples from "your experience"
- Anecdotes or stories
- Case studies or scenarios
- Personal observations

**Category 2: Factual Claims**
- Statistics or data points
- Research findings
- Historical events or dates
- Technical specifications

**Category 3: Attributed Content**
- Direct quotes
- Paraphrased statements
- Expert opinions
- Published works

**Category 4: Specific Entities**
- Named individuals (except public figures with verified facts)
- Specific companies or organizations (except well-known with verified facts)
- Particular products or services
- Real locations with specific claims

### What I'll Ask You

When I detect content in the above categories, I will:

1. **Show you the proposed content** with clear labels
2. **Ask for verification:**
   - "Is this based on your real experience?" (for personal content)
   - "Can you provide the source?" (for factual claims)
   - "Do you have the exact quote/citation?" (for attributed content)
   - "Is this a real entity you're referencing?" (for specific entities)
3. **Offer alternatives:**
   - **REAL**: User confirms this is factual/from their experience
   - **HYPOTHETICAL**: Clearly labeled as "hypothetical example"
   - **GENERIC**: Generalized scenario without specific claims
   - **PLACEHOLDER**: Marked [VERIFY] or [CITATION NEEDED] for later

### Content Labels I'll Use

**For Examples and Anecdotes:**
- **[REAL EXPERIENCE]** - User confirmed this happened
- **[HYPOTHETICAL EXAMPLE]** - Clearly labeled as illustrative
- **[GENERIC SCENARIO]** - Generalized, no specific claims
- **[PLACEHOLDER - VERIFY]** - Needs user's real experience added

**For Statistics and Data:**
- **[VERIFIED: Source]** - Source provided and cited
- **[CITATION NEEDED]** - Claim needs source
- **[APPROXIMATE]** - Rough estimate, clearly labeled
- **[GENERIC RANGE]** - "Studies show X-Y%" (no specific study claimed)

**For Quotes:**
- **✓ Verified** - Full citation provided
- **⚠ Needs Citation** - Quote exists but needs proper source
- **⏳ Pending** - Placeholder, user will verify
- **[PARAPHRASE]** - Clearly marked as paraphrased idea, not direct quote

**For Specific Entities:**
- **[REAL: Name]** - User confirmed real person/company
- **[ANONYMIZED]** - Real but identity protected ("a colleague", "a client")
- **[COMPOSITE]** - Clearly labeled composite example
- **[FICTIONAL EXAMPLE]** - Clearly labeled as made up for illustration

### Example Verification Flow

**Scenario:** You ask me to add an example about productivity techniques.

**My Response:**
```
I'd like to add an example here. Would you like me to:

A) Use a REAL example from your experience
   → Please describe what happened

B) Create a HYPOTHETICAL example (clearly labeled)
   → I'll mark it as "For example, imagine..."

C) Use a GENERIC scenario
   → "Many professionals find that..."

D) Leave a PLACEHOLDER
   → [ADD EXAMPLE: Describe your experience with this technique]

Which would you prefer?
```

### What I Will NEVER Do

❌ **NEVER** fabricate:
- Your personal experiences
- Specific people or their actions
- Exact statistics without sources
- Direct quotes without attribution
- Specific company names in examples (unless public and verified)
- Research findings that don't exist
- Dates or events that didn't happen

❌ **NEVER** assume:
- What happened in your life
- What you think or believe
- What results you achieved
- Who you interacted with
- What you observed

### What I WILL Do

✅ **ALWAYS**:
- Ask before creating examples
- Offer hypothetical/generic alternatives
- Use clear labels for content type
- Provide placeholders for you to fill
- Request sources for factual claims
- Mark quotes with verification status
- Give you options and control

### Recovery Protocol

**If fabricated content is detected after the fact:**

1. **Flag it immediately** with [VERIFY] marker
2. **Ask user for verification** or correction
3. **Offer alternatives** (hypothetical, generic, placeholder)
4. **Update _chg file** to document the correction
5. **Increment version** appropriately

---

## Quote Management Integration

**For all quotes and epigraphs:**

Use the centralized quote management system (see: `07_Quote_Management_System.md`)

**Status codes:**
- ⏳ **Pending verification** - Initial entry, user will provide citation
- ⚠ **Needs proper citation** - Quote exists but citation incomplete
- ✓ **Verified with source** - Full citation provided and confirmed

**Required fields:**
- Chapter number
- Quote text (NEVER fabricated)
- Author name (NEVER guessed)
- Source (book/article/speech title)
- Year
- Page (if applicable)
- Full bibliography entry
- Verification status

**NEVER:**
- Fabricate quotes
- Attribute quotes without verification
- Guess at sources
- Paraphrase and present as quotes
- Use famous quotes without proper citation

---

## Implementation Guidelines

### Choosing Verification Level

**Use Level 1 (Reference Only):**
- Prompt generates NO new content
- Pure analysis or reporting
- File operations only

**Use Level 2 (Contextual Note):**
- Prompt MAY generate content in specific scenarios
- Content is typically placeholder or structural
- Limited content generation

**Use Level 3 (Comprehensive Verification):**
- Primary content generation workflow
- Extensive user interaction expected
- High risk of fabrication if not careful

### Prompt-Specific Notes

**Prompt 1 (Initialize):**
- Level 2: May generate style examples
- May create sample passages
- Usually placeholder content

**Prompt 3 (Modify File):**
- Level 3: Primary content generation
- Highest risk of fabrication
- Most comprehensive verification needed

**Prompt 4 (Integrate Inbox):**
- Level 2: Processing user-provided content
- May need to verify claims in inbox content
- Ask user about content authenticity

**Prompt 5 (Compile):**
- Level 2: Usually no new content
- But if user requests additions during compilation
- Use verification protocol

**All Others:**
- Level 1: Reference only
- Minimal to no content generation

---

## Content Type Guidelines

### Examples and Anecdotes

**ALWAYS ask:**
- "Is this from your real experience?"
- "Would you like me to use a hypothetical example instead?"
- "Should I leave a placeholder for you to add your experience?"

**NEVER:**
- Fabricate personal stories
- Claim "you" did something without confirmation
- Invent scenarios and present as real

### Statistics and Data

**ALWAYS:**
- Request source
- Offer to use placeholder: [STAT: X% - ADD SOURCE]
- Suggest generic ranges if user doesn't have specific data
- Mark approximate values clearly

**NEVER:**
- Fabricate specific numbers
- Cite non-existent studies
- Claim precision without source

### Quotes and Citations

**ALWAYS:**
- Request full citation
- Use status codes (⏳ ⚠ ✓)
- Leave incomplete citations as ⚠ Needs Citation
- Verify in Manuscript/Quotes/Chapter_Quotes.md

**NEVER:**
- Fabricate quotes
- Guess at attributions
- Paraphrase and call it a quote
- Invent sources

### Named Entities

**ALWAYS:**
- Confirm entity is real
- Ask if should be anonymized
- Offer composite alternative
- Suggest "a client" instead of "John Smith"

**NEVER:**
- Invent people
- Fabricate companies
- Create specific scenarios with named entities without confirmation

---

## Standard Verification Questions

**For Personal Content:**
```
I need to verify: Is this based on your real experience, or should I:
A) Leave a placeholder for you to add your experience
B) Use a clearly-labeled hypothetical example
C) Use a generic scenario
```

**For Statistics:**
```
Can you provide the source for this statistic, or should I:
A) Mark it [CITATION NEEDED] for you to add later
B) Use a generic range instead (e.g., "studies show X-Y%")
C) Remove the specific number and keep it general
```

**For Quotes:**
```
Do you have the full citation for this quote?
- If yes: I'll add it with ✓ Verified status
- If partial: I'll add it with ⚠ Needs Citation status
- If no: I'll add it with ⏳ Pending status and you can verify later
```

**For Named Entities:**
```
Is [Entity Name] a real person/company you're referencing?
- If yes: How should it be presented? (real name, anonymized, composite)
- If no: Should I use a generic reference instead? ("a colleague", "a company")
```

---

## Success Criteria

**Verification is successful when:**
- ✅ NO fabricated personal experiences
- ✅ NO unsourced statistics presented as fact
- ✅ NO fabricated quotes or misattributions
- ✅ ALL content clearly labeled (REAL, HYPOTHETICAL, GENERIC, PLACEHOLDER)
- ✅ USER in control of what claims are made
- ✅ PLACEHOLDERS used when information not yet available

---

**Module Version:** 0.10.0
**Last Updated:** 2025-11-19
**Status:** Active
**See Also:** `Process/Anti-Hallucination_Guidelines.md` (complete framework guidelines)
