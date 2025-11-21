# Citation Management Protocol

**Framework Version:** 0.11.0
**Module:** Centralized Citation Management
**Purpose:** Standardized citation tracking, verification, and anti-hallucination compliance

---

## Overview

Centralized system for managing citations with strict verification requirements. Prevents fabricated citations and ensures all sources are verifiable by the author before publication.

**Core principle:** ALL citations start as ⏳ Pending until author verifies access and accuracy. NEVER fabricate citations.

---

## Status Code System

**Three verification levels:**

| Code | Status | Meaning | Next Action |
|------|--------|---------|-------------|
| ⏳ | Pending verification | AI found source via WebSearch, user must verify | Author checks access and accuracy |
| ✓ | Verified | Author confirmed access and accuracy | Ready for publication |
| ❌ | Rejected | Author rejected as inaccurate or inaccessible | Remove or find alternative |

**Verification progression:** ⏳ → ✓ or ❌

**Critical rule:** Only author can change status from ⏳ to ✓ or ❌

---

## Citation Entry Format

**Standard format in `BackMatter/Bibliography/Chapter_XX_References.md`:**

```markdown
## Pending Citations (⏳ User Must Verify)

**[ShortRef2023]⏳**
- **Full Citation:** [Complete bibliographic entry in project's style]
- **Why Suggested:** [Explanation of how this supports the claim]
- **Relevance Score:** [XX]%
- **DOI/URL:** [Direct link to source]
- **Status:** ⏳ Pending - User must verify access and accuracy
- **Added by:** Prompt 15: Citation_Finder (YYYY-MM-DD)
- **Location in Chapter:** Line XXX

**USER ACTION REQUIRED:**
1. Verify you can access this source
2. Confirm it supports the claim accurately
3. Update status: ⏳ → ✓ (verified) or ❌ (rejected)

---

## Verified Citations (✓ Ready for Publication)

**[ShortRef2023]✓**
- **Full Citation:** [Complete bibliographic entry]
- **DOI/URL:** [Direct link]
- **Status:** ✓ Verified by author (YYYY-MM-DD)
- **Verified by:** [Author name/initials]
- **Notes:** [Any additional context]

---

## Rejected Citations (❌ Not Used)

**[ShortRef2023]❌**
- **Full Citation:** [Complete bibliographic entry]
- **Reason for Rejection:** [Why rejected - inaccessible, inaccurate, etc.]
- **Rejected by:** [Author name/initials] (YYYY-MM-DD)
- **Alternative:** [If replacement found, reference here]
```

---

## In-Text Citation Format

**How citations appear in chapter content:**

### With Status Indicator (During Drafting)
```markdown
Remote work increased productivity by 13% during 2020-2021 [Bloom2023]⏳.
```

### After Verification
```markdown
Remote work increased productivity by 13% during 2020-2021 [Bloom2023]✓.
```

### Final Publication (Status Removed)
```markdown
Remote work increased productivity by 13% during 2020-2021 [Bloom2023].
```

**Status indicators:**
- Included during drafting to track verification status
- Removed during final compilation (Prompt 7)
- Help identify what needs verification

---

## Required Metadata Fields

### Full Citation
- **Complete bibliographic entry** in project's chosen style (APA, Chicago, MLA)
- **Includes:** Author(s), year, title, publication, volume/issue, pages
- **Format consistency:** Must match style guide exactly
- **NEVER fabricated:** Must come from WebSearch verification

### Why Suggested
- **Explanation:** How this source supports the claim in the chapter
- **Specificity:** Cite page numbers or sections if possible
- **Relevance:** Clear connection between source and claim

### Relevance Score
- **Scale:** 0-100%
- **High (80-100%):** Direct support, primary source, perfect match
- **Medium (60-79%):** Indirect support, secondary source, related
- **Low (<60%):** Tangential, general support, questionable fit
- **Guidance:** Scores <70% should prompt user to review carefully

### DOI/URL
- **DOI preferred:** Permanent identifier (e.g., 10.1257/aer.20201834)
- **URL acceptable:** If DOI unavailable
- **Accessibility:** Must be publicly accessible or commonly available
- **Verification:** Link must work at time of insertion

### Status
- **Always starts:** ⏳ Pending
- **User action:** Required to move to ✓ or ❌
- **Timestamp:** Record when status changed
- **Actor:** Record who changed status (author name/initials)

### Added By
- **Source:** Always "Prompt 15: Citation_Finder"
- **Date:** YYYY-MM-DD format
- **Traceability:** Know where citation came from

### Location in Chapter
- **Line number:** Where citation appears in chapter
- **Context:** Helps user find and verify claim
- **Updates:** If line number changes, update during Prompt 5

---

## Bibliography File Structure

**Per-chapter reference files:**

```
BackMatter/Bibliography/
├── Bibliography_chg.md                 # Change tracking for bibliography
├── Chapter_01_References.md            # Chapter 1 citations
├── Chapter_02_References.md            # Chapter 2 citations
├── Chapter_03_References.md            # Chapter 3 citations
├── FrontMatter_References.md           # Citations in front matter
├── BackMatter_References.md            # Citations in back matter
└── README.md                           # Bibliography overview/instructions
```

**Bibliography overview (README.md):**
```markdown
# Bibliography Management

**Citation Style:** [APA 7th | Chicago 17th | MLA 9th]
**Last Updated:** YYYY-MM-DD
**Total Citations:** XX (YY ✓ verified, ZZ ⏳ pending)

---

## Status Summary

- ✓ Verified: XX citations ready for publication
- ⏳ Pending: YY citations awaiting verification
- ❌ Rejected: ZZ citations removed

---

## Verification Instructions

1. Open `Chapter_XX_References.md` for citations to verify
2. Access each pending (⏳) source using provided DOI/URL
3. Confirm source exists and supports the claim accurately
4. Update status in file: ⏳ → ✓ (verified) or ❌ (rejected)
5. Run Prompt 3 or 4 to update chapter with status changes
6. Commit changes to git

---

## Citation Style Guide

[Include specific formatting rules for project's chosen style]
```

---

## Verification Progression

### Stage 1: Initial Entry (⏳ Pending)

**When created:**
- By Prompt 15: Citation_Finder after WebSearch
- NEVER manually without WebSearch verification
- User requested citation addition via Prompt 4

**Required fields:**
- Full Citation (from WebSearch results)
- Why Suggested
- Relevance Score
- DOI/URL (must be accessible)
- Status: ⏳ Pending
- Added By: Prompt 15
- Location in Chapter

**User action needed:**
- Access the source
- Verify it supports the claim
- Confirm accuracy
- Move to Stage 2 or 3

**Example:**
```markdown
**[Bloom2023]⏳**
- **Full Citation:** Bloom, N., Liang, J., Roberts, J., & Ying, Z. J. (2023).
  Does working from home work? Evidence from a Chinese experiment.
  *American Economic Review*, 113(1), 123-156.
- **Why Suggested:** Directly supports productivity claim with empirical data
- **Relevance Score:** 95%
- **DOI:** 10.1257/aer.20201834
- **Status:** ⏳ Pending - User must verify access and accuracy
- **Added by:** Prompt 15: Citation_Finder (2025-11-20)
- **Location in Chapter:** Line 234

**USER ACTION REQUIRED:**
1. Verify you can access this source
2. Confirm it supports the claim accurately
3. Update status: ⏳ → ✓ (verified) or ❌ (rejected)
```

### Stage 2: Verified (✓ Ready for Publication)

**When promoted:**
- User accessed source successfully
- User confirmed accuracy of citation
- User confirmed it supports the claim
- Ready for publication

**Updated fields:**
- Status: ✓ Verified
- Verified by: [Author name/initials]
- Date verified: YYYY-MM-DD
- Remove "USER ACTION REQUIRED" section
- Move from "Pending" to "Verified" section

**Example:**
```markdown
**[Bloom2023]✓**
- **Full Citation:** Bloom, N., Liang, J., Roberts, J., & Ying, Z. J. (2023).
  Does working from home work? Evidence from a Chinese experiment.
  *American Economic Review*, 113(1), 123-156.
- **DOI:** 10.1257/aer.20201834
- **Status:** ✓ Verified by JSM (2025-11-21)
- **Notes:** Excellent empirical study, directly applicable to Chapter 2 argument
```

### Stage 3: Rejected (❌ Not Used)

**When rejected:**
- User cannot access source
- User found citation inaccurate
- User found better alternative
- Source doesn't actually support claim

**Updated fields:**
- Status: ❌ Rejected
- Reason for Rejection: [Explanation]
- Rejected by: [Author name/initials]
- Date rejected: YYYY-MM-DD
- Alternative: [If replacement found]
- Remove citation from chapter text

**Example:**
```markdown
**[Bloom2023]❌**
- **Full Citation:** Bloom, N., Liang, J., Roberts, J., & Ying, Z. J. (2023).
  Does working from home work? Evidence from a Chinese experiment.
  *American Economic Review*, 113(1), 123-156.
- **Reason for Rejection:** Paywalled, no institutional access available
- **Rejected by:** JSM (2025-11-21)
- **Alternative:** Found open-access alternative [Smith2022]⏳
```

---

## Citation Styles Supported

### APA 7th Edition
- Author-date in-text citations
- Reference list alphabetical by author
- DOI included when available

**Example:**
```
Bloom, N., Liang, J., Roberts, J., & Ying, Z. J. (2023). Does working
from home work? Evidence from a Chinese experiment. American Economic
Review, 113(1), 123-156. https://doi.org/10.1257/aer.20201834
```

### Chicago 17th Edition
- Notes and bibliography system
- Footnote or endnote citations
- Full bibliography at end

**Example:**
```
Bloom, Nicholas, James Liang, John Roberts, and Zhichun Jenny Ying.
"Does Working from Home Work? Evidence from a Chinese Experiment."
American Economic Review 113, no. 1 (2023): 123-156.
https://doi.org/10.1257/aer.20201834.
```

### MLA 9th Edition
- Author-page in-text citations
- Works Cited list alphabetical
- Container concept for complex sources

**Example:**
```
Bloom, Nicholas, et al. "Does Working from Home Work? Evidence from
a Chinese Experiment." American Economic Review, vol. 113, no. 1,
2023, pp. 123-156, doi:10.1257/aer.20201834.
```

**Project style configured in:** `Project_Config.md`

---

## Anti-Hallucination Compliance (CRITICAL)

### Absolute Rules

**NEVER:**
- ❌ Fabricate citations
- ❌ Create fake sources
- ❌ Invent DOIs or URLs
- ❌ Guess author names
- ❌ Approximate publication dates
- ❌ Make up article titles
- ❌ Create fictional journals
- ❌ Generate fake statistics or data
- ❌ Claim sources exist without WebSearch verification

**ALWAYS:**
- ✅ Use WebSearch to verify every source exists
- ✅ Include actual, working DOI or URL
- ✅ Mark citations as ⏳ Pending initially
- ✅ Require user verification before ✓ status
- ✅ Provide clear reasoning for suggestions
- ✅ Calculate honest relevance scores
- ✅ Admit uncertainty if source unclear
- ✅ Offer to search again if results insufficient

### WebSearch Integration (Prompt 15 Only)

**Required process:**
1. Identify claim needing citation in chapter
2. Formulate precise search query based on claim
3. Use WebSearch tool to find academic/authoritative sources
4. Verify source actually exists and is accessible
5. Extract complete bibliographic information
6. Verify source appears to support claim (from abstract/summary)
7. Calculate relevance score honestly
8. Insert citation with ⏳ Pending status
9. NEVER skip any step

**If WebSearch finds no suitable sources:**
- Inform user: "No suitable citation found for this claim"
- Suggest alternative: Rephrase claim more cautiously, or
- Suggest alternative: Mark claim as opinion/analysis rather than fact

**Never assume a source exists without WebSearch confirmation.**

### Verification Protocol

**Before inserting any citation:**
- [ ] WebSearch executed for this exact claim
- [ ] Source found and verified to exist
- [ ] DOI or URL confirmed working
- [ ] Full bibliographic information extracted
- [ ] Abstract/summary checked for relevance
- [ ] Relevance score calculated honestly
- [ ] Status marked as ⏳ Pending
- [ ] USER ACTION REQUIRED section included

**If any check fails:** Do not insert citation. Report to user.

---

## Coordination with Quote Management (Module 07)

**Similarities:**
- Both use status codes: ⏳ ⚠ ✓
- Both require user verification
- Both prevent fabrication
- Both track sources

**Differences:**
- **Quotes:** For chapter epigraphs, stored in Quotes/Chapter_Quotes.md
- **Citations:** For in-text claims, stored in BackMatter/Bibliography/
- **Quotes:** Exact text must be preserved
- **Citations:** Bibliographic info sufficient
- **Quotes:** Optional (chapters can have no epigraph)
- **Citations:** Essential for factual claims

**Integration:**
- Quote sources may also need citations in bibliography
- Both managed through same verification workflow
- Both reported by Prompt 8 (Consistency)
- Both updated via Prompts 3/4

---

## Integration with Prompts

### Prompt 15: Citation_Finder (Primary Creator)
- Analyzes chapters for claims needing citations
- Uses WebSearch to find sources
- Inserts citations with ⏳ Pending status
- Creates bibliography entries
- Updates _chg files
- Commits to git

### Prompt 8: Consistency Checker (Reporter)
- Counts citations per chapter
- Shows ⏳ pending vs ✓ verified distribution
- Flags uncited claims
- Reports citation status
- Recommends running Prompt 15

### Prompts 3/4: Change by Chg / Interactive Change (Updaters)
- User updates citation status (⏳ → ✓ or ❌)
- User adds manual citations if needed
- User edits citation metadata
- User fixes citation format issues

### Prompt 7: Compile (Consumer)
- Resolves citation references
- Removes status indicators (⏳ ✓ ❌) from final output
- Includes bibliography in manuscript
- Formats citations per output style (DOCX, PDF, EPUB)

---

## Quality Standards

**Citations must:**
- Come from credible sources (peer-reviewed, authoritative)
- Be accessible to readers (not paywalled if possible, or commonly available)
- Be recent (prefer last 5-10 years unless historical)
- Directly support the claim (high relevance score)
- Be formatted correctly per style guide
- Include DOI when available
- Have working URLs

**Bibliography files must:**
- Group by status (Pending / Verified / Rejected)
- Sort alphabetically within each group
- Use consistent formatting
- Include all required metadata
- Be updated promptly when status changes

---

## Usage Example

**Scenario:** Chapter 2 discusses remote work productivity and makes a statistical claim.

**Step 1: Prompt 15 identifies uncited claim**
```markdown
# Chapter 2, line 234:
Remote work increased productivity by 13% during 2020-2021.
```
**Issue:** Statistical claim with no citation

**Step 2: WebSearch for source**
- Query: "remote work productivity 13% 2020 2021 study"
- WebSearch finds: Bloom et al. (2023) AER article
- Verifies: Source exists, DOI works, abstract mentions productivity gains

**Step 3: Insert citation in chapter**
```markdown
Remote work increased productivity by 13% during 2020-2021 [Bloom2023]⏳.
```

**Step 4: Create bibliography entry**
In `BackMatter/Bibliography/Chapter_02_References.md`:
```markdown
**[Bloom2023]⏳**
- **Full Citation:** Bloom, N., Liang, J., Roberts, J., & Ying, Z. J. (2023).
  Does working from home work? Evidence from a Chinese experiment.
  *American Economic Review*, 113(1), 123-156.
- **Why Suggested:** Empirical study directly measuring remote work productivity
- **Relevance Score:** 95%
- **DOI:** 10.1257/aer.20201834
- **Status:** ⏳ Pending - User must verify access and accuracy
- **Added by:** Prompt 15: Citation_Finder (2025-11-20)
- **Location in Chapter:** Line 234

**USER ACTION REQUIRED:**
1. Verify you can access this source
2. Confirm it supports the claim accurately
3. Update status: ⏳ → ✓ (verified) or ❌ (rejected)
```

**Step 5: Update _chg file**
In `Chapter_02_chg.md`:
```markdown
### v1.3.5 (2025-11-20) - AUTO: Citation additions

**Changes:**
- Added citation [Bloom2023]⏳ for remote work productivity claim (line 234)
- Added to Bibliography/Chapter_02_References.md as Pending

**Rationale:** Prompt 15 identified uncited statistical claim
**Status:** ⏳ Pending user verification
```

**Step 6: User verifies**
- User accesses DOI link
- Confirms study supports the 13% claim
- Updates status in Bibliography file: ⏳ → ✓
- Updates via Prompt 3 or 4

**Step 7: Final result**
```markdown
# Chapter text:
Remote work increased productivity by 13% during 2020-2021 [Bloom2023]✓.

# Bibliography (verified section):
**[Bloom2023]✓**
- **Full Citation:** Bloom, N., Liang, J., Roberts, J., & Ying, Z. J. (2023).
  Does working from home work? Evidence from a Chinese experiment.
  *American Economic Review*, 113(1), 123-156.
- **DOI:** 10.1257/aer.20201834
- **Status:** ✓ Verified by JSM (2025-11-21)
```

---

## Error Handling

**Missing citation file:**
- Chapter references citation not in bibliography
- **Resolution:** Run Prompt 15 to find source, or remove reference

**Orphaned citation:**
- Bibliography entry exists but not referenced in any chapter
- **Resolution:** Remove from bibliography or add reference to chapter

**Broken DOI/URL:**
- Link no longer works
- **Resolution:** Find updated link, or mark ❌ rejected and find alternative

**Duplicate citations:**
- Same source referenced with different short refs
- **Resolution:** Standardize on one short ref, update all references

**Style inconsistency:**
- Citations formatted in multiple styles
- **Resolution:** Standardize to project's chosen style

---

## Migration from Existing Citations

**If chapter already has citations:**

1. **Audit existing citations:**
   - Check each has proper bibliography entry
   - Verify sources are real (not fabricated)
   - Confirm DOI/URL works

2. **Create bibliography files:**
   - Extract to `BackMatter/Bibliography/Chapter_XX_References.md`
   - Mark all as ⏳ Pending initially
   - User verifies each before moving to ✓

3. **Update chapter references:**
   - Standardize short ref format
   - Add status indicators
   - Update _chg file with migration record

4. **Commit changes:**
   - Record migration in git history

---

## Validation Checklist

**When inserting/updating citations:**

- [ ] Source verified via WebSearch (not fabricated)
- [ ] Full citation formatted correctly per style guide
- [ ] DOI or URL included and working
- [ ] Relevance score calculated honestly
- [ ] Status marked as ⏳ Pending
- [ ] USER ACTION REQUIRED included
- [ ] Bibliography file updated
- [ ] Chapter reference inserted
- [ ] _chg file updated
- [ ] Changes committed to git

---

## Best Practices

### For AI (Prompt 15)
1. **Always use WebSearch:** Never insert citation without verification
2. **Be honest about relevance:** Don't oversell weak sources
3. **Provide context:** Explain why source was suggested
4. **Include working links:** Test DOI/URL before inserting
5. **Start conservative:** Always ⏳ Pending, never assume ✓

### For Authors
1. **Verify promptly:** Don't let ⏳ citations accumulate
2. **Access first:** Ensure you can actually read the source
3. **Read carefully:** Confirm source supports claim accurately
4. **Document reasons:** If rejecting, note why for future reference
5. **Update regularly:** Run Prompt 8 to track verification status

### For Maintenance
1. **Regular audits:** Check for broken links at milestones
2. **Style consistency:** Verify all citations match style guide
3. **Remove rejected:** Clean up ❌ citations periodically
4. **Coordinate with editor:** Align on citation requirements
5. **Final sweep:** Verify all ✓ before submission

---

## Summary

Citation Management Protocol provides:
- ✅ Strict anti-hallucination compliance (NEVER fabricate)
- ✅ WebSearch verification required
- ✅ Three-stage status system (⏳ ✓ ❌)
- ✅ Per-chapter bibliography files
- ✅ In-text citation format with status
- ✅ Integration with framework prompts
- ✅ Coordination with quote management
- ✅ User verification required
- ✅ Multiple citation styles supported

**Used by:** Prompt 15 (primary), Prompt 8 (reporter), Prompts 3/4 (updaters), Prompt 7 (consumer)

**Critical principle:** NO citation enters the system without WebSearch verification and ⏳ Pending status. Only author can promote to ✓ Verified.

---

**Framework Version:** 0.11.0
**Created:** 2025-11-20
**Status:** Active

---

*This protocol prevents fabricated citations while making it easy for authors to find, verify, and manage sources throughout the writing process*
