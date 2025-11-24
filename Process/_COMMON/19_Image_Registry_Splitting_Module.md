# Image Registry Splitting Module

**Framework Version:** 0.14.0
**Module:** 19 - Image Registry Splitting
**Purpose:** Automatic splitting of Image Registry into chapter-based registries when threshold exceeded

---

## Overview

This module provides automatic registry splitting capability when the unified `Image_Registry.md` exceeds 300 entries (~75,000 tokens). Splitting distributes images into per-chapter registries while maintaining a master index for overview and coordination.

**Key Benefits:**
- 89% token reduction for typical operations (read chapter registry only)
- Scalability to 1,000+ images without context exhaustion
- Cleaner git diffs (changes isolated to chapter)
- Better navigation and manual editing experience
- Backward compatible (single registry still supported)

---

## Registry Types

### Single Registry Mode (Default)

**Used when:** Total images < 300
**Structure:**
```
Manuscript/images/
└── Image_Registry.md              # All entries in single file
```

**Detection:** Registry does NOT contain "Registry Type: Split"

### Split Registry Mode

**Used when:** Total images >= 300 (or manually triggered)
**Structure:**
```
Manuscript/images/
├── Image_Registry.md                    # Master index only
├── Image_Registry_Chapter_01.md         # Chapter 1 images
├── Image_Registry_Chapter_02.md         # Chapter 2 images
├── Image_Registry_Chapter_03.md         # Chapter 3 images
├── ...
├── Image_Registry_Frontmatter.md        # Frontmatter images (if any)
└── Image_Registry_Backmatter.md         # Backmatter images (if any)
```

**Detection:** Master index contains "Registry Type: Split"

---

## Threshold Monitoring

### Warning Levels

**At 200 images:**
```
⚠️ Image registry approaching size limit (200 entries).
Consider splitting into chapter-based registries at 300 entries.
Current token usage: ~50,000 tokens
```

**At 300 images:**
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

**At 400+ images:**
```
❌ Image registry has exceeded safe limits (400+ entries).
Context window exhaustion risk. Splitting REQUIRED.

Initiating automatic split...
```

### Entry Counting

Count entries by searching for `### fig-` pattern in Image_Registry.md:
```bash
grep -c "^### fig-" Manuscript/images/Image_Registry.md
```

Or count by header (includes cover, author-photo, etc.):
```bash
grep -c "^### " Manuscript/images/Image_Registry.md
```

---

## Split Algorithm

### Step 1: Analyze Current Registry

1. Read current `Image_Registry.md`
2. Count total entries
3. Parse entries by chapter (extract chapter number from filename)
4. Group entries:
   - **Frontmatter:** Images with no chapter number (cover, author-photo)
   - **Chapter XX:** Images with `fig-XX-` prefix
   - **Backmatter:** Images in backmatter folder or with backmatter prefix

### Step 2: Create Chapter Registries

For each chapter with images:

1. Create `Image_Registry_Chapter_XX.md` using chapter registry template
2. Copy chapter-specific entries preserving all metadata fields
3. Add chapter metadata:
   - Chapter number and title
   - Image count
   - Last updated date
4. Add summary statistics section
5. For Frontmatter/Backmatter, create similarly named files

### Step 3: Create Master Index

1. Archive old registry: `Image_Registry_LEGACY_[date].md`
2. Create new `Image_Registry.md` with master index format
3. Build registry distribution table:
   ```markdown
   | Chapter | Registry File | Images | Last Updated |
   |---------|--------------|--------|--------------|
   | Frontmatter | `Image_Registry_Frontmatter.md` | 3 | 2025-11-20 |
   | Chapter 01 | `Image_Registry_Chapter_01.md` | 23 | 2025-11-22 |
   | ... | ... | ... | ... |
   ```
4. Calculate global statistics (totals, percentages, type breakdown)
5. Add migration metadata

### Step 4: Validate Split Results

1. Verify all entries accounted for:
   - Sum of chapter registries = original total
   - No duplicate entries
   - No missing entries
2. Verify all files exist for each entry
3. Verify chapter references match entry locations

### Step 5: Git Commit

```bash
git add Manuscript/images/Image_Registry.md
git add Manuscript/images/Image_Registry_Chapter_*.md
git add Manuscript/images/Image_Registry_Frontmatter.md  # if exists
git add Manuscript/images/Image_Registry_Backmatter.md   # if exists
git add Manuscript/images/Image_Registry_LEGACY_*.md
git commit -m "REFACTOR: Split Image Registry into chapter-based registries

- Created X chapter registries from single Y-entry registry
- Master index tracks Y images across X chapters
- Token usage reduced from ~Z tokens to ~N tokens per operation
- All image references preserved
- Legacy registry archived

🤖 Generated with Claude Code

Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

## Registry Type Detection

**Use this logic in all prompts that read Image Registry:**

```markdown
## Registry Type Detection

1. Read first 10 lines of `Manuscript/images/Image_Registry.md`
2. Search for "Registry Type: Split"
3. If found: Use SPLIT MODE operations
4. If not found: Use SINGLE MODE operations (backward compatible)
```

### Split Mode Operations

**Adding image to Chapter XX:**
1. Read `Image_Registry_Chapter_XX.md` only (~5,000 tokens)
2. Determine next figure number from chapter registry
3. Add entry to chapter registry
4. Update master index statistics (read/write ~2,000 tokens)

**Validating registry:**
1. Read master index for registry list
2. For each chapter registry:
   - Read chapter registry
   - Validate references in corresponding chapter
   - Check file existence
3. Aggregate results

**Listing chapter images:**
1. Read chapter registry only
2. Display chapter images

### Single Mode Operations (Backward Compatible)

**All operations:**
- Read entire `Image_Registry.md`
- Process as before
- No changes to existing behavior

---

## Master Index Format

**File:** `Manuscript/images/Image_Registry.md` (after split)

```markdown
# Image Registry (Master Index)

**Registry Type:** Split (Chapter-Based)
**Total Images:** [COUNT]
**Split Date:** [DATE]
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
| Frontmatter | `Image_Registry_Frontmatter.md` | [N] | [DATE] |
| Chapter 01 | `Image_Registry_Chapter_01.md` | [N] | [DATE] |
| Chapter 02 | `Image_Registry_Chapter_02.md` | [N] | [DATE] |
| ... | ... | ... | ... |
| Backmatter | `Image_Registry_Backmatter.md` | [N] | [DATE] |

**Total:** [COUNT] images across [N] registries

---

## Quick Stats

**By Type:**
- Text-based visuals: [N] ([%])
- Professional images: [N] ([%])
- Photos/screenshots: [N] ([%])

**By Chapter:**
- Average: [N] images/chapter
- Most images: Chapter [XX] ([N] images)
- Least images: Chapter [XX] ([N] images)

**Status:**
- Referenced: [N] ([%])
- Unreferenced: [N] ([%])
- Missing files: [N] ([%])

---

## How to Use Split Registries

**For Authors:**
- Reference images normally: `![Description](images/fig-02-01-diagram.png)`
- Prompts automatically use correct chapter registry

**For AI (Claude):**
- When processing Chapter 5: Read `Image_Registry_Chapter_05.md` only
- For full validation: Read master index + all chapter registries
- For duplicate detection: Read only relevant chapter registry

**Adding Images:**
1. User specifies chapter (or AI detects from context)
2. Prompt 16 reads chapter registry only
3. Adds entry to chapter registry
4. Updates master index stats

---

## Migration Information

**Migrated from:** Single registry (`Image_Registry.md`)
**Migration Date:** [DATE]
**Original File:** Archived as `Image_Registry_LEGACY_[DATE].md`
**Migration Tool:** Prompt 16 automatic split

**All image references preserved:** No content file updates required

---

**Framework Version:** 0.14.0
**Last Updated:** [DATE]
```

---

## Chapter Registry Format

**File:** `Manuscript/images/Image_Registry_Chapter_XX.md`

```markdown
# Image Registry - Chapter XX

**Chapter:** XX - [Chapter Title]
**Total Images:** [COUNT]
**Last Updated:** [DATE]
**Framework Version:** 0.14.0

---

## Text-Based Visuals ([N])

### fig-XX-01-description
- **Figure:** X.1
- **Title:** [Title]
- **Type:** [Table | Diagram | Chart | Flowchart]
- **Status:** 📝 Text-based (Markdown)
- **File:** `images/fig-XX-01-description.md`
- **Referenced in:** Chapter_XX.md:line [N]
- **Alt Text:** "[Description]"
- **Caption:** "Figure X.1: [Caption]"
- **Created:** [DATE] by Prompt 15 (Visual Content Suggester)
- **Upgrade Priority:** [High | Medium | Low]
- **Notes:** [Notes]

[... more text-based entries ...]

---

## Professional Images ([N])

### fig-XX-02-description
- **Figure:** X.2
- **Title:** [Title]
- **Type:** [Photo | Screenshot | Chart | Diagram | Infographic]
- **Status:** 🖼️ Professional image ([FORMAT])
- **File:** `images/fig-XX-02-description.ext`
- **Size:** [SIZE] ([WIDTH]x[HEIGHT]px)
- **Referenced in:** Chapter_XX.md:line [N]
- **Alt Text:** "[Description]"
- **Caption:** "Figure X.2: [Caption]"
- **Created:** [DATE] by Prompt 16 (Image Manager)
- **Upgrade Priority:** N/A (professional image)
- **Notes:** [Notes]

[... more professional image entries ...]

---

## Summary Statistics

- **Total images:** [N]
- **Text-based:** [N] ([%])
- **Professional:** [N] ([%])
- **Referenced:** [N] ([%])
- **Unreferenced:** [N] ([%])
- **Upgrade candidates:** [N] text-based figures

---

**Chapter Registry Version:** 1.0
**Framework Version:** 0.14.0
```

---

## Frontmatter/Backmatter Registry Format

**File:** `Manuscript/images/Image_Registry_Frontmatter.md`

```markdown
# Image Registry - Front Matter

**Section:** Front Matter
**Total Images:** [COUNT]
**Last Updated:** [DATE]
**Framework Version:** 0.14.0

---

## Cover & Author

### cover
- **Figure:** N/A (Cover)
- **Title:** Book Cover
- **Type:** Cover Image
- **Status:** 🖼️ Professional image (JPG)
- **File:** `images/cover.jpg`
- **Size:** [SIZE] ([dimensions])
- **Referenced in:** EPUB export, Title Page
- **Alt Text:** "[Book Title] by [Author Name]"
- **Caption:** N/A
- **Created:** [DATE] by author
- **Upgrade Priority:** N/A (final)
- **Notes:** Professional design

### author-photo
- **Figure:** N/A (Author)
- **Title:** Author Photo
- **Type:** Photo
- **Status:** 🖼️ Professional image (JPG)
- **File:** `images/author-photo.jpg`
- **Size:** [SIZE] ([dimensions])
- **Referenced in:** About the Author section
- **Alt Text:** "Portrait of [Author Name]"
- **Caption:** N/A
- **Created:** [DATE] by author
- **Upgrade Priority:** N/A (final)
- **Notes:** [Notes]

---

## Summary Statistics

- **Total images:** [N]
- **Professional:** [N] (100%)

---

**Section Registry Version:** 1.0
**Framework Version:** 0.14.0
```

---

## Chapter Number Extraction

**Parse chapter number from figure filename:**

```
Filename: fig-03-02-survey-results.png
Pattern:  fig-XX-YY-description.ext

XX = Chapter number (03)
YY = Figure number within chapter (02)
```

**Extraction logic:**
1. Match pattern: `^fig-(\d{2})-\d{2}-.*\.\w+$`
2. Extract group 1 = chapter number
3. If no match: Check for `cover`, `author-photo` → Frontmatter
4. If contains `backmatter` or `appendix` → Backmatter

---

## Updating Master Index Statistics

**When adding/removing images, update master index:**

1. Read `Image_Registry.md` (master index)
2. Update Registry Distribution table:
   - Find row for affected chapter
   - Update Images count
   - Update Last Updated date
3. Update Quick Stats section:
   - Recalculate totals
   - Update type percentages
   - Update status counts
4. Write updated master index

**Frequency:** After every add/upgrade/delete operation

---

## Manual Split Request

**User can trigger split before threshold:**

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

**Process:** Same split algorithm as automatic trigger

---

## Merge Back to Single Registry

**Use case:** Project shrinks below 200 images

**Process (optional, user-requested):**
1. Read all chapter registries
2. Combine entries into single registry
3. Update header to remove "Registry Type: Split"
4. Delete chapter registries
5. Commit changes

**Note:** Low priority feature - rarely needed

---

## Lock Management Integration

**Split mode extends existing lock behavior:**

- `ImageRegistry` lock now protects:
  - Master index (`Image_Registry.md`)
  - All chapter registries (`Image_Registry_Chapter_XX.md`)
- Acquired lock covers all split registry files
- No new lock types required

**Rationale:** Simpler than per-chapter registry locks, operations typically update master index + one chapter registry

---

## Error Handling

### Split Operation Errors

**Entry count mismatch:**
```
❌ Split validation failed: Entry count mismatch
   Original registry: 347 entries
   Sum of chapter registries: 345 entries
   Missing: 2 entries

   Check: Image_Registry_LEGACY_[DATE].md for comparison
   Action: Manual review required
```

**File write failure:**
```
❌ Failed to write chapter registry: Image_Registry_Chapter_05.md
   Error: [error message]

   Action: Check disk space and permissions
   Recovery: Original registry preserved (not yet archived)
```

### Runtime Errors (Post-Split)

**Chapter registry not found:**
```
⚠️ Chapter registry not found: Image_Registry_Chapter_12.md

This chapter may not have any images yet.
Creating empty chapter registry...
```

**Master index out of sync:**
```
⚠️ Master index statistics out of sync

Master index total: 347
Actual total (sum of registries): 352

Run Prompt 16 Mode 4 (Validate) to reconcile.
```

---

## Integration with Prompts

### Prompt 16 (Image Manager) - Primary

**Mode 1 (Add Image):**
- Split: Read chapter registry, add entry, update master stats
- Single: Read full registry, add entry

**Mode 2 (Upgrade):**
- Split: Read chapter registry, upgrade entry, update master stats
- Single: Read full registry, upgrade entry

**Mode 3 (Scan):**
- Split: Scan files, distribute to chapter registries, update master
- Single: Scan files, add to single registry

**Mode 4 (Validate):**
- Split: Read master + all chapter registries, validate each
- Single: Read full registry, validate all

**New: Split Command:**
- "split image registry" triggers split algorithm
- Available when: entries > 100 (preventive) or > 300 (recommended)

### Prompt 15 (Visual Content Suggester)

**Changes:**
- Detect registry type
- Split: Add entries to `Image_Registry_Chapter_XX.md`
- Single: Add entries to `Image_Registry.md`
- Always update master index stats if split

### Prompt 8 (Consistency Checker)

**Changes:**
- Detect registry type
- Split: Read master index, then all chapter registries
- Validate per-chapter, aggregate results
- Report in structured format showing per-chapter status

### Prompt 10 (Dashboard)

**Changes:**
- Detect registry type
- Split: Read master index for totals
- Show per-chapter image distribution
- Show registry health metrics

### Prompt 6 (Integrate Inbox)

**Changes:**
- Detect registry type
- When integrating images, detect target chapter
- Split: Add to appropriate chapter registry
- Update master index stats

### Other Prompts (No Changes)

- **Prompt 1:** Creates single registry (default) - no changes
- **Prompt 2:** Creates chapter files, registries created lazily - no changes
- **Prompts 3, 4, 5, 9, 11, 12, 13, 14:** No direct registry operations - no changes
- **Prompt 7:** Reads chapters, image refs unchanged - no changes

---

## Performance Comparison

### Single Registry (300+ entries)

| Operation | Tokens Read | Performance |
|-----------|-------------|-------------|
| Add image | ~75,000 | Slow |
| Validate registry | ~75,000 | Very slow |
| List chapter images | ~75,000 | Slow |
| Check duplicates | ~75,000 | Slow |

### Split Registry (300+ entries, ~15 entries/chapter)

| Operation | Tokens Read | Performance |
|-----------|-------------|-------------|
| Add image (Chapter) | ~5,000 | Fast |
| Update master stats | ~2,000 | Fast |
| Validate registry | ~5,000 + parallel | Moderate |
| List chapter images | ~5,000 | Fast |
| Check duplicates | ~5,000 | Fast |

**Improvement:** 89% token reduction for typical operations

---

## Summary

The Image Registry Splitting Module enables:

- ✅ **Scalability** to 1,000+ images
- ✅ **Performance** improvement (89% token reduction)
- ✅ **Usability** enhancement (easier navigation)
- ✅ **Backward compatibility** (single registry still works)
- ✅ **Automatic** threshold detection and splitting
- ✅ **Manual** split option for proactive users
- ✅ **Integration** with existing lock management

**Used by:** Prompts 6, 8, 10, 15, 16

---

**Framework Version:** 0.14.0
**Last Updated:** 2025-11-24
**Status:** Active

---

*This module enables books with large numbers of images to scale efficiently while maintaining the unified visual asset management philosophy.*
