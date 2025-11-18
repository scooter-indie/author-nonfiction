# Custom Writing Styles

**Project:** [Your Book Title]
**Created:** [YYYY-MM-DD]
**Last Updated:** [YYYY-MM-DD]

---

## About Custom Styles

This file contains writing styles specific to your project or domain. Use this when:
- Framework styles don't quite fit your needs
- You're writing in a specialized field (medical, legal, technical domain)
- You want to mix characteristics from multiple framework styles
- You've developed a unique voice you want to formalize

**Naming Convention:**
- Internal name: CUSTOM_[Your_Style_Name]
- Display name: [Your Style Name] (shown in prompts without prefix)
- Example: CUSTOM_Medical_Journal displays as "Medical Journal"

**Format:**
Follow the same structure as Process/Style_Examples.md for consistency. This ensures:
- Your custom styles work seamlessly with all prompts
- Future you (or collaborators) understand the style clearly
- You can easily share styles across projects

**Reusability:**
- Copy custom styles to other projects by copying this file
- Share with colleagues working in similar domains
- Contribute exceptional styles back to the framework (via GitHub)

---

## How to Create a Custom Style

### Option 1: Start from Scratch

Define all characteristics based on your needs. Use the template below and fill in each section thoughtfully.

### Option 2: Extend a Framework Style

Start with a framework style and modify what doesn't fit:

```markdown
## [Your Style Name]

**Internal Name:** CUSTOM_[Name]
**Based On:** FW_[Framework_Style_Name]
**Best For:** [Your specific use case]

**Modifications from Base:**
- Changed [aspect] from [original] to [new] because [reason]
- Kept [aspects] from base style
- Added [new element] for [purpose]

[Then include full style definition with your changes]
```

### Option 3: Mix Multiple Styles

Combine characteristics from different framework styles:

```markdown
## [Your Style Name]

**Internal Name:** CUSTOM_[Name]
**Combines:** FW_[Style1] (voice) + FW_[Style2] (tone) + FW_[Style3] (structure)
**Best For:** [Your specific use case]

**Synthesis:**
- Voice from [Style1]: [Why this voice]
- Tone from [Style2]: [Why this tone]
- Structure from [Style3]: [Why this structure]

[Then include full unified style definition]
```

---

## Custom Style Template

```markdown
## [Your Style Name]

**Internal Name:** CUSTOM_[Name]
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

> [Sample paragraph demonstrating YOUR style in action - this is crucial]

### DO

- [Specific guideline aligned with YOUR style]
- [Specific guideline aligned with YOUR style]
- [Specific guideline aligned with YOUR style]
- [Specific guideline aligned with YOUR style]

### DON'T

- [Specific anti-pattern for YOUR style]
- [Specific anti-pattern for YOUR style]
- [Specific anti-pattern for YOUR style]

---
```

---

## Example: Custom Medical Journal Style

Here's an example of a custom style that extends Academic Authority for medical writing:

```markdown
## Medical Journal Style

**Internal Name:** CUSTOM_Medical_Journal
**Based On:** FW_Academic_Authority
**Best For:** Medical professionals, clinical research, healthcare policy

**Modifications from Base:**
- Added patient-centered language requirements
- Incorporated medical terminology conventions
- Emphasized evidence grading systems
- Added clinical case presentation patterns

### Voice Characteristics

**Person:** Third person with occasional "we" for clinical teams
**Formality:** High - medical register with precise clinical terminology
**Sentence Structure:** Complex but clear; follows IMRAD structure where applicable
**Vocabulary:** Medical terminology per AMA style; defines acronyms on first use

### Tone

Authoritative yet compassionate. Maintains clinical objectivity while acknowledging patient impact. Evidence-based with appropriate uncertainty quantification.

**Sample Phrases:**
- "Clinical evidence suggests..."
- "The patient presented with..."
- "Based on current guidelines..."
- "Further investigation revealed..."

### Pacing

**Density:** 300-400 words per clinical concept
**Examples:** Case presentations, trial data, clinical guidelines
**Breaks:** Section headings per medical journal format (Introduction, Methods, Results, Discussion)

### Structure

**Approach:** IMRAD (Introduction, Methods, Results, and Discussion) or Clinical Case format
**Pattern:** Present problem, describe methodology, report findings, discuss implications, acknowledge limitations

### Example Passage

> A 47-year-old female presented to the emergency department with acute onset chest pain radiating to the left arm, accompanied by diaphoresis and shortness of breath. Initial vital signs revealed blood pressure 168/94 mmHg, heart rate 102 beats per minute, and oxygen saturation 94% on room air. Electrocardiogram demonstrated ST-segment elevation in leads II, III, and aVF, consistent with acute inferior myocardial infarction.
>
> Immediate intervention according to STEMI protocol included aspirin 325 mg, sublingual nitroglycerin, and morphine for pain management. Cardiac biomarkers were drawn, with initial troponin I elevated at 2.3 ng/mL (normal <0.04 ng/mL). The patient was transferred to the cardiac catheterization laboratory within 47 minutes of presentation (door-to-balloon time), where coronary angiography revealed 95% occlusion of the right coronary artery.

### DO

- Use proper medical terminology and abbreviations (define on first use)
- Follow IMRAD or case presentation structure
- Include specific vital signs and lab values
- Grade evidence quality (e.g., Level A, B, C)
- Acknowledge limitations and alternative diagnoses
- Follow AMA or journal-specific citation style
- Use patient-first language ("patient with diabetes" not "diabetic patient")

### DON'T

- Use undefined medical jargon
- Present incomplete case information
- Skip informed consent or ethical considerations
- Ignore differential diagnoses
- Make definitive claims without appropriate evidence level
- Use stigmatizing language
- Violate patient confidentiality even in de-identified cases

---
```

---

## Your Custom Styles

[Add your custom style definitions below using the template above]

---

## Notes and Reflections

Use this space to document:
- Why you created specific custom styles
- How they're working in practice
- Adjustments you've made over time
- Insights about your writing voice

---

**[AI ASSISTANT NOTE]**

When processing custom styles:
1. Treat CUSTOM_ styles with same respect as FW_ framework styles
2. Apply DO/DON'T guidelines consistently
3. Reference custom styles in Style/Style_Guide.md when selected
4. Help author refine custom styles based on usage patterns
5. Suggest when a custom style might be worth sharing with framework
