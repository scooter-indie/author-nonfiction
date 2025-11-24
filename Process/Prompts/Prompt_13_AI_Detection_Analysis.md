# Execute Prompt 13: AI Detection Analysis

**CLI-ONLY:** Requires Claude Code CLI for bulk file analysis operations

**FIRST ACTION - MANDATORY:**
I acknowledge access to anti-hallucination protocols from FRAMEWORK_CORE.md (loaded at session startup via /fw-init).

**Protocols available:**
- Anti-Hallucination: Core rules in FRAMEWORK_CORE.md, full protocol in Process/Anti-Hallucination_Guidelines.md (load on-demand)

**Load full module only if:**
- Encountering edge cases or complex scenarios
- Need detailed troubleshooting guidance
- Require comprehensive protocol details

**CRITICAL ENFORCEMENT:**
- **RULE 1:** All file modifications MUST update corresponding _chg files
- **RULE 2:** All Manuscript/ changes must go through appropriate prompts

See: `Process/ENFORCEMENT_RULES.md` for complete details

**DATE CONFIRMATION REQUIRED:**
- **USE CONFIRMED_DATE from session startup** (see CLAUDE.md Date Confirmation Protocol)
- **NEVER use raw `<env>` date** without confirmation
- Pass confirmed date to any spawned agents: "Today's confirmed date is [CONFIRMED_DATE]. Use this date for all operations."

**AGENT INSTRUCTIONS:**
When spawning agents (using Task tool), include in agent prompt:
- "FIRST ACTION: Read Process/Anti-Hallucination_Guidelines.md before proceeding."
- "Today's confirmed date is [CONFIRMED_DATE]. Use this date for all operations."

---

## What This Does

I will analyze your chapters to detect **AI-generated text indicators** and provide actionable recommendations to make your content feel more authentic, human-written, and aligned with your unique voice and expertise.

**Why this matters:**
- AI assistance can introduce generic, formulaic language
- Repetitive patterns make text feel artificial
- Lack of personal voice weakens credibility
- Publishers and readers can detect "AI-sounding" content
- Your expertise and unique perspective should shine through

**This is not about detecting whether you used AI** - it's about ensuring the final content sounds authentically YOURS, regardless of how it was drafted.

---

## How This Works

### Questions I'll Ask:

1. **Which chapters to analyze?**
   - Specific chapters (e.g., "Chapter 3, 5, 7")
   - All chapters
   - Range (e.g., "Chapters 1-5")
   - Front/Back matter (optional)

2. **Analysis depth?**
   - **Quick scan** (5-10 minutes): Flag obvious AI patterns, basic scoring
   - **Standard analysis** (15-25 minutes): Detailed report with examples
   - **Comprehensive review** (30-45 minutes): Deep analysis with rewrite suggestions

3. **Focus areas?** (or analyze all)
   - Generic language and clichés
   - Missing personal voice/expertise
   - Repetitive phrasing patterns
   - Sentence structure uniformity
   - Hedging language overuse
   - Generic transitions

---

## AI Text Indicators I'll Scan For

### 1. Generic Transitions
**Indicators:**
- "Moreover", "Furthermore", "Additionally", "In conclusion"
- "It's worth noting that...", "It's important to understand..."
- "On the other hand", "Nevertheless", "Consequently"
- Overuse of transition phrases (>3 per page)

**Why problematic:**
- Sounds like academic essay, not engaging nonfiction
- Creates robotic, predictable flow
- Weakens narrative momentum

### 2. Repetitive Phrasing Patterns
**Indicators:**
- Same sentence openings ("This is...", "The key is...", "It's important to...")
- Repeated structural patterns (3+ similar sentences in a row)
- Formulaic paragraph openings
- Echo words/phrases across paragraphs

**Why problematic:**
- Creates monotonous reading experience
- Suggests template-based generation
- Lacks natural variation

### 3. Excessive Hedging Language
**Indicators:**
- "might", "could", "possibly", "potentially", "arguably"
- "some experts suggest", "research indicates", "it may be"
- Overqualification (>5 hedges per page)
- Tentative tone when authority is appropriate

**Why problematic:**
- Undermines your expertise
- Sounds unsure or uncommitted
- Weakens persuasive impact

### 4. Lack of Specific Examples
**Indicators:**
- Vague references ("many people", "most experts")
- Generic scenarios ("for example, consider a situation where...")
- Missing concrete data, names, case studies
- Abstract descriptions without grounding

**Why problematic:**
- Reduces credibility
- Fails to illustrate concepts
- Sounds theoretical rather than practical

### 5. Overly Formal/Stiff Language
**Indicators:**
- Academic jargon when plain language would work
- Long, complex sentence structures
- Passive voice overuse (>20% of sentences)
- Formal register inconsistent with target audience

**Why problematic:**
- Creates distance from reader
- Reduces accessibility
- Doesn't match conversational nonfiction style

### 6. Missing Personal Voice
**Indicators:**
- No first-person perspective (where appropriate)
- Absence of personal anecdotes or experiences
- Generic "best practices" without unique insights
- Sounds like it could be written by anyone

**Why problematic:**
- Readers connect with authors, not AI
- Your expertise and perspective are the value
- Memorable books have distinctive voices

### 7. Uniform Sentence Structure
**Indicators:**
- All sentences 15-25 words
- Subject-verb-object repetition
- Lack of short, punchy sentences
- No sentence variety (simple, compound, complex)

**Why problematic:**
- Creates monotonous rhythm
- Lacks emphasis and pacing
- Sounds machine-generated

### 8. Overuse of Lists and Bullet Points
**Indicators:**
- Every section has bulleted lists
- Concepts always broken into numbered points
- Lack of narrative flow
- List-heavy pages (>50% lists)

**Why problematic:**
- Can feel formulaic
- Reduces narrative engagement
- May signal lack of integration

### 9. Generic "Best Practices" Language
**Indicators:**
- "best practices", "key takeaways", "important considerations"
- "tips and tricks", "proven strategies", "essential steps"
- Buzzwords without substance
- Corporate-speak in general audience book

**Why problematic:**
- Sounds like blog post or webinar
- Lacks depth and originality
- Readers expect more from books

### 10. Absence of Conversational Elements
**Indicators:**
- No rhetorical questions
- No direct reader address ("you" language missing)
- No informal asides or commentary
- Sounds like textbook, not conversation

**Why problematic:**
- Creates one-way lecture feel
- Misses opportunity for engagement
- Conversational tone is hallmark of popular nonfiction

---

## Analysis Report Format

### Summary Report

```markdown
# AI Detection Analysis Report

**Generated:** [DATE]
**Chapters Analyzed:** [List]
**Analysis Depth:** [Quick/Standard/Comprehensive]

## Overall Authenticity Scores

| Chapter | Score | Grade | Issues Found | Priority |
|---------|-------|-------|--------------|----------|
| Chapter 1 | 7/10 | B | Generic transitions, hedging | Medium |
| Chapter 2 | 4/10 | D | Missing voice, repetitive | HIGH |
| Chapter 3 | 9/10 | A | Minor (good!) | Low |

**Average Score:** 6.7/10
**Chapters needing attention:** 2 (Chapter 2 critical)

## Priority Summary

**CRITICAL (Score 1-4):** 1 chapter
- Chapter 2: Extensive AI patterns, lacks personal voice

**MODERATE (Score 5-7):** 1 chapter
- Chapter 1: Some generic language, easily fixable

**MINOR (Score 8-10):** 1 chapter
- Chapter 3: Authentic voice, minimal issues
```

### Per-Chapter Analysis

```markdown
## Chapter 2: Research Methods (Score: 4/10) ⚠️ CRITICAL

### Issues Found:

**1. Generic Transitions (8 instances)**
Severity: High

Lines 45-67:
> "Moreover, the survey method provides valuable insights. Furthermore, it's
> important to understand that sample size matters. Additionally, response
> rates can vary."

**Problem:** Three generic transitions in three sentences - sounds robotic

**Suggestion:**
> "The survey method provides valuable insights, but sample size matters more
> than most researchers realize. Response rates? They can vary wildly depending
> on your approach."

---

**2. Missing Personal Voice (throughout)**
Severity: Critical

Lines 120-145:
> "Many researchers find that qualitative methods are effective. Some experts
> suggest using mixed methods. It's worth noting that each approach has merits."

**Problem:** No personal authority, all vague references

**Suggestion:**
> "In twenty years of research, I've learned that qualitative methods reveal
> nuances you'll never find in numbers. My approach? Mix methods ruthlessly -
> interviews give you the 'why' that surveys miss."

---

**3. Excessive Hedging (12 instances)**
Severity: Moderate

Lines 89-95:
> "This approach might be effective in some situations and could potentially
> lead to better results, arguably improving outcomes."

**Problem:** Four hedges in one sentence - sounds uncertain

**Suggestion:**
> "This approach works. I've used it successfully in [specific project], and
> it improved outcomes by [specific result]."

### Authenticity Score Breakdown:
- Voice/Expertise: 2/10 (no personal perspective)
- Specificity: 3/10 (vague examples)
- Language: 5/10 (too formal)
- Variety: 4/10 (repetitive)

### Recommended Actions (Priority Order):
1. **Add personal anecdotes** (3-5 from your research experience)
2. **Replace generic references** ("many researchers" → specific names/studies)
3. **Remove hedging language** (state findings confidently)
4. **Vary sentence structure** (add short punchy sentences)
5. **Replace transitions** (use narrative flow instead)

### Estimated Revision Time: 2-3 hours
```

### Rewriting Examples

```markdown
## Before/After Examples

### Example 1: Generic to Specific

**Before (AI-sounding):**
> "Many experts in the field suggest that participant engagement is important.
> It's worth noting that response rates can vary depending on methodology.
> Research indicates that careful planning improves outcomes."

**After (Authentic voice):**
> "Want participants to engage? Here's what worked in my 2019 healthcare study:
> We ditched the 50-question survey and asked 12 targeted questions. Response
> rate jumped from 23% to 67%. The difference? We respected their time."

**Changes:**
- Added specific project (healthcare study, 2019)
- Used concrete numbers (50 → 12 questions, 23% → 67%)
- Personal perspective ("my study", "we")
- Conversational tone ("Want...?", "Here's what...")

---

### Example 2: Hedging to Confident

**Before (AI-sounding):**
> "This approach could potentially be useful in situations where researchers
> might need to gather qualitative data. It's possible that it may lead to
> better insights, arguably improving the research outcomes."

**After (Authentic voice):**
> "Use this approach when you need qualitative richness over quantitative
> breadth. It works. In my dissertation research, it uncovered three patterns
> that survey data completely missed."

**Changes:**
- Removed all hedging (could, potentially, might, possibly, arguably)
- Added personal authority (dissertation research)
- Specific result (three patterns)
- Direct statement ("It works")

---

### Example 3: Generic Transition to Natural Flow

**Before (AI-sounding):**
> "Survey methodology has several advantages. Moreover, it provides quantitative
> data. Furthermore, it's cost-effective. In conclusion, surveys are valuable
> research tools."

**After (Authentic voice):**
> "Surveys give you quantitative data quickly and cheaply. But here's the
> catch: cheap data isn't always good data. The survey that took me two weeks
> to design yielded insights I'm still using five years later. The one I rushed?
> Worthless."

**Changes:**
- Removed transitions (Moreover, Furthermore, In conclusion)
- Added narrative tension ("But here's the catch")
- Personal experience (specific timeframes)
- Conversational asides
- Varied sentence length
```

---

## Cross-Chapter Comparison

```markdown
## Consistency Analysis

**Voice consistency:** Chapter 3 uses personal anecdotes; Chapters 1-2 do not
**Recommendation:** Add similar personal touches to Chapters 1-2

**Formality mismatch:** Chapter 1 is conversational; Chapter 2 is academic
**Recommendation:** Revise Chapter 2 to match Chapter 1's tone

**Specificity variance:** Chapter 3 has 12 named examples; Chapter 2 has 0
**Recommendation:** Add concrete examples to Chapter 2
```

---

## Integration with Workflow

### After Analysis

**Option 1: Apply via Prompt 4 (Interactive_Change)**
```
You: Execute Prompt 4
Me: Which file?
You: Chapter 2
Me: What changes?
You: [Use recommendations from this report]
```

**Option 2: Apply via Prompt 3 (Change_by_Chg)**
1. Open `Chapter_02_chg.md`
2. Add instructions based on this report
3. Execute Prompt 3

**Option 3: Save Report and Update README (Automatic)**
See the "Save Report and Update README.md" section below for automatic report saving.

---

## Save Report and Update README.md (v0.12.8+)

**After generating the AI detection analysis report:**

### Step 1: Create Reports Directory (if needed)

```bash
mkdir -p Manuscript/Reports
```

### Step 2: Determine Report Filename

Based on scope:
- **Single chapter analysis:** `ai-detection-chapter-XX-YYYY-MM-DD.md`
- **Full-book analysis (multiple chapters):** `ai-detection-YYYY-MM-DD.md`

Use `CONFIRMED_DATE` for the date (from session startup).

**Examples:**
- `ai-detection-chapter-03-2025-11-21.md` (Chapter 3 only on Nov 21, 2025)
- `ai-detection-2025-11-21.md` (full book analysis on Nov 21, 2025)

**Note:** If file exists (same scope and date), it will be overwritten.

### Step 3: Save Report

Write the complete AI detection analysis report to the determined filename in `Manuscript/Reports/`.

### Step 4: Update README.md

**Follow `Process/_COMMON/17_README_Management_Module.md` to regenerate README.md.**

1. Read `.config/metadata.json` for Project Information
2. Read init.json or PROJECT_CONTEXT.md for About This Book
3. Scan `Manuscript/Reports/` for all reports (ai-detection-*.md and consistency-*.md)
4. Check if `Manuscript/Dashboard/Dashboard.md` exists
5. Regenerate README.md with:
   - Updated AI Detection Analysis table (5 most recent, newest first)
   - Preserved Consistency Check Reports table (if exists)
   - Dashboard link (if Dashboard.md exists)
   - All metadata sections

**Link text for new report:**
- Single chapter: `[Chapter X Analysis](...)`
- Full-book: `[Full Book Analysis](...)`

### Step 5: Inform User

Display message:
```
✓ AI detection report saved: Manuscript/Reports/[filename]
✓ README.md updated with report link
```

---

## Scoring Rubric

**10/10 - Exceptional Authenticity**
- Strong personal voice throughout
- Specific examples and anecdotes
- Natural, varied sentence structure
- Conversational and engaging
- No AI patterns detected

**8-9/10 - Very Good**
- Clear personal perspective
- Some specific examples
- Mostly natural flow
- Minor AI patterns (1-2)

**6-7/10 - Good with Issues**
- Personal voice present but inconsistent
- Generic language in places
- Some repetitive patterns
- Needs moderate revision

**4-5/10 - Needs Significant Work**
- Weak or missing personal voice
- Multiple AI patterns detected
- Generic examples
- Requires substantial revision

**1-3/10 - Critical Issues**
- Sounds entirely AI-generated
- No personal voice
- Extensive generic language
- Complete rewrite recommended

---

## Important Notes

### This Analysis Is About Quality, Not Judgment

**I'm not checking if you used AI** - I'm helping ensure your content sounds authentically YOURS.

**Valid uses of AI:**
- Drafting assistance
- Structural suggestions
- Editing help
- Research support

**The goal:** Your final content should reflect your expertise, voice, and unique perspective - regardless of drafting method.

### Limitations

**What this analysis CAN'T do:**
- Definitively prove AI-generation (patterns can occur naturally)
- Guarantee publisher/reader acceptance
- Replace human editorial feedback
- Account for intentional stylistic choices

**What this analysis CAN do:**
- Flag patterns common in AI text
- Identify areas lacking personal voice
- Suggest authenticity improvements
- Help you strengthen your unique perspective

### When to Run This Prompt

**Recommended timing:**
- After drafting each chapter (before finalizing)
- Before major milestones (25%, 50%, 75%, 100%)
- Before submission to editors or beta readers
- Before publication
- When you suspect a section feels "off"

**How often:**
- At least once per chapter during drafting
- Full manuscript scan before submission

---

## Process/_COMMON Modules Used

This prompt uses:
- **Module 01:** Prompt Structure Template
- **Module 02:** Desktop Compatibility (CLI-ONLY)
- **Module 03:** Anti-Hallucination Protocols (Level 1 - read-only analysis)
- **Module 06:** Validation Protocols (file existence, chapter checks)
- **Module 09:** Report Templates (analysis report formatting)
- **Module 11:** Interactive Patterns (user questions)

---

## Git Integration (v0.12.8+)

**This prompt is READ-ONLY for manuscript content** - it analyzes content but makes no modifications to chapters.

**Files created/modified:**
- `Manuscript/Reports/ai-detection-[...].md` (new report)
- `README.md` (updated with report link)

**Git commit recommended** after report generation to track analysis history.

**To apply recommendations:**
- Use Prompt 4 (Interactive_Change) for conversational edits
- Use Prompt 3 (Change_by_Chg) for direct application

---

## Ready to Begin?

**Tell me which chapters you want analyzed, and I'll scan for AI text indicators!**

Recommendations will be actionable, specific, and designed to strengthen your unique voice and expertise.

---

*Created: v0.11.0*
*Purpose: Content authenticity and voice analysis*
*Type: Quality control - read-only analysis*

---

## Session Cleanup

**After this prompt completes:**

Tell user: "✓ Prompt 13 AI Detection Analysis complete.

To free up tokens for your next task, you can say:
**'Clear Prompt 13 AI Detection Analysis from context'**

This will reclaim tokens for your next operation."
