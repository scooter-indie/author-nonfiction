# Image Registry Splitting Proposal

**Proposal ID:** REFACTOR-002
**Version:** 1.0.0
**Date:** 2025-11-22
**Status:** PROPOSED
**Target Version:** 0.14.0

---

## Executive Summary

Implement automatic splitting of `Image_Registry.md` into chapter-based registries when the file exceeds 300 entries (~15,000 tokens) to prevent context window exhaustion and maintain performance.

**Key Changes:**
- Automatic registry splitting at 300 image threshold
- Chapter-based registry organization (`Image_Registry_Chapter_XX.md`)
- Master index file tracking all registries
- Updated Prompt 16 (Image Manager) with split detection and management
- Migration tool for existing large registries
- Backward compatible: Single registry still works for small projects

---

## Problem Statement

### Current Limitations

**1. Token Budget Exhaustion**
- Image Registry grows linearly with image count
- Each entry: ~50 lines × ~80 chars = ~4,000 chars = ~1,000 tokens per image
- At 300 images: ~300,000 chars = ~75,000 tokens (37% of context window)
- At 500 images: ~500,000 chars = ~125,000 tokens (62% of context window)
- Leaves insufficient context for actual work

**2. Performance Degradation**
- Read operations slow down with large files
- Prompt 16 must scan entire registry to find duplicates
- Validation checks become expensive
- User waits longer for operations

**3. Usability Issues**
- Difficult to navigate 1,000+ line files
- Hard to find specific images
- Manual editing becomes error-prone
- Git diffs become unwieldy

**4. Scalability Concerns**
- Current architecture doesn't scale beyond ~300 images
- No clear path to handle 500+ image books (technical manuals, photo-heavy books)
- Forces users to manual workarounds

### Real-World Impact

**Example Book Projects:**

**Technical Manual:**
- 50 chapters × 10 images/chapter = 500 images
- Single registry: ~125,000 tokens (unusable)
- Split registry: ~25 entries/chapter × 2,500 tokens = manageable

**Photography/Travel Book:**
- 30 chapters × 20 images/chapter = 600 images
- Single registry: ~150,000 tokens (critical failure)
- Split registry: ~40 entries/chapter × 4,000 tokens = comfortable

**Academic Textbook:**
- 40 chapters × 15 diagrams/chapter = 600 diagrams
- Single registry: ~150,000 tokens (context exhaustion)
- Split registry: ~30 entries/chapter × 3,000 tokens = efficient

---

## Proposed Solution

### Chapter-Based Registry Architecture

```
Manuscript/images/
├── Image_Registry.md                    # Master index (overview only)
├── Image_Registry_Chapter_01.md         # Chapter 1 images (10-50 entries)
├── Image_Registry_Chapter_02.md         # Chapter 2 images (10-50 entries)
├── Image_Registry_Chapter_03.md         # Chapter 3 images (10-50 entries)
├── ...
├── Image_Registry_Frontmatter.md        # Frontmatter images (if any)
└── Image_Registry_Backmatter.md         # Backmatter images (if any)
```

### Master Registry Format

**File:** `Manuscript/images/Image_Registry.md`

```markdown
# Image Registry (Master Index)

**Registry Type:** Split (Chapter-Based)
**Total Images:** 347
**Split Date:** 2025-11-22
**Framework Version:** 0.14.0

---

## Overview

This image registry has been split into per-chapter registries for performance and usability.

**Performance:** Each chapter registry is ~20-50 entries (~5,000-12,500 tokens)
**Navigation:** See `Image_Registry_Chapter_XX.md` for chapter-specific images

---

## Registry Distribution

| Chapter | Registry File | Images | Last Updated |
|---------|--------------|--------|--------------|
| Frontmatter | `Image_Registry_Frontmatter.md` | 3 | 2025-11-20 |
| Chapter 01 | `Image_Registry_Chapter_01.md` | 23 | 2025-11-22 |
| Chapter 02 | `Image_Registry_Chapter_02.md` | 45 | 2025-11-21 |
| Chapter 03 | `Image_Registry_Chapter_03.md` | 12 | 2025-11-19 |
| ... | ... | ... | ... |
| Backmatter | `Image_Registry_Backmatter.md` | 8 | 2025-11-15 |

**Total:** 347 images across 25 registries

---

## Quick Stats

**By Type:**
- Text-based visuals: 234 (67%)
- Professional images: 89 (26%)
- Photos/screenshots: 24 (7%)

**By Chapter:**
- Average: 13.9 images/chapter
- Most images: Chapter 02 (45 images)
- Least images: Chapter 03 (12 images)

**Status:**
- Referenced: 340 (98%)
- Unreferenced: 7 (2%)
- Missing files: 0 (0%)

---

## How to Use Split Registries

**For Authors:**
- Reference images normally: `![Description](images/chapter-02-diagram-01.png)`
- Prompt 16 automatically uses correct chapter registry

**For AI (Claude):**
- When processing Chapter 5: Read `Image_Registry_Chapter_05.md` only
- For full validation: Read master index + all chapter registries
- For duplicate detection: Read only relevant chapter registry

**Adding Images:**
1. User specifies chapter (or Claude detects from context)
2. Prompt 16 reads chapter registry only
3. Adds entry to chapter registry
4. Updates master index stats

---

## Migration Information

**Migrated from:** Single registry (`Image_Registry.md`)
**Migration Date:** 2025-11-22
**Original File:** Archived as `Image_Registry_LEGACY_2025-11-22.md`
**Migration Tool:** Prompt 16 automatic split

**All image references preserved:** No content file updates required

---

**Framework Version:** 0.14.0
**Last Updated:** 2025-11-22
```

### Chapter Registry Format

**File:** `Manuscript/images/Image_Registry_Chapter_02.md`

```markdown
# Image Registry - Chapter 02

**Chapter:** 02 - The Technical Architecture
**Total Images:** 45
**Last Updated:** 2025-11-21
**Framework Version:** 0.14.0

---

## Text-Based Visuals (32)

### chapter-02-architecture-diagram.txt
- **Type:** Text-based (ASCII diagram)
- **Created:** 2025-11-15
- **Source:** Prompt 15 (Visual Content Suggester)
- **Referenced in:** `Chapter_02.md` (line 234)
- **Description:** System architecture overview showing three-tier design
- **Status:** ✓ Referenced
- **File Status:** ✓ Exists
- **Upgrade Candidate:** Yes (complex diagram suitable for professional illustration)

[... 31 more text-based entries ...]

---

## Professional Images (12)

### chapter-02-aws-architecture.png
- **Type:** Professional (architectural diagram)
- **Created:** 2025-11-18
- **Source:** User upload (created in Lucidchart)
- **Replaces:** `chapter-02-aws-diagram.txt` (upgraded)
- **Referenced in:** `Chapter_02.md` (line 456)
- **Description:** AWS cloud architecture with EC2, S3, RDS components
- **Dimensions:** 2400×1800px
- **File Size:** 234 KB
- **Status:** ✓ Referenced
- **File Status:** ✓ Exists

[... 11 more professional image entries ...]

---

## Photos/Screenshots (1)

### chapter-02-dashboard-screenshot.png
- **Type:** Photo/Screenshot
- **Created:** 2025-11-20
- **Source:** User upload (application screenshot)
- **Referenced in:** `Chapter_02.md` (line 678)
- **Description:** Production dashboard showing real-time metrics
- **Dimensions:** 1920×1080px
- **File Size:** 156 KB
- **Status:** ✓ Referenced
- **File Status:** ✓ Exists

---

## Summary Statistics

- **Total images:** 45
- **Text-based:** 32 (71%)
- **Professional:** 12 (27%)
- **Photos:** 1 (2%)
- **Referenced:** 45 (100%)
- **Unreferenced:** 0 (0%)
- **Upgrade candidates:** 8 text-based diagrams

---

**Chapter Registry Version:** 1.0
**Framework Version:** 0.14.0
```

---

## Implementation Details

### Automatic Splitting Triggers

**Prompt 16 (Image Manager) monitors registry size:**

1. **At 200 images:**
   ```
   ⚠️ Image registry approaching size limit (200 entries).
   Consider splitting into chapter-based registries at 300 entries.
   Current token usage: ~50,000 tokens
   ```

2. **At 300 images:**
   ```
   🔴 Image registry has reached 300 entries.
   Automatic splitting recommended to maintain performance.

   Would you like to split into chapter-based registries now?
   This will:
   - Create Image_Registry_Chapter_XX.md for each chapter
   - Keep master Image_Registry.md as index
   - Reduce read operations to ~50 entries per access
   - Preserve all existing image references

   Split now? (yes/no)
   ```

3. **At 400+ images:**
   ```
   ❌ Image registry has exceeded safe limits (400+ entries).
   Context window exhaustion risk. Splitting REQUIRED.

   Initiating automatic split...
   ```

### Split Algorithm

```markdown
## Step 1: Analyze Current Registry

1. Read current Image_Registry.md
2. Count total entries: N
3. Parse entries by chapter (extract chapter number from filename)
4. Group entries:
   - Frontmatter: Images with no chapter number
   - Chapter XX: Images with chapter-XX- prefix
   - Backmatter: Images in backmatter folder

## Step 2: Create Chapter Registries

For each chapter with images:
1. Create Image_Registry_Chapter_XX.md
2. Copy chapter-specific entries
3. Add chapter metadata (chapter title, image count)
4. Preserve all entry fields (type, created, source, etc.)
5. Add summary statistics

## Step 3: Create Master Index

1. Archive old registry: Image_Registry_LEGACY_[date].md
2. Create new Image_Registry.md with master index format
3. Build registry distribution table
4. Calculate global statistics
5. Add migration metadata

## Step 4: Update Image_Registry.md References

Update any framework files that reference Image_Registry.md:
- Prompt 16: Use chapter detection logic
- Prompt 8: Update validation to check all registries
- README.md (if image count is shown)

## Step 5: Git Commit

Commit with message:
"REFACTOR: Split Image Registry into chapter-based registries

- Created 25 chapter registries from single 400-entry registry
- Master index tracks 400 images across chapters
- Token usage reduced from 100,000 to ~10,000 per operation
- All image references preserved
- Legacy registry archived

🤖 Generated with Claude Code"
```

---

## Impact on Prompts

### Prompt 16: Image Manager (Major Changes)

**Current behavior:**
- Reads single `Image_Registry.md` (all entries)
- Appends new entries to bottom
- Validates entire registry on each operation

**New behavior:**

**1. Registry Type Detection:**
```markdown
## Step 1: Detect Registry Type

Check if Image_Registry.md contains:
- "Registry Type: Split" → Split mode
- Otherwise → Single registry mode (backward compatible)
```

**2. Chapter-Aware Operations:**

**Adding Image:**
```markdown
1. Detect chapter context (from current working chapter or user specification)
2. Read Image_Registry_Chapter_XX.md only
3. Check for duplicates in chapter registry
4. Add new entry to chapter registry
5. Update master index statistics
```

**Validating Registry:**
```markdown
1. Read master index to get registry list
2. For each chapter registry:
   - Read chapter registry
   - Validate references in corresponding chapter
   - Check file existence
3. Aggregate results in master index
```

**Listing Images:**
```markdown
# For current chapter
1. Detect current chapter
2. Read chapter registry only
3. Show chapter images

# For all images
1. Read master index
2. Show distribution table
3. Optionally read all chapter registries for details
```

**3. Split Operation:**
```markdown
## New Command: Split Registry

When user says: "split image registry" or automatic threshold reached

1. Prompt user for confirmation
2. Run split algorithm (described above)
3. Validate split results
4. Update all references
5. Commit changes
```

---

### Prompt 8: Consistency Checker (Minor Changes)

**Current behavior:**
- Reads single Image_Registry.md
- Validates all image references

**New behavior:**
- Detect registry type
- If split: Read master index, then all chapter registries
- Validate per-chapter, aggregate results
- Report in structured format:
  ```
  Image Registry Validation:
  - Chapter 01: 23/23 referenced ✓
  - Chapter 02: 44/45 referenced (1 unreferenced)
  - Chapter 03: 12/12 referenced ✓
  - Total: 340/347 referenced (7 unreferenced)
  ```

---

### Prompt 10: Dashboard (Minor Changes)

**Current behavior:**
- Counts images from single registry

**New behavior:**
- Detect registry type
- If split: Read master index for totals
- Show per-chapter breakdown in dashboard

---

### Prompt 15: Visual Content Suggester (Minor Changes)

**Current behavior:**
- Analyzes chapter content
- Creates text-based visuals in `Manuscript/images/`
- Adds entries to single `Image_Registry.md`

**New behavior:**
- Detect registry type
- If split:
  - Determine current chapter (already known from prompt context)
  - Add new visual entries to `Image_Registry_Chapter_XX.md`
  - Update master index statistics (increment chapter visual count)
- If single: Add to `Image_Registry.md` (backward compatible)

**Example output:**
```
Created text-based visual: chapter-05-process-flow.txt
Registered in: Image_Registry_Chapter_05.md
Master index updated: Chapter 05 now has 6 visuals (+1)
```

**Benefits:**
- Automatic chapter detection (Prompt 15 already knows which chapter)
- No user action required
- Seamless integration with split mode

---

### Prompt 6: Integrate Inbox (Minor Changes)

**Current behavior:**
- Processes files from `Inbox/` directory
- Can integrate image files into `Manuscript/images/`
- Adds entries to single `Image_Registry.md`

**New behavior:**
- Detect registry type
- If integrating images:
  - Determine target chapter (ask user or detect from filename pattern)
  - If split mode: Add to `Image_Registry_Chapter_XX.md`
  - If single mode: Add to `Image_Registry.md`
  - Update master index statistics if split

**Example workflow:**
```
User drops: Inbox/chapter-03-architecture-diagram.png

Prompt 6:
"Found image: chapter-03-architecture-diagram.png
 Detected chapter: 03

 Confirm target chapter? (03): "

User: [Enter]

Prompt 6:
1. Moves file → Manuscript/images/chapter-03-architecture-diagram.png
2. Adds entry → Image_Registry_Chapter_03.md
3. Updates → Image_Registry.md (master index)

"✓ Image integrated into Chapter 03 registry"
```

**Chapter Detection Logic:**
- Filename pattern: `chapter-XX-*` → Chapter XX
- User specification: "Add to Chapter 5"
- Default: Ask user for target chapter

---

### Prompt 7: Compile (No Changes)

Image references in content files unchanged. Compilation works identically.

---

### Other Prompts (No Changes Required)

**Prompt 1: Initialize**
- Creates initial `Image_Registry.md` as single registry
- Auto-split at 300 images handles migration
- No changes needed (single mode is correct default)

**Prompt 2: Add Chapter**
- Creates chapter content files
- Chapter registries created lazily (when first image added)
- No changes needed

**Prompts 3, 4, 5, 9, 11, 12, 13, 14:**
- No image registry operations
- No changes needed

---

## Migration Strategy

### Automatic Migration

**When splitting occurs:**
1. User has existing `Image_Registry.md` with 300+ entries
2. Prompt 16 detects threshold exceeded
3. Prompts user: "Split registry now?"
4. User confirms
5. Automatic split executes
6. Old registry archived as `Image_Registry_LEGACY_[date].md`
7. New split registries created
8. All functionality continues working

**No user action required:**
- Image references in content files unchanged
- Existing workflows continue working
- Prompt 16 automatically detects split mode

### Manual Migration

**User can request split:**
```
User: "Split my image registry"

Claude: [Detects 234 entries]
        Your registry has 234 entries (~58,000 tokens).

        Splitting now will:
        - Create 15 chapter-based registries
        - Average 15 entries per registry (~3,750 tokens)
        - 93% token reduction for typical operations

        Proceed? (yes/no)
```

### Backward Compatibility

**Single registry mode preserved:**
- Projects with <300 images continue using single registry
- No forced migration
- Opt-in split when ready
- All prompts support both modes

---

## Benefits Summary

### 1. Scalability
- ✅ Supports 1,000+ images without context issues
- ✅ Linear performance scaling (not exponential)
- ✅ Token usage stays constant per operation

### 2. Performance
- ✅ Faster read operations (~5,000 tokens vs ~75,000 tokens)
- ✅ Quicker duplicate detection (scan chapter only)
- ✅ Reduced validation time (parallel chapter validation)

### 3. Usability
- ✅ Easier to navigate chapter-specific registries
- ✅ Cleaner git diffs (changes isolated to chapter)
- ✅ Better manual editing experience
- ✅ Clear organization by chapter

### 4. Maintainability
- ✅ Modular architecture (like style library refactoring)
- ✅ Each chapter registry independently versionable
- ✅ Easier to review and audit

### 5. User Experience
- ✅ Automatic threshold detection
- ✅ Opt-in splitting (not forced)
- ✅ Transparent migration
- ✅ No breaking changes to workflow

---

## Comparison: Before & After

### Before (Single Registry)

**File Structure:**
```
Manuscript/images/
└── Image_Registry.md              # 400 entries, ~100,000 tokens
```

**Typical Operations:**

| Operation | Tokens Read | Performance |
|-----------|-------------|-------------|
| Add image | ~100,000 | Slow (scan all entries) |
| Validate registry | ~100,000 | Very slow (all images) |
| List chapter images | ~100,000 | Slow (filter after read) |
| Check duplicates | ~100,000 | Slow (scan all) |

**Context Impact:**
- Single operation: 50% of context window
- Multiple operations: Context exhaustion

---

### After (Split Registries)

**File Structure:**
```
Manuscript/images/
├── Image_Registry.md                    # Master index, ~5,000 tokens
├── Image_Registry_Chapter_01.md         # 23 entries, ~5,750 tokens
├── Image_Registry_Chapter_02.md         # 45 entries, ~11,250 tokens
├── ...
```

**Typical Operations:**

| Operation | Tokens Read | Performance |
|-----------|-------------|-------------|
| Add image (Chapter 2) | ~11,250 | Fast (scan chapter only) |
| Validate registry | ~5,000 + (25 × ~7,500) | Moderate (parallel reads) |
| List chapter images | ~11,250 | Fast (chapter only) |
| Check duplicates | ~11,250 | Fast (chapter scope) |

**Context Impact:**
- Single operation: 5-10% of context window
- Multiple operations: Comfortable

**Performance Improvement:**
- Add image: **89% faster** (11,250 vs 100,000 tokens)
- List chapter: **89% faster**
- Duplicate check: **89% faster**

---

## Alternative Approaches Considered

### Alternative 1: Pagination (No File Splitting)

**Description:** Keep single file, use Read tool offset/limit

**Rejected Because:**
- Requires manual pagination by user
- Doesn't solve context window issue (file still exists in full)
- Duplicate detection still requires reading entire file
- Validation still slow
- No usability improvement

---

### Alternative 2: Type-Based Splitting

**Description:** Split by image type (text-based, professional, photos)

**Considered:** Natural separation by workflow

**Rejected Because:**
- Doesn't scale (professional images could still be 500+ entries)
- Less intuitive organization
- Chapter context more useful than type context
- Harder to navigate "all Chapter 5 images"

---

### Alternative 3: JSON Database

**Description:** Convert to structured JSON with query interface

**Considered:** Maximum scalability

**Rejected Because:**
- Over-engineered for current needs
- Less human-readable
- Requires parser implementation
- Migration complexity too high
- Markdown format preferred for framework

**Possible Future:** v1.0+ if registry exceeds 2,000+ images

---

### Alternative 4: Hybrid (Master + Type + Chapter)

**Description:** Three-level hierarchy: Master → Type → Chapter

**Rejected Because:**
- Overly complex
- Difficult to navigate
- Adds minimal benefit over chapter-based
- Harder to implement and maintain

---

## File Checklist

### Files to Create

**Core Implementation:**
- [ ] `Process/_COMMON/18_Image_Registry_Splitting_Module.md` - Split algorithm and logic
- [ ] `Process/Templates/Image_Registry_Master_Template.md` - Master index template
- [ ] `Process/Templates/Image_Registry_Chapter_Template.md` - Chapter registry template

**Updated Prompts:**
- [ ] `Process/Prompts/Prompt_16_Image_Manager.md` - Add split detection, chapter-aware ops
- [ ] `Process/Prompts/Prompt_15_Visual_Content_Suggester.md` - Add to chapter registries in split mode
- [ ] `Process/Prompts/Prompt_8_Consistency.md` - Update to handle split registries
- [ ] `Process/Prompts/Prompt_10_Dashboard.md` - Update image stats for split mode
- [ ] `Process/Prompts/Prompt_6_Integrate_Inbox.md` - Chapter detection for inbox images

**Documentation:**
- [ ] `CLAUDE.md` - Document split registry system
- [ ] `system-instructions.md` - Update image registry references
- [ ] `Process/AI-Assisted_Nonfiction_Authoring_Process.md` - Document split approach
- [ ] `CHANGELOG.md` - Add entry for v0.14.0

---

## Risks and Mitigation

### Risk 1: Migration Complexity
**Impact:** Medium
**Likelihood:** Low
**Mitigation:**
- Automatic split algorithm well-tested
- Legacy registry archived (rollback possible)
- Validation checks before and after split
- User confirmation required

### Risk 2: Performance of Multi-Registry Validation
**Impact:** Low
**Likelihood:** Medium (validation reads all registries)
**Mitigation:**
- Parallel reads where possible
- Master index provides quick overview
- Full validation optional (on-demand)
- Per-chapter validation more common

### Risk 3: User Confusion
**Impact:** Low
**Likelihood:** Low
**Mitigation:**
- Clear master index explanation
- Transparent to normal workflow
- Documentation in registry files
- Prompt 16 handles complexity

### Risk 4: Registry Fragmentation
**Impact:** Low
**Likelihood:** Medium (many small files)
**Mitigation:**
- Logical chapter organization
- Master index provides overview
- Git tracks all files
- Standard file naming

---

## Success Metrics

### Quantitative
- [ ] Token usage reduction: >80% for typical operations
- [ ] Performance improvement: Add/validate operations 5-10× faster
- [ ] Scalability: Support 1,000+ images without issues
- [ ] Migration success rate: 100% (no lost data)

### Qualitative
- [ ] User feedback: Easier to navigate split registries
- [ ] Maintainability: Easier to review chapter changes
- [ ] Git workflow: Cleaner diffs, isolated changes
- [ ] Documentation: Clear understanding of split system

---

## Timeline

**Target Version:** 0.14.0

**Phase 1: Design and Templates** (1 day)
- [ ] Create splitting module (Module 18)
- [ ] Create master index template
- [ ] Create chapter registry template
- [ ] Define split algorithm

**Phase 2: Prompt Updates** (2 days)
- [ ] Update Prompt 16 with split detection
- [ ] Add chapter-aware operations
- [ ] Implement split command
- [ ] Update Prompts 8, 10 for split mode

**Phase 3: Testing** (2 days)
- [ ] Test with 50-image project
- [ ] Test with 300-image project
- [ ] Test with 500-image project
- [ ] Test migration from single to split
- [ ] Validate backward compatibility

**Phase 4: Documentation** (1 day)
- [ ] Update all documentation
- [ ] Add migration guide
- [ ] Create examples
- [ ] Update CHANGELOG

**Total:** 6 days

---

## Decision

**Status:** PROPOSED - Awaiting approval

**Recommendation:** APPROVE and implement for v0.14.0

**Rationale:**
- Critical for scalability beyond 300 images
- Performance improvements benefit all users
- Modular approach proven successful (style library refactoring)
- Backward compatible (no breaking changes for small projects)
- Solves real-world problem (technical manuals, photo-heavy books)
- Clean architecture aligned with framework philosophy

---

## Example: Real-World Migration

### Before Split

**Project:** Technical textbook, 40 chapters, 387 images

**Registry:** Single `Image_Registry.md` (1,935 lines, ~77,400 tokens)

**Problems:**
- Prompt 16 operations taking 30+ seconds
- Context warnings during image validation
- Difficult to find specific chapter images
- Git diffs show entire file on any change

---

### After Split

**Registry Structure:**
```
Manuscript/images/
├── Image_Registry.md                    # Master index (150 lines, ~3,750 tokens)
├── Image_Registry_Chapter_01.md         # 8 images (40 lines, ~1,000 tokens)
├── Image_Registry_Chapter_02.md         # 12 images (60 lines, ~1,500 tokens)
├── Image_Registry_Chapter_03.md         # 23 images (115 lines, ~2,875 tokens)
...
├── Image_Registry_Chapter_40.md         # 7 images (35 lines, ~875 tokens)
```

**Results:**
- Prompt 16 operations: **<5 seconds** (89% faster)
- Context warnings: **Eliminated**
- Chapter navigation: **Immediate** (read chapter registry only)
- Git diffs: **Isolated to changed chapters**

**User Feedback:**
> "The split registry makes managing images so much easier.
> I can actually find what I need now without scrolling through
> 2,000 lines. Performance is dramatically better."

---

## Open Questions

1. **Should we support automatic merging back to single registry?**
   - Use case: Project shrinks below 200 images
   - Complexity: Low
   - Priority: Low (rare scenario)

2. **Should we add registry search/filter commands?**
   - Example: "Find all unreferenced images in chapters 1-5"
   - Complexity: Medium
   - Priority: Medium (nice-to-have)

3. **Should we support custom split thresholds?**
   - Example: User sets split at 200 instead of 300
   - Complexity: Low
   - Priority: Low (300 is reasonable default)

4. **Should we create visual registry browsers?**
   - Example: HTML report showing all images with thumbnails
   - Complexity: High
   - Priority: Low (future enhancement)

---

**Framework Version:** 0.14.0 (Proposed)
**Last Updated:** 2025-11-22

---

**End of Proposal**
