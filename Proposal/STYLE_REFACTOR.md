# Style Library Refactoring Proposal

**Proposal ID:** REFACTOR-001
**Version:** 1.0.0
**Date:** 2025-11-22
**Status:** DRAFT
**Target Version:** 0.13.0

---

## Executive Summary

Refactor the monolithic `Process/Style_Examples.md` (650 lines, 9 styles) into a modular style library to support scaling from 9 to 19+ styles while improving performance, maintainability, and user experience.

**Key Changes:**
- Split single 650-line file into modular category-based directory structure
- Create lightweight catalog for browsing (250 lines)
- Individual style files (80-100 lines each)
- Add 10 new styles organized by purpose/genre (total: 19 styles)
- Update Prompt 1 for progressive disclosure UX with category browsing
- Introduce complexity/expertise level dimension for audience targeting

---

## Problem Statement

### Current Limitations

**1. Scalability Issues**
- `Style_Examples.md` is 650 lines for 9 styles (~72 lines per style)
- Adding 6 more styles → 1,080 lines (unwieldy)
- Adding 15 more styles → 1,730 lines (unmanageable)
- Single file becomes bottleneck for browsing and selection

**2. Performance Impact**
- Prompt 1 must read entire 650-line file to show styles
- User only needs 1 style, but reads all 9
- Token usage: 650 lines regardless of selection
- Slower initialization for users

**3. Maintenance Challenges**
- Updating one style requires editing large file
- Git diffs show entire file as changed
- Risk of accidental changes to other styles
- Hard to track version history per style

**4. User Experience**
- Information overload: 9 full style definitions at once
- No easy way to filter or compare
- Can't preview just example passages
- Difficult to browse 15+ styles

**5. Missing Style Coverage**
- Current 9 styles don't cover important nonfiction genres:
  - Philosophy/ethics
  - Cultural criticism
  - Historical narrative
  - Humor/satire
  - Nature writing
  - Activism/advocacy

---

## Proposed Solution

### Modular Style Library Architecture

```
Process/
└── Styles/                              # NEW: Category-based style library
    ├── Style_Catalog.md                 # Master index (lightweight, ~200 lines)
    ├── README.md                        # Style library usage guide
    │
    ├── Academic/                        # Scholarly & Research (4 styles)
    │   ├── Academic_Authority.md
    │   ├── Scientific_Communicator.md
    │   ├── Technical_Precision.md
    │   └── Medical_Health_Narrative.md
    │
    ├── Professional/                    # Business & Career (2 styles)
    │   ├── Business_Professional.md
    │   └── Conversational_Expert.md
    │
    ├── Narrative/                       # Story-Based Nonfiction (4 styles)
    │   ├── Narrative_Storyteller.md
    │   ├── Historical_Chronicler.md
    │   ├── Investigative_Journalist.md
    │   └── Confessional_Memoir.md
    │
    ├── Personal/                        # Development & How-To (3 styles)
    │   ├── Inspirational_Teacher.md
    │   ├── Practical_Guide.md
    │   └── Philosophical_Contemplative.md
    │
    └── Cultural/                        # Social & Cultural Commentary (6 styles)
        ├── Cultural_Critic.md
        ├── Satirical_Humorist.md
        ├── Activist_Advocate.md
        ├── Lyrical_Nature_Writer.md
        ├── Spiritual_Religious_Writer.md
        └── Sports_Writer.md

Process/Style_Examples.md                # REMOVE (breaking change OK for testing)
```

**Category Rationale:**
- **Academic/** (4 styles) - Scholarly works, research-based books, technical documentation, medical narratives
- **Professional/** (2 styles) - Business books, workplace guides, professional development
- **Narrative/** (4 styles) - History, journalism, memoir (polished and raw), story-based nonfiction
- **Personal/** (3 styles) - Self-help, skills, philosophical inquiry, personal growth
- **Cultural/** (6 styles) - Cultural criticism, humor, advocacy, nature writing, spiritual, sports, essays

**Style Distribution Summary:**

| Category | Count | Styles Included |
|----------|-------|-----------------|
| Academic | 4 | Academic Authority, Scientific Communicator, Technical Precision, Medical/Health Narrative |
| Professional | 2 | Business Professional, Conversational Expert |
| Narrative | 4 | Narrative Storyteller, Historical Chronicler, Investigative Journalist, Confessional Memoir |
| Personal | 3 | Inspirational Teacher, Practical Guide, Philosophical Contemplative |
| Cultural | 6 | Cultural Critic, Satirical Humorist, Activist Advocate, Lyrical Nature Writer, Spiritual/Religious Writer, Sports Writer |
| **Total** | **19** | 111% increase from original 9 |

### File Size Comparison

| Component | Lines | Purpose |
|-----------|-------|---------|
| **Current:** | | |
| Style_Examples.md | 650 | All 9 styles |
| **Proposed:** | | |
| Style_Catalog.md | 200 | Browse all 15 styles |
| Individual style file | 80-100 | Full definition for one style |
| **Typical usage:** | 280 | Catalog + 1 selected style |
| **Savings:** | 57% | 370 fewer lines for typical flow |

---

## New Catalog Format

### Style_Catalog.md Structure

**Purpose:** Lightweight index for category-based browsing and selection

**Contents:**
1. How to use the catalog
2. Academic & Research category (3 styles)
3. Business & Professional category (2 styles)
4. Narrative & Storytelling category (3 styles)
5. Personal Development & How-To category (3 styles)
6. Cultural & Social Commentary category (4 styles)
7. Multi-dimensional browsing (formality, voice, alphabetical)
8. File paths for each style

**Format:** (See full catalog in Appendix C)

```markdown
## Academic & Research (3 styles)

**Best for:** Scholarly works, research-based books, scientific writing, technical documentation

| Style | File | Key Characteristics |
|-------|------|---------------------|
| Academic Authority | `Academic/Academic_Authority.md` | Formal, evidence-based, third person, citations |
| Scientific Communicator | `Academic/Scientific_Communicator.md` | Accessible science, wonder + rigor |
| Technical Precision | `Academic/Technical_Precision.md` | Systematic, detailed, procedural |

**Choose Academic Authority if:** Writing for peer review, policy analysis, academic audiences
**Choose Scientific Communicator if:** Popular science, making complex science accessible
**Choose Technical Precision if:** Technical guides, engineering, systematic methodologies

---

## Business & Professional (2 styles)

**Best for:** Management books, leadership guides, workplace improvement

| Style | File | Key Characteristics |
|-------|------|---------------------|
| Business Professional | `Professional/Business_Professional.md` | Action-oriented, frameworks |
| Conversational Expert | `Professional/Conversational_Expert.md` | Engaging "you", accessible expertise |

[... continues for all 5 categories ...]

---

## Browse by Formality Level

**High:** Academic Authority, Technical Precision
**Moderate:** Business Professional, Scientific Communicator, Historical Chronicler, [...]
**Low:** Conversational Expert, Practical Guide, Satirical Humorist

---

## Browse by Voice/Person

**Third Person:** Academic Authority, Technical Precision, Investigative Journalist
**Second Person ("you"):** Conversational Expert, Practical Guide, Inspirational Teacher
**First Person:** Narrative Storyteller, Lyrical Nature Writer
**Mix/Plural ("we"):** Business Professional, Philosophical Contemplative, Activist Advocate

---

## Alphabetical Index

[All 15 styles with category paths]
```

---

## Individual Style File Format

### Template Structure

Each style file (80-100 lines):

```markdown
# [Style Name]

**Category:** Academic | Professional | Narrative | Personal | Cultural
**Internal Name:** FW_[StyleName]
**Version:** 1.0.0
**Last Updated:** [Date]

---

## Overview

**Best For:** [Genres/book types]
**Description:** [One paragraph summary]

---

## Voice Characteristics

**Person:** [First/second/third person usage]
**Formality:** [High/moderate/low with description]
**Sentence Structure:** [Patterns and techniques]
**Vocabulary:** [Level and approach]

---

## Tone

[Paragraph describing tone with key attributes]

**Sample Phrases:**
- "[Example phrase 1]"
- "[Example phrase 2]"
- "[Example phrase 3]"
- "[Example phrase 4]"

---

## Pacing

**Density:** [Words per major concept]
**Examples:** [Types of examples used]
**Breaks:** [Paragraph/section break patterns]

---

## Structure

**Approach:** [Organizational philosophy]
**Pattern:** [Typical content flow]

---

## Example Passage

> [150-250 word example passage demonstrating the style]

---

## DO

- [Guideline 1]
- [Guideline 2]
- [Guideline 3]
[... 4-7 guidelines total ...]

---

## DON'T

- [Anti-pattern 1]
- [Anti-pattern 2]
- [Anti-pattern 3]
[... 4-6 anti-patterns total ...]

---

**End of Style Definition**
```

---

## Ten New Styles (Expanding Genre Coverage)

### 1. Philosophical Contemplative

**Best For:** Philosophy, ethics, existential inquiry, big questions
**Description:** Thoughtful examination of fundamental questions through careful reasoning and reflection. Invites reader into sustained inquiry without demanding answers.

**Fills Gap:** No current style for philosophical inquiry or contemplative examination of meaning, ethics, consciousness.

**Voice:** First person plural ("we") and second person for shared inquiry
**Formality:** Moderate - intellectually serious but approachable
**Key Phrases:** "Consider what this means...", "We might ask ourselves...", "What if we're wrong about..."

---

### 2. Cultural Critic & Essayist

**Best For:** Cultural commentary, social criticism, essay collections, media analysis
**Description:** Insightful analysis of culture and society with distinctive voice. Combines sharp observation with elegant prose. Personal yet analytical.

**Fills Gap:** No current style for cultural criticism, social commentary, or essayistic writing.

**Voice:** Mix of first person observation and third person analysis
**Formality:** Moderate - sophisticated but not academic
**Key Phrases:** "Notice how we've normalized...", "There's something revealing about...", "The cultural script demands..."

---

### 3. Historical Chronicler

**Best For:** History books, historical biography, narrative history
**Description:** Brings the past alive through vivid narrative while maintaining historical accuracy. Balances storytelling with scholarly rigor.

**Fills Gap:** No current style for historical narrative (distinct from memoir or academic history).

**Voice:** Third person narrative with occasional first person plural for reflection
**Formality:** Moderate - narrative engagement with historical authority
**Key Phrases:** "By the summer of [year]...", "What [person] couldn't have known...", "The historical record shows..."

---

### 4. Satirical Humorist

**Best For:** Humorous nonfiction, satirical social commentary, comedic memoirs
**Description:** Uses humor, irony, and satire to illuminate truth. Makes serious points through comedic lens. Entertains while informing.

**Fills Gap:** None of the current 9 styles use humor as a primary tool.

**Voice:** First person or second person; creates intimacy for comedic effect
**Formality:** Low - conversational with comedic timing
**Key Phrases:** "Here's the thing nobody tells you...", "I'm not saying [X], but...", "Somehow we've decided that..."

---

### 5. Lyrical Nature Writer

**Best For:** Nature writing, environmental memoirs, place-based nonfiction, travel writing
**Description:** Poetic attention to the natural world with vivid sensory detail. Combines scientific accuracy with aesthetic appreciation.

**Fills Gap:** No current style for lyrical, place-based, or environmental writing.

**Voice:** First person observation; occasionally second person invitation
**Formality:** Moderate - literary without pretension
**Key Phrases:** "Watch how the...", "I have learned that...", "The [animal/plant] teaches us...", "In this landscape, time..."

---

### 6. Activist Advocate

**Best For:** Social justice, advocacy, political manifestos, systemic change
**Description:** Passionate call to action grounded in evidence and moral clarity. Combines personal conviction with rigorous analysis. Mobilizes readers toward change.

**Fills Gap:** No current style for advocacy, social justice writing, or movement-building.

**Voice:** First person plural ("we") to build collective identity; second person for appeal
**Formality:** Moderate - serious but accessible
**Key Phrases:** "We can no longer accept...", "The time has come to...", "This is not about... it's about..."

---

### 7. Spiritual/Religious Writer

**Best For:** Theology, spirituality, faith-based reflection, contemplative writing, interfaith dialogue
**Description:** Explores the transcendent and sacred through personal experience and spiritual tradition. Invites readers into questions of faith, meaning, and the divine while respecting diverse belief systems.

**Fills Gap:** Current Philosophical Contemplative is secular; this addresses spiritual/religious experience and theological reflection.

**Voice:** Reverent, contemplative, invitational
**Formality:** Moderate - thoughtful but accessible
**Key Phrases:** "In the silence, I found...", "The sacred tradition teaches us...", "Faith asks us to...", "We encounter the divine when..."

---

### 8. Confessional Memoir

**Best For:** Trauma narratives, addiction memoirs, identity exploration, raw personal revelation
**Description:** Unflinching honesty about difficult experiences. Reveals the messy, complicated truth of being human. Vulnerability as a form of connection and truth-telling.

**Fills Gap:** Narrative Storyteller is polished and crafted; this is intentionally raw, intimate, and emotionally intense.

**Voice:** First person, confessional, unvarnished
**Formality:** Low - conversational intimacy, sometimes fragmented
**Key Phrases:** "I need to tell you the truth...", "What I haven't said is...", "Here's what actually happened...", "I'm not proud of this, but..."

---

### 9. Medical/Health Narrative

**Best For:** Illness narratives, medical memoirs, patient experience, healthcare insights, body/health journeys
**Description:** Combines medical knowledge with deeply human experience of illness, healing, and mortality. Bridges clinical understanding and lived reality of being in a body.

**Fills Gap:** Scientific Communicator explains science; this is about living through medical experience with both expertise and vulnerability.

**Voice:** First person or compassionate third person; medical insight + human intimacy
**Formality:** Moderate - professional knowledge made personal
**Key Phrases:** "The diagnosis came on...", "What the textbooks don't tell you...", "My body was teaching me...", "Between doctor and patient..."

---

### 10. Sports Writer

**Best For:** Sports narratives, athletic memoirs, game analysis, sports culture, competition
**Description:** Captures the drama, strategy, and human stories within sports. Uses athletics as lens to explore character, competition, culture, and what it means to pursue excellence.

**Fills Gap:** Sports as both spectacle and metaphor; athletic experience and sports culture analysis.

**Voice:** Energetic, detailed, passionate; can be first-person athlete or third-person observer
**Formality:** Low to moderate - accessible enthusiasm
**Key Phrases:** "In the final seconds...", "The game taught me...", "What separates champions from...", "On the field, you learn..."

---

## Complexity/Expertise Level Dimension

### Overview

In addition to category and style, the framework introduces a **Complexity Level** dimension to target different audience expertise levels. This allows the same base style to be calibrated for different reading levels without creating separate styles.

### The Four Complexity Levels

**1. Accessible (High School / General Public)**
- Simple sentence structures (15-20 words average)
- Define all specialized terms
- Concrete examples and analogies
- Minimal jargon
- Clear transitions and signposting

**2. Intermediate (Undergraduate / Educated General)**
- Mix of simple and complex sentences (20-25 words average)
- Introduce specialized terms with brief definitions
- Balance concrete and abstract concepts
- Some disciplinary language with context
- Assumes general education background

**3. Advanced (Graduate / Specialist)**
- Complex sentence structures (25-30 words average)
- Use specialized terminology with minimal explanation
- Abstract concepts and theoretical frameworks
- Assumes disciplinary knowledge
- Nuanced argumentation

**4. Expert (Professional / Academic)**
- Full disciplinary complexity (30+ words average)
- Specialized terminology without definition
- Dense theoretical engagement
- Assumes expert background
- Field-specific conventions

### How It Works with Different Styles

**Academic Authority:**
- Accessible: Popular academic writing (Malcolm Gladwell level)
- Intermediate: Upper-level undergraduate textbook
- Advanced: Graduate seminar reading
- Expert: Peer-reviewed journal article

**Conversational Expert:**
- Accessible: General business book (friendly, simple)
- Intermediate: Professional development book (HBR article level)
- Advanced: Sophisticated business analysis (McKinsey report level)
- Expert: Peer-to-peer executive communication

**Narrative Storyteller:**
- Accessible: Young adult memoir style
- Intermediate: Literary memoir (general audience)
- Advanced: Literary complexity (craft-focused)
- Expert: Experimental narrative techniques

**Confessional Memoir:**
- Accessible: Direct, simple emotional honesty
- Intermediate: Reflective complexity on experience
- Advanced: Sophisticated self-analysis and cultural context
- Expert: Meta-narrative and literary experimentation

**Note:** Not all styles benefit equally from complexity levels. Narrative, Personal, and some Cultural styles may have less variation across levels, while Academic and Professional styles show significant differentiation.

### Implementation in Framework

**During Prompt 1 (Initialize):**

After user selects style, ask:

```
"What is your target audience's expertise level?

1. Accessible - General public, high school level
2. Intermediate - College-educated general audience
3. Advanced - Graduate-level or specialists in your field
4. Expert - Professional academics or field experts

This helps calibrate vocabulary, sentence complexity, and assumed knowledge.
Your choice: [1-4]"
```

**Stored in Style_Guide.md:**

```markdown
**Selected Style:** Conversational Expert
**Category:** Professional
**Complexity Level:** Intermediate
**Target Audience:** College-educated professionals
```

**Applied during writing:**

The complexity level informs:
- Vocabulary choices
- Sentence length and structure
- How much to define/explain concepts
- Example selection (concrete vs. abstract)
- Assumed background knowledge

**Can be overridden:**

Like style overrides, complexity level can be adjusted for specific chapters:

```markdown
<!-- COMPLEXITY_OVERRIDE: Accessible -->
This chapter introduces concepts to a general audience...
<!-- END_COMPLEXITY_OVERRIDE -->
```

### Guidelines by Complexity Level

**Accessible:**
- Average sentence: 15-20 words
- Reading level: Grades 9-12
- Define terms: Always define specialized vocabulary
- Examples: Concrete, everyday, relatable
- Transitions: Explicit ("First,", "Therefore,", "In other words,")

**Intermediate:**
- Average sentence: 20-25 words
- Reading level: College/educated general
- Define terms: Define on first use, assume retention
- Examples: Mix of concrete and conceptual
- Transitions: Smooth, less explicit

**Advanced:**
- Average sentence: 25-30 words
- Reading level: Graduate/specialist
- Define terms: Assume familiarity with discipline
- Examples: Abstract, theoretical, field-specific
- Transitions: Subtle, implied connections

**Expert:**
- Average sentence: 30+ words
- Reading level: Professional/academic
- Define terms: Field-specific without explanation
- Examples: Cutting-edge, field-advancing
- Transitions: Dense argumentative flow

### Example: Same Content at Different Levels

**Topic:** Explaining cognitive load theory

**Accessible (High School):**
> Your brain can only hold so much information at once. Think of it like your phone's memory—if you have too many apps open, everything slows down. This is called "cognitive load." When you're learning something new, you want to keep the load light so your brain can actually process the information. That's why good teachers break complex topics into smaller chunks.

**Intermediate (Undergraduate):**
> Cognitive load theory, developed by John Sweller in the 1980s, proposes that working memory has limited capacity. When instructional design exceeds this capacity, learning suffers. Effective teaching manages three types of load: intrinsic (inherent complexity), extraneous (poor presentation), and germane (productive processing). By reducing extraneous load and optimizing germane load, educators enhance learning outcomes.

**Advanced (Graduate):**
> Sweller's cognitive load theory (1988) posits that working memory constraints fundamentally shape instructional efficacy. The tripartite framework—intrinsic, extraneous, and germane load—provides a theoretical lens for analyzing pedagogical interventions. Empirical research demonstrates that schema acquisition and automation are mediated by load optimization, with germane load serving as the primary mechanism for long-term knowledge consolidation.

**Expert (Academic):**
> CLT's theoretical architecture rests on the evolutionary psychology of cognition (Sweller, 2003; Paas & Sweller, 2014), specifically the differentiation between biologically primary knowledge (evolved capacities) and biologically secondary knowledge (cultural transmission). The germane-intrinsic distinction has been reconceptualized (Kalyuga, 2011) to reflect element interactivity's role in schema construction, while recent neurocognitive evidence (Kriegbaum et al., 2018) suggests load-induced activation patterns in the prefrontal cortex correlate with long-term retention.

---

## Impact on Prompts

### Prompt 1: Initialize (Major Changes)

**Current Flow:**
1. Read `Process/Style_Examples.md` (650 lines)
2. Show all 9 styles with full definitions
3. User selects
4. Copy to `Manuscript/Style/Style_Guide.md`

**New Flow:**
1. Read `Process/Styles/Style_Catalog.md` (250 lines)
2. Show organized catalog table (19 styles across 5 categories)
3. Offer category-based browsing
4. User selects category and style
5. **[Optional]** Ask about complexity/expertise level (Accessible/Intermediate/Advanced/Expert)
6. **[Optional]** Show example passage preview (15 lines from individual file)
7. Read full selected style file (80 lines)
8. Copy to `Manuscript/Style/Style_Guide.md` with metadata including complexity level

**Benefits:**
- Faster browsing (200 lines vs 650)
- Progressive disclosure UX
- Can preview multiple styles easily
- Better genre-based guidance
- Token savings: ~280 lines typical vs 650

**Example User Experience:**

```
Claude: I've loaded 15 writing styles organized into 5 categories:

        1. Academic & Research (3 styles)
        2. Business & Professional (2 styles)
        3. Narrative & Storytelling (3 styles)
        4. Personal Development & How-To (3 styles)
        5. Cultural & Social Commentary (4 styles)

        Which category best fits your book? (1-5, or 'browse all')

User:   4

Claude: Great! Here are the Personal Development & How-To styles:

        1. Inspirational Teacher - Uplifting, transformational
        2. Practical Guide - Step-by-step how-to
        3. Philosophical Contemplative - Reflective inquiry into big questions

        Would you like to see example passages? (Enter numbers to compare)

User:   1, 3

Claude: [Reads Personal/Inspirational_Teacher.md - shows example]
        [Reads Personal/Philosophical_Contemplative.md - shows example]

        Which style resonates more with your vision?

User:   1

Claude: Perfect! Setting Inspirational Teacher as your book style.
        [Reads full Personal/Inspirational_Teacher.md]
        [Creates Manuscript/Style/Style_Guide.md with complete definition]

        ✅ Style configured!
```

---

### Prompt 11: Style Manager (Minor Changes)

**Current:** Reads `Style_Examples.md` to list available styles for overrides
**New:** Reads `Style_Catalog.md` for listing, individual files for setting overrides

**Benefit:** Lighter catalog read for listing, full definition only when needed

---

### Prompt 8: Consistency (Minor Changes)

**Current:** References `Style_Examples.md` when validating style consistency
**New:** References `Style_Catalog.md` for style names, individual files if deep validation needed

**Benefit:** Minimal token usage for style name validation

---

### Other Prompts: No Changes

Prompts 2-7, 9-10, 12-16 reference style indirectly through `Style_Guide.md` - no changes needed.

---

## Benefits Summary

### 1. Scalability
- ✅ Grow from 9 → 15 → 30+ styles without bloat
- ✅ Each style ~80-100 lines (manageable)
- ✅ Add new styles without touching existing ones

### 2. Performance
- ✅ Token savings: 280 lines typical vs 650 current (57% reduction)
- ✅ Read only what's needed
- ✅ Faster style selection in Prompt 1

### 3. Maintainability
- ✅ Update individual styles independently
- ✅ Clear git diffs (changed style file only)
- ✅ Version control per style
- ✅ Easy to add metadata (version, author, last updated)

### 4. User Experience
- ✅ Progressive disclosure (catalog → preview → full)
- ✅ Genre-based filtering
- ✅ Compare multiple styles side-by-side
- ✅ No information overload

### 5. Extensibility
- ✅ Future: Style questionnaire/wizard
- ✅ Future: Search/filter by attributes
- ✅ Future: Community-contributed styles
- ✅ Future: Style versioning and updates

### 6. Genre Coverage
- ✅ Adds philosophy, cultural criticism, history
- ✅ Adds humor, nature writing, activism
- ✅ Adds spiritual/religious, confessional memoir, medical narrative, sports
- ✅ Covers significantly more nonfiction genres (19 vs 9 = 111% increase)

---

## Migration Strategy

### Breaking Change (Testing Phase)

Since framework is in testing (v0.12.8), **breaking changes are acceptable**.

**Implementation Plan:**

1. **Create new structure** (`Process/Styles/`)
2. **Create catalog** (`Style_Catalog.md`)
3. **Split 9 core styles** into individual files
4. **Add 6 extended styles** with full definitions
5. **Create README** for style library
6. **Update Prompt 1** with new selection flow
7. **Update Prompt 11** to reference catalog
8. **Update Prompt 8** for catalog reference
9. **Remove** `Style_Examples.md` (breaking)
10. **Update documentation** (CLAUDE.md, system-instructions.md, main docs)

**No backward compatibility needed** - clean break for testing phase.

---

## File Checklist

### Files to Create

**Catalog & Guide:**
- [ ] `Process/Styles/Style_Catalog.md` (master index with category organization)
- [ ] `Process/Styles/README.md` (usage guide)

**Academic Category (4 styles):**
- [ ] `Process/Styles/Academic/Academic_Authority.md`
- [ ] `Process/Styles/Academic/Scientific_Communicator.md`
- [ ] `Process/Styles/Academic/Technical_Precision.md`
- [ ] `Process/Styles/Academic/Medical_Health_Narrative.md`

**Professional Category (2 styles):**
- [ ] `Process/Styles/Professional/Business_Professional.md`
- [ ] `Process/Styles/Professional/Conversational_Expert.md`

**Narrative Category (4 styles):**
- [ ] `Process/Styles/Narrative/Narrative_Storyteller.md`
- [ ] `Process/Styles/Narrative/Historical_Chronicler.md`
- [ ] `Process/Styles/Narrative/Investigative_Journalist.md`
- [ ] `Process/Styles/Narrative/Confessional_Memoir.md`

**Personal Category (3 styles):**
- [ ] `Process/Styles/Personal/Inspirational_Teacher.md`
- [ ] `Process/Styles/Personal/Practical_Guide.md`
- [ ] `Process/Styles/Personal/Philosophical_Contemplative.md`

**Cultural Category (6 styles):**
- [ ] `Process/Styles/Cultural/Cultural_Critic.md`
- [ ] `Process/Styles/Cultural/Satirical_Humorist.md`
- [ ] `Process/Styles/Cultural/Activist_Advocate.md`
- [ ] `Process/Styles/Cultural/Lyrical_Nature_Writer.md`
- [ ] `Process/Styles/Cultural/Spiritual_Religious_Writer.md`
- [ ] `Process/Styles/Cultural/Sports_Writer.md`

### Files to Update

- [ ] `Process/Prompts/Prompt_1_Initialize.md` (style selection section)
- [ ] `Process/Prompts/Prompt_11_Style_Manager.md` (catalog reference)
- [ ] `Process/Prompts/Prompt_8_Consistency.md` (catalog reference)
- [ ] `CLAUDE.md` (update style count and location)
- [ ] `system-instructions.md` (update style references)
- [ ] `Process/AI-Assisted_Nonfiction_Authoring_Process.md` (update style docs)

### Files to Remove

- [ ] `Process/Style_Examples.md` (replaced by modular structure)

---

## Risks and Mitigation

### Risk 1: Breaking Existing Projects
**Impact:** Medium
**Likelihood:** Low (framework in testing)
**Mitigation:**
- Clean break acceptable in testing phase
- Document migration clearly
- Update version to 0.13.0 (minor bump signals breaking change)

### Risk 2: Increased File Count
**Impact:** Low
**Likelihood:** High (17 new files)
**Mitigation:**
- Files are small and well-organized
- Directory structure is logical
- Modular approach is consistent with framework philosophy

### Risk 3: Prompt Complexity
**Impact:** Low
**Likelihood:** Low
**Mitigation:**
- Progressive disclosure simplifies UX
- Clear catalog structure aids navigation
- Example flow provided for Prompt 1

### Risk 4: Maintenance Overhead
**Impact:** Low
**Likelihood:** Low
**Mitigation:**
- Template ensures consistency
- Individual files easier to maintain than monolith
- Git history cleaner per-style

---

## Success Metrics

### Quantitative
- [ ] Token usage reduction: >50% in Prompt 1 style selection
- [ ] File size: No individual style file >150 lines
- [ ] Catalog: <250 lines for all 15+ styles
- [ ] User selection time: Measure before/after (subjective)

### Qualitative
- [ ] User feedback: Easier to browse styles
- [ ] Maintainability: Easier to update individual styles
- [ ] Extensibility: Can add 10 more styles without issues
- [ ] Coverage: Users find styles matching their genre

---

## Timeline

**Target Version:** 0.13.0

**Phase 1: Structure Creation** (1-2 days)
- Create directory structure
- Create catalog
- Split original 9 styles into category folders
- Write 10 new styles with full definitions
- Create README and complexity level documentation

**Phase 2: Prompt Updates** (1 day)
- Update Prompt 1
- Update Prompt 11
- Update Prompt 8
- Test workflows

**Phase 3: Documentation** (1 day)
- Update CLAUDE.md
- Update system-instructions.md
- Update main documentation
- Remove old file

**Phase 4: Testing** (2-3 days)
- Test Prompt 1 with new structure
- Test all style selection flows
- Test override workflows
- User testing feedback

**Total:** 5-7 days

---

## Decision

**Status:** DRAFT - Awaiting approval

**Recommendation:** APPROVE and implement for v0.13.0

**Rationale:**
- Scalability essential for long-term framework growth
- Performance improvements benefit all users
- Better UX for style selection
- 10 new styles fill important genre gaps (bringing total to 19)
- Breaking change acceptable in testing phase
- Modular approach aligns with framework philosophy

---

## Appendix A: Alternative Approaches Considered

### Alternative 1: Keep Single File, Add Metadata
**Description:** Keep `Style_Examples.md`, add YAML frontmatter for filtering
**Rejected Because:** Still requires reading entire file; doesn't solve scalability

### Alternative 2: Core/Extended Subdirectories
**Description:** Organize as `Core/` (original 9) and `Extended/` (new 6)
**Rejected Because:** Creates artificial hierarchy; "Extended" sounds experimental/second-tier; doesn't help users find right style; distinction loses meaning as styles mature

### Alternative 3: Flat Directory (No Subdirectories)
**Description:** All styles in `Process/Styles/` alphabetically, catalog organizes by category
**Considered:** Simple, scalable, no categorization debates
**Why Category-Based is Better:** Physical folder organization helps browsing in file explorers; matches how users think; clearer scope per category; easier for new users to navigate

### Alternative 4: Database/JSON Format
**Description:** Styles as structured data, separate from prose
**Rejected Because:** Less human-readable; more complex; over-engineered for current needs

### Alternative 5: Defer Refactoring
**Description:** Wait until more styles accumulate before refactoring
**Rejected Because:** Better to refactor now before more prompts/projects depend on old structure

---

## Appendix B: Future Enhancements

### Style Wizard (v0.14.0+)
Interactive questionnaire to recommend styles:
- "Is your book primarily narrative or instructional?"
- "What's your target audience's expertise level?"
- "Do you want formal or conversational tone?"
→ Recommends 2-3 best-fit styles

### Community Styles (v1.0.0+)
- Allow users to submit custom styles
- Community review process
- Add to Extended/ or Community/ directory
- Version and maintain separately from Core

### Style Mixing (Future)
- Allow blending characteristics from multiple styles
- "70% Conversational Expert + 30% Narrative Storyteller"
- Generate hybrid style definitions
- More advanced than current override system

### Style Analytics (Future)
- Analyze actual chapter content
- "Your writing currently matches: 60% Conversational Expert, 40% Narrative Storyteller"
- Suggest style adjustments for consistency
- Compare intended vs actual style

### Additional Style Candidates (Not Selected for v0.13.0)

The following genres were identified but not selected for initial implementation. These represent potential future additions as the style library grows:

**From Tier 1 (High Priority - Not Selected):**

1. **True Crime Chronicler**
   - Crime narratives, criminal justice examination, forensic storytelling
   - Why distinct: Crime-specific with dramatic tension (vs. broader Investigative Journalist)
   - Examples: Truman Capote, Michelle McNamara, Ann Rule
   - **Massive audience** - true crime is extremely popular

2. **Literary Journalist / New Journalist**
   - Immersive journalism with literary techniques, personal voice in reporting
   - Why distinct: Emphasizes style/artistry (vs. Investigative's focus on revelation)
   - Examples: Joan Didion, Tom Wolfe, Gay Talese, Susan Orlean
   - **Prestigious genre** - journalism as literature

**From Tier 2 (Medium Priority - Not Selected):**

3. **Food/Culinary Writer**
   - Food memoirs, culinary history, sensory food writing
   - Examples: M.F.K. Fisher, Anthony Bourdain, Ruth Reichl, Michael Pollan
   - Voice: Sensory-rich, cultural/personal through food

4. **Political Analyst**
   - Political theory, current affairs analysis, political commentary
   - Why distinct: Analytical (vs. Activist Advocate's mobilizing focus)
   - Examples: Ta-Nehisi Coates, George Orwell essays, Hannah Arendt

5. **Psychological Insight Writer**
   - Understanding the mind, behavioral science for general audience
   - Why distinct: Explains how we think (vs. Inspirational Teacher's motivation)
   - Examples: Oliver Sacks, Daniel Kahneman, Brené Brown (research side)

**From Tier 3 (Specialized - Not Selected):**

6. **Legal/Policy Writer**
   - Legal analysis, policy proposals, constitutional commentary
   - Examples: Bryan Stevenson, legal scholars writing for public

7. **Parenting/Relationship Expert**
   - Relationship guidance, parenting philosophy
   - Examples: Esther Perel, Emily Oster
   - Note: Could overlap with Practical Guide or Inspirational Teacher

8. **Personal Finance Writer**
   - Money philosophy, financial strategy
   - Examples: Ramit Sethi, Morgan Housel
   - Note: Could overlap with Business Professional

**Implementation Priority (if expanding beyond 19):**

**Next 5 styles (v0.14.0):**
1. True Crime Chronicler (Narrative category) - Massive commercial appeal
2. Literary Journalist (Cultural category) - Prestigious, distinct style
3. Food/Culinary Writer (Cultural category) - Popular subgenre
4. Political Analyst (Cultural category) - Important for current affairs books
5. Psychological Insight (Academic or Personal category) - Popular psychology

**Considerations:**
- Prioritize commercial viability (True Crime, Food Writing)
- Balance genre coverage (add missing major categories)
- Consider overlap (some may fit as style variants rather than separate styles)
- Community demand (survey users about most-needed styles)

---

## Appendix C: Full Style Catalog Example

**File:** `Process/Styles/Style_Catalog.md`

```markdown
# Nonfiction Writing Style Catalog

**Version:** 2.0.0
**Last Updated:** 2025-11-22
**Total Styles:** 19

---

## How to Use This Catalog

**Browsing by Category:**
- Each category folder contains styles suited to specific book types
- Review styles within your primary category
- Read individual style files for full definitions and examples

**Quick Selection:**
1. Identify your book's primary category below
2. Review 2-3 styles from that category
3. Read example passages to find your best fit
4. During Prompt 1, select by style name

---

## Academic & Research (3 styles)

**Best for:** Scholarly works, research-based books, scientific writing, technical documentation

| Style | File | Key Characteristics |
|-------|------|---------------------|
| Academic Authority | `Academic/Academic_Authority.md` | Formal, evidence-based, third person, citations |
| Scientific Communicator | `Academic/Scientific_Communicator.md` | Accessible science, wonder + rigor, explanatory |
| Technical Precision | `Academic/Technical_Precision.md` | Systematic, detailed, procedural, accurate |

**Choose Academic Authority if:** Writing for peer review, policy analysis, or academic audiences
**Choose Scientific Communicator if:** Popular science, health, making complex science accessible
**Choose Technical Precision if:** Technical guides, engineering, systematic methodologies

---

## Business & Professional (2 styles)

**Best for:** Management books, leadership guides, workplace improvement, professional development

| Style | File | Key Characteristics |
|-------|------|---------------------|
| Business Professional | `Professional/Business_Professional.md` | Action-oriented, frameworks, results-focused |
| Conversational Expert | `Professional/Conversational_Expert.md` | Engaging "you", accessible expertise, warm |

**Choose Business Professional if:** Management/leadership focus, organizational strategy
**Choose Conversational Expert if:** Practitioner guides, accessible expertise, peer-to-peer tone

---

## Narrative & Storytelling (3 styles)

**Best for:** History books, investigative journalism, memoir-adjacent nonfiction, story-based books

| Style | File | Key Characteristics |
|-------|------|---------------------|
| Narrative Storyteller | `Narrative/Narrative_Storyteller.md` | First person, scenes, story arcs, memoir-like |
| Historical Chronicler | `Narrative/Historical_Chronicler.md` | Narrative history, past events, scholarly storytelling |
| Investigative Journalist | `Narrative/Investigative_Journalist.md` | Objective reporting, evidence-based, compelling |

**Choose Narrative Storyteller if:** Memoir-adjacent, creative nonfiction, personal journey
**Choose Historical Chronicler if:** History books, biography, bringing the past alive
**Choose Investigative Journalist if:** Exposés, investigations, revealing truth through reporting

---

## Personal Development & How-To (3 styles)

**Best for:** Self-help, skill development, philosophical inquiry, personal growth, practical guides

| Style | File | Key Characteristics |
|-------|------|---------------------|
| Inspirational Teacher | `Personal/Inspirational_Teacher.md` | Uplifting, transformational, motivational |
| Practical Guide | `Personal/Practical_Guide.md` | Step-by-step, how-to, instructional |
| Philosophical Contemplative | `Personal/Philosophical_Contemplative.md` | Reflective inquiry, ethics, big questions |

**Choose Inspirational Teacher if:** Motivational, mindset shifts, transformation
**Choose Practical Guide if:** Teaching skills, how-to instructions, actionable steps
**Choose Philosophical Contemplative if:** Ethics, meaning, existential questions, deep thinking

---

## Cultural & Social Commentary (4 styles)

**Best for:** Cultural criticism, social justice, humor, nature writing, advocacy, essays

| Style | File | Key Characteristics |
|-------|------|---------------------|
| Cultural Critic | `Cultural/Cultural_Critic.md` | Sharp observation, essayistic, analytical |
| Satirical Humorist | `Cultural/Satirical_Humorist.md` | Witty, ironic, comedic truth-telling |
| Activist Advocate | `Cultural/Activist_Advocate.md` | Social justice, advocacy, call to action |
| Lyrical Nature Writer | `Cultural/Lyrical_Nature_Writer.md` | Poetic, sensory, ecological, place-based |

**Choose Cultural Critic if:** Social commentary, cultural analysis, essay collections
**Choose Satirical Humorist if:** Humorous nonfiction, satire, comedic observations
**Choose Activist Advocate if:** Social justice, political advocacy, movement-building
**Choose Lyrical Nature Writer if:** Nature writing, environmental, travel, place-based

---

## Quick Selection by Book Type

**Academic/Research Writing:**
- Dissertation or scholarly work → Academic Authority
- Popular science book → Scientific Communicator
- Technical manual → Technical Precision

**Business Books:**
- Management/strategy → Business Professional
- Accessible expertise → Conversational Expert

**Story-Based:**
- Personal memoir → Narrative Storyteller
- History book → Historical Chronicler
- Investigation/exposé → Investigative Journalist

**Self-Help/Personal:**
- Motivational/transformation → Inspirational Teacher
- Skills/how-to → Practical Guide
- Philosophy/meaning → Philosophical Contemplative

**Cultural/Social:**
- Cultural commentary → Cultural Critic
- Humor/satire → Satirical Humorist
- Social justice → Activist Advocate
- Nature/environment → Lyrical Nature Writer

---

## Browse by Formality Level

**High Formality:**
- Academic Authority (`Academic/`)
- Technical Precision (`Academic/`)

**Moderate Formality:**
- Business Professional (`Professional/`)
- Scientific Communicator (`Academic/`)
- Historical Chronicler (`Narrative/`)
- Philosophical Contemplative (`Personal/`)
- Cultural Critic (`Cultural/`)
- Activist Advocate (`Cultural/`)
- Lyrical Nature Writer (`Cultural/`)

**Low Formality:**
- Conversational Expert (`Professional/`)
- Narrative Storyteller (`Narrative/`)
- Investigative Journalist (`Narrative/`)
- Practical Guide (`Personal/`)
- Inspirational Teacher (`Personal/`)
- Satirical Humorist (`Cultural/`)

---

## Browse by Voice/Person

**Third Person:**
- Academic Authority (`Academic/`)
- Technical Precision (`Academic/`)
- Investigative Journalist (`Narrative/`)

**Second Person ("you"):**
- Conversational Expert (`Professional/`)
- Practical Guide (`Personal/`)
- Inspirational Teacher (`Personal/`)
- Philosophical Contemplative (`Personal/`)

**First Person:**
- Narrative Storyteller (`Narrative/`)
- Lyrical Nature Writer (`Cultural/`)

**Mix/Plural ("we"):**
- Business Professional (`Professional/`)
- Scientific Communicator (`Academic/`)
- Philosophical Contemplative (`Personal/`)
- Activist Advocate (`Cultural/`)
- Cultural Critic (`Cultural/`)

---

## Alphabetical Index

All 15 styles listed alphabetically with category file paths:

- Academic Authority → `Academic/Academic_Authority.md`
- Activist Advocate → `Cultural/Activist_Advocate.md`
- Business Professional → `Professional/Business_Professional.md`
- Conversational Expert → `Professional/Conversational_Expert.md`
- Cultural Critic → `Cultural/Cultural_Critic.md`
- Historical Chronicler → `Narrative/Historical_Chronicler.md`
- Inspirational Teacher → `Personal/Inspirational_Teacher.md`
- Investigative Journalist → `Narrative/Investigative_Journalist.md`
- Lyrical Nature Writer → `Cultural/Lyrical_Nature_Writer.md`
- Narrative Storyteller → `Narrative/Narrative_Storyteller.md`
- Philosophical Contemplative → `Personal/Philosophical_Contemplative.md`
- Practical Guide → `Personal/Practical_Guide.md`
- Satirical Humorist → `Cultural/Satirical_Humorist.md`
- Scientific Communicator → `Academic/Scientific_Communicator.md`
- Technical Precision → `Academic/Technical_Precision.md`

---

**End of Style Catalog**
```

---

**End of Proposal**
