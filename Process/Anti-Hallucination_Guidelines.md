# Anti-Hallucination Guidelines for AI Assistants

**Version:** 1.0.0
**Last Updated:** 2025-11-17
**Purpose:** Rules and guidelines for AI assistants to prevent hallucination during nonfiction book authoring and brainstorming

---

## Table of Contents

1. [Overview](#overview)
2. [Core Principles](#core-principles)
3. [Fact-Based Writing Rules](#fact-based-writing-rules)
4. [Brainstorming Guidelines](#brainstorming-guidelines)
5. [Source and Citation Requirements](#source-and-citation-requirements)
6. [Red Flags and Self-Checks](#red-flags-and-self-checks)
7. [When Uncertainty Exists](#when-uncertainty-exists)

---

## Overview

This document establishes strict guidelines for AI assistants working on nonfiction content to minimize hallucination and ensure factual accuracy. All AI-generated content must adhere to these rules.

### Definition of Hallucination

In the context of AI-assisted authoring, **hallucination** refers to:
- Stating facts that are not verifiable or are incorrect
- Creating plausible-sounding but fictional examples, statistics, or case studies
- Inventing quotes, attributions, or citations
- Making up specific details when only general knowledge exists
- Presenting assumptions or inferences as established facts

---

## Core Principles

### 1. ASK FIRST - Don't Assume

**BEFORE generating content with examples, anecdotes, statistics, or quotes:**

**MANDATORY: ASK THE USER**

Do NOT assume you can:
- ❌ Speak for the user's experiences ("I've worked with authors who...", "I hear that...")
- ❌ Create plausible-sounding examples with specific people
- ❌ State statistics without verified sources
- ❌ Use quotes without verification

**INSTEAD: Ask the user to provide:**
- ✅ "Is this based on your real experience? Tell me your story."
- ✅ "Do you have a verified source for this statistic?"
- ✅ "Do you have the quote source, or should I mark it ⏳ Pending?"

### 2. Truth Over Completeness

**ALWAYS prefer saying "I don't know" or "This needs verification" over generating plausible-sounding but unverified content.**

✅ **Correct:**
> "Recent studies have shown improvements in productivity with remote work, though the specific percentage varies by study and needs verification."

❌ **Incorrect:**
> "A 2023 Stanford study found that remote work increases productivity by 47%."
> *(Unless you have direct access to this specific study)*

### 3. Label What You Generate

**ALWAYS use clear labels when creating content:**

✅ **REAL EXPERIENCE** (user confirmed):
> "Based on your experience as a software engineer..."

✅ **HYPOTHETICAL** (clearly fictional):
> "Imagine a healthcare consultant writing about patient communication..."

✅ **GENERIC** (no specifics):
> "Many authors face version control challenges..."

❌ **FABRICATED** (NEVER do this):
> ~~"Sarah, a consultant I worked with..."~~ (fake person)
> ~~"I hear from dozens of authors that..."~~ (fake observations)

### 4. Distinguish Between Types of Knowledge

Clearly label the epistemic status of information:

- **Known fact**: Well-established, verifiable information
- **General understanding**: Widely accepted but may need specific citation
- **Reasonable inference**: Logical conclusion based on known facts
- **Speculation**: Educated guess that requires further research
- **Unknown**: Information you cannot verify

### 5. Never Fabricate Supporting Details

**Never invent:**
- Specific statistics or percentages
- Names of studies, researchers, or institutions
- Exact dates or time periods (unless widely known)
- Specific case studies or examples
- Direct quotes from individuals
- Book titles, article titles, or publication names
- URLs or specific page numbers

---

## Fact-Based Writing Rules

### Rule 1: Statistical Claims Require Sources

**Before stating any statistic:**
- Do you have access to the source document?
- Can you cite it properly?
- Is the statistic widely known and easily verifiable?

**If NO to any of these, use placeholders:**

✅ **Correct approach:**
> "[CITATION NEEDED: Recent research suggests approximately X% of companies have adopted hybrid work models]"

✅ **Alternative approach:**
> "Many companies have adopted hybrid work models in recent years, though exact figures vary by industry and region."

### Rule 2: Named Examples Must Be Real or Clearly Fictional

**For case studies and examples:**

✅ **Option 1 - Generic/Anonymous:**
> "Consider a mid-sized technology company that implemented a four-day work week..."

✅ **Option 2 - Clearly Hypothetical:**
> "Imagine a fictional company, TechCorp, that wants to improve employee retention..."

✅ **Option 3 - Well-Known Real Example:**
> "Microsoft's experiment with a four-day work week in Japan in 2019 showed promising results."
> *(Only if this is widely reported and verifiable)*

❌ **Never do this:**
> "In 2022, DataTech Solutions in Austin implemented a four-day work week and saw a 34% increase in productivity."
> *(Unless this is a real, documented case you can cite)*

### Rule 3: Quotes Must Be Accurate or Clearly Paraphrased

**For quotes:**

✅ **If you have the exact quote:**
> According to Peter Drucker, "Management is doing things right; leadership is doing things right."

✅ **If you recall the general idea:**
> Peter Drucker made a distinction between management (execution) and leadership (direction), though the exact wording should be verified.

✅ **For generic wisdom:**
> As management experts often note, leadership is about setting direction while management is about execution.

❌ **Never fabricate quotes:**
> As Steve Jobs said in 2005, "The best innovation comes from diverse teams working asynchronously."

### Rule 4: Historical Claims Require Verification

**For historical facts:**
- Widely known dates and events are acceptable (e.g., "World War II ended in 1945")
- Specific details require citation markers
- When unsure, use approximate language

✅ **Acceptable:**
> "The concept of remote work gained significant traction during the COVID-19 pandemic starting in 2020."

❌ **Risky without verification:**
> "On March 15, 2020, 73% of US companies mandated work-from-home policies."

### Rule 5: Technical Claims Must Be Defensible

**For technical or specialized information:**
- Only state what you're confident is accurate
- Use hedging language when appropriate
- Mark areas requiring expert review

✅ **Good practice:**
> "Modern encryption algorithms like AES-256 are considered secure for most applications, though specific implementation details should be reviewed by security experts."

❌ **Overconfident:**
> "AES-256 encryption is unbreakable and will remain secure for the next 50 years."

---

## Brainstorming Guidelines

During brainstorming sessions, different rules apply, but clarity is still essential.

### Brainstorming Mode: Label Speculative Content

When generating ideas, possibilities, or hypothetical scenarios:

✅ **Clearly mark speculative content:**
> **[BRAINSTORMING - REQUIRES VERIFICATION]**
>
> Possible chapter structure:
> - Introduction: The rise of remote work (need statistics on adoption rates)
> - Chapter 1: Benefits and challenges (need case studies)
> - Chapter 2: Best practices (need expert interviews or research)

✅ **Use question format for uncertain details:**
> "Could we include a case study about a major tech company's remote work transition? (Need to research: Microsoft, Twitter, or similar)"

✅ **Distinguish between types of ideas:**
> **CONFIRMED TOPICS:**
> - The history of remote work (well-documented)
>
> **NEEDS RESEARCH:**
> - Statistical trends in remote work adoption
> - Specific company case studies
>
> **SPECULATIVE/CREATIVE:**
> - Future predictions about hybrid work models

### Brainstorming Framework

**Structure brainstorming outputs as:**

1. **Foundation (What We Know)**
   - Established facts and general knowledge
   - Clearly verifiable information

2. **Working Hypotheses (What We Think)**
   - Reasonable inferences
   - Industry trends
   - Common practices
   - *Mark as: [Hypothesis - needs verification]*

3. **Open Questions (What We Need to Find Out)**
   - Specific statistics needed
   - Expert opinions required
   - Case studies to research
   - *Mark as: [Research needed]*

4. **Creative Exploration (What We Could Imagine)**
   - Hypothetical scenarios
   - Thought experiments
   - Future possibilities
   - *Mark as: [Speculative]*

---

## Source and Citation Requirements

### When Sources Are Required

**Sources are REQUIRED for:**
- Specific statistics or quantitative claims
- Direct quotes
- Controversial or debated points
- Recent research findings
- Technical specifications
- Legal or regulatory information

### Citation Placeholder Format

When content needs a source:

```markdown
[CITATION NEEDED: Brief description of what needs to be sourced]
[SOURCE: If you know a likely source but can't verify exact details]
[VERIFY: If you're uncertain about the accuracy of a claim]
```

**Examples:**

> The adoption of remote work increased significantly during the pandemic [CITATION NEEDED: Specific percentage and timeframe from reputable study].

> According to [SOURCE: Likely Gallup or similar workplace research organization], employee engagement varies significantly between remote and in-office workers.

> Some experts argue that four-day work weeks improve productivity [VERIFY: Check recent meta-analyses or systematic reviews].

### Creating a Research Bibliography

For each chapter or section, maintain a research needs list:

```markdown
## Research Bibliography for Chapter X

### Required Sources
- [ ] Statistics on remote work adoption 2020-2023
- [ ] Case study: Major company transition to hybrid work
- [ ] Expert opinion on productivity metrics

### Potential Sources
- Gallup State of the Workplace reports
- Harvard Business Review articles on remote work
- Academic journals: Journal of Organizational Behavior

### Verification Needed
- Claim about 4-day work week benefits (page X, draft)
- Statistic about meeting fatigue (page Y, draft)
```

---

## Red Flags and Self-Checks

### Before Writing Any Content, Ask:

1. **The Specificity Test**
   - Am I providing overly specific details (exact percentages, dates, names)?
   - Could I cite a source for this if asked?
   - Is this detail necessary, or would a general statement work?

2. **The Verification Test**
   - If the author asked me "Where did you get this?", what would I say?
   - Can I distinguish between what I know vs. what I'm inferring?
   - Have I clearly marked anything that needs verification?

3. **The Harm Test**
   - Could stating this incorrectly damage the book's credibility?
   - Is this a claim that readers might fact-check?
   - Would it be better to mark this as [NEEDS RESEARCH]?

4. **The Alternative Test**
   - Could I rephrase this more generally without losing meaning?
   - Could I present this as a question rather than a claim?
   - Could I use a hypothetical example instead of a "real" one?

### Red Flag Phrases (Use with Caution)

These phrases often indicate potential hallucination:

❌ "According to a 2023 study..."
❌ "Research shows that exactly X% of..."
❌ "As [specific person] said in [specific year]..."
❌ "A company called [made-up name] implemented..."
❌ "Statistics indicate that..."
❌ "A recent survey found that [specific number]..."

**Instead, use:**

✅ "Research suggests..." [CITATION NEEDED]
✅ "Studies have found varying results on..."
✅ "Common industry practice includes..."
✅ "Consider a hypothetical company that..."
✅ "Experts generally agree that..."
✅ "Available evidence indicates..." [SOURCES TO VERIFY]

---

## When Uncertainty Exists

### The Uncertainty Hierarchy

**Level 1: High Confidence - State Clearly**
- Widely known facts
- Basic definitions
- General principles
- Common knowledge in the field

**Level 2: Medium Confidence - Hedge Appropriately**
- Use: "generally," "typically," "often," "many experts suggest"
- Add: "though specific data varies"
- Consider: [VERIFY] tag if precision matters

**Level 3: Low Confidence - Mark for Research**
- Use: [CITATION NEEDED] or [RESEARCH REQUIRED]
- Provide general direction: "This area needs current statistics from..."
- Offer: "Questions to explore: [list questions]"

**Level 4: Unknown - Say So**
- State: "This requires subject matter expert input"
- Suggest: "Research needed on..."
- Offer: "Possible approaches to investigate..."

### Constructive Uncertainty Responses

Instead of fabricating, provide value through:

✅ **Framework Suggestions:**
> "While I don't have specific statistics, a useful framework for analyzing this might include: [provide structure]"

✅ **Research Directions:**
> "To support this claim, consider researching: [list potential sources]"

✅ **Question Formulation:**
> "Key questions to investigate: 1) What percentage of..., 2) How do experts define..., 3) What case studies exist..."

✅ **Placeholder Content:**
> "SECTION OUTLINE - NEEDS RESEARCH:
> - Opening: [describe type of statistic or example needed]
> - Body: [concepts to cover]
> - Conclusion: [tie to chapter theme]"

---

## Content Review Checklist

Before finalizing any drafted content, verify:

### Factual Claims
- [ ] All statistics have [CITATION NEEDED] tags or verified sources
- [ ] All specific examples are clearly real, hypothetical, or anonymous
- [ ] All quotes are accurate or marked for verification
- [ ] All technical claims are defensible or marked for expert review

### Structural Clarity
- [ ] Brainstorming content is clearly marked as speculative
- [ ] Different types of knowledge are distinguished
- [ ] Research needs are clearly documented
- [ ] Uncertainty is acknowledged where appropriate

### Author Guidance
- [ ] Clear markers for what needs verification
- [ ] Research directions provided for uncertain areas
- [ ] Placeholder text indicates what type of content is needed
- [ ] Questions are formulated for areas requiring expert input

---

## Collaborative Fact-Checking Protocol

### During Drafting

**AI Assistant responsibilities:**
1. Draft content with appropriate uncertainty markers
2. Provide [CITATION NEEDED] tags for all specific claims
3. Suggest research directions
4. Distinguish between types of knowledge

**Author responsibilities:**
1. Verify all marked claims
2. Conduct research for [CITATION NEEDED] items
3. Validate technical accuracy
4. Provide or verify specific examples

### Review Cycle

**Phase 1: Initial Draft**
- AI provides structure with heavy use of placeholders and tags

**Phase 2: Research Phase**
- Author researches and fills in verified information
- Author provides sources and citations

**Phase 3: Revision**
- AI assists with integration of researched material
- AI helps with clarity and flow while maintaining accuracy

**Phase 4: Verification**
- Joint review of all factual claims
- Final fact-checking pass
- Expert review if needed

---

## Examples: Before and After

### Example 1: Statistics

❌ **Hallucinated Version:**
> "A 2023 McKinsey study found that 68% of employees prefer hybrid work arrangements, and companies that offer flexibility see 34% higher retention rates."

✅ **Corrected Version:**
> "Recent research suggests that many employees prefer hybrid work arrangements, and companies offering flexibility often report improved retention [CITATION NEEDED: McKinsey, Gallup, or similar workplace research on hybrid work preferences and retention rates, approximately 2021-2024]."

### Example 2: Case Studies

❌ **Hallucinated Version:**
> "TechFlow Solutions, a 500-person software company in Seattle, implemented a four-day work week in January 2023. Within six months, they reported a 45% decrease in turnover and a 28% increase in productivity."

✅ **Corrected Version - Option A (Hypothetical):**
> "Consider a hypothetical mid-sized software company implementing a four-day work week. Based on reported trends, they might expect to see improvements in employee satisfaction and retention, though specific outcomes vary widely by industry and implementation approach [RESEARCH NEEDED: Real case studies of four-day work week implementations]."

✅ **Corrected Version - Option B (Generic):**
> "Some technology companies have experimented with four-day work weeks, reporting various results in terms of productivity and employee retention [CITATION NEEDED: Documented case studies with specific outcomes]."

### Example 3: Expert Opinions

❌ **Hallucinated Version:**
> "As workplace researcher Dr. Sarah Martinez stated in her 2022 Harvard Business Review article, 'The future of work is fundamentally about trust, not location.'"

✅ **Corrected Version:**
> "Workplace researchers emphasize that successful remote and hybrid work arrangements are built on trust rather than physical proximity [SOURCE NEEDED: Recent HBR or similar publication on remote work and organizational trust]."

### Example 4: Historical Context

❌ **Hallucinated Version:**
> "The concept of remote work was first introduced by Jack Nilles in 1973, when he published 'The Telecommunications-Transportation Tradeoff.' By 1985, approximately 15,000 Americans were working remotely."

✅ **Corrected Version:**
> "The concept of remote work emerged in the 1970s and has evolved significantly since then [RESEARCH NEEDED: History of remote work - check Jack Nilles' actual work, early adoption statistics if available, evolution through different decades]."

### Example 5: Brainstorming

✅ **Good Brainstorming Format:**

> **CHAPTER 3: The Economics of Remote Work**
>
> **[BRAINSTORMING - STRUCTURE ONLY]**
>
> **POTENTIAL CONTENT (Needs Research):**
>
> 1. Cost savings for companies
>    - [STAT NEEDED: Office space cost reductions]
>    - [EXAMPLE NEEDED: Real company that published cost analysis]
>
> 2. Cost savings for employees
>    - [STAT NEEDED: Commuting cost averages]
>    - [STAT NEEDED: Time savings data]
>
> 3. Hidden costs
>    - [RESEARCH: Home office setup costs]
>    - [RESEARCH: Technology/infrastructure investments]
>
> **QUESTIONS TO EXPLORE:**
> - What's the net economic impact for companies over 1-3 years?
> - How do cost savings vary by industry?
> - What are the equity implications (who can/can't afford home office)?
>
> **POTENTIAL SOURCES:**
> - Global Workplace Analytics
> - Stanford remote work research
> - Company case studies (Buffer, GitLab, etc. - verify what's published)

---

## Quote/Epigraph Guidelines

### Never Fabricate or Misattribute Quotes

Quotes used as chapter epigraphs must be accurate and properly attributed. This is a critical area where AI hallucination can damage credibility.

### Rule 1: Verify Every Quote

❌ **NEVER do this:**
> As Einstein famously said, "The most powerful force in the universe is compound interest."

*(This is often misattributed - likely apocryphal, no primary source exists)*

✅ **Instead:**
If uncertain about attribution:
- Mark as Status: ⏳ Pending in Quotes/Chapter_Quotes.md
- Add note: "NEEDS VERIFICATION: Check attribution before using"
- Research original source
- Only mark as ✓ Verified when confirmed

### Rule 2: Complete Attribution Required

**For all chapter epigraphs in Quotes/Chapter_Quotes.md:**

**Required fields:**
- **Quote text**: Exact wording from source (use [...] for omissions)
- **Author**: Full name
- **Source**: Book title, article, speech, interview, etc.
- **Year**: Publication or delivery year
- **Page**: Page number if from book/article (or N/A if not applicable)

**Do NOT mark as ✓ Verified unless all fields are complete and confirmed.**

### Rule 3: Quote Verification Process

**Status ⏳ Pending → Status ⚠ Needs Citation:**
1. Select appropriate quote for chapter theme
2. Verify exact wording (check against original if possible)
3. Confirm basic attribution (Author, Source, Year)
4. Add to Quotes/Chapter_Quotes.md
5. Mark as ⚠ Needs Citation

**Status ⚠ Needs Citation → Status ✓ Verified:**
1. Locate original source (book, article, video, recording)
2. Verify exact wording matches
3. Add complete bibliographic information (page number, publisher, etc.)
4. Add corresponding entry to Bibliography.md
5. Link bibliography reference in quote entry
6. Mark as ✓ Verified

### Rule 4: When You Cannot Verify

If you cannot verify a quote:

❌ **Don't use it anyway**
❌ **Don't mark it as verified**
❌ **Don't guess at the attribution**

✅ **Instead:**
```markdown
## Chapter XX: [Title]

**Status:** ⏳ Pending

**Quote:**
> [NEEDS VERIFICATION: Cannot confirm exact wording or attribution]

**Attribution:**
- **Author:** [Likely author but unconfirmed]
- **Source:** [UNKNOWN - needs research]
- **Year:**
- **Page:**

**Bibliography Reference:** N/A

**Notes:** Quote appears widely but no primary source found.
Consider alternative quote or skip epigraph for this chapter.
```

### Rule 5: Common Quote Pitfalls

**Misattributions to watch for:**
- Einstein: Many apocryphal quotes attributed to him
- Mark Twain: Often falsely credited with witty sayings
- Confucius: Many modern sayings incorrectly attributed
- Winston Churchill: Numerous misattributions
- Abraham Lincoln: "Don't believe everything you read on the internet" (obviously fake)

**Red flags:**
- "As [famous person] famously said..."
- Quote found only on quote websites, not in original works
- No page number or specific source provided
- Wording varies significantly across sources

### Rule 6: Acceptable Sources for Verification

**Primary sources (preferred):**
- Original book, article, or publication
- Verified speech transcript
- Authenticated interview recording
- Author's collected works

**Secondary sources (use with caution):**
- Reputable quote databases with citations (e.g., Yale Book of Quotations)
- Scholarly articles citing the quote with source
- Biographies with proper attribution

**Unacceptable sources:**
- Quote aggregator websites without citations
- Social media posts
- Unsourced quote images
- "Someone said on the internet"

### Rule 7: When Paraphrasing

If you need to paraphrase or modernize language:

❌ **Don't do this:**
> As Aristotle said, "We are what we repeatedly do. Excellence, then, is not an act, but a habit."

*(This is Will Durant paraphrasing Aristotle, not Aristotle's actual words)*

✅ **Instead, attribute accurately:**
> As Will Durant wrote, summarizing Aristotle, "We are what we repeatedly do. Excellence, then, is not an act, but a habit."

**Or find the original:**
> As Aristotle wrote in *Nicomachean Ethics*, "...for the things we have to learn before we can do them, we learn by doing them."

### Quote Workflow Integration

**With Prompt 3 (Modify File):**
- Don't use Prompt 3 for quote management
- Edit Quotes/Chapter_Quotes.md directly
- Commit quote changes separately

**With Prompt 5 (Compile):**
- Only quotes with Status ✓ or ⚠ are inserted
- Status ⏳ quotes are skipped or marked [EPIGRAPH PENDING]

**With Prompt 6 (Consistency Check):**
- Automatically flags unverified quotes
- Checks for missing attribution fields
- Verifies bibliography links

**With Prompt 8 (Dashboard):**
- Shows quote completion percentage
- Lists chapters needing quote work

### Example: Good Quote Entry

```markdown
## Chapter 05: The Scientific Method

**Status:** ✓ Verified

**Quote:**
> The most beautiful experience we can have is the mysterious. It is the fundamental emotion that stands at the cradle of true art and true science.

**Attribution:**
- **Author:** Albert Einstein
- **Source:** The World As I See It
- **Year:** 1931
- **Page:** 5
- **Context:** Essay on science and religion

**Bibliography Reference:** Einstein, A. (1931). *The World As I See It* (A. Harris, Trans.). New York: Covici-Friede. (Original work published 1930)

**Notes:** Verified from original English translation. Public domain.
```

### Remember

**The Golden Rule for Quotes:**
When in doubt, leave it out. It's better to have no epigraph than an incorrectly attributed one.

**Verification is not optional:**
- Status ⏳ = Not verified, don't use in final manuscript
- Status ⚠ = Partially verified, use with caution
- Status ✓ = Fully verified, safe to publish

---

**End of Document**
