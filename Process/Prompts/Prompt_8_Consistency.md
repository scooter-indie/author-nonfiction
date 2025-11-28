# Execute Prompt 8: Consistency Checker

**Version:** 0.15.2
**⚡ Token Efficient:** ~5,000 tokens (75% reduction from v0.14.0)
**CLI-ONLY:** Requires Claude Code CLI for bulk file operations (30-50+ files)

**NOTE:** Read-only analysis. No _chg updates required.

---

## Quick Start

Scans your entire book project for consistency issues, style problems, and errors. Generates a comprehensive report without modifying files.

### Workflow (5 Steps)

1. Ask scope and check types
2. Scan all files in scope
3. Analyze consistency across 7 categories
4. Generate prioritized report
5. Save report and update README.md

---

## Step 1: Questions

**Ask user:**

1. **Scope:** All chapters, specific chapters, or specific sections?
2. **Check types:** (select multiple)
   - Terminology consistency
   - Cross-reference validation
   - Style consistency
   - Fact consistency
   - Tone/voice analysis
   - Quote/epigraph verification
   - Visual content status
   - Citation status
   - All of the above

---

## Step 2: Scan Files

Read all content in scope:
- Chapter files (`Manuscript/Chapters/`)
- Style files (`Manuscript/Style/`)
- Quote file (`Manuscript/Quotes/Chapter_Quotes.md`)
- Image registry (detect single vs split mode)
- Bibliography files (`BackMatter/Bibliography/`)

---

## Step 3: Analysis Categories

### Terminology Consistency
- Build terminology index
- Flag variations (email vs e-mail, etc.)
- Check capitalization and acronym usage

### Cross-Reference Validation
- Verify internal references exist
- Check for broken links
- Flag ambiguous references

### Style Consistency
- Heading hierarchy (H1→H2→H3)
- List/quote/number formatting
- Citation format consistency

### Fact Consistency
- Track claims across chapters
- Flag contradictions
- Verify repeated statistics match

### Hierarchical Writing Style (v0.10.1+)
- Load Style_Guide.md and overrides
- Resolve active style per chapter/section
- Check alignment with DO/DON'T guidelines
- Monitor override threshold (30%)
- Analyze style transitions

### Quote/Epigraph Status
- Check Chapter_Quotes.md completeness
- Flag ⏳ pending quotes
- Verify attribution completeness

### Visual Content Status (v0.14.0+)

**Registry Type Detection:**
1. Read first 15 lines of `Image_Registry.md`
2. If "Registry Type: Split" → read chapter registries
3. If not → read single registry

**Check:**
- Figure references valid
- Registry health (entries match files)
- Upgrade recommendations

### Citation Status
- Scan bibliography files
- Report ✓ verified / ⏳ pending / ❌ rejected
- Flag uncited statistical claims

📖 **For detailed report examples:** See `Process/Prompts/Prompt_8_Reference.md`

---

## Step 4: Generate Report

**Organize by priority:**

| Priority | Category |
|----------|----------|
| Critical | Broken references, contradictions |
| Warning | Style variations, unclear references |
| Suggestion | Minor inconsistencies |

**Include:**
- Terminology Index
- Cross-Reference Map
- Writing Style Analysis
- Visual Asset Summary
- Citation Status Summary
- Quote Status Summary

---

## Step 5: Save Report

1. Create `Manuscript/Reports/` if needed
2. Save as `consistency-YYYY-MM-DD.md` (use CONFIRMED_DATE)
3. Update README.md with report link (per Module 17)

**Display:**
```
✓ Consistency report saved: Manuscript/Reports/consistency-YYYY-MM-DD.md
✓ README.md updated with report link
```

---

## What to Do With Results

| Issue Type | Use Prompt |
|------------|------------|
| Content fixes | Prompt 3 or 4 |
| Add visuals | Prompt 15 |
| Upgrade visuals | Prompt 16 Mode 2 |
| Find citations | Prompt 14 |
| Verify quotes | Prompt 3 or 4 |

---

## Recommended Frequency

- **Weekly:** During active writing
- **At milestones:** 25%, 50%, 75%, 100%
- **Before compilation:** Prior to Prompt 7
- **Before export:** Prior to Prompt 9

---

📖 **For detailed examples and report formats:** See `Process/Prompts/Prompt_8_Reference.md`

---

**Version:** 0.15.2
**Last Updated:** 2025-11-24
**Token Efficiency:** 75% reduction

---

## Session Cleanup

**After this prompt completes:**

Tell user: "✓ Prompt 8 Consistency complete.

To free up tokens, say: **'Clear Prompt 8 from context'**"
