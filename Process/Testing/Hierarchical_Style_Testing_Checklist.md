# Hierarchical Style System Testing Checklist

**Framework Version:** 0.10.1
**Testing Phase:** Manual Validation
**Purpose:** Verify hierarchical style system works correctly across all prompts and scenarios

---

## Testing Overview

This checklist covers all major scenarios for the hierarchical style system (book → chapter → section overrides with cascading inheritance).

**Test Status Legend:**
- ⏳ Not Started
- 🔄 In Progress
- ✓ Passed
- ❌ Failed
- ⚠ Partial/Needs Review

---

## Test Category 1: Initialization (Prompt 1)

### Test 1.1: Style_Overrides.md Creation
**Status:** ⏳

**Steps:**
1. Execute Prompt 1 (Initialize) on new book project
2. Select a book-level style during initialization
3. Verify `Manuscript/Style/Style_Overrides.md` is created
4. Verify it contains book-level style information
5. Verify registry sections are present (chapter overrides, section overrides, distribution)

**Expected Result:**
- Style_Overrides.md exists with complete template structure
- Book-level style matches selection from initialization
- All registry sections initialized (empty but present)

**Actual Result:**
[Record results here]

**Notes:**
[Any observations or issues]

---

### Test 1.2: Style Selection Process
**Status:** ⏳

**Steps:**
1. Execute Prompt 1 (Initialize)
2. Test each style selection option:
   - Option A: Choose framework style
   - Option B: Customize framework style
   - Option C: Mix multiple styles
   - Option D: Define custom style
   - Option E: Skip (default)
3. Verify Style_Guide.md created correctly for each option
4. Verify Style_Overrides.md references correct book-level style

**Expected Result:**
- All 5 options work correctly
- Style_Guide.md reflects chosen style
- Style_Overrides.md registry shows correct book-level style

**Actual Result:**
[Record results here]

**Notes:**
[Any observations or issues]

---

## Test Category 2: Chapter-Level Overrides (Prompts 2, 11)

### Test 2.1: Add Chapter with Style Override
**Status:** ⏳

**Steps:**
1. Execute Prompt 2 (Add New Chapter)
2. When asked about chapter-level style override, choose "Yes"
3. Select override style different from book-level
4. Verify `Chapter_XX_style.md` created in chapter directory
5. Verify Style_Overrides.md updated with new entry

**Expected Result:**
- Chapter_XX_style.md created with correct template
- Contains selected style configuration
- Style_Overrides.md lists chapter override in registry
- Distribution percentages updated

**Actual Result:**
[Record results here]

**Notes:**
[Any observations or issues]

---

### Test 2.2: Add Chapter without Style Override
**Status:** ⏳

**Steps:**
1. Execute Prompt 2 (Add New Chapter)
2. When asked about chapter-level style override, choose "No"
3. Verify NO Chapter_XX_style.md file created
4. Verify Style_Overrides.md shows chapter using book-level style

**Expected Result:**
- No chapter style file created
- Style_Overrides.md correctly shows chapter inherits book style
- Distribution analysis accurate

**Actual Result:**
[Record results here]

**Notes:**
[Any observations or issues]

---

### Test 2.3: Add Chapter Override via Prompt 11
**Status:** ⏳

**Steps:**
1. Have existing chapter without override
2. Execute Prompt 11 (Style Manager) → Add Chapter Override
3. Select chapter and new style
4. Verify Chapter_XX_style.md created
5. Verify Style_Overrides.md updated

**Expected Result:**
- Chapter style file created retroactively
- Registry updated correctly
- Distribution percentages recalculated

**Actual Result:**
[Record results here]

**Notes:**
[Any observations or issues]

---

### Test 2.4: Remove Chapter Override via Prompt 11
**Status:** ⏳

**Steps:**
1. Have chapter with existing override
2. Execute Prompt 11 (Style Manager) → Remove Chapter Override
3. Verify Chapter_XX_style.md deleted
4. Verify Style_Overrides.md updated
5. Verify chapter now inherits book-level style

**Expected Result:**
- Chapter style file removed
- Registry updated, chapter moved to "no override" list
- Distribution percentages recalculated

**Actual Result:**
[Record results here]

**Notes:**
[Any observations or issues]

---

## Test Category 3: Section-Level Overrides (Prompts 3, 11)

### Test 3.1: Add Section Override in Content
**Status:** ⏳

**Steps:**
1. Edit chapter content file manually
2. Add section override markers:
   ```markdown
   <!-- STYLE_OVERRIDE: Technical Precision -->
   Section content here...
   <!-- END_STYLE_OVERRIDE -->
   ```
3. Execute Prompt 11 → Scan Section Overrides
4. Verify Style_Overrides.md updated with section entry

**Expected Result:**
- Section override detected by scan
- Registry shows section with location (file:line)
- Distribution analysis includes section override

**Actual Result:**
[Record results here]

**Notes:**
[Any observations or issues]

---

### Test 3.2: Section Override Detection by Prompt 3
**Status:** ⏳

**Steps:**
1. Have chapter with section override markers
2. Execute Prompt 3 (Modify File) on that chapter
3. Add modification instructions in _chg file
4. Verify Prompt 3 detects section overrides
5. Verify Prompt 3 applies correct style to each section

**Expected Result:**
- Prompt 3 reports: "Detected section-level style overrides"
- Modifications respect override boundaries
- Overridden sections use specified style
- Non-overridden sections use inherited style

**Actual Result:**
[Record results here]

**Notes:**
[Any observations or issues]

---

### Test 3.3: Nested Section Overrides (Error Case)
**Status:** ⏳

**Steps:**
1. Attempt to create nested section overrides:
   ```markdown
   <!-- STYLE_OVERRIDE: Style1 -->
   Outer content
   <!-- STYLE_OVERRIDE: Style2 -->
   Inner content
   <!-- END_STYLE_OVERRIDE -->
   More outer content
   <!-- END_STYLE_OVERRIDE -->
   ```
2. Run Prompt 11 → Scan Section Overrides

**Expected Result:**
- Warning issued: "Nested section overrides not supported"
- Inner override markers flagged as error
- Suggestions to flatten structure

**Actual Result:**
[Record results here]

**Notes:**
[Any observations or issues]

---

### Test 3.4: Unclosed Section Override (Error Case)
**Status:** ⏳

**Steps:**
1. Add section override without closing tag:
   ```markdown
   <!-- STYLE_OVERRIDE: Technical Precision -->
   Section content here...
   [No END_STYLE_OVERRIDE tag]
   ```
2. Run Prompt 11 → Validate Override Registry

**Expected Result:**
- Error issued: "Unclosed section override marker at [location]"
- Specific line number provided
- Suggestion to add closing tag

**Actual Result:**
[Record results here]

**Notes:**
[Any observations or issues]

---

## Test Category 4: Cascading Inheritance

### Test 4.1: Book → Chapter Inheritance
**Status:** ⏳

**Steps:**
1. Book-level style: Conversational Expert
2. Chapter without override
3. Execute Prompt 3 on chapter, request style analysis
4. Verify chapter uses Conversational Expert style

**Expected Result:**
- Prompt 3 reports: "Using book-level style (Conversational Expert)"
- Content modifications follow Conversational Expert guidelines

**Actual Result:**
[Record results here]

**Notes:**
[Any observations or issues]

---

### Test 4.2: Book → Chapter Override → Section Inheritance
**Status:** ⏳

**Steps:**
1. Book-level style: Conversational Expert
2. Chapter override: Technical Precision
3. Section without override in that chapter
4. Execute Prompt 3, request style analysis

**Expected Result:**
- Prompt 3 reports: "Using chapter-level override (Technical Precision)"
- Section inherits from chapter, not book
- Content follows Technical Precision guidelines

**Actual Result:**
[Record results here]

**Notes:**
[Any observations or issues]

---

### Test 4.3: Book → Chapter → Section Override Chain
**Status:** ⏳

**Steps:**
1. Book-level style: Conversational Expert
2. Chapter override: Technical Precision
3. Section override: Narrative Storyteller
4. Execute Prompt 3, request style analysis

**Expected Result:**
- Prompt 3 reports: "Using section-level override (Narrative Storyteller)"
- Section uses Narrative style
- Surrounding content uses Technical Precision (chapter override)
- Other chapters use Conversational Expert (book level)

**Actual Result:**
[Record results here]

**Notes:**
[Any observations or issues]

---

## Test Category 5: Style Transitions (Prompt 6, 11)

### Test 5.1: Chapter-to-Chapter Transition Detection
**Status:** ⏳

**Steps:**
1. Create two adjacent chapters with different styles:
   - Chapter_05: Conversational Expert (book-level)
   - Chapter_06: Technical Precision (chapter override)
2. Execute Prompt 6 (Consistency) with style transition check
3. Verify transition warning issued

**Expected Result:**
- Warning: "Style transition detected between Chapter_05 and Chapter_06"
- Styles listed: Conversational Expert → Technical Precision
- Suggestion to add transition strategy in Style_Overrides.md

**Actual Result:**
[Record results here]

**Notes:**
[Any observations or issues]

---

### Test 5.2: Section-Level Transition Within Chapter
**Status:** ⏳

**Steps:**
1. Chapter with multiple section overrides:
   - Section A: Book style (Conversational)
   - Section B: Technical Precision override
   - Section C: Back to book style
2. Execute Prompt 6 with style transition check

**Expected Result:**
- Warnings for both transitions (A→B and B→C)
- Line numbers provided for transition points
- Suggestion to smooth transitions with bridging sentences

**Actual Result:**
[Record results here]

**Notes:**
[Any observations or issues]

---

### Test 5.3: 30% Override Threshold Warning
**Status:** ⏳

**Steps:**
1. Create book with 10 chapters
2. Add chapter overrides to 4 chapters (40%)
3. Execute Prompt 8 (Dashboard) or Prompt 11 (Validate)

**Expected Result:**
- Warning: "Override usage (40%) exceeds recommended 30% threshold"
- Suggestion: "Consider whether book-level style is appropriate"
- Distribution table shows percentages

**Actual Result:**
[Record results here]

**Notes:**
[Any observations or issues]

---

## Test Category 6: Prompt Integration

### Test 6.1: Prompt 3 Style Application
**Status:** ⏳

**Steps:**
1. Chapter with book-level style
2. Add modification instructions in _chg file
3. Execute Prompt 3
4. Verify modifications use correct style

**Expected Result:**
- Prompt 3 detects inherited book style
- Reports: "Applying [Style Name] style"
- Generated/modified content follows style guidelines
- Style characteristics visible in output

**Actual Result:**
[Record results here]

**Notes:**
[Any observations or issues]

---

### Test 6.2: Prompt 6 Style Consistency Check
**Status:** ⏳

**Steps:**
1. Book with mixed styles (book + overrides)
2. Execute Prompt 6 → Select "Style consistency analysis"
3. Review consistency report

**Expected Result:**
- Report shows style usage per chapter/section
- Identifies deviations from declared styles
- Flags transitions requiring attention
- Provides specific examples of style violations

**Actual Result:**
[Record results here]

**Notes:**
[Any observations or issues]

---

### Test 6.3: Prompt 8 Style Distribution Display
**Status:** ⏳

**Steps:**
1. Book with various overrides
2. Execute Prompt 8 (Dashboard) → Detailed mode

**Expected Result:**
- Dashboard includes "Style Distribution" section
- Shows book-level style
- Lists all chapter overrides
- Shows override percentage with threshold status
- Provides style transition map

**Actual Result:**
[Record results here]

**Notes:**
[Any observations or issues]

---

### Test 6.4: Prompt 11 Full Workflow
**Status:** ⏳

**Steps:**
1. Execute Prompt 11 (Style Manager)
2. Test each operation:
   - Add chapter override
   - Remove chapter override
   - Scan section overrides
   - Validate override registry
   - View style distribution
   - Analyze transitions
3. Verify each operation works correctly

**Expected Result:**
- All 6 operations complete successfully
- Style_Overrides.md updated correctly
- Chapter style files created/removed as appropriate
- Validation catches errors
- Reports are accurate and helpful

**Actual Result:**
[Record results here]

**Notes:**
[Any observations or issues]

---

## Test Category 7: Edge Cases

### Test 7.1: Undefined Style Reference
**Status:** ⏳

**Steps:**
1. Manually edit Chapter_XX_style.md
2. Reference non-existent style: "Fake Style Name"
3. Execute Prompt 11 → Validate Override Registry

**Expected Result:**
- Error: "Style 'Fake Style Name' not found in Style_Guide.md or Custom_Styles.md"
- Location provided (Chapter_XX_style.md)
- Suggestion to check style name or create custom style

**Actual Result:**
[Record results here]

**Notes:**
[Any observations or issues]

---

### Test 7.2: Missing Chapter Style File
**Status:** ⏳

**Steps:**
1. Add chapter override entry to Style_Overrides.md
2. Delete corresponding Chapter_XX_style.md file
3. Execute Prompt 11 → Validate Override Registry

**Expected Result:**
- Error: "Chapter_XX_style.md listed in registry but file not found"
- Offer to:
  - Remove registry entry (chapter reverts to book style)
  - Recreate file from template

**Actual Result:**
[Record results here]

**Notes:**
[Any observations or issues]

---

### Test 7.3: Orphaned Chapter Style File
**Status:** ⏳

**Steps:**
1. Create Chapter_XX_style.md in chapter directory
2. Do NOT add entry to Style_Overrides.md
3. Execute Prompt 11 → Validate Override Registry

**Expected Result:**
- Warning: "Chapter_XX_style.md exists but not registered in Style_Overrides.md"
- Offer to:
  - Add to registry
  - Delete orphaned file

**Actual Result:**
[Record results here]

**Notes:**
[Any observations or issues]

---

### Test 7.4: Style Change Impact Analysis
**Status:** ⏳

**Steps:**
1. Book with 5 chapters using book-level style
2. Execute Prompt 11 → Change book-level style
3. Select new style
4. Review impact analysis

**Expected Result:**
- Shows which chapters will be affected (those without overrides)
- Lists chapters that will NOT change (have overrides)
- Asks for confirmation before applying
- Updates Style_Guide.md and Style_Overrides.md

**Actual Result:**
[Record results here]

**Notes:**
[Any observations or issues]

---

## Test Category 8: Documentation & Help

### Test 8.1: Template Accessibility
**Status:** ⏳

**Steps:**
1. Verify templates exist:
   - Process/Templates/Chapter_Style_Template.md
   - Process/Templates/Style_Overrides_Template.md
2. Verify templates are complete and usable

**Expected Result:**
- Both templates present
- All sections filled with guidance
- Examples provided
- Clear instructions for usage

**Actual Result:**
[Record results here]

**Notes:**
[Any observations or issues]

---

### Test 8.2: Documentation Completeness
**Status:** ⏳

**Steps:**
1. Check hierarchical style system documented in:
   - CLAUDE.md (overview)
   - QUICK_REFERENCE.md (workflows)
   - Process/AI-Assisted_Nonfiction_Authoring_Process.md (detailed)
   - Process/Prompts/README.md (Prompt 11 description)
2. Verify documentation is accurate and complete

**Expected Result:**
- All files mention hierarchical style system
- Workflows clearly explained
- Examples provided
- Cross-references between documents

**Actual Result:**
[Record results here]

**Notes:**
[Any observations or issues]

---

## Test Summary

### Test Statistics

**Total Tests:** [Count when complete]
**Passed:** [Count]
**Failed:** [Count]
**Partial/Needs Review:** [Count]
**Not Started:** [Count]

**Pass Rate:** [Percentage]

---

### Critical Issues Found

[List any critical issues that must be fixed before release]

1.
2.
3.

---

### Minor Issues Found

[List non-critical issues that should be addressed]

1.
2.
3.

---

### Recommendations

[Based on testing, what recommendations for improvements or changes?]

1.
2.
3.

---

### Sign-Off

**Tester:** [Your name]
**Date Completed:** [Date]
**Framework Version Tested:** 0.10.1
**Status:** ⏳ Testing In Progress / ✓ Testing Complete / ⚠ Needs Revision

**Notes:**
[Any final observations or context]

---

**Next Steps:**
- [ ] Address critical issues
- [ ] Address minor issues
- [ ] Retest failed scenarios
- [ ] Update documentation based on findings
- [ ] Prepare for release

---

*This testing checklist ensures the hierarchical style system works correctly across all use cases before releasing v0.10.1.*
