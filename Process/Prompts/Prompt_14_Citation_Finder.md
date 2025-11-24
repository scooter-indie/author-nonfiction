# Execute Prompt 14: Citation_Finder

**Version:** 0.13.0
**CLI-ONLY:** Requires Claude Code CLI for WebSearch tool and bulk file analysis operations

**FIRST ACTION - MANDATORY:**
1. Read `Process/_COMMON/18_Lock_Management_Module.md`
2. Read `Process/Anti-Hallucination_Guidelines.md` in full before proceeding with ANY other actions or questions.

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

I will analyze your chapters to identify **statements requiring academic or professional citations** and use WebSearch to find valid, verifiable references that support your claims. I will then auto-insert citations with pending verification status, allowing you to confirm access and accuracy before marking them as verified.

**Why this matters:**
- Uncited claims weaken credibility
- Statistics and data require verifiable sources
- Theoretical frameworks need proper attribution
- Readers and publishers expect scholarly rigor
- Proper citations protect against plagiarism accusations
- Citations enable readers to explore topics further

**This is NOT about fabricating citations** - it's about finding REAL sources via WebSearch, verifying they exist, and marking them as Pending until YOU confirm access and accuracy.

---

## Anti-Hallucination Compliance (CRITICAL)

**This prompt operates at Anti-Hallucination Level 3: NEVER FABRICATE**

### Absolute Rules:

1. **NEVER fabricate citations**
   - Only suggest sources found via WebSearch
   - Verify sources actually exist on the web
   - Never guess DOIs, ISBNs, or URLs

2. **ALWAYS mark as ⏳ Pending**
   - All auto-inserted citations are Pending by default
   - User must verify they can access the source
   - User must confirm the source supports the claim

3. **NEVER assume attribution**
   - Don't guess authors or publication years
   - Don't assume journal names or publishers
   - Flag uncertain information with ⚠

4. **ALWAYS verify before inserting**
   - Use WebSearch to confirm source exists
   - Check that author names are real
   - Verify publication is accessible

5. **Coordinate with Quote Management (Module 07)**
   - Quote citations follow quote verification workflow
   - Use same status system: ⏳ → ✓ or ❌
   - Cross-reference with Quotes/Chapter_Quotes.md

---

## How This Works

### Step 0: Lock Management

**Initialize Lock System:**

1. Check if `.locks/` directory exists
   - If not: Create `.locks/` directory using bash: `mkdir -p .locks`
   - **CRITICAL:** Use `mkdir -p` (bash/sh command), NOT Windows CMD syntax (`if not exist`)


2. Check if `.locks/locks.json` exists
   - If not: Create with empty structure:
     ```json
     {
       "locks": []
     }
     ```

**Generate Instance ID:**

Create unique instance identifier for this session:
- Format: `CLI-[5-digit-random]` or `Desktop-[5-digit-random]`
- Example: `CLI-12345`, `Desktop-67890`
- Reuse same ID for all locks in this session

**Determine Required Resources:**

Based on user's chapter selection and whether bibliography will be updated:
- Analyzing chapters → `Chapter_XX` (for each chapter)
- Updating bibliography → `BackMatter`

**Acquire Locks:**

Resources needed for this prompt: `Chapter_XX` (for each chapter receiving citations), `BackMatter`

For each resource:

1. Read `.locks/locks.json`

2. Check if resource is locked:
   - Search `locks` array for entry where `"resource"` matches

3. **If lock exists:**
   - Calculate age: `current_time - lock.timestamp`

   - **If age < 15 minutes:**
     ```
     ⚠️ [Resource] is currently locked by another instance.

     Lock details:
     - Resource: [resource]
     - Locked at: [timestamp] ([X] minutes ago)
     - Instance: [instance]

     Cannot add citations to this location while locked.

     Options:
     1. Skip this chapter/resource
     2. Wait for lock to clear (checks every 5 seconds)
     3. Cancel entire operation

     Choose option (1-3):
     ```

   - **If age >= 15 minutes:**
     ```
     ⚠️ [Resource] has a stale lock (older than 15 minutes).

     Lock details:
     - Resource: [resource]
     - Locked at: [timestamp] ([X] minutes ago)
     - Instance: [instance]

     This lock may be from a crashed instance.

     Options:
     1. Override stale lock and continue
     2. Skip this chapter/resource
     3. Cancel entire operation

     Choose option (1-3):
     ```

4. **If user chooses to wait (Option 2):**
   - Poll every 5 seconds
   - Re-check `.locks/locks.json`
   - If lock cleared: Proceed to acquire
   - If timeout (2 minutes): Skip resource

5. **If user cancels:**
   - Exit prompt without changes
   - Release any already-acquired locks

6. **If no lock OR override approved:**
   - Add lock entries:
     ```json
     {
       "resource": "Chapter_XX",
       "timestamp": "[ISO-8601-timestamp]",
       "instance": "[instance_id]"
     },
     {
       "resource": "BackMatter",
       "timestamp": "[ISO-8601-timestamp]",
       "instance": "[instance_id]"
     }
     ```
   - Write updated JSON to `.locks/locks.json`
   - Proceed with citation finding

---

### Questions I'll Ask:

1. **Which chapters to analyze?**
   - Specific chapters (e.g., "Chapter 3, 5, 7")
   - All chapters
   - Range (e.g., "Chapters 1-5")
   - Front/Back matter (optional)

2. **What citation style?**
   - APA (American Psychological Association)
   - Chicago (Author-Date or Notes-Bibliography)
   - MLA (Modern Language Association)
   - Other (specify)

3. **Analysis scope?**
   - **Quick scan** (5-10 minutes): Flag obvious uncited claims
   - **Standard analysis** (15-25 minutes): Comprehensive citation finding
   - **Deep research** (30-45 minutes): Extensive source verification

4. **Focus areas?** (or analyze all)
   - Statistical claims
   - Historical facts
   - Theoretical frameworks
   - Best practices assertions
   - Case study references
   - Quote attributions

---

## Statements Needing Citations

### 1. Statistical Claims

**Indicators:**
- Percentages, ratios, or numerical data
- "X% of companies/people..."
- "Studies show that..."
- Comparative statistics

**Examples requiring citations:**
- "Remote work increased productivity by 13% during 2020-2021."
- "73% of employees prefer hybrid arrangements."
- "Customer satisfaction improved by 28% after implementation."

### 2. Historical Facts

**Indicators:**
- Specific dates or events
- "In [year], [event] happened..."
- Historical trends or patterns
- Origin stories or founding dates

**Examples requiring citations:**
- "The concept of remote work was first introduced in 1973."
- "The four-day work week movement began in Iceland in 2015."
- "The pandemic caused the largest remote work shift in history."

### 3. Theoretical Frameworks

**Indicators:**
- Named theories or models
- "According to [theory]..."
- Frameworks attributed to researchers
- Academic concepts

**Examples requiring citations:**
- "Maslow's hierarchy of needs explains motivation."
- "The Diffusion of Innovation theory describes adoption patterns."
- "Social Cognitive Theory suggests that learning occurs through observation."

### 4. Research Findings

**Indicators:**
- "Research shows/indicates/suggests..."
- "Studies have found..."
- "Experiments demonstrate..."
- Scientific or academic claims

**Examples requiring citations:**
- "Research indicates that employee engagement correlates with retention."
- "Neuroscience studies show that multitasking reduces productivity."
- "Longitudinal research demonstrates long-term health benefits."

### 5. Expert Opinions

**Indicators:**
- "Experts agree/suggest/recommend..."
- "Practitioners have found..."
- "According to [field] professionals..."
- Industry consensus claims

**Examples requiring citations:**
- "Management experts recommend quarterly performance reviews."
- "Healthcare professionals advocate for preventive care."
- "Economists predict inflation rates will stabilize."

### 6. Best Practices Assertions

**Indicators:**
- "Best practices include..."
- "Industry standards require..."
- "Evidence-based approaches suggest..."
- Prescriptive recommendations

**Examples requiring citations:**
- "Best practices for cybersecurity include multi-factor authentication."
- "Agile methodologies recommend daily stand-up meetings."
- "Evidence-based education practices prioritize active learning."

### 7. Case Study References

**Indicators:**
- Specific company or organization examples
- "Company X implemented Y..."
- Named projects or initiatives
- Real-world implementation stories

**Examples requiring citations:**
- "Microsoft's Japan office tested a four-day work week in 2019."
- "Buffer has published salary transparency data since 2013."
- "The city of Barcelona implemented superblocks to reduce traffic."

### 8. Direct Quotes (Coordinate with Quote Management)

**Indicators:**
- Any quoted material
- Attributed statements
- Paraphrased ideas from specific sources

**Examples requiring citations:**
- All chapter epigraphs (managed via Quotes/Chapter_Quotes.md)
- Inline quotes from experts or authorities
- Paraphrased unique ideas

---

## Citation Finding Workflow

### Step 1: Scan for Uncited Claims

**I will read through specified chapters and identify:**
- Statements matching the 8 categories above
- Claims that sound specific enough to need verification
- Assertions that readers might question
- Data points without supporting references

**I will create a preliminary report:**
```markdown
## Chapter 03: Remote Work Productivity

**Uncited Claims Found:** 8

**Line 45:** "Remote work increased productivity by 13% during 2020-2021."
- **Type:** Statistical claim
- **Priority:** HIGH (specific percentage requires verification)
- **Search needed:** Remote work productivity statistics 2020-2021

**Line 112:** "The concept of remote work was first introduced in 1973."
- **Type:** Historical fact
- **Priority:** MEDIUM (specific date requires verification)
- **Search needed:** History of remote work Jack Nilles 1973

**Line 203:** "Maslow's hierarchy of needs explains employee motivation patterns."
- **Type:** Theoretical framework
- **Priority:** LOW (widely known, but citation adds credibility)
- **Search needed:** Maslow hierarchy of needs original publication
```

### Step 2: Search for Valid References

**Using WebSearch, I will:**
- Search for academic papers, books, articles supporting each claim
- Verify sources actually exist (not hallucinated)
- Check publication dates and authors
- Assess source quality (peer-reviewed, authoritative, reputable)
- Calculate relevance score (how well source supports the claim)

**Search strategy:**
- Use Google Scholar for academic papers
- Search reputable news sources for current events
- Find original publications for theories/frameworks
- Verify company case studies via official announcements

**Example WebSearch queries:**
- "remote work productivity statistics 2020 2021 study"
- "Jack Nilles telework 1973 original publication"
- "Maslow hierarchy of needs original paper citation"

### Step 3: Verify Sources Are Real

**CRITICAL Anti-Hallucination Check:**
- ✓ WebSearch returns actual results
- ✓ Source has verifiable author(s)
- ✓ Publication date is confirmed
- ✓ Source is accessible online or in libraries
- ✓ DOI or URL is valid (test if possible)
- ❌ If ANY verification fails, flag as ⚠ Uncertain

### Step 4: Auto-Insert Citations with Pending Status

**For each verified source, I will:**

1. **Insert in-text citation in chapter content:**
   ```markdown
   Remote work increased productivity by 13% during 2020-2021 [Bloom2023]⏳.
   ```

2. **Add full citation to Bibliography:**
   `BackMatter/Bibliography/Chapter_XX_References.md`
   ```markdown
   ## Pending Citations (⏳ User Must Verify)

   **[Bloom2023]⏳**
   - **Full Citation:** Bloom, N., Liang, J., Roberts, J., & Ying, Z. J. (2023).
     Does working from home work? Evidence from a Chinese experiment.
     *American Economic Review*, 113(1), 123-156.
   - **Why Suggested:** Directly supports 13% productivity claim with empirical data
   - **Relevance Score:** 95%
   - **DOI:** 10.1257/aer.20201834
   - **URL:** https://www.aeaweb.org/articles?id=10.1257/aer.20201834
   - **Status:** ⏳ Pending - User must verify access and accuracy
   - **Added by:** Prompt 14: Citation_Finder ([CONFIRMED_DATE])

   **USER ACTION REQUIRED:**
   1. Verify you can access this source
   2. Read the relevant section to confirm it supports your claim
   3. Update status: ⏳ → ✓ (verified) or ❌ (rejected)
   4. If rejected, request alternative source suggestions
   ```

3. **Update chapter _chg file:**
   ```markdown
   ### v1.3.2 ([CONFIRMED_DATE]) - AUTO: Citation additions

   **Changes:**
   - Added citation [Bloom2023]⏳ for remote work productivity claim (line 45)
   - Citation details added to Bibliography/Chapter_03_References.md
   - Status: Pending user verification

   **Rationale:** Prompt 14 identified uncited statistical claim requiring source

   **Verification Required:**
   - User must confirm access to source
   - User must verify source supports the specific 13% claim
   - Alternative sources available if this source is inaccessible

   **Next Steps:**
   - Review citation in context
   - Verify via Prompt 4 (Interactive_Change) if needed
   - Update status in Bibliography when verified
   ```

4. **Update Bibliography _chg file:**
   ```markdown
   ### v1.2.1 ([CONFIRMED_DATE]) - AUTO: New citations added

   **Changes:**
   - Added [Bloom2023]⏳ - Remote work productivity study
   - Status: ⏳ Pending user verification

   **Source:** Prompt 14: Citation_Finder
   **Related Chapter:** Chapter_03.md (line 45)

   **User Action Required:**
   - Verify accessibility
   - Confirm relevance
   - Update status: ⏳ → ✓ or ❌
   ```

### Step 5: Generate Citation Report

**I will create a comprehensive report:**

```markdown
# Citation Analysis Report: Chapter 03

**Generated:** [CONFIRMED_DATE]
**Chapter:** Chapter 03: Remote Work Productivity
**Uncited Claims Found:** 8
**Citations Added:** 6
**Flagged for Manual Research:** 2

---

## Citations Successfully Added

### 1. [Bloom2023]⏳ - Line 45
**Claim:** "Remote work increased productivity by 13% during 2020-2021."
**Citation:** Bloom et al. (2023), *American Economic Review*
**Relevance:** 95% (directly supports specific percentage)
**Status:** ⏳ Pending verification
**Access:** DOI link provided, paywall possible

### 2. [Nilles1976]⏳ - Line 112
**Claim:** "The concept of remote work was first introduced in 1973."
**Citation:** Nilles, J. M. (1976), *The telecommunications-transportation tradeoff*
**Relevance:** 90% (seminal work on telework concept)
**Status:** ⏳ Pending verification
**Access:** May require library access for original publication

### 3. [Maslow1943]⏳ - Line 203
**Claim:** "Maslow's hierarchy of needs explains employee motivation patterns."
**Citation:** Maslow, A. H. (1943), *Psychological Review*
**Relevance:** 100% (original theory publication)
**Status:** ⏳ Pending verification
**Access:** Widely available, public domain

---

## Claims Requiring Manual Research

### 1. Line 178 - ⚠ No Source Found
**Claim:** "85% of managers report difficulty managing remote teams."
**Issue:** Could not find specific source for this exact statistic
**Recommendation:**
- Verify if this is from your proprietary research/survey
- Consider rephrasing as "many managers report difficulty..."
- Or conduct WebSearch for similar statistics with broader wording

### 2. Line 289 - ⚠ Source Quality Uncertain
**Claim:** "The average remote worker saves $4,000 annually on commuting."
**Issue:** Found multiple blog posts claiming this, but no peer-reviewed source
**Recommendation:**
- Mark as [CITATION NEEDED: verify with authoritative source]
- Consider Global Workplace Analytics or similar research org
- May need to adjust specific dollar amount based on verified data

---

## Citation Status Summary

**Total Claims Analyzed:** 8
**Citations Added:** 6 (75%)
**Pending User Verification:** 6
**Flagged for Manual Work:** 2 (25%)

**Next Steps:**
1. Review all ⏳ Pending citations in BackMatter/Bibliography/Chapter_03_References.md
2. Verify you can access each source
3. Confirm each source supports your specific claim
4. Update status: ⏳ → ✓ (verified) or ❌ (rejected)
5. For rejected citations, request alternative suggestions
6. Address 2 flagged claims requiring manual research

---

## Bibliography File Updated

**File:** BackMatter/Bibliography/Chapter_03_References.md
**New entries:** 6 citations
**Status:** All marked ⏳ Pending

**Verification Instructions:**
- Each citation includes relevance score and rationale
- DOI/URL provided where available
- User action steps clearly marked
- Alternative search suggestions provided for flagged items

---

## Verification Workflow

**Option 1: Review in Claude Desktop**
1. Open BackMatter/Bibliography/Chapter_03_References.md
2. Click DOI/URL links to verify access
3. Read relevant sections to confirm support for claims
4. Manually update status: ⏳ → ✓ or ❌

**Option 2: Use Prompt 4 (Interactive_Change)**
1. Execute Prompt 4
2. Specify Bibliography file
3. Discuss each citation interactively
4. Update statuses conversationally
5. Request alternative suggestions if needed

---

**Report saved to:** Drafts/Citation_Report_Chapter_03_[CONFIRMED_DATE].md
```

### Step 6: Commit to Git

**I will create a git commit:**
```bash
git add Chapter_03.md
git add Chapter_03_chg.md
git add BackMatter/Bibliography/Chapter_03_References.md
git add BackMatter/Bibliography/Chapter_03_References_chg.md
git add Drafts/Citation_Report_Chapter_03_[CONFIRMED_DATE].md
git commit -m "AUTO: Add 6 pending citations to Chapter 03 (Prompt 14)

- Added [Bloom2023], [Nilles1976], [Maslow1943], [Allen2021], [Grant2022], [Bailey2020]
- All citations marked ⏳ Pending user verification
- Updated Chapter_03.md with in-text citations
- Created Bibliography/Chapter_03_References.md entries
- Generated citation analysis report
- Flagged 2 claims requiring manual research

User must verify access and accuracy before marking ✓ Verified

Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

### Step 7: Prompt User for Verification

**I will display:**
```
✅ Citation analysis complete!

**Summary:**
- Chapter 03: 6 citations added, 2 flagged for manual research
- All citations marked ⏳ Pending verification
- Bibliography file updated with full citation details

**Next Steps:**
1. Review citations in BackMatter/Bibliography/Chapter_03_References.md
2. Verify you can access each source (DOI/URL links provided)
3. Confirm each source supports your claims accurately
4. Update status: ⏳ → ✓ (verified) or ❌ (rejected)

**To verify citations:**
- Option 1: Manually edit Bibliography file
- Option 2: Execute Prompt 4 (Interactive_Change) for conversational review

**Flagged claims (need your input):**
- Line 178: Cannot verify "85% of managers..." statistic
- Line 289: "$4,000 annually" figure needs authoritative source

Would you like to review citations now via Prompt 4, or verify manually later?
```

---

## Citation Format by Style

### APA (American Psychological Association)

**In-text citation:**
```markdown
Remote work increased productivity (Bloom et al., 2023).
```

**Bibliography entry:**
```markdown
Bloom, N., Liang, J., Roberts, J., & Ying, Z. J. (2023). Does working from home
work? Evidence from a Chinese experiment. *American Economic Review*, 113(1),
123-156. https://doi.org/10.1257/aer.20201834
```

### Chicago (Author-Date)

**In-text citation:**
```markdown
Remote work increased productivity (Bloom et al. 2023, 134).
```

**Bibliography entry:**
```markdown
Bloom, Nicholas, James Liang, John Roberts, and Zhichun Jenny Ying. 2023.
"Does Working from Home Work? Evidence from a Chinese Experiment."
*American Economic Review* 113 (1): 123–156.
```

### Chicago (Notes-Bibliography)

**In-text citation:**
```markdown
Remote work increased productivity.¹
```

**Footnote:**
```markdown
1. Nicholas Bloom et al., "Does Working from Home Work? Evidence from a Chinese
Experiment," *American Economic Review* 113, no. 1 (2023): 134.
```

**Bibliography entry:**
```markdown
Bloom, Nicholas, James Liang, John Roberts, and Zhichun Jenny Ying.
"Does Working from Home Work? Evidence from a Chinese Experiment."
*American Economic Review* 113, no. 1 (2023): 123–156.
```

### MLA (Modern Language Association)

**In-text citation:**
```markdown
Remote work increased productivity (Bloom et al. 134).
```

**Works Cited entry:**
```markdown
Bloom, Nicholas, et al. "Does Working from Home Work? Evidence from a Chinese
Experiment." *American Economic Review*, vol. 113, no. 1, 2023, pp. 123-156.
```

---

## Citation Insertion Format

### Framework Standard: Bracketed Key + Status

**Format:** `[AuthorYear]⏳`

**Examples:**
- `[Bloom2023]⏳` - Single author or first author + year
- `[SmithJones2022]⏳` - Two authors
- `[Brownetal2021]⏳` - Three or more authors

**Status indicators:**
- ⏳ Pending - Auto-inserted by Prompt 14, not yet verified
- ✓ Verified - User confirmed access and accuracy
- ❌ Rejected - User determined source is inaccessible or irrelevant

**In chapter content:**
```markdown
Remote work increased productivity by 13% during 2020-2021 [Bloom2023]⏳.
However, outcomes varied significantly by industry [Allen2021]⏳ and role type
[Grant2022]⏳.
```

**After user verification:**
```markdown
Remote work increased productivity by 13% during 2020-2021 [Bloom2023]✓.
However, outcomes varied significantly by industry [Allen2021]✓ and role type
[Grant2022]⚠.
```

---

## Bibliography Entry Format

### Required Fields

**Mandatory:**
- **Citation Key:** [AuthorYear]
- **Status:** ⏳ | ✓ | ❌
- **Full Citation:** Complete bibliographic information in chosen style
- **Why Suggested:** Explanation of relevance to the claim
- **Relevance Score:** 0-100% (how well source supports claim)
- **Added by:** Prompt 14: Citation_Finder (date)
- **User Action Required:** Verification steps

**Optional but recommended:**
- **DOI:** Digital Object Identifier (if available)
- **URL:** Direct link to source (if accessible online)
- **Access Notes:** Paywall, library access, open access
- **Alternative Sources:** Backup options if primary is inaccessible
- **Related Chapter:** Which chapter(s) use this citation
- **Page/Section:** Specific location within source
- **Notes:** Additional context or caveats

### Example Entry: Pending Citation

```markdown
## Pending Citations (⏳ User Must Verify)

**[Bloom2023]⏳**
- **Full Citation:** Bloom, N., Liang, J., Roberts, J., & Ying, Z. J. (2023).
  Does working from home work? Evidence from a Chinese experiment.
  *American Economic Review*, 113(1), 123-156.
- **Why Suggested:** Directly supports the 13% productivity increase claim
  with empirical data from controlled experiment
- **Relevance Score:** 95%
- **DOI:** 10.1257/aer.20201834
- **URL:** https://www.aeaweb.org/articles?id=10.1257/aer.20201834
- **Access Notes:** Published in peer-reviewed journal, may be behind paywall,
  check institutional access
- **Related Chapter:** Chapter_03.md (line 45)
- **Page/Section:** Abstract and results section (pp. 134-140)
- **Added by:** Prompt 14: Citation_Finder (2025-11-20)

**USER ACTION REQUIRED:**
1. Verify you can access this source (institutional login may be needed)
2. Read abstract and results section to confirm 13% figure is accurate
3. Verify the context matches your claim (Chinese call center experiment)
4. Update status: ⏳ → ✓ (verified) or ❌ (rejected)
5. If rejected, note reason and request alternative suggestions

**Alternative Sources (if primary is inaccessible):**
- Working paper version may be available on Stanford website
- Author Nicholas Bloom has discussed findings in interviews and blog posts
- Meta-analyses on remote work productivity may cite this study
```

### Example Entry: Verified Citation

```markdown
## Verified Citations (✓ Confirmed by User)

**[Bloom2023]✓**
- **Full Citation:** Bloom, N., Liang, J., Roberts, J., & Ying, Z. J. (2023).
  Does working from home work? Evidence from a Chinese experiment.
  *American Economic Review*, 113(1), 123-156.
- **Why Suggested:** Directly supports the 13% productivity increase claim
- **Relevance Score:** 95%
- **DOI:** 10.1257/aer.20201834
- **URL:** https://www.aeaweb.org/articles?id=10.1257/aer.20201834
- **Status:** ✓ Verified (2025-11-21)
- **Verified by:** User confirmed access and accuracy
- **Related Chapter:** Chapter_03.md (line 45)
- **Page/Section:** pp. 134-140
- **Notes:** Accessed via institutional library. Chinese context noted in text.
```

### Example Entry: Rejected Citation

```markdown
## Rejected Citations (❌ Not Used)

**[Bloom2023]❌**
- **Full Citation:** Bloom, N., Liang, J., Roberts, J., & Ying, Z. J. (2023).
  Does working from home work? Evidence from a Chinese experiment.
  *American Economic Review*, 113(1), 123-156.
- **Why Suggested:** Appeared to support 13% productivity claim
- **Relevance Score:** 95%
- **Status:** ❌ Rejected (2025-11-21)
- **Rejection Reason:** Paywall access issue, unable to verify specific figure
- **Alternative Used:** [Grant2022]✓ (open access alternative found)
- **Notes:** May revisit if institutional access becomes available
```

---

## Verification Workflow

### User Verification Process

**Step 1: Open Bibliography File**
```
BackMatter/Bibliography/Chapter_XX_References.md
```

**Step 2: Review Each Pending Citation**
- Click DOI or URL link (if provided)
- Verify you can access the source
- Read the relevant section(s)
- Confirm the source supports your specific claim

**Step 3: Update Status**

**If verified:**
```markdown
**[Bloom2023]✓**
- **Status:** ✓ Verified (2025-11-21)
- **Verified by:** User confirmed access and accuracy
- **Notes:** Accessed via institutional library. Confirms 13% figure.
```

**If rejected:**
```markdown
**[Bloom2023]❌**
- **Status:** ❌ Rejected (2025-11-21)
- **Rejection Reason:** Cannot access due to paywall
- **Alternative Requested:** Yes - need open access alternative
```

**Step 4: Update Chapter Content**

Change in-text citation status:
```markdown
Before: [Bloom2023]⏳
After:  [Bloom2023]✓
```

**Step 5: Commit Changes**

Via Prompt 12 or manual git:
```bash
git add BackMatter/Bibliography/Chapter_03_References.md
git add Chapter_03.md
git commit -m "VERIFY: Confirm citations in Chapter 03

- Verified [Bloom2023]✓, [Allen2021]✓, [Maslow1943]✓
- Rejected [Grant2022]❌ (paywall access issue)
- Updated in-text citation statuses

User verified via institutional library access"
```

---

## Integration with Module 16: Citation_Management_Protocol

This prompt follows the Citation Management Protocol established in:
`Process/_COMMON/16_Citation_Management_Protocol.md`

**Key integrations:**
- Uses standard status codes: ⏳ ⚠ ✓ ❌
- Follows citation entry format requirements
- Adheres to verification progression workflow
- Coordinates with Quote Management (Module 07)
- Integrates with Consistency Checker (Prompt 8)

**See Module 16 for:**
- Detailed citation entry format specifications
- Status code definitions and usage rules
- Bibliography file structure standards
- Citation style formatting guidelines
- Anti-Hallucination compliance protocols

---

## Integration with Prompt 8: Consistency Checker

**Prompt 8 will now report:**
```markdown
## Citation Status

**Chapter 03: Remote Work Productivity**
- Total citations: 8
- ✓ Verified: 5 (62%)
- ⏳ Pending: 2 (25%)
- ❌ Rejected: 1 (13%)
- ⚠ Uncited claims: 3 found

**Recommendations:**
- Verify 2 pending citations in Chapter_03_References.md
- Run Prompt 14 to find citations for 3 uncited claims
- Consider alternative source for 1 rejected citation
```

---

## Integration with Quote Management (Module 07)

**Coordination rules:**
- Quote citations managed in Quotes/Chapter_Quotes.md
- In-text quotes use same status system: ⏳ ⚠ ✓
- Bibliography entries link to quote file
- Prompt 14 skips quote analysis (handled by quote workflow)
- Cross-reference verification prevents duplication

**Example coordination:**
```markdown
## Chapter epigraph quote
**Location:** Quotes/Chapter_Quotes.md
**Status:** ✓ Verified
**Bibliography entry:** [Einstein1931]✓

## In-text reference to same source
**Location:** Chapter_03.md (line 178)
**Citation:** [Einstein1931]✓
**Note:** Bibliography entry already exists, reused from quote verification
```

---

## Important Notes

### What This Prompt Does

✅ **Scans chapters for uncited claims**
✅ **Uses WebSearch to find real sources**
✅ **Verifies sources exist before suggesting**
✅ **Auto-inserts citations with Pending status**
✅ **Creates full bibliography entries**
✅ **Generates citation analysis reports**
✅ **Updates _chg files appropriately**
✅ **Commits changes to git**

### What This Prompt Does NOT Do

❌ **Fabricate citations**
❌ **Guess at sources or attributions**
❌ **Mark citations as Verified (only user can do this)**
❌ **Access paywalled content**
❌ **Verify citation quality (user judgment required)**
❌ **Handle quote citations (use Quote Management workflow)**

### Anti-Hallucination Safeguards

**Built-in protections:**
- WebSearch verification before insertion
- All citations marked ⏳ Pending by default
- User confirmation required for ✓ Verified status
- Relevance scores guide user assessment
- Alternative source suggestions provided
- Flags uncertain attributions with ⚠
- Never guesses DOIs, ISBNs, or URLs
- Cross-checks against Anti-Hallucination Guidelines

### When to Run This Prompt

**Recommended timing:**
- After drafting each chapter
- Before major milestones (25%, 50%, 75%, 100%)
- When Prompt 8 flags uncited claims
- Before submission to editors or reviewers
- During fact-checking phase
- When adding new statistical claims

---

## Process/_COMMON Modules Used

This prompt uses:
- **Module 01:** Prompt Structure Template
- **Module 02:** Desktop Compatibility (CLI-ONLY designation)
- **Module 03:** Anti-Hallucination Protocols (Level 3 - NEVER fabricate)
- **Module 04:** File Operations (update chapters, bibliography, _chg files)
- **Module 05:** Git Integration (commit format and workflow)
- **Module 06:** Validation Protocols (verify sources before insertion)
- **Module 07:** Quote Management System (coordination and cross-reference)
- **Module 08:** Semantic Versioning (version increments for _chg files)
- **Module 09:** Report Templates (citation report formatting)
- **Module 11:** Interactive Patterns (user questions and responses)
- **Module 14:** Enforcement Rules (_chg file update requirements)
- **Module 16:** Citation_Management_Protocol (citation format and workflow)

---

## Git Integration

**Automatic git commit after citation insertion:**

**Commit includes:**
- Modified chapter files (with in-text citations)
- Modified chapter _chg files (citation additions logged)
- Modified/created Bibliography files
- Modified Bibliography _chg files
- Generated citation report (saved to Drafts/)

**Commit message format:**
```
AUTO: Add [N] pending citations to Chapter XX (Prompt 14)

- Added [CitationKey1], [CitationKey2], [CitationKey3]...
- All citations marked ⏳ Pending user verification
- Updated Chapter_XX.md with in-text citations
- Created/updated Bibliography/Chapter_XX_References.md
- Generated citation analysis report
- Flagged [N] claims requiring manual research

User must verify access and accuracy before marking ✓ Verified

Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>
```

---

## Ready to Begin?

**Tell me which chapters you want analyzed for citation opportunities!**

I'll use WebSearch to find real, verifiable sources and auto-insert citations with Pending status, allowing you to confirm access and accuracy before marking them as Verified.

**Remember:**
- All citations marked ⏳ Pending until YOU verify
- WebSearch verification prevents fabrication
- Full citation details provided for your review
- Alternative sources suggested if primary is inaccessible
- Integration with Quote Management prevents duplication

---

## Release Locks

**CRITICAL:** Release locks even if operation fails or errors occur.

**Release all acquired locks:**

1. Read `.locks/locks.json`

2. Remove lock entries:
   - For each chapter: Filter `locks` array to remove where `"resource": "Chapter_XX"` AND `"instance": "[your_instance_id]"`
   - Filter `locks` array to remove where `"resource": "BackMatter"` AND `"instance": "[your_instance_id]"`

3. Write updated JSON to `.locks/locks.json`

**Confirmation:**
```
✓ Locks released: Chapter_03, Chapter_05, BackMatter
```

---

## Lock Management Notes

**Concurrency Support (v0.13.0+):**
- This prompt locks `Chapter_XX` (for each chapter) and `BackMatter` to prevent conflicts
- Locks are held from Step 0 through completion
- Locked chapters can be skipped with user notification
- Locks are released even if citation finding fails
- Stale locks (>15 minutes) can be overridden
- See `Process/_COMMON/18_Lock_Management_Module.md` for complete details

---

**Version:** 0.13.0
**Last Updated:** 2025-11-23

*Created: v0.11.0*
*Purpose: Citation finding and verification workflow*
*Type: Content enhancement - requires user verification*
