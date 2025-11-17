# Execute Prompt 6: Consistency Checker

**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`

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

   **Tone/Voice Analysis:**
   - Assess formality level across chapters
   - Check person perspective (1st, 2nd, 3rd person)
   - Note tense consistency (past, present, future)
   - Identify outlier sections that don't match overall tone

3. **Generate Report** organized by:
   - **Critical Issues**: Must be fixed (broken references, contradictions)
   - **Warnings**: Should be reviewed (style variations, unclear references)
   - **Suggestions**: Consider addressing (minor inconsistencies, improvements)
   - **Terminology Index**: All terms and usage patterns
   - **Cross-Reference Map**: All references and their validity

---

## Report Format

The report will be organized by:
- Priority (Critical → High → Medium → Low)
- Location (Chapter and section where issue occurs)
- Type (Terminology, Cross-reference, Style, Fact, Tone)

Example:
```markdown
## Critical Issues

### Chapter 3, Section 2.1 (Terminology)
Reference to "Chapter 8" but book only has 7 chapters.
Location: Chapters/Chapter_03_Methods.md:45

### Chapter 5, Section 1.2 (Fact Consistency)
States "30% of employees" but Chapter 2 stated "25% of employees" for same metric.
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
