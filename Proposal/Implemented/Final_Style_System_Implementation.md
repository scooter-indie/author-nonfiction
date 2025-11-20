# Final Style and Tone System Implementation

**Date:** 2025-11-17
**Status:** Ready for Implementation
**Approach:** Framework-Level Library + Project-Level Extensibility

---

## Overview

This document defines the complete implementation of the style and tone system with:
- **Framework-level curated library** (Process/Style_Examples.md)
- **Project-level extensibility** (Style/Custom_Styles.md - optional)
- **Project configuration** (Style/Style_Guide.md)
- **Invisible prefixing** (FW_ and CUSTOM_ for backend only)
- **Natural user experience** (descriptive names shown to users)

---

## File Structure

```
Process/
├── Style_Examples.md              # Framework curated library (version controlled)
├── AI-Assisted_Nonfiction_Authoring_Process.md
├── Anti-Hallucination_Guidelines.md
└── ...

[Project Root]/
├── Project_Config.md
├── Style/
│   ├── Style_Guide.md            # Active style configuration
│   └── Custom_Styles.md          # Optional: Project-specific additions
└── ...
```

---

## Framework Style Library (Process/Style_Examples.md)

### Purpose
Provides professionally curated writing styles that cover major nonfiction categories. Authors can use as-is, customize, or use as inspiration.

### Content Structure

```markdown
# Nonfiction Writing Style Examples

**Version:** 1.0.0
**Purpose:** Curated library of writing styles for nonfiction books
**Usage:** Select during project initialization or reference when creating custom styles

---

## How to Use This Library

**During Initialization:**
- Prompt 1 will show you these styles with examples
- Choose the one that resonates with your vision
- Selection is stored in your project's Style/Style_Guide.md

**For Custom Styles:**
- Use these as templates for Custom_Styles.md
- Reference "Based on: [style name]" to extend a framework style
- Maintain same format for consistency

**Prefix Note:**
- Internal name: FW_[name] (for file organization)
- Display name: [name] (what you see in prompts)

---

## Framework Styles

[8-10 complete style definitions with examples]
```

### Curated Styles to Include

1. **FW_Academic_Authority**
2. **FW_Conversational_Expert**
3. **FW_Narrative_Storyteller**
4. **FW_Business_Professional**
5. **FW_Technical_Precision**
6. **FW_Investigative_Journalist**
7. **FW_Practical_Guide**
8. **FW_Inspirational_Teacher**
9. **FW_Scientific_Communicator** (optional)
10. **FW_Memoir_Reflective** (optional)

---

## Style Definition Template

Each style follows this structure:

```markdown
## [Display Name]

**Internal Name:** FW_[Name]
**Best For:** [Target audience and book types]
**Description:** [2-3 sentences describing the overall feel]

### Voice Characteristics

**Person:** [First/Second/Third/Mixed]
**Formality:** [High/Moderate/Low with explanation]
**Sentence Structure:** [Simple/Complex/Varied with details]
**Vocabulary:** [Technical/Accessible/Mixed with approach]

### Tone

[Description of emotional quality and reader relationship]

**Sample Phrases:**
- "[Example phrase 1]"
- "[Example phrase 2]"
- "[Example phrase 3]"

### Pacing

**Density:** [Words per major concept]
**Examples:** [Frequency and type]
**Breaks:** [How often and what kind]

### Structure

**Approach:** [Deductive/Inductive/Dialectical/Mixed]
**Pattern:** [How concepts are typically introduced]

### Example Passage (150-200 words)

> [Sample paragraph demonstrating the style in action]

### DO

- [Specific guideline aligned with this style]
- [Specific guideline aligned with this style]
- [Specific guideline aligned with this style]
- [Specific guideline aligned with this style]

### DON'T

- [Specific anti-pattern for this style]
- [Specific anti-pattern for this style]
- [Specific anti-pattern for this style]

---
```

---

## Project Style Guide (Style/Style_Guide.md)

### Purpose
Stores the active style configuration for the project. Referenced by all prompts and the book-writing-assistant agent.

### Template

```markdown
# Writing Style Guide

**Project:** [Book Title]
**Style Version:** 1.0
**Established:** [YYYY-MM-DD]
**Last Updated:** [YYYY-MM-DD]

---

## Active Style Configuration

**Selected Style:** FW_[Style_Name]
**Source:** Framework Library
**Customizations:** [None | See below]

---

## Style Overview

[Auto-populated from selected framework style OR custom definition]

**Voice:** [Description]
**Tone:** [Description]
**Formality:** [Level and explanation]
**Pacing:** [Density and approach]
**Structure:** [Pattern]

---

## Quick Reference

### Example Passage

> [Paste example from selected style OR custom example]

### DO

- [List from selected style]
- [Custom additions if any]

### DON'T

- [List from selected style]
- [Custom additions if any]

---

## Customizations

**[This section only appears if author customizes the base style]**

**Base Style:** FW_[Name]
**Modifications:**
- [What was changed from base]
- [Why it was changed]

**Custom Guidelines:**
- [Project-specific additions]

---

## Style Evolution

**[Track major style changes here]**

### Version 1.0 - [YYYY-MM-DD]
- Initial style selection: [Style Name]
- Rationale: [Why this style fits the book]

---

## Usage Notes

This style guide is automatically referenced by:
- Prompt 3 (Modify File) - Style consistency checking
- Prompt 6 (Consistency Check) - Cross-chapter style analysis
- Book-writing-assistant agent - Real-time writing assistance

**To update this style:**
1. Edit this file directly OR
2. Run Prompt 1 with style reconfiguration option
3. Commit changes to git
```

---

## Custom Styles (Style/Custom_Styles.md - Optional)

### Purpose
Allows authors to define project-specific or domain-specific styles not in framework library.

### Creation
- Not created during initialization
- Created on-demand when author adds first custom style
- Can be created manually or via future prompt enhancement

### Template

```markdown
# Custom Writing Styles

**Project:** [Book Title]
**Created:** [YYYY-MM-DD]
**Last Updated:** [YYYY-MM-DD]

---

## About Custom Styles

This file contains writing styles specific to this project or your domain.

**Naming Convention:**
- Internal name: CUSTOM_[Your_Name]
- Display name: [Your Name] (shown in prompts)

**Format:**
Follow the same structure as Process/Style_Examples.md for consistency.

**Reusability:**
These styles can be copied to other projects or contributed back to the framework.

---

## Custom Styles

[Your style definitions here]

---

## Example: Extending a Framework Style

If you want to base a custom style on a framework style:

## [Your Custom Style Name]

**Internal Name:** CUSTOM_[Name]
**Based On:** FW_[Framework_Style_Name]
**Best For:** [Your specific use case]
**Description:** [How it differs from base style]

**Modifications from Base:**
- [What you changed]
- [What you kept]
- [Why you changed it]

[Then follow standard style template format]

---
```

---

## Integration Points

### Prompt 1: Initialize

**New Step Added:**

```markdown
## Step 9: Configure Writing Style

**I'll ask:**

"Let me help you choose a writing style for your book."

**Then I'll:**

1. **Ask about target audience:**
   - Academic researchers
   - Professional practitioners
   - General public
   - Students/learners
   - Mixed audience

2. **Show 3-4 relevant framework styles** based on audience:
   - Display name only (no FW_ prefix)
   - Show example passage from each
   - Highlight key characteristics

3. **Offer options:**
   - "Choose one of these styles"
   - "Mix characteristics from multiple styles"
   - "Describe your own style (I'll help formalize it)"

4. **If style chosen:**
   - Create Style/ directory
   - Generate Style_Guide.md with selected style
   - Reference framework style (FW_[name] internally)
   - Show confirmation with example

5. **If custom style:**
   - Help author define characteristics
   - Create Style_Guide.md with custom definition
   - Optionally create Custom_Styles.md
   - Mark as CUSTOM_[name] internally

6. **Commit to git:**
   - Style/Style_Guide.md
   - Style/Custom_Styles.md (if created)
   - Add to .gitignore exceptions if needed
```

### Prompt 3: Modify File

**Enhanced Step:**

```markdown
## Step 5: Style Consistency Check

**Before finalizing changes:**

1. **Load active style:**
   - Read Style/Style_Guide.md
   - Extract DO/DON'T guidelines
   - Note voice/tone/pacing parameters

2. **Analyze modified content:**
   - Check person consistency (first/second/third)
   - Evaluate formality level
   - Measure paragraph lengths
   - Assess sentence complexity
   - Review terminology usage

3. **Flag issues if found:**
   - List specific inconsistencies
   - Show examples from text
   - Reference style guide rules
   - Suggest corrections

4. **Offer author choice:**
   - "Apply style corrections automatically"
   - "Show me the issues, I'll fix manually"
   - "Skip - this variance is intentional"

5. **Apply if requested:**
   - Make style-consistent revisions
   - Preserve author's meaning
   - Note corrections in commit message
```

### Prompt 6: Consistency Check

**New Check Category:**

```markdown
## Style Consistency Analysis

**Scope:** [All chapters | Chapters X-Y]

**Checks:**

1. **Voice Drift**
   - Person shifts within/across chapters
   - Formality inconsistencies
   - Sentence structure variations

2. **Tone Misalignment**
   - Chapters that diverge from configured tone
   - Unexpected shifts in reader relationship
   - Inconsistent emotional register

3. **Pacing Variations**
   - Chapters denser/lighter than configured
   - Example frequency differences
   - Paragraph length outliers

4. **Structural Patterns**
   - Mixed deductive/inductive unexpectedly
   - Inconsistent concept introduction patterns

**Report Format:**

### Style Consistency Report

**Overall Alignment:** [Excellent | Good | Needs Review]

**Voice Consistency:** [Score/Analysis]
- Chapters with person shifts: [List if any]
- Formality outliers: [List if any]

**Tone Consistency:** [Score/Analysis]
- Chapters diverging from configured tone: [List if any]

**Pacing Consistency:** [Score/Analysis]
- Density variations: [Chapter comparisons]
- Example usage patterns: [Analysis]

**Recommendations:**
- High Priority: [Chapters needing attention]
- Medium Priority: [Minor adjustments]
- Low Priority: [Optional refinements]
```

### Book-Writing-Assistant Agent

**Enhanced Instructions:**

```markdown
**Writing Style Integration:**

**At Session Start:**

1. **Load style configuration:**
   - Read Style/Style_Guide.md
   - Extract active style parameters
   - Note DO/DON'T guidelines
   - Store for session reference

2. **Acknowledge style:**
   - Briefly mention active style to user
   - Example: "I see you're using Conversational Expert style. I'll match that tone."

**During Writing Assistance:**

1. **Apply style automatically:**
   - Match configured voice and tone
   - Follow pacing preferences
   - Use specified structure patterns
   - Respect formality level

2. **Style-aware suggestions:**
   - When offering revisions, maintain style
   - When generating new content, apply style
   - When answering questions, use style-appropriate examples

3. **Flag drift gently:**
   - If user's writing diverges: "I notice this passage uses first person while your style is configured for second person. Intentional?"
   - Offer harmonization without being pushy

**When User Requests Style Changes:**

1. **Update Style_Guide.md**
2. **Version the change** (add to Style Evolution section)
3. **Offer to scan existing content** for consistency
4. **Create harmonization plan** if requested
5. **Never override author preference** - guide, don't dictate

**Custom Style Support:**

- If user wants to create custom style: help them define it
- If user wants to modify framework style: update Style_Guide.md
- If user wants to add to Custom_Styles.md: follow template format
```

---

## Display Logic (Hiding Prefixes)

**Internal Storage:**
```markdown
**Selected Style:** FW_Conversational_Expert
**Source:** Framework Library
```

**Display to User:**
```
Current Style: Conversational Expert
Source: Framework Library
```

**In Prompts:**
```
Available Styles:
1. Academic Authority
2. Conversational Expert
3. Narrative Storyteller
...

[Not shown:]
1. FW_Academic_Authority
2. FW_Conversational_Expert
3. FW_Narrative_Storyteller
```

**Search/Reference Logic:**
```python
# Pseudo-code for style lookup
def get_style(style_name):
    # Add prefix if not present
    if not style_name.startswith('FW_') and not style_name.startswith('CUSTOM_'):
        # Try framework first
        framework_style = find_in_file('Process/Style_Examples.md', f'FW_{style_name}')
        if framework_style:
            return framework_style

        # Try custom
        custom_style = find_in_file('Style/Custom_Styles.md', f'CUSTOM_{style_name}')
        if custom_style:
            return custom_style

    return style_name  # Already has prefix

def display_style_name(internal_name):
    # Strip prefix for display
    return internal_name.replace('FW_', '').replace('CUSTOM_', '').replace('_', ' ')
```

---

## Migration Path

### For New Projects
1. Run Prompt 1
2. Choose style from framework library
3. Style/Style_Guide.md created automatically
4. Start writing

### For Existing Projects
1. Run enhanced Prompt 1 OR manually create Style/Style_Guide.md
2. Run Prompt 6 to analyze existing content
3. Choose style that matches current writing OR
4. Choose desired style and harmonize content
5. Document style version in Style_Guide.md

### Adding Custom Styles Later
1. Create Style/Custom_Styles.md manually
2. Define style following template format
3. Reference in Style_Guide.md if desired
4. Commit to git

---

## Framework Updates

**When Process/Style_Examples.md is updated:**

1. **User receives update** via git pull
2. **Prompt 8 (Dashboard)** can show: "Framework has 2 new styles available"
3. **User can review** new styles anytime
4. **No impact on existing projects** - Style_Guide.md references remain valid
5. **User can switch** if new style better fits their needs

**Version Tracking:**
```markdown
# Process/Style_Examples.md header
**Version:** 1.1.0
**Last Updated:** 2025-12-01
**Changes:**
- Added: FW_Data_Science_Narrative
- Enhanced: FW_Technical_Precision (more examples)
```

---

## Implementation Checklist

### Phase 1: Core Files
- [ ] Create Process/Style_Examples.md with 8-10 curated styles
- [ ] Create Style/Style_Guide.md template
- [ ] Create Style/Custom_Styles.md template (for reference)
- [ ] Update directory structure documentation

### Phase 2: Prompt Updates
- [ ] Update Prompt 1 with style configuration step
- [ ] Enhance Prompt 3 with style consistency checking
- [ ] Enhance Prompt 6 with style analysis
- [ ] Update book-writing-assistant agent instructions

### Phase 3: Documentation
- [ ] Update AI-Assisted_Nonfiction_Authoring_Process.md
- [ ] Add style system section to README.md
- [ ] Update QUICK_REFERENCE.md
- [ ] Add examples to Anti-Hallucination_Guidelines.md

### Phase 4: Testing
- [ ] Test new project initialization with style selection
- [ ] Test custom style creation
- [ ] Test style consistency checking
- [ ] Test framework style updates

---

## Questions Resolved

✅ **Separate files?** Yes - framework + project levels
✅ **Extensible?** Yes - Custom_Styles.md for project additions
✅ **Curated library?** Yes - 8-10 framework styles
✅ **Descriptive names?** Yes - clean names, prefixes hidden
✅ **User sees prefix?** No - stripped for display
✅ **Framework updates?** Yes - clean separation allows updates

---

## Next Steps

1. **Review and approve** this implementation plan
2. **Create curated style library** (8-10 complete style definitions)
3. **Create templates** for Style_Guide.md and Custom_Styles.md
4. **Update prompts** with style integration
5. **Update documentation**
6. **Test with sample project**

**Estimated Effort:** 1-2 days for complete implementation

**Risk:** Low - additive feature, doesn't break existing functionality

**Value:** High - addresses major author need for style consistency

---

**End of Implementation Plan**
