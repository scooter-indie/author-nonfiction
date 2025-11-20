# Execute Prompt 6: Consistency Checker

**DESKTOP-READY:** 100% compatible with Claude Desktop (zero bash/git required)

**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`

**CRITICAL ENFORCEMENT:**
- **RULE 1:** All file modifications MUST update corresponding _chg files
- **RULE 2:** All Manuscript/ changes must go through appropriate prompts

See: `Process/ENFORCEMENT_RULES.md` for complete details

**NOTE:** This is a read-only analysis operation. No _chg updates are required (reports findings only, does not modify files)

**Claude Desktop Compatibility:**
- ✅ Pure read-only file analysis via MCP Filesystem
- ✅ No git commands required
- ✅ No bash commands required
- 📋 Works 100% in Desktop

---

## What This Does

I will scan your entire book project for consistency issues, style problems, and potential errors. This is a read-only analysis - no files will be modified.

---

## How This Works

I'll ask you what scope and types of checks you want, then analyze your content and generate a comprehensive report.

### Questions I'll ask:

1. **Scope**: What should I check?
   - All chapters and content
   - Specific chapters (you'll specify which)
   - Specific sections or types of content

2. **Check types**: Which consistency checks? (You can select multiple)
   - Terminology consistency
   - Cross-reference validation
   - Style consistency
   - Fact consistency
   - Tone/voice analysis
   - Quote/epigraph verification
   - All of the above

### Then I'll:

1. **Scan files**: Read all content in scope

2. **Analyze**:

   **Terminology Consistency:**
   - Build terminology index
   - Flag variations (e.g., "email" vs. "e-mail", "work-from-home" vs. "remote work")
   - Check capitalization consistency
   - Identify acronym usage patterns
   - Note first use vs. subsequent uses

   **Cross-Reference Validation:**
   - List all internal references (e.g., "see Chapter 5", "as discussed in Section 2.3")
   - Verify target chapters/sections exist
   - Check for broken links
   - Flag ambiguous references

   **Style Consistency:**
   - Heading hierarchy (proper nesting of H1, H2, H3, etc.)
   - List formatting (consistent use of bullets vs. numbers)
   - Quote style (straight vs. curly quotes, single vs. double)
   - Number formatting (spelled out vs. numerals, consistency in dates)
   - Citation format consistency

   **Fact Consistency:**
   - Track claims made across chapters
   - Flag potential contradictions
   - Note statistics used multiple times (check if consistent)
   - Verify citation consistency

   **Hierarchical Writing Style Consistency (v0.10.1+):**
   - Load book-level style from Manuscript/Style/Style_Guide.md
   - Scan for chapter-level overrides (Chapter_XX_style.md files)
   - Scan for section-level overrides (HTML comment markers)
   - Load style override registry (Manuscript/Style/Style_Overrides.md)
   - Resolve active style for each chapter/section using cascading inheritance
   - Assess each section against its active style (not just book-level)
   - Check person perspective consistency within each style context
   - Analyze paragraph length patterns vs. active style guidelines
   - Measure passive voice density per active style requirements
   - Detect and analyze style transitions (chapter-to-chapter, section-to-section)
   - Check override percentage vs. 30% threshold
   - Validate documented transition strategies
   - Identify chapters that drift from configured style
   - Flag violations of style DO/DON'T guidelines
   - Note tense consistency (past, present, future)
   - Assess tone alignment with configured tone

   **Quote/Epigraph Verification:**
   - Check Manuscript/Quotes/Chapter_Quotes.md for completeness
   - Flag chapters with Status ⏳ (pending quotes)
   - Verify all quotes have complete attribution (Author, Source, Year)
   - Check for missing bibliography references
   - Flag quotes without page numbers (where applicable)
   - Identify formatting inconsistencies in quote entries
   - Report quote verification status summary

3. **Generate Report** organized by:
   - **Critical Issues**: Must be fixed (broken references, contradictions)
   - **Warnings**: Should be reviewed (style variations, unclear references)
   - **Suggestions**: Consider addressing (minor inconsistencies, improvements)
   - **Terminology Index**: All terms and usage patterns
   - **Cross-Reference Map**: All references and their validity
   - **Writing Style Analysis**: Alignment with Manuscript/Style/Style_Guide.md (if exists)
   - **Quote Status Summary**: Verification status and missing attributions

---

## Report Format

The report will be organized by:
- Priority (Critical → High → Medium → Low)
- Location (Chapter and section where issue occurs)
- Type (Terminology, Cross-reference, Style, Fact, Writing Style, Quote)

Example:
```markdown
## Critical Issues

### Chapter 3, Section 2.1 (Terminology)
Reference to "Chapter 8" but book only has 7 chapters.
Location: Manuscript/Chapters/Chapter_03/Chapter_03_Methods.md:45

### Chapter 5, Section 1.2 (Fact Consistency)
States "30% of employees" but Chapter 2 stated "25% of employees" for same metric.

## Hierarchical Writing Style Analysis (v0.10.1+)

**Book-Level Style:** Conversational Expert
**Chapter Overrides:** 2 (20%)
**Section Overrides:** 3 sections across 2 chapters
**Override Threshold:** ✓ Below 30%

### Style Distribution Map

| Chapter | Active Style | Source | Alignment |
|---------|-------------|--------|-----------|
| 01 | Conversational Expert | Book | ✓ Excellent |
| 02 | Conversational Expert | Book (+ 1 section override) | ✓ Good |
| 03 | Technical Precision | Chapter Override | ✓ Excellent |
| 04 | Conversational Expert | Book | ⚠ Moderate drift |
| 05 | Conversational Expert | Book (+ 2 section overrides) | ⚠ Violations |

### Style Transition Analysis

**Chapter-Level Transitions:** 4 detected

⚠️ Chapter 02 → 03: Conversational Expert → Technical Precision
- Severity: Medium
- Documented strategy: Yes ✓
- Transition quality: Smooth

⚠️ Chapter 03 → 04: Technical Precision → Conversational Expert
- Severity: Medium
- Documented strategy: No ❌
- Recommendation: Add transition strategy to Style_Overrides.md

**Section-Level Transitions:** 6 detected across 2 chapters

Chapter 02:
✓ Line 145: Smooth transition into Technical Precision override
⚠️ Line 230: Abrupt return to Conversational (add summary sentence)

### Chapter-by-Chapter Consistency

**Chapter 1:** ✓ Excellent alignment with Conversational Expert
- Person: Consistent second person
- Formality: Moderate informal (matches style)
- Avg paragraph: 125 words (within 150 word guideline)

**Chapter 3:** ✓ Excellent alignment with Technical Precision (chapter override)
- Person: Consistent third person (matches override style)
- Formality: Technical/formal (matches override)
- Technical terms: Used appropriately for this style
- Note: This is a chapter override - different style intentional

**Chapter 4:** ⚠ Moderate drift from Conversational Expert
- Person: Mixed (8 instances of first person, book style uses second)
- Formality: Slightly more formal than book style
- Avg paragraph: 142 words (within guideline)
- Recommendation: Review first-person instances or consider chapter override

**Chapter 5:** ⚠ Style violations in Conversational Expert sections
- Base style (Conversational): ⚠ Issues detected
  - Paragraph length: 3 paragraphs exceed 200 words (guideline: 150 max)
  - Technical terms without explanation
  - Location: Lines 1-88, 230-end
- Section override (Technical Precision, Lines 89-229): ✓ Excellent
  - Technical terms appropriate for this style
  - No violations
- Recommendation: Issues only in Conversational sections, not overrides

### Priority Recommendations

**High Priority:**
- Chapter 5: Add explanations for technical terms in Conversational sections (or extend Technical override)
- Chapter 03→04: Document transition strategy in Style_Overrides.md

**Medium Priority:**
- Chapter 5: Break long paragraphs in Conversational sections
- Chapter 4: Decide on person consistency or add chapter override if intentional shift

**Style System Health:**
✅ Override usage healthy (20%, below 30% threshold)
⚠️ 1 undocumented transition requires strategy
✓ Most chapters align well with active styles
```

---

## What to Do With Results

Use the report to:
1. Identify issues that need fixing
2. Use **Prompt 3** to modify files and fix problems
3. Re-run Consistency Checker after fixes
4. Run before major milestones (25%, 50%, 75%, 100% completion)

---

## Recommended Frequency

- **Weekly**: During active writing
- **At milestones**: 25%, 50%, 75% completion
- **Before compilation**: Prior to using Prompt 5
- **Before export**: Prior to using Prompt 7

---

## Ready to Begin?

**What scope should I check?** (All chapters, or specific chapters?)

---

*Reference: Process/AI-Assisted_Nonfiction_Authoring_Process.md (Prompt 6)*
