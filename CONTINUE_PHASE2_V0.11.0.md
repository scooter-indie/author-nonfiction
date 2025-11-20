# Continue Phase 2: v0.11.0 Development

**Created:** 2025-11-20
**Branch:** v_0.11.0
**Status:** Phase 2 Content Enhancement - Ready to Start
**Prerequisite:** Phase 1 Complete ✅ (tagged as v0.11.0-phase1)

---

## Phase 1 Completion Summary

✅ **All Phase 1 tasks complete** (12 commits, tag: v0.11.0-phase1)
- 13-prompt structure implemented
- All documentation updated
- All cross-references verified
- Prompts 4 and 13 created and documented

---

## Phase 2 Overview

**Goal:** Add Prompts 14 (Visual Content Suggester) and 15 (Citation Finder) to expand framework from 13→15 prompts

**Estimated Time:** 9-11 hours
- Module 15: 1-2 hours
- Module 16: 1-2 hours
- Prompt 14: 4-5 hours (including testing)
- Prompt 15: 5-6 hours (WebSearch integration, Anti-Hallucination compliance)

**Reference Document:** `Proposal/REFACTOR_P3_TODO.md` (lines 790-1040)

---

## What Needs To Be Created

### 1. Module 15: Visual_Asset_Management_Protocol

**File:** `Process/_COMMON/15_Visual_Asset_Management_Protocol.md`

**Based on structure from:** `Process/_COMMON/07_Quote_Management_System.md`

**Content Required:**
- **Status Code System**: 📝 Text-based vs 🖼️ Professional image
- **Figure File Format**: How to structure figures in `Chapter_XX/figures/`
- **Registry Format**: How `figures/README.md` tracks all visuals
- **Metadata Fields**: Type, Status, Location, References, Creation Date, Replacement Priority
- **Directory Structure**: Standard for figure files
- **Naming Conventions**: `fig_XX_YY_description.md` or `.png`
- **Reference Format**: How to link figures in chapter content `[See: figures/fig_03_01.md]`
- **Upgrade Path**: How text-based → professional image replacement works
- **Integration Points**: Used by Prompts 14, 8, and compilation workflows

**Key Sections:**
1. Overview
2. Status Code System
3. Figure File Format
4. Figure Registry Format
5. Required Metadata Fields
6. Directory Structure Standards
7. Naming Conventions
8. Reference Format in Chapters
9. Upgrade Path (Text → Image)
10. Integration with Prompts

**Length:** ~200-300 lines

---

### 2. Module 16: Citation_Management_Protocol

**File:** `Process/_COMMON/16_Citation_Management_Protocol.md`

**Based on structure from:** `Process/_COMMON/07_Quote_Management_System.md`

**Content Required:**
- **Status Code System**: ⏳ Pending | ✓ Verified | ❌ Rejected
- **Citation Entry Format**: How citations are structured in `BackMatter/Bibliography/Chapter_XX_References.md`
- **In-Text Citation Format**: `[Author2023]⏳` with status indicator
- **Metadata Fields**: Full Citation, Relevance Score, DOI, Status, Added By, User Action Required
- **Verification Progression**: ⏳ → ✓ or ❌
- **Anti-Hallucination Integration**: NEVER fabricate citations, WebSearch verification required
- **Bibliography Structure**: Per-chapter reference files
- **Citation Styles**: Support for APA, Chicago, MLA
- **Integration Points**: Used by Prompts 15, 8, and quote management

**Key Sections:**
1. Overview
2. Status Code System
3. Citation Entry Format
4. In-Text Citation Format
5. Required Metadata Fields
6. Verification Progression
7. Anti-Hallucination Compliance
8. Bibliography File Structure
9. Citation Style Support
10. Integration with Prompts
11. Workflow: Search → Insert → Verify

**Length:** ~250-350 lines

---

### 3. Prompt 14: Visual_Content_Suggester

**File:** `Process/Prompts/Prompt_14_Visual_Content_Suggester.md`

**Based on structure from:** `Process/Prompts/Prompt_13_AI_Detection_Analysis.md`

**Full specification:** `Proposal/REFACTOR_P3_TODO.md` lines 794-898

**Workflow Steps:**
1. Ask which chapters to analyze
2. Scan content for visual opportunities (complex concepts, data, processes, comparisons, timelines)
3. Generate suggestions report (placement, type, purpose, complexity)
4. Create visual assets (text-based diagrams/tables using markdown/ASCII)
5. Save to `Chapter_XX/figures/` directory with descriptions
6. Create/update figures registry (`figures/README.md`)
7. Update chapter _chg file with figure additions
8. Commit changes to git

**Key Features:**
- Creates TEXT-BASED diagrams/tables (not images) that can be upgraded later
- Uses markdown tables, ASCII art, mermaid diagrams
- Separate files in `figures/` subdirectory (not inline)
- Inserts references in chapter: `[See: figures/fig_03_01.md]`
- Auto-maintains registry in `figures/README.md`
- Tracks replacement priority (which text-based visuals should be upgraded first)

**Compatibility:** CLI-ONLY (bulk analysis) or HYBRID (single chapter in Desktop)

**Modules Used:**
- Module 01: Prompt Structure Template
- Module 02: Desktop Compatibility
- Module 03: Anti-Hallucination Level 2
- Module 04: File Operations
- Module 05: Git Integration
- Module 06: Validation Protocols
- Module 08: Semantic Versioning
- Module 09: Report Templates
- Module 11: Interactive Patterns
- Module 14: Enforcement Rules
- **Module 15: Visual_Asset_Management_Protocol** (NEW)

**Length:** ~450-550 lines

---

### 4. Prompt 15: Citation_Finder

**File:** `Process/Prompts/Prompt_15_Citation_Finder.md`

**Based on structure from:** `Process/Prompts/Prompt_13_AI_Detection_Analysis.md`

**Full specification:** `Proposal/REFACTOR_P3_TODO.md` lines 901-1017

**Workflow Steps:**
1. Ask which chapters to analyze for citation opportunities
2. Scan for statements needing citations (stats, facts, theories, quotes)
3. Search for valid references using WebSearch tool
4. Auto-insert citations with ⏳ Pending status
5. Add full citation to `BackMatter/Bibliography/Chapter_XX_References.md`
6. Generate citation report with relevance scores
7. Update chapter _chg file and Bibliography _chg file
8. Commit changes to git
9. Prompt user to verify citations via Prompt 4

**CRITICAL Anti-Hallucination Requirements:**
- **NEVER fabricate citations** - only suggest sources found via WebSearch
- Use WebSearch to verify all sources actually exist
- Mark ALL citations as ⏳ Pending until user confirms access
- Flag any uncertain attributions with ⚠ Needs Verification
- Follow verification protocol from Anti-Hallucination_Guidelines.md
- Coordinate with Module 07 (Quote Management) for quote citations

**Compatibility:** CLI-ONLY (requires WebSearch tool, bulk file operations)

**Modules Used:**
- Module 01: Prompt Structure Template
- Module 02: Desktop Compatibility (CLI-ONLY)
- Module 03: Anti-Hallucination Level 3 (NEVER fabricate)
- Module 04: File Operations
- Module 05: Git Integration
- Module 06: Validation Protocols
- Module 07: Quote Management System (similar workflow)
- Module 08: Semantic Versioning
- Module 09: Report Templates
- Module 11: Interactive Patterns
- Module 14: Enforcement Rules
- **Module 16: Citation_Management_Protocol** (NEW)

**Length:** ~500-600 lines

---

### 5. Enhance Prompt 8: Consistency Checker

**File:** `Process/Prompts/Prompt_8_Consistency.md` (existing, needs enhancement)

**Enhancement:** Add visual and citation status reporting sections

**New sections to add:**
1. **Visual Content Status Check**
   - Count visuals per chapter
   - Show 📝 text-based vs 🖼️ professional images
   - Flag chapters with no visuals where complex data is discussed
   - Recommend running Prompt 14 where appropriate

2. **Citation Status Check**
   - Count citations per chapter (✓ verified vs ⏳ pending)
   - Flag uncited statistical claims
   - Show citation completeness percentage
   - Recommend running Prompt 15 where appropriate

**Example output addition:**
```markdown
## Visual Content Status
- Chapter 1: 3 visuals (2 🖼️ images, 1 📝 text-based)
- Chapter 2: ⚠ No visuals found (complex data discussed - consider Prompt 14)
- Chapter 3: 2 visuals (both 📝 text-based - consider upgrading)

## Citation Status
- Chapter 1: 12 citations (5 ✓ verified, 7 ⏳ pending)
- Chapter 2: ⚠ 3 uncited statistical claims found (run Prompt 15)
- Chapter 3: 8 citations (all ✓ verified)

**Recommendations:**
- Run Prompt 14 for Chapter 2 to add visual aids
- Run Prompt 15 for Chapter 2 to find citations
- Verify 7 pending citations in Chapter 1
```

**Location:** Add after existing consistency checks, before final recommendations

---

### 6. Update Documentation

**Files to update (from 13→15 prompts):**
1. CLAUDE.md
   - Update prompt count: 13→15
   - Add directory listings for Prompts 14 and 15
   - Update 13 Core Prompts section → 15 Core Prompts
2. README.md
   - Update prompt count: 13→15
   - Add Prompt 14 and 15 descriptions
3. system-instructions.md
   - Update CLI-ONLY list to include Prompts 14 and 15
   - Update prompt count
4. PREPARE_RELEASE.md
   - Update prompt count references
   - Update CLI-ONLY checklist
5. Process/Prompts/QUICK_REFERENCE.md
   - Add Prompts 14 and 15 to tables
   - Update "At a Glance" table (13→15 rows)
   - Add to workflow sections
6. Process/Prompts/README.md
   - Add Prompt 14 and 15 to directory listing
   - Add descriptions to "Available Prompts" section
7. Process/AI-Assisted_Nonfiction_Authoring_Process.md
   - Add Prompt 14 and 15 documentation
   - Update "13 core prompts" → "15 core prompts"
   - Update integration sections

---

## Workflow for Phase 2

### Step 1: Create Modules (2-4 hours)
1. Create Module 15: Visual_Asset_Management_Protocol
2. Create Module 16: Citation_Management_Protocol
3. Commit both modules

### Step 2: Create Prompts (9-11 hours)
1. Create Prompt 14: Visual_Content_Suggester (4-5 hours)
2. Create Prompt 15: Citation_Finder (5-6 hours)
3. Enhance Prompt 8: Add visual/citation status reporting
4. Commit each prompt separately

### Step 3: Update Documentation (3-4 hours)
1. Update all 7 documentation files listed above
2. Follow same pattern as Phase 1
3. Commit each doc file separately

### Step 4: Testing (2-3 hours)
1. Test Prompt 14 on sample chapter
2. Test Prompt 15 with WebSearch
3. Test Prompt 8 enhancements
4. Verify all cross-references
5. Fix any issues

### Step 5: Completion
1. Tag as v0.11.0-phase2
2. Update CONTINUE document
3. Consider merge to main or additional testing

---

## Testing Checklist

**Prompt 14 (Visual Content Suggester):**
- [ ] Correctly identifies visual opportunities
- [ ] Creates valid markdown/ASCII diagrams
- [ ] Saves to correct `figures/` directory
- [ ] Updates `figures/README.md` registry
- [ ] Inserts correct references in chapter
- [ ] Updates _chg file appropriately
- [ ] Git commit works correctly

**Prompt 15 (Citation Finder):**
- [ ] Identifies uncited claims correctly
- [ ] Uses WebSearch to find real sources
- [ ] NEVER fabricates citations
- [ ] Inserts citations with ⏳ Pending status
- [ ] Creates correct Bibliography entries
- [ ] Updates _chg files appropriately
- [ ] Git commit works correctly
- [ ] Anti-Hallucination compliance verified

**Prompt 8 Enhancements:**
- [ ] Reports visual status accurately
- [ ] Reports citation status accurately
- [ ] Recommendations are appropriate
- [ ] Doesn't break existing functionality

---

## Success Criteria

**Functionality:**
- ✅ Prompt 14 creates text-based visuals correctly
- ✅ Prompt 15 finds and inserts citations safely
- ✅ Prompt 8 reports on visual/citation status
- ✅ All prompts commit to git properly
- ✅ All integrations work smoothly

**Documentation:**
- ✅ All files updated for 15-prompt structure
- ✅ All cross-references correct
- ✅ Compatibility tables accurate

**Quality:**
- ✅ Anti-Hallucination compliance (especially Prompt 15)
- ✅ No fabricated citations
- ✅ WebSearch integration working
- ✅ Clear user instructions

---

## Decision Point

After Phase 2 completion, you'll have a **15-prompt framework** with:
- Visual content suggestion and management
- Citation finding and verification
- Enhanced consistency checking

**Options:**
1. **Merge to main** as v0.11.0 (recommended)
2. **Additional testing period** before release
3. **Continue to Phase 3** (if there are more features planned)

---

## Quick Start Command

When resuming Phase 2:

```bash
cd E:\Projects\author-nonfiction
git checkout v_0.11.0
git log --oneline -5  # Verify Phase 1 complete
```

Then say: "Continue Phase 2: Create Module 15"

---

**Status:** Ready to begin Phase 2
**Estimated completion:** 14-18 hours total
**Next task:** Create Module 15: Visual_Asset_Management_Protocol

---

*Phase 1 complete, Phase 2 ready to start*
