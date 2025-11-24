# Execute Prompt 11: Style Manager

**Version:** 0.13.0
**HYBRID:** Works in both Claude Desktop and Claude Code CLI with mixed interaction.

Desktop MCP copies large files for processing which can break down with many chapter files. For validation and scanning operations that read multiple files, CLI is more reliable.

**FIRST ACTION - MANDATORY:**
Reference `Process/Prompts/Prompt_Essentials.md` (loaded once per session via /fw-init)

**Quick references available in Prompt_Essentials:**
- Lock Management (acquire/release protocol)
- Anti-Hallucination Rules (ASK FIRST verification)
- Git Commit Format (CLI and Desktop templates)
- Style Resolution (hierarchical system)
- Date Handling (CONFIRMED_DATE protocol)
- Semantic Versioning
- Change Tracking Format

**Load full modules only if encountering edge cases:**
- Lock Management: Process/_COMMON/18_Lock_Management_Module.md
- Anti-Hallucination: Process/Anti-Hallucination_Guidelines.md

**CRITICAL ENFORCEMENT:**
- **RULE 1:** All file modifications MUST update corresponding _chg files
- **RULE 2:** All Manuscript/ changes must go through appropriate prompts

See: `Process/ENFORCEMENT_RULES.md` for complete details

**Claude Desktop Compatibility:**
- ✅ Single-file operations work well in Desktop (add/remove chapter override)
- ✅ View operations work in Desktop (style distribution display)
- ⚠️ Multi-file operations better in CLI (scan section overrides, validate registry)
- 📋 Works 60% in Desktop (hybrid - use CLI for scanning/validation)

**NOTE:** This manages style overrides only. No _chg updates required (registry is auto-maintained).

---

## What This Does

I will help you manage the hierarchical style system for your book, including:
- Adding or removing chapter-level style overrides
- Scanning and tracking section-level overrides
- Validating override registry consistency
- Viewing style distribution across your book
- Analyzing style transitions for smoothness
- Changing book-level style with impact analysis

---

## Hierarchical Style System Overview

Your book uses a three-level cascading style system:

```
Book Style (Global Default in Style_Guide.md)
  ↓ inherits
Chapter Style (Optional - Chapter_XX_style.md in chapter directory)
  ↓ inherits
Section Style (Optional - HTML comments in content)
```

**Book-Level Style:**
- Defined in `Manuscript/Style/Style_Guide.md`
- Applies to all content unless overridden
- Selected during Prompt 1 (Initialize)

**Chapter-Level Overrides:**
- Optional `Chapter_XX_style.md` files in chapter directories
- Override book-level style for entire chapter
- Created via Prompt 2 (Add Chapter) or this prompt

**Section-Level Overrides:**
- Inline HTML comment markers in content files
- Override chapter or book style for specific sections
- Added manually or via Prompt 3 (Modify File)

**Registry:**
- `Manuscript/Style/Style_Overrides.md` tracks all overrides
- Auto-updated by this prompt and Prompts 2, 3
- Shows distribution, transitions, threshold warnings

---

## Step 0: Lock Management

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

**Acquire Lock: StyleSystem**

Resources needed for this prompt: `StyleSystem`

1. Read `.locks/locks.json`

2. Check if `StyleSystem` is locked:
   - Search `locks` array for entry where `"resource": "StyleSystem"`

3. **If lock exists:**
   - Calculate age: `current_time - lock.timestamp`

   - **If age < 15 minutes:**
     ```
     ⚠️ StyleSystem is currently locked by another instance.

     Lock details:
     - Resource: StyleSystem
     - Locked at: [timestamp] ([X] minutes ago)
     - Instance: [instance]

     Another style operation may be in progress.

     Options:
     1. Wait for lock to clear (checks every 5 seconds)
     2. Cancel operation

     Choose option (1-2):
     ```

   - **If age >= 15 minutes:**
     ```
     ⚠️ StyleSystem has a stale lock (older than 15 minutes).

     Lock details:
     - Resource: StyleSystem
     - Locked at: [timestamp] ([X] minutes ago)
     - Instance: [instance]

     This lock may be from a crashed instance.

     Options:
     1. Override stale lock and continue
     2. Cancel operation

     Choose option (1-2):
     ```

4. **If user chooses to wait (Option 1):**
   - Poll every 5 seconds
   - Re-check `.locks/locks.json`
   - If lock cleared: Proceed to acquire
   - If timeout (2 minutes): Ask to cancel or override

5. **If user cancels:**
   - Exit prompt without changes

6. **If no lock OR override approved:**
   - Add lock entry:
     ```json
     {
       "resource": "StyleSystem",
       "timestamp": "[ISO-8601-timestamp]",
       "instance": "[instance_id]"
     }
     ```
   - Write updated JSON to `.locks/locks.json`
   - Proceed with style management operations

---

## Operations Available

### 1. Add Chapter Override
Add a style override to an existing chapter.

### 2. Remove Chapter Override
Remove a style override, chapter reverts to book-level style.

### 3. Scan Section Overrides
Scan all chapter files for section override markers and update registry.

### 4. Validate Override Registry
Check consistency between registry and actual files, fix discrepancies.

### 5. View Style Distribution
Show style usage across book with percentages and threshold status.

### 6. Analyze Transitions
Detect and assess chapter/section transitions, check for documented strategies.

### 7. Change Book-Level Style
Change the book-level style with impact analysis on existing chapters.

---

## How This Works

### Operation 1: Add Chapter Override

**I'll ask:**
1. Which chapter needs a style override?
2. Which style should override the book-level style?
   - Framework style (from Process/Styles/Style_Catalog.md - 19 styles across 5 categories)
   - Custom style (from Manuscript/Style/Custom_Styles.md)
   - Create new custom style
3. What's the rationale for this override?
4. Any transition strategy notes?

**Then I'll:**
1. Validate chapter exists
2. Check if override already exists (offer to update if yes)
3. Load selected style configuration
4. Create `Chapter_XX_style.md` from template in chapter directory
5. Populate with style characteristics and rationale
6. Update `Manuscript/Style/Style_Overrides.md` registry
7. Recalculate override percentage
8. Check if exceeds 30% threshold (warn if yes)
9. Analyze new transitions created
10. Create git commit
11. Report impact

**Example Report:**
```
✅ Chapter override added successfully

Chapter: Chapter_05
New Style: Technical Precision
Previous Style: Conversational Expert (book-level)

Files Created:
- Manuscript/Chapters/Chapter_05/Chapter_05_style.md

Files Updated:
- Manuscript/Style/Style_Overrides.md

Override Analysis:
- Total Chapters: 10
- Chapters with Overrides: 3 (30%)
- Threshold: 30% ✓ At threshold

New Transitions:
⚠️ Chapter 04 → 05: Conversational Expert → Technical Precision
  Severity: Medium
  Recommendation: Add transition strategy in Style_Overrides.md

⚠️ Chapter 05 → 06: Technical Precision → Conversational Expert
  Severity: Medium
  Recommendation: Add bridging content at chapter boundary

Next Steps:
1. Document transition strategies in Style_Overrides.md
2. Consider adding transition paragraphs in affected chapters
3. Run Prompt 6 (Consistency) to validate style application
```

---

### Operation 2: Remove Chapter Override

**I'll ask:**
1. Which chapter override should I remove?
   - Show list of chapters with current overrides

**Then I'll:**
1. Validate chapter has override
2. Confirm removal (show what will happen)
3. Delete `Chapter_XX_style.md` file
4. Update `Manuscript/Style/Style_Overrides.md` registry
5. Recalculate override percentage
6. Check which transitions are eliminated
7. Create git commit
8. Report impact

**Example Report:**
```
✅ Chapter override removed successfully

Chapter: Chapter_07
Style Removed: Narrative Storyteller
Reverted To: Conversational Expert (book-level)

Files Deleted:
- Manuscript/Chapters/Chapter_07/Chapter_07_style.md

Files Updated:
- Manuscript/Style/Style_Overrides.md

Override Analysis:
- Total Chapters: 10
- Chapters with Overrides: 1 (10%)
- Threshold: 30% ✓ Well below threshold

Transitions Eliminated:
✓ Chapter 06 → 07: Was Conversational → Narrative, now consistent
✓ Chapter 07 → 08: Was Narrative → Conversational, now consistent

Chapter 07 now uses: Conversational Expert (book-level)

Next Steps:
1. Run Prompt 3 to modify Chapter 07 if content needs adjustment
2. Run Prompt 6 to verify style consistency
```

---

### Operation 3: Scan Section Overrides

**I'll ask:**
1. Scan all chapters or specific chapters?
2. If specific: Which chapters?

**Then I'll:**
1. Read specified chapter content files
2. Scan for section override markers:
   ```markdown
   <!-- STYLE_OVERRIDE: StyleName -->
   ...content...
   <!-- END_STYLE_OVERRIDE -->
   ```
3. Validate markers:
   - Check for matching closing tags
   - Verify style names exist
   - Check for nesting (not allowed)
4. Record locations (file:line range)
5. Update `Manuscript/Style/Style_Overrides.md` with findings
6. Report issues and suggestions

**Example Report:**
```
📋 Section Override Scan Complete

Scanned: 10 chapters

Section Overrides Found: 5

Chapter_02:
✓ Lines 145-230: Technical Precision
  - Purpose: Database schema example
  - Valid: Properly closed, style exists

Chapter_05:
✓ Lines 89-156: Narrative Storyteller
  - Purpose: User story anecdote
  - Valid: Properly closed, style exists

✓ Lines 420-485: Conversational Expert
  - Purpose: Interview excerpt
  - Valid: Properly closed, style exists

Chapter_08:
❌ Lines 200-[EOF]: Business Professional
  - ERROR: Unclosed override marker
  - Action Required: Add <!-- END_STYLE_OVERRIDE --> before chapter end

Chapter_09:
⚠️ Lines 100-180: TechnicalPrecision
  - WARNING: Style name has typo (should be "Technical Precision")
  - Action Required: Fix style name in marker

Files Updated:
- Manuscript/Style/Style_Overrides.md (valid overrides added)

Issues Requiring Attention:
1. Chapter_08:200 - Unclosed marker
2. Chapter_09:100 - Invalid style name

Next Steps:
1. Fix issues in Chapter_08 and Chapter_09
2. Run scan again to verify fixes
3. Run Prompt 6 to analyze section style consistency
```

---

### Operation 4: Validate Override Registry

**I'll ask:**
1. Auto-fix issues or report only?

**Then I'll:**
1. Load `Manuscript/Style/Style_Overrides.md`
2. Check all listed chapter overrides:
   - Verify Chapter_XX_style.md files exist
   - Verify files are in correct directories
3. Scan for orphaned chapter style files:
   - Find Chapter_XX_style.md files not in registry
4. Validate all referenced styles exist:
   - Check against Style_Guide.md, Custom_Styles.md, and Process/Styles/ catalog (19 framework styles)
5. Validate section override markers (if enabled):
   - Check for unclosed markers
   - Check for undefined styles
   - Check for nesting
6. If auto-fix enabled:
   - Add orphaned files to registry
   - Remove missing files from registry
7. Generate validation report

**Example Report:**
```
🔍 Override Registry Validation Complete

Registry File: Manuscript/Style/Style_Overrides.md

Chapter-Level Overrides: 3 listed

✅ Chapter_03: Technical Precision
  - File exists: Chapter_03_style.md ✓
  - Style exists: Process/Styles/Academic/Technical_Precision.md ✓

✅ Chapter_07: Narrative Storyteller
  - File exists: Chapter_07_style.md ✓
  - Style exists: Process/Styles/Narrative/Narrative_Storyteller.md ✓

❌ Chapter_09: Business Authority
  - File missing: Chapter_09_style.md NOT FOUND
  - Registry entry without file
  - Action: Remove from registry or create file

⚠️ Orphaned Files Found: 1

Chapter_12_style.md exists but NOT in registry
  - File: Manuscript/Chapters/Chapter_12/Chapter_12_style.md
  - Style: Practical Guide
  - Action: Add to registry or delete file

Section Override Validation:

❌ Chapter_05:145 - Unclosed marker (Technical Precision)
⚠️ Chapter_08:200 - Unknown style "CustomStyle" (not in Style_Guide.md or Custom_Styles.md)

Auto-Fix Actions Taken:
1. ✅ Added Chapter_12 to registry (Practical Guide override)
2. ✅ Removed Chapter_09 from registry (file not found)

Manual Actions Required:
1. Fix unclosed marker in Chapter_05:145
2. Add "CustomStyle" to Custom_Styles.md or change marker to valid style

Updated Files:
- Manuscript/Style/Style_Overrides.md

Next Steps:
1. Address manual actions
2. Run validation again to verify all clean
```

---

### Operation 5: View Style Distribution

**I'll ask:**
1. Summary view or detailed view?

**Then I'll:**
1. Load Style_Overrides.md registry
2. Calculate distribution:
   - Total chapters
   - Chapters with overrides (count and percentage)
   - Chapters using book-level style
   - Section overrides across all chapters
3. Show style usage table
4. Show override percentage vs. threshold (30%)
5. Display style transition map
6. Provide recommendations

**Example Report (Detailed):**
```
📊 Style Distribution Report

Book: [Title]
Book-Level Style: Conversational Expert
Total Chapters: 10

Chapter-Level Distribution:

| Chapter | Active Style | Source | Notes |
|---------|-------------|--------|-------|
| 01 | Conversational Expert | Book | - |
| 02 | Conversational Expert | Book | + 1 section override |
| 03 | Technical Precision | Chapter Override | Full chapter |
| 04 | Conversational Expert | Book | - |
| 05 | Conversational Expert | Book | + 2 section overrides |
| 06 | Conversational Expert | Book | - |
| 07 | Narrative Storyteller | Chapter Override | Full chapter |
| 08 | Conversational Expert | Book | - |
| 09 | Conversational Expert | Book | - |
| 10 | Conversational Expert | Book | - |

Override Analysis:

Chapter Overrides: 2 of 10 (20%)
✅ Below 30% threshold

Section Overrides: 3 sections across 2 chapters

Style Usage Summary:

| Style | Chapters | Sections | Total Usage |
|-------|----------|----------|-------------|
| Conversational Expert | 8 (book-level) | 1 (section) | 80% + 1 section |
| Technical Precision | 1 (chapter) | 1 (section) | 10% + 1 section |
| Narrative Storyteller | 1 (chapter) | 1 (section) | 10% + 1 section |

Style Transition Map:

```
Ch 01: [Book: Conversational Expert]
Ch 02: [Book: Conversational Expert] → (Section: Technical) → [Book]
Ch 03: [CHAPTER OVERRIDE: Technical Precision] ← Transition point
Ch 04: [Book: Conversational Expert] ← Transition point
Ch 05: [Book: Conversational Expert] → (Section: Narrative) → (Section: Conversational) → [Book]
Ch 06: [Book: Conversational Expert]
Ch 07: [CHAPTER OVERRIDE: Narrative Storyteller] ← Transition point
Ch 08: [Book: Conversational Expert] ← Transition point
Ch 09: [Book: Conversational Expert]
Ch 10: [Book: Conversational Expert]
```

Transition Points: 4 chapter-level, 6 section-level

Recommendations:
✅ Override usage is healthy (20%)
⚠️ 4 chapter transitions may need documented strategies
✓ Style consistency looks good overall

Next Steps:
1. Document transition strategies for Ch 02→03, 03→04, 06→07, 07→08
2. Run Prompt 6 to analyze style consistency within each section
```

---

### Operation 6: Analyze Transitions

**I'll ask:**
1. Analyze chapter-level transitions, section-level, or both?

**Then I'll:**
1. Load style configuration for all chapters/sections
2. Detect transitions:
   - Chapter-to-chapter: Different styles between adjacent chapters
   - Section-to-section: Style changes within chapters
3. Assign severity levels:
   - Low: Related styles, short sections, documented strategies
   - Medium: Significantly different styles, undocumented
   - High: Opposing styles, frequent transitions
4. Check Style_Overrides.md for documented transition strategies
5. Generate recommendations for each transition
6. Provide actionable suggestions

**Example Report:**
```
🔀 Style Transition Analysis

Chapter-Level Transitions: 4

⚠️ MEDIUM: Chapter 02 → Chapter 03
From: Conversational Expert (book-level)
To: Technical Precision (chapter override)

Severity: Medium
- Significantly different formality levels
- No documented transition strategy

Recommendations:
1. Add transition paragraph at end of Chapter 02:
   "Now that we've covered the conceptual framework, let's examine the technical implementation details..."

2. Open Chapter 03 with acknowledgment:
   "This chapter dives deep into the technical aspects. We'll use precise terminology and detailed examples..."

3. Document strategy in Style_Overrides.md

---

✅ LOW: Chapter 03 → Chapter 04
From: Technical Precision (chapter override)
To: Conversational Expert (book-level)

Severity: Low
- Documented transition strategy exists ✓
- Strategy: "Chapter 03 ends with summary that bridges back to conceptual discussion"

Current Strategy Working: Yes

---

⚠️ HIGH: Chapter 06 → Chapter 07
From: Conversational Expert (book-level)
To: Narrative Storyteller (chapter override)

Severity: High
- Major tone shift (analytical → personal narrative)
- No documented transition strategy
- Voice change (second-person → first-person)

Recommendations:
1. Add transition at end of Chapter 06:
   "Let me share a personal experience that illustrates these principles in action..."

2. Open Chapter 07 with context:
   "In this chapter, I'll take you through my journey implementing these ideas..."

3. Add closing transition at end of Chapter 07:
   "Now that you've seen this narrative example, let's return to the analytical framework..."

4. Document all three transition points in Style_Overrides.md

---

Section-Level Transitions: 6 (across 2 chapters)

Chapter 02: 2 transitions
⚠️ Line 145: Conversational → Technical (section override begins)
  Severity: Medium
  Recommendation: Add bridging sentence before <!-- STYLE_OVERRIDE -->

✅ Line 230: Technical → Conversational (section override ends)
  Severity: Low
  Recommendation: Already has summary sentence

[Additional section transitions...]

---

Summary:

Total Transitions: 10 (4 chapter, 6 section)
High Severity: 1 (requires immediate attention)
Medium Severity: 5 (should address)
Low Severity: 4 (monitored, acceptable)

Undocumented Transitions: 3
- Chapter 02 → 03
- Chapter 06 → 07
- Chapter 07 → 08

Next Steps:
1. Address high-severity transition (Chapter 06→07)
2. Document strategies for 3 undocumented transitions
3. Add recommended bridging content
4. Run Prompt 6 to verify smoothness after changes
```

---

### Operation 7: Change Book-Level Style

**I'll ask:**
1. What new book-level style should I use?
   - Framework style
   - Custom style
   - Create new custom style
2. Should I analyze impact before changing?

**Then I'll:**
1. Show current book-level style
2. Analyze impact:
   - How many chapters currently inherit book-level style
   - Which chapters have overrides (won't be affected)
   - How this changes transitions
3. Ask for confirmation
4. Update `Manuscript/Style/Style_Guide.md`
5. Update `Manuscript/Style/Style_Overrides.md` registry
6. Recalculate distribution
7. Update transition analysis
8. Create git commit
9. Report complete impact

**Example Report:**
```
📝 Book-Level Style Change Impact Analysis

Current Book-Level Style: Conversational Expert
Proposed New Style: Academic Authority

Impact Analysis:

Chapters Affected: 8 (will change to Academic Authority)
- Chapter 01, 02, 04, 05, 06, 08, 09, 10

Chapters NOT Affected: 2 (have chapter overrides)
- Chapter 03: Technical Precision (override remains)
- Chapter 07: Narrative Storyteller (override remains)

Section Overrides: 3 (will inherit new book-level style as base)
- Chapter 02, Section 145-230: Technical Precision (section override)
- Chapter 05, Section 89-156: Narrative Storyteller (section override)
- Chapter 05, Section 420-485: Conversational Expert (section override becomes redundant)

Transition Changes:

New Transitions Created: 2
- Chapter 02 → 03: Academic Authority → Technical Precision
- Chapter 06 → 07: Academic Authority → Narrative Storyteller

Eliminated Transitions: 4
- Chapters 01-02, 04-05, 05-06, 08-09-10 now consistent (Academic Authority)

Style Characteristics Changing:

From Conversational Expert:
- Voice: Second person ("you")
- Tone: Conversational, accessible
- Formality: Moderate
- Examples: Frequent, relatable

To Academic Authority:
- Voice: Third person / First person plural ("we")
- Tone: Scholarly, authoritative
- Formality: High
- Examples: Research-based, citations

Recommendations:

⚠️ This is a major change affecting 80% of your book
⚠️ Consider: Is Academic Authority the right choice, or should some current content become chapter overrides?

Alternative Approach:
- Keep Conversational Expert as book-level
- Add Academic Authority overrides to specific chapters needing scholarly tone

Proceed with change? (Yes/No/Reconsider)

If Yes:
1. Update Style_Guide.md with Academic Authority
2. Update Style_Overrides.md registry
3. Recommend running Prompt 3 on affected chapters to adjust content
4. Recommend running Prompt 6 to validate consistency

If No:
- No changes made, current configuration preserved

If Reconsider:
- I can help you identify which chapters might benefit from Academic Authority as overrides instead
```

---

## Important Notes

- **Registry is auto-maintained**: Don't edit Style_Overrides.md manually, use this prompt
- **Chapter style files**: Created from template, can be customized after creation
- **Section markers**: Use exact syntax `<!-- STYLE_OVERRIDE: StyleName -->` and `<!-- END_STYLE_OVERRIDE -->`
- **30% threshold**: Guideline to ensure book-level style is appropriate
- **Transitions matter**: Smooth transitions improve reader experience

---

## Git Commit Format (For Claude Desktop Users)

When providing the git commit command at the end, format it like this:

**For Claude Desktop users, provide:**

Go to Claude Code CLI and say:
```
Run: git add Manuscript/Style/ Manuscript/Chapters/Chapter_XX/ && git commit -m '[Operation]: [Description]

[Detailed changes]

🤖 Generated with Claude Desktop

Co-Authored-By: Claude <noreply@anthropic.com>'
```

**The instruction "Go to Claude Code CLI and say:" must be OUTSIDE the code block.**

---

## Release Locks

**CRITICAL:** Release locks even if operation fails or errors occur.

**Release acquired lock:**

1. Read `.locks/locks.json`

2. Remove lock entry:
   - Filter `locks` array to remove where `"resource": "StyleSystem"` AND `"instance": "[your_instance_id]"`

3. Write updated JSON to `.locks/locks.json`

**Confirmation:**
```
✓ Lock released: StyleSystem
```

---

## Lock Management Notes

**Concurrency Support (v0.13.0+):**
- This prompt locks `StyleSystem` to prevent conflicting style changes
- Lock is held from Step 0 through completion
- Lock is released even if operation fails
- Stale locks (>15 minutes) can be overridden
- See `Process/_COMMON/18_Lock_Management_Module.md` for complete details

---

## Ready to Begin?

**Which style management operation would you like to perform?**

1. Add Chapter Override
2. Remove Chapter Override
3. Scan Section Overrides
4. Validate Override Registry
5. View Style Distribution
6. Analyze Transitions
7. Change Book-Level Style

---

**Version:** 0.13.0
**Last Updated:** 2025-11-23

*Reference: Process/_COMMON/10_Style_Consistency_Protocol.md*
*Templates: Process/Templates/Chapter_Style_Template.md, Style_Overrides_Template.md*

---

## Session Cleanup

**After this prompt completes:**

Tell user: "✓ Prompt 11 Style Manager complete.

To free up tokens for your next task, you can say:
**'Clear Prompt 11 Style Manager from context'**

This will reclaim tokens for your next operation."
