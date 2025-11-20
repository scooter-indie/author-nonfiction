# Hierarchical Style System Proposal

**Status:** Proposal - Awaiting Decision
**Created:** 2025-11-19
**Framework Version:** 0.10.0+
**Proposed Implementation:** v0.11.0 or v0.10.1

---

## Problem Statement

**Current System:**
- Book has single global style set during Prompt 1 (Initialize)
- Style defined in `Manuscript/Style/Style_Guide.md`
- All chapters must follow this style
- No way to override for specific chapters or sections

**Use Case Example:**
```
Book: "The Complete Guide to Data Science"
Overall Style: Business Professional (clear, accessible, formal)

BUT:
- Chapter 3 (Case Studies): Needs Narrative Storyteller style (stories, examples)
- Chapter 7 (Technical Implementation): Needs Technical Precision style (code, specs)
- Chapter 12, Section 3 (Personal Reflection): Needs Conversational Expert style
```

**Need:** Hierarchical style system with inheritance and overrides at:
1. **Book level** (default for all content)
2. **Chapter level** (override for entire chapter)
3. **Section level** (override for specific sections within chapter)

---

## Proposed Solution: Cascading Style Inheritance

### Hierarchy (CSS-like)

```
Book Style (Global Default)
  ↓ inherits
Chapter Style (Optional Override)
  ↓ inherits
Section Style (Optional Override)
```

**Inheritance Rules:**
- If no chapter style specified → use book style
- If no section style specified → use chapter style (or book if no chapter override)
- Explicit style always overrides inherited style

---

## Implementation Design

### File Structure

```
my-book/
├── Manuscript/
│   ├── Style/
│   │   ├── Style_Guide.md                    # BOOK-LEVEL (global default)
│   │   ├── Style_Guide_chg.md
│   │   ├── Custom_Styles.md                  # Optional custom styles
│   │   └── Style_Overrides.md                # NEW: Tracks all overrides
│   ├── Chapters/
│   │   ├── Chapter_01/
│   │   │   ├── Chapter_01.md
│   │   │   ├── Chapter_01_chg.md
│   │   │   └── Chapter_01_style.md           # NEW: Chapter-level override (optional)
│   │   ├── Chapter_03/
│   │   │   ├── Chapter_03.md
│   │   │   ├── Chapter_03_chg.md
│   │   │   └── Chapter_03_style.md           # Chapter 3 uses different style
│   │   └── Chapter_07/
│   │       ├── Chapter_07.md                 # Uses book default (no override)
│   │       └── Chapter_07_chg.md
```

---

## Style Override Files

### Book-Level Style (Manuscript/Style/Style_Guide.md)

**No changes to existing format** - this remains the global default.

```markdown
# Style Guide: [Book Title]

**Active Style:** Business Professional
**Last Updated:** 2025-11-19

## Style Configuration

[Existing format - unchanged]
```

---

### NEW: Chapter-Level Override (Chapter_XX/Chapter_XX_style.md)

**Format:**
```markdown
# Chapter Style Override: Chapter [N]

**Chapter:** [N] - [Chapter Title]
**Override Style:** [Style Name]
**Reason:** [Why this chapter needs different style]
**Applies To:** Entire chapter (all sections)
**Created:** [Date]
**Last Updated:** [Date]

---

## Style Selection

**Overriding Book Default:**
- Book Style: [Business Professional]
- Chapter Style: **[Narrative Storyteller]** ← Override

**Rationale:**
[Explain why this chapter needs a different style]

Example: "This chapter presents case studies and real-world examples
that benefit from storytelling approach rather than business formality."

---

## Style Configuration

**Style Name:** [Narrative Storyteller]

**Copy of selected style from Process/Style_Examples.md:**

[Full style definition pasted here for reference]

---

## DO / DON'T Lists (Chapter-Specific Additions)

**In addition to the Narrative Storyteller style, for THIS chapter:**

**DO:**
- Use real company names from case studies
- Include direct quotes from interviews
- Provide specific dates and timelines
- Use first-person when recounting observations

**DON'T:**
- Use generic "a company" phrasing
- Skip attribution for quotes
- Omit contextual details
- Remain detached/impersonal

---

## Consistency Notes

**When modifying this chapter (Prompt 3):**
- Apply chapter style (Narrative Storyteller), not book style
- Check consistency against this file, not global Style_Guide.md
- Validate story elements (characters, timeline, details)

**Prompt 6 (Consistency Checker) should:**
- Use chapter style for validation
- Flag if content matches book style instead of chapter style
- Check transitions at chapter boundaries (style shifts)
```

---

### NEW: Section-Level Override (Embedded in Chapter File)

**Location:** Within the chapter markdown file itself

**Format:**
```markdown
# Chapter 7: Technical Implementation

[Content using book/chapter default style...]

## Section 7.1: Architecture Overview

[Content continues with default style...]

## Section 7.2: API Reference

<!-- STYLE_OVERRIDE: Technical Precision -->
<!-- REASON: This section contains code examples and technical specifications -->
<!-- APPLIES_TO: Section 7.2 only -->

This section uses **Technical Precision** style for code documentation.

[Content with Technical Precision style...]

### Subsection 7.2.1: Authentication Endpoints

```python
def authenticate(username: str, password: str) -> Token:
    """
    Authenticate user credentials and return access token.

    Args:
        username: User's registered username
        password: User's plaintext password (will be hashed)

    Returns:
        Token: JWT access token valid for 24 hours

    Raises:
        AuthenticationError: If credentials are invalid
    """
    # Implementation details...
```

[More technical content...]

<!-- END_STYLE_OVERRIDE -->

## Section 7.3: Deployment Guide

[Returns to book/chapter default style...]
```

---

## NEW File: Style_Overrides.md (Central Registry)

**Purpose:** Track all style overrides across the book for easy reference.

**Location:** `Manuscript/Style/Style_Overrides.md`

**Format:**
```markdown
# Style Override Registry

**Book Default Style:** Business Professional

This file tracks all chapters and sections that override the book's default style.

---

## Summary

| Level | Location | Override Style | Reason |
|-------|----------|----------------|--------|
| Chapter | Chapter 3 | Narrative Storyteller | Case studies require storytelling |
| Chapter | Chapter 12 | Conversational Expert | Personal reflections |
| Section | Chapter 7, Section 7.2 | Technical Precision | API reference documentation |
| Section | Chapter 15, Section 15.4 | Inspirational Teacher | Motivational conclusion |

**Total Overrides:** 4
- Chapter-level: 2
- Section-level: 2

---

## Chapter-Level Overrides

### Chapter 3: Case Studies

**Override Style:** Narrative Storyteller

**File:** `Manuscript/Chapters/Chapter_03/Chapter_03_style.md`

**Rationale:** This chapter presents real-world case studies that benefit
from storytelling approach. Examples include character-driven narratives,
specific timelines, and detailed contextual information.

**Created:** 2025-11-15
**Last Modified:** 2025-11-18

**Validation Notes:**
- Prompt 6 checks this chapter against Narrative Storyteller, not book default
- Transitions at chapter boundaries (Ch 2→3 and Ch 3→4) may shift style
- Acceptable style shift - intentional design

---

### Chapter 12: Reflections and Next Steps

**Override Style:** Conversational Expert

**File:** `Manuscript/Chapters/Chapter_12/Chapter_12_style.md`

**Rationale:** Final chapter includes personal reflections and direct
reader engagement, warranting a more conversational, accessible tone
than the business formality of earlier chapters.

**Created:** 2025-11-16
**Last Modified:** 2025-11-16

---

## Section-Level Overrides

### Chapter 7, Section 7.2: API Reference

**Override Style:** Technical Precision

**Marker:** `<!-- STYLE_OVERRIDE: Technical Precision -->`

**Location:** `Manuscript/Chapters/Chapter_07/Chapter_07.md` (lines 245-389)

**Rationale:** This section contains code examples, API specifications,
and technical documentation that require precise, systematic formatting
rather than business prose.

**Created:** 2025-11-17

**Validation Notes:**
- Only applies to Section 7.2 and its subsections
- Section 7.1 and 7.3 use book default style
- Code examples follow technical documentation standards

---

### Chapter 15, Section 15.4: Your Journey Continues

**Override Style:** Inspirational Teacher

**Marker:** `<!-- STYLE_OVERRIDE: Inspirational Teacher -->`

**Location:** `Manuscript/Chapters/Chapter_15/Chapter_15.md` (lines 892-1024)

**Rationale:** Motivational conclusion to book requires inspirational,
encouraging tone to energize readers for their next steps.

**Created:** 2025-11-18

---

## Override Management

### Adding Chapter-Level Override

1. Create `Chapter_XX/Chapter_XX_style.md` file
2. Copy style definition from `Process/Style_Examples.md`
3. Add chapter-specific DO/DON'T lists
4. Update this registry file
5. Commit both files

### Adding Section-Level Override

1. Add `<!-- STYLE_OVERRIDE: [Style Name] -->` marker in chapter file
2. Add rationale comment
3. Specify scope (which section)
4. Write content in override style
5. Add `<!-- END_STYLE_OVERRIDE -->` marker
6. Update this registry file
7. Commit changes

### Removing Override

1. Delete `Chapter_XX_style.md` (for chapter-level)
2. Remove `<!-- STYLE_OVERRIDE -->` markers (for section-level)
3. Rewrite content in book default style
4. Update this registry file
5. Commit changes

---

## Validation Rules

### Prompt 3 (Modify File) Behavior

**When modifying Chapter 3 (has chapter-level override):**
1. Check for `Chapter_03_style.md`
2. If exists: Use Narrative Storyteller style for modifications
3. If not exists: Use book default (Business Professional)
4. Report which style was applied

**When modifying Chapter 7, Section 7.2 (has section-level override):**
1. Check for `<!-- STYLE_OVERRIDE -->` marker in file
2. If modifying content within override markers: Use Technical Precision
3. If modifying content outside markers: Use book default
4. Report which style was applied

### Prompt 6 (Consistency Checker) Behavior

**Check hierarchy:**
1. Load book default style from `Style_Guide.md`
2. For each chapter:
   - Check if `Chapter_XX_style.md` exists
   - If yes: Load chapter override style
   - If no: Use book default
3. Within chapter content:
   - Check for `<!-- STYLE_OVERRIDE -->` markers
   - If found: Load section override style for that section
   - If not: Use chapter or book style

**Validation:**
- Chapter 1 (no override): Check against Business Professional ✓
- Chapter 3 (chapter override): Check against Narrative Storyteller ✓
- Chapter 7, Section 7.1 (no override): Check against Business Professional ✓
- Chapter 7, Section 7.2 (section override): Check against Technical Precision ✓
- Chapter 7, Section 7.3 (no override): Check against Business Professional ✓

**Report:**
```markdown
# Style Consistency Report

## Chapters Using Book Default Style (Business Professional)
- Chapter 1: ✓ Consistent
- Chapter 2: ✓ Consistent
- Chapter 4: ⚠ 3 minor issues (see below)
- Chapter 5-6: ✓ Consistent
- Chapter 7 (Sections 7.1, 7.3): ✓ Consistent
- Chapter 8-11: ✓ Consistent

## Chapters with Style Overrides

### Chapter 3: Case Studies (Narrative Storyteller)
- ✓ Consistent with override style
- Style shift at boundaries: Acceptable (intentional)

### Chapter 12: Reflections (Conversational Expert)
- ✓ Consistent with override style

## Sections with Style Overrides

### Chapter 7, Section 7.2: API Reference (Technical Precision)
- ✓ Consistent with override style
- Proper code formatting: ✓
- Technical terminology: ✓

### Chapter 15, Section 15.4: Conclusion (Inspirational Teacher)
- ⚠ 1 issue: Line 923 uses business formality, should be inspirational
```

---

## Style Transition Guidance

### At Chapter Boundaries

**Problem:** Style shifts between chapters can feel jarring.

**Solution:** Intentional transitions

**Example: Chapter 2 → Chapter 3**

**End of Chapter 2 (Business Professional):**
> In the next chapter, we'll examine real-world applications of these
> principles through detailed case studies from leading organizations.

**Start of Chapter 3 (Narrative Storyteller):**
> # Chapter 3: Case Studies from the Field
>
> Sarah Martinez sat in the conference room, looking at three years of
> data spread across the table. Her company's customer retention had
> dropped 15% annually, and no one could explain why. This is her story...

**Technique:**
- Chapter 2 ends with forward reference (signals transition)
- Chapter 3 opens with immediate immersion (storytelling starts)
- Reader understands the shift is intentional

---

### At Section Boundaries (Within Chapter)

**Problem:** Style shifts mid-chapter can confuse readers.

**Solution:** Explicit signposting

**Example: Chapter 7, Section 7.1 → 7.2**

**End of Section 7.1 (Business Professional):**
> The following section provides technical API reference documentation
> for developers implementing these integrations.

**Start of Section 7.2 (Technical Precision):**
> ## Section 7.2: API Reference
>
> <!-- STYLE_OVERRIDE: Technical Precision -->
>
> This section contains complete API specifications. Each endpoint includes:
> - Function signature
> - Parameter descriptions
> - Return types
> - Error codes
> - Code examples

**Technique:**
- Section 7.1 ends with explicit "technical reference" signal
- Section 7.2 opens with clear heading and purpose statement
- Style shift is expected, not jarring

---

## Prompt Modifications Required

### Prompt 1 (Initialize)

**Current:**
- Asks user to select ONE style for entire book

**Proposed Change:**
- Ask user to select DEFAULT style for book
- Explain that individual chapters/sections can override later
- Create `Style_Overrides.md` file (initially empty)

**New Question:**
```
What writing style should be the DEFAULT for your book?

This will be the primary style used throughout the book. You can
override this style for specific chapters or sections later if needed
(e.g., case study chapters might use storytelling style while the rest
uses business professional).

[List of 9 styles...]

Your choice: _____
```

---

### Prompt 2 (Add Chapter)

**Current:**
- Creates chapter using book default style

**Proposed Addition:**
- Ask: "Should this chapter use a different style than the book default?"
- If yes: Create `Chapter_XX_style.md` file
- Update `Style_Overrides.md` registry

**New Questions:**
```
Should this chapter use a different writing style?

Book Default: Business Professional

Options:
1. Use book default (Business Professional)
2. Override with different style

Your choice: _____

[If choice 2:]

Which style should this chapter use?
[List of 9 styles...]

Why does this chapter need a different style?
[User provides rationale]
```

---

### Prompt 3 (Modify File)

**Current:**
- Uses book default style for all modifications

**Proposed Changes:**

**Before applying modifications:**
1. Check if modifying a chapter
2. If yes: Check for `Chapter_XX_style.md`
   - If exists: Load and apply chapter override style
3. Check content for `<!-- STYLE_OVERRIDE -->` markers
   - If modification is within override section: Apply section style
4. Report which style is being used

**Example Interaction:**
```
I'm modifying Chapter_03.md based on your instructions.

Detected chapter-level style override:
- Book Default: Business Professional
- Chapter 3 Override: Narrative Storyteller

I will apply modifications using the Narrative Storyteller style
as specified in Chapter_03_style.md.

[Proceeds with modifications...]
```

**For Section Overrides:**
```
I'm modifying Chapter_07.md, Section 7.2.

Detected section-level style override:
- Book Default: Business Professional
- Section 7.2 Override: Technical Precision (lines 245-389)

Your modification affects Section 7.2 (within override).
I will apply Technical Precision style for this modification.

[Proceeds with modifications...]
```

---

### Prompt 6 (Consistency Checker)

**Major Enhancement Required**

**Current:**
- Checks all chapters against single book style

**Proposed Changes:**

**Algorithm:**
```
1. Load book default style from Style_Guide.md
2. Load Style_Overrides.md registry
3. For each chapter:
   a. Check if chapter has override (Chapter_XX_style.md exists)
   b. If yes: Load chapter style
   c. If no: Use book default
   d. Scan chapter content for section overrides (<!-- STYLE_OVERRIDE -->)
   e. Apply appropriate style to each section
4. Validate content against applicable style
5. Report issues organized by style level
```

**Enhanced Report:**
```markdown
# Style Consistency Report

**Book Default:** Business Professional
**Chapters with Overrides:** 2 (Chapters 3, 12)
**Sections with Overrides:** 2 (Ch 7 Sec 7.2, Ch 15 Sec 15.4)

---

## Chapters Using Book Default Style

### Chapter 1-2: ✓ Consistent
No issues found.

### Chapter 4: ⚠ 3 Issues (Business Professional)
1. Line 234: Uses first-person "I" (violation of formal style)
2. Line 456: Sentence fragment (should be complete sentence)
3. Line 678: Colloquial phrase "pretty good" (use "effective")

### Chapter 5-6, 8-11: ✓ Consistent

---

## Chapters with Style Overrides

### Chapter 3: Case Studies (Narrative Storyteller Override)

**Override Status:** ✓ Active
**Style File:** Chapter_03_style.md
**Consistency:** ✓ Passes

Content correctly uses:
- First-person narratives ✓
- Specific character names ✓
- Story structure (beginning/middle/end) ✓
- Dialogue and quotes ✓

**Style Transition:**
- Chapter 2 → 3: ✓ Smooth (forward reference at end of Ch 2)
- Chapter 3 → 4: ⚠ Abrupt (consider adding transition)

**Recommendation:**
Add transition sentence at end of Chapter 3:
"While these case studies illustrate the human impact of data decisions,
the following chapters return to technical implementation details."

---

### Chapter 12: Reflections (Conversational Expert Override)

**Override Status:** ✓ Active
**Style File:** Chapter_12_style.md
**Consistency:** ✓ Passes

---

## Sections with Style Overrides

### Chapter 7, Section 7.2: API Reference (Technical Precision)

**Override Marker:** Found at line 245
**Override Scope:** Lines 245-389 (Section 7.2 only)
**Consistency:** ✓ Passes

Content correctly uses:
- Code examples with proper syntax ✓
- Technical terminology ✓
- Systematic documentation format ✓
- Type annotations ✓

**Validation:**
- Section 7.1 (before override): Business Professional ✓
- Section 7.2 (within override): Technical Precision ✓
- Section 7.3 (after override): Business Professional ✓

**Style Transitions:**
- Section 7.1 → 7.2: ✓ Smooth (signposted)
- Section 7.2 → 7.3: ✓ Smooth (clear end marker)

---

## Style Override Health Check

**Total Overrides:** 4
- Chapter-level: 2 ✓
- Section-level: 2 ✓

**All override files exist:** ✓
- Chapter_03_style.md ✓
- Chapter_12_style.md ✓

**Registry accurate:** ✓
- Style_Overrides.md matches actual overrides ✓

**Recommendation:**
All style overrides are properly configured and content is consistent.
Consider adding transition at Chapter 3 → 4 boundary.
```

---

### Prompt 8 (Dashboard)

**Addition to Dashboard:**

```markdown
## Style Configuration

**Book Default:** Business Professional

**Chapter-Level Overrides:** 2
- Chapter 3: Narrative Storyteller (case studies)
- Chapter 12: Conversational Expert (personal reflections)

**Section-Level Overrides:** 2
- Chapter 7, Section 7.2: Technical Precision (API reference)
- Chapter 15, Section 15.4: Inspirational Teacher (conclusion)

**Style Distribution:**
- Business Professional: 12 chapters, 85% of content
- Narrative Storyteller: 1 chapter, 7% of content
- Conversational Expert: 1 chapter, 5% of content
- Technical Precision: 1 section, 2% of content
- Inspirational Teacher: 1 section, 1% of content

**Style Consistency:** ✓ Last checked 2025-11-18 (all passing)
```

---

### NEW: Prompt 11 (Style Manager)

**Purpose:** Dedicated prompt for managing style overrides.

**Workflow:**

```markdown
# Execute Prompt 11: Style Manager

**Purpose:** Manage writing style overrides at chapter and section levels.

---

## What This Does

I will help you:
1. Add style override to a chapter
2. Add style override to a section
3. Remove style override
4. View all style overrides
5. Check style consistency

---

## Questions I'll Ask

1. What would you like to do?
   - Add chapter-level style override
   - Add section-level style override
   - Remove style override
   - View all overrides
   - Check style consistency

[Based on choice, interactive workflow...]

---

## Adding Chapter-Level Override

If you choose to add chapter-level override:

1. Which chapter? [Chapter number]
2. Which style should it use? [List of 9 styles]
3. Why does this chapter need a different style? [Rationale]
4. Review and confirm

Then I'll:
- Create `Chapter_XX_style.md` with full style definition
- Update `Style_Overrides.md` registry
- Commit changes
- Report completion

---

## Adding Section-Level Override

If you choose to add section-level override:

1. Which chapter and section? [Chapter X, Section X.Y]
2. Which style should it use? [List of 9 styles]
3. Why does this section need a different style? [Rationale]
4. Specify exact line range or I'll help identify it
5. Review and confirm

Then I'll:
- Insert `<!-- STYLE_OVERRIDE -->` markers in chapter file
- Add rationale and scope comments
- Update `Style_Overrides.md` registry
- Commit changes
- Report completion

---

## Removing Override

1. Which override to remove? [Show list of current overrides]
2. Confirm removal
3. Should content be rewritten in book default style? [Yes/No]

Then I'll:
- Delete `Chapter_XX_style.md` (if chapter-level)
- Remove `<!-- STYLE_OVERRIDE -->` markers (if section-level)
- Optionally rewrite content in book default style
- Update `Style_Overrides.md` registry
- Commit changes

---

## View All Overrides

Display contents of `Style_Overrides.md` with:
- Summary table
- Details for each override
- Rationale for each override
- Links to override files
```

---

## Implementation Phases

### Phase 1: File Structure & Templates (1-2 days)

**Tasks:**
1. Create template for `Chapter_XX_style.md`
2. Create template for `Style_Overrides.md`
3. Document section-level override syntax (`<!-- STYLE_OVERRIDE -->` markers)
4. Update framework documentation

**Deliverables:**
- Template files in `Process/Templates/`
- Documentation updated
- Examples created

---

### Phase 2: Prompt Modifications (3-4 days)

**Tasks:**
1. Update Prompt 1 (Initialize) to create `Style_Overrides.md`
2. Update Prompt 2 (Add Chapter) to support chapter-level overrides
3. Update Prompt 3 (Modify File) to detect and apply overrides
4. Update Prompt 6 (Consistency) to validate hierarchical styles
5. Update Prompt 8 (Dashboard) to show style distribution

**Deliverables:**
- 5 prompts updated
- All prompts tested with override scenarios

---

### Phase 3: Style Manager Prompt (2-3 days)

**Tasks:**
1. Create Prompt 11 (Style Manager)
2. Implement add/remove override workflows
3. Implement view and check functionality
4. Test all operations

**Deliverables:**
- Prompt 11 fully functional
- Documentation complete
- Examples provided

---

### Phase 4: Testing & Documentation (2-3 days)

**Tasks:**
1. Create test book with multiple override scenarios
2. Test all prompts with overrides
3. Validate consistency checker
4. Update user guide
5. Create tutorial/examples

**Deliverables:**
- Complete test coverage
- User documentation
- Tutorial examples

---

## Total Estimated Effort

**Time:** 8-12 days (2-2.5 weeks)

**Complexity:** Medium
- Requires changes to 5 existing prompts
- 1 new prompt (Style Manager)
- New file types and templates
- Enhanced validation logic

---

## Benefits

### For Authors

**Flexibility:**
- Use different styles for different content types
- Case studies can be narrative
- Technical sections can be precise
- Personal reflections can be conversational

**Consistency:**
- Automatic validation against appropriate style
- Prompt 6 checks each section with correct style
- No manual tracking needed

**Clarity:**
- Central registry shows all overrides
- Easy to see style distribution
- Rationale documented for each override

### For Readers

**Better Reading Experience:**
- Style matches content type
- Technical sections are clear and precise
- Stories are engaging and narrative
- Transitions are intentional and smooth

---

## Potential Issues & Solutions

### Issue 1: Too Many Overrides = Inconsistent Book

**Risk:** Author overuses overrides, book feels disjointed.

**Solution:**
- Prompt 8 (Dashboard) shows style distribution percentage
- Warning if > 30% of content uses overrides
- Recommendation: "Consider if overrides are necessary"

**Example Warning:**
```
⚠ Style Override Alert

Your book uses 5 different styles across 15 chapters (40% override rate).

Consider:
- Is the book default style correct?
- Could some overrides be consolidated?
- Does this serve reader experience?

Books with > 30% overrides may feel inconsistent. Review Style_Overrides.md
to ensure each override is justified.
```

---

### Issue 2: Forgetting Which Style Applies

**Risk:** Author forgets Chapter 3 has override, manually edits in wrong style.

**Solution:**
- Prompt 3 always checks for overrides and reports which style is being used
- Chapter files can include header comment
- Prompt 10 (Update Change Tracking) detects style mismatches

**Example Chapter Header:**
```markdown
# Chapter 3: Case Studies

<!-- CHAPTER STYLE OVERRIDE: Narrative Storyteller -->
<!-- See: Chapter_03_style.md for details -->
<!-- Book Default: Business Professional -->

[Content follows...]
```

---

### Issue 3: Style Transition Awkwardness

**Risk:** Jarring shifts between chapters or sections.

**Solution:**
- Prompt 6 checks transitions at override boundaries
- Suggests transition sentences
- Examples provided in documentation

**Prompt 6 Transition Check:**
```
⚠ Style Transition Review

Chapter 3 (Narrative Storyteller) → Chapter 4 (Business Professional)

Current ending of Chapter 3:
"...and that's how Sarah's team turned things around."

Current beginning of Chapter 4:
"The implementation of robust data governance frameworks requires..."

Recommendation: Add transition at end of Chapter 3 or beginning of Chapter 4
to smooth the style shift.

Suggested transition (end of Chapter 3):
"While Sarah's story illustrates the human impact, the following chapters
examine the technical frameworks that enabled her success."
```

---

### Issue 4: Section Override Markers Broken

**Risk:** Author manually edits chapter, breaks `<!-- STYLE_OVERRIDE -->` markers.

**Solution:**
- Prompt 6 validates all override markers
- Checks for matching open/close markers
- Validates line ranges in `Style_Overrides.md` still accurate

**Validation Error:**
```
❌ Style Override Marker Error

Chapter 7: Found opening marker but no closing marker
- Line 245: <!-- STYLE_OVERRIDE: Technical Precision -->
- Expected: <!-- END_STYLE_OVERRIDE -->
- Status: MISSING

This will cause style validation to fail. Please add closing marker.
```

---

## Alternative Approaches Considered

### Alternative 1: Single Style Per Chapter (Simpler)

**Approach:**
- Only chapter-level overrides
- No section-level overrides
- Each chapter is homogeneous

**Pros:**
- Simpler implementation
- Easier to manage
- Less complexity

**Cons:**
- Can't handle technical section in otherwise narrative chapter
- Less granular control
- Doesn't solve all use cases

**Decision:** Rejected - section-level needed for technical references within chapters

---

### Alternative 2: Style Attributes in Frontmatter (YAML)

**Approach:**
- Add YAML frontmatter to chapter files
```yaml
---
style: Narrative Storyteller
reason: Case studies require storytelling
---
```

**Pros:**
- Standard markdown pattern
- Programmatically parseable
- Clean syntax

**Cons:**
- Frontmatter not widely used in framework yet
- Harder for non-technical authors
- Can't handle section-level overrides easily

**Decision:** Rejected for now, consider for v2.0

---

### Alternative 3: Multiple Style Files per Chapter

**Approach:**
- `Chapter_03_style_default.md`
- `Chapter_03_style_section2.md`
- `Chapter_03_style_section5.md`

**Pros:**
- Clear separation
- Easy to manage per-section

**Cons:**
- File proliferation
- Harder to track
- More complex to maintain

**Decision:** Rejected - inline markers cleaner for sections

---

## Recommendation

**Implement the proposed hierarchical system:**

**Book-level default** (existing `Style_Guide.md`)
  ↓
**Chapter-level overrides** (optional `Chapter_XX_style.md`)
  ↓
**Section-level overrides** (inline `<!-- STYLE_OVERRIDE -->` markers)

**With:**
- Central registry (`Style_Overrides.md`)
- New Prompt 11 (Style Manager)
- Enhanced Prompts 1, 2, 3, 6, 8
- Comprehensive validation

**Estimated effort:** 2-2.5 weeks

**Target version:** v0.11.0 (or v0.10.1 if prioritized)

---

## User Decision Needed

**Questions:**

1. **Should we implement this?**
   - [ ] Yes - Proceed with implementation
   - [ ] No - Keep single style per book
   - [ ] Modified approach (describe)

2. **If yes, which levels?**
   - [ ] Chapter-level only (simpler)
   - [ ] Chapter + Section levels (full proposal)

3. **Priority?**
   - [ ] High - Implement in v0.10.1
   - [ ] Medium - Implement in v0.11.0
   - [ ] Low - Defer to future version

4. **Additional requirements?**
   [Describe any additional needs...]

---

**Status:** Awaiting User Decision
**Created:** 2025-11-19
**Framework Version:** 0.10.0
**Estimated Effort:** 8-12 days

---

*This proposal provides complete hierarchical style system with inheritance,
overrides, validation, and management tools. Implementation ready pending
user approval.*
