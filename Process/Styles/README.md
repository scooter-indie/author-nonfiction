# Nonfiction Writing Style Library

**Version:** 2.0.0
**Last Updated:** 2025-11-22
**Total Styles:** 19

---

## Overview

This directory contains the AI-Assisted Nonfiction Authoring Framework's modular writing style library. Each style is a complete definition of voice, tone, pacing, and structure for a specific type of nonfiction writing.

**What's New in v2.0:**
- **19 styles** (up from 9) organized into 5 categories
- **Modular architecture** - each style is a separate file
- **Category-based browsing** - find styles by book type
- **Complexity levels** - calibrate for different audiences (future feature)

---

## Directory Structure

```
Process/Styles/
├── Style_Catalog.md          # Master index of all 19 styles
├── README.md                  # This file
├── Academic/                  # 4 scholarly & research styles
│   ├── Academic_Authority.md
│   ├── Scientific_Communicator.md
│   ├── Technical_Precision.md
│   └── Medical_Health_Narrative.md
├── Professional/              # 2 business & workplace styles
│   ├── Business_Professional.md
│   └── Conversational_Expert.md
├── Narrative/                 # 4 story-based styles
│   ├── Narrative_Storyteller.md
│   ├── Historical_Chronicler.md
│   ├── Investigative_Journalist.md
│   └── Confessional_Memoir.md
├── Personal/                  # 3 self-help & guidance styles
│   ├── Practical_Guide.md
│   ├── Inspirational_Teacher.md
│   └── Philosophical_Contemplative.md
└── Cultural/                  # 6 commentary & cultural styles
    ├── Cultural_Critic.md
    ├── Satirical_Humorist.md
    ├── Activist_Advocate.md
    ├── Lyrical_Nature_Writer.md
    ├── Spiritual_Religious_Writer.md
    └── Sports_Writer.md
```

---

## How to Use the Style Library

### 1. During Project Initialization (Prompt 1)

When creating a new book project:

1. **Browse the catalog**: Open `Style_Catalog.md`
2. **Find your category**: Academic, Professional, Narrative, Personal, or Cultural
3. **Review 2-3 styles** from your category
4. **Read example passages** in individual style files
5. **Select one style** as your book-level default during Prompt 1

**Example:**
```
User: I'm writing a popular science book about neuroscience
Claude: That sounds like Academic/Scientific Communicator would be a great fit.
         Let me show you the style definition...
```

### 2. Quick Selection Shortcuts

**If you know your book type**, use the Quick Selection guide in `Style_Catalog.md`:

- **Dissertation** → Academic Authority
- **Popular science** → Scientific Communicator
- **Management book** → Business Professional
- **Personal memoir** → Narrative Storyteller
- **How-to guide** → Practical Guide
- **Cultural essays** → Cultural Critic
- **Nature writing** → Lyrical Nature Writer

### 3. Browsing by Characteristics

The catalog also organizes styles by:

- **Formality Level**: High, Moderate, Low
- **Voice/Person**: Third, Second ("you"), First, Plural ("we")
- **Book Type**: 20+ common nonfiction genres

This helps you find styles that match your preferences.

---

## Style File Format

Every style file follows this consistent structure:

```markdown
# Style Name

**Category:** [Academic|Professional|Narrative|Personal|Cultural]
**Internal Name:** FW_Style_Name
**Version:** 1.0.0
**Last Updated:** YYYY-MM-DD

## Overview
**Best For:** [genres this style suits]
**Description:** [1-2 sentence summary]

## Voice Characteristics
**Person:** [first/second/third/plural]
**Formality:** [High/Moderate/Low]
**Sentence Structure:** [pacing and rhythm]
**Vocabulary:** [word choice approach]

## Tone
[Description and sample phrases]

## Pacing
**Density:** [words per example/concept]
**Examples:** [types of examples used]
**Breaks:** [how to create rhythm]

## Structure
**Approach:** [organizational pattern]
**Pattern:** [typical flow]

## Example Passage
[200-300 word sample in this style]

## DO
[8 guidelines for using this style]

## DON'T
[8 common mistakes to avoid]
```

---

## How Styles Work in the Framework

### Hierarchical Style System

The framework uses **three-level cascading inheritance**:

```
Book Style (Global Default)
  ↓ inherits
Chapter Style (Optional Override)
  ↓ inherits
Section Style (Optional Override)
```

**Levels:**

1. **Book-Level Style** (configured during Prompt 1)
   - Selected from this library
   - Applies to all content unless overridden
   - Stored in `Manuscript/Style/Style_Guide.md`

2. **Chapter-Level Overrides** (optional)
   - Use different style for specific chapters
   - Created via Prompt 2 or Prompt 11
   - Example: Technical appendix uses Technical Precision

3. **Section-Level Overrides** (optional)
   - Override for specific paragraphs/sections
   - HTML comment markers in content
   - Example: Interview section uses Investigative Journalist

**Central Registry:**
- `Manuscript/Style/Style_Overrides.md` tracks all overrides
- Shows style distribution across your book
- Prompt 11 (Style Manager) manages overrides

---

## When to Use Style Overrides

### Book-Level Style

**Choose one primary style that matches your book's overall genre and tone.**

Most books use a single style throughout. Only override when you have distinct sections that genuinely require different voices.

### Chapter-Level Overrides

Use when **entire chapters** have different purposes:

- **Technical appendix** in a business book → Technical Precision
- **Personal story chapter** in an academic book → Narrative Storyteller
- **Case study chapter** in a how-to guide → Investigative Journalist

**Guideline:** If >30% of chapters use overrides, reconsider your book-level choice.

### Section-Level Overrides

Use for **specific passages** within chapters:

- **Anecdotes** → Narrative Storyteller
- **How-to instructions** → Practical Guide
- **Research findings** → Academic Authority
- **Quotes/interviews** → Investigative Journalist

**Syntax:**
```markdown
<!-- STYLE_OVERRIDE: Narrative_Storyteller -->
I remember the first time I saw the code fail in production...
<!-- END_STYLE_OVERRIDE -->
```

---

## Managing Styles with Prompts

### Prompt 1: Initialize Project
- **What it does**: Lets you select book-level style from catalog
- **When to use**: Starting new book project
- **Output**: Creates `Manuscript/Style/Style_Guide.md` with selected style

### Prompt 2: Add Chapter
- **What it does**: Optionally set chapter-level style override
- **When to use**: Adding chapter that needs different voice
- **Output**: Creates `Chapter_XX_style.md` override file

### Prompt 3: Change by Chg
- **What it does**: Applies active style when modifying content
- **When to use**: All content changes
- **Output**: Content written in resolved style (book → chapter → section cascade)

### Prompt 8: Consistency Checker
- **What it does**: Analyzes style distribution and transitions
- **When to use**: Weekly, at milestones
- **Output**: Report on style usage and suggestions

### Prompt 11: Style Manager
- **What it does**: Add/remove/analyze style overrides
- **When to use**: Managing chapter/section overrides, analyzing distribution
- **Output**: Updated override registry, validation reports

---

## Frequently Asked Questions

### Q: How do I change my book's style after initialization?

**A:** Edit `Manuscript/Style/Style_Guide.md` and replace the style definition with a different one from this library. Use Prompt 11 to validate.

### Q: Can I create my own custom style?

**A:** Yes. Follow the standard style file format above. Store custom styles in `Manuscript/Style/Custom_Styles/`. See `Process/Templates/Custom_Styles_Template.md`.

### Q: How many styles should I use in one book?

**A:** Most books use 1 primary style with 0-3 chapter overrides and occasional section overrides. If you're using 5+ different styles, your book may lack coherent voice.

### Q: What if no style matches my book?

**A:**
1. Choose the **closest fit** and customize it in `Manuscript/Style/Style_Guide.md`
2. **Mix characteristics** from 2 styles (document your customizations)
3. **Request a new style** - submit to framework repository

### Q: Can I use complexity levels?

**A:** Complexity levels are **documented but not yet implemented**. Coming in v0.14.0. They will let you calibrate vocabulary and sentence complexity for different audiences (high school → college → expert).

---

## Style Categories Explained

### Academic & Research (4 styles)

**Core purpose:** Scholarly credibility and research-based authority

- **Academic Authority**: Formal scholarly writing with citations
- **Scientific Communicator**: Accessible science for general audiences
- **Technical Precision**: Systematic technical documentation
- **Medical/Health Narrative**: Clinical knowledge + patient experience

**Best for:** Academic books, textbooks, research summaries, technical manuals, medical narratives

---

### Professional & Business (2 styles)

**Core purpose:** Workplace improvement and professional development

- **Business Professional**: Management strategy and organizational leadership
- **Conversational Expert**: Accessible expertise for practitioners

**Best for:** Management books, leadership guides, professional development, business strategy

---

### Narrative & Storytelling (4 styles)

**Core purpose:** Story-based nonfiction with dramatic arcs

- **Narrative Storyteller**: Memoir-adjacent creative nonfiction
- **Historical Chronicler**: Bringing the past alive through narrative
- **Investigative Journalist**: Evidence-based reporting with narrative tension
- **Confessional Memoir**: Raw, unflinching personal honesty

**Best for:** Memoirs, history books, investigative journalism, creative nonfiction, trauma narratives

---

### Personal Development & How-To (3 styles)

**Core purpose:** Individual growth and practical skill-building

- **Practical Guide**: Step-by-step how-to instruction
- **Inspirational Teacher**: Transformational mindset and motivation
- **Philosophical Contemplative**: Deep inquiry into meaning and ethics

**Best for:** Self-help, how-to guides, skill development, philosophy, personal growth

---

### Cultural & Social Commentary (6 styles)

**Core purpose:** Examining society, culture, and the human experience

- **Cultural Critic**: Sharp analytical essays on culture and society
- **Satirical Humorist**: Witty social commentary through comedy
- **Activist Advocate**: Social justice advocacy and movement-building
- **Lyrical Nature Writer**: Poetic nature writing with ecological awareness
- **Spiritual/Religious Writer**: Contemplative exploration of faith and meaning
- **Sports Writer**: Athletic drama and the culture of competition

**Best for:** Essays, cultural commentary, humor, advocacy, nature writing, spirituality, sports

---

## Future Enhancements

### Complexity Levels (v0.14.0)

Planned feature to calibrate styles for different audiences:

- **Accessible** (high school level): Short sentences, common vocabulary
- **Intermediate** (college level): Moderate complexity, some technical terms
- **Advanced** (graduate level): Sophisticated prose, specialized vocabulary
- **Expert** (peer review): Discipline-specific terminology, dense arguments

### Additional Styles (v0.14.0+)

Top candidates for future additions:

1. **True Crime Chronicler** (Narrative)
2. **Literary Journalist** (Cultural)
3. **Food/Culinary Writer** (Cultural)
4. **Political Analyst** (Cultural)
5. **Psychological Insight Writer** (Academic or Personal)

See `Proposal/STYLE_REFACTOR.md` for full list.

---

## Getting Help

- **Style selection unclear?** Read `Style_Catalog.md` Quick Selection guide
- **Want to see examples?** Every style file has 200-300 word example passage
- **Need to manage overrides?** Use Prompt 11 (Style Manager)
- **Questions about styles?** Read framework documentation in `Process/AI-Assisted_Nonfiction_Authoring_Process.md`

---

## Version History

**v2.0.0** (2025-11-22)
- Modular refactoring: Split `Style_Examples.md` into category-based structure
- Added 10 new styles (9 → 19 total)
- Created 5 category directories
- Added comprehensive catalog and usage documentation
- Documented complexity level system (implementation pending)

**v1.0.0** (Initial)
- Single file `Style_Examples.md` with 9 styles
- No category organization

---

**End of Style Library Documentation**
