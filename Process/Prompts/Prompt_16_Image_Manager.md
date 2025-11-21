# Prompt 16: Image Manager

**Version:** 0.12.5
**Last Updated:** 2025-11-21
**Compatibility:** Claude Code CLI only (requires file operations, image handling)

---

## Purpose

Manage actual images (photos, screenshots, charts, graphics) in your book manuscript. This prompt works alongside Prompt 15 (Visual Content Suggester) to provide complete visual asset management.

**VISUAL SYSTEM VERSION:** v0.12.5 - Unified directory structure
- **Location:** `Manuscript/images/` (single flat directory)
- **Naming:** `fig-XX-YY-description.ext` (hyphens, not underscores)
- **Registry:** `Manuscript/images/Image_Registry.md` (unified, not per-chapter)
- **Coordination:** Reads registry to determine next figure number for any chapter
- **Status:** 🖼️ Professional image (vs 📝 text-based from Prompt 15)

---

## When to Use This Prompt

Use Prompt 16 when you need to:
- **Add new images** (photos, screenshots, charts) to specific chapters
- **Upgrade text-based visuals** (from Prompt 15) to professional images
- **Scan and register** existing images already in your manuscript
- **Validate** that all image references are correct and files exist
- **Update metadata** for existing images (alt text, captions, file info)

**CLI-ONLY**: This prompt requires Claude Code CLI for file operations and image analysis.

---

## Four Operating Modes

### Mode 1: Add Image to Chapter
Add a new professional image to a specific chapter. Claude will:
1. Read `Image_Registry.md` to determine the next figure number for the chapter
2. Copy/move the image file to `Manuscript/images/` with proper naming
3. Register the image with full metadata
4. Insert the markdown reference in the specified chapter location
5. Update statistics in the registry
6. Commit changes to git

### Mode 2: Upgrade Text-Based to Professional Image
Replace a text-based visual (created by Prompt 15) with a professional image. Claude will:
1. Locate the text-based figure in the registry
2. Replace the `.md` file with the provided image file
3. Update the registry entry (status 📝 → 🖼️, add size/dimensions)
4. Update the chapter reference to use the new image
5. Archive the old text-based file with version history
6. Update statistics and commit

### Mode 3: Scan and Register Existing Images
Discover and register images already present in your manuscript. Claude will:
1. Scan `Manuscript/images/` for unregistered image files
2. Search chapters for image references
3. Create registry entries with inferred metadata
4. Report findings for user confirmation
5. Register confirmed images
6. Update statistics and commit

### Mode 4: Validate Image References
Check that all image references are correct and files exist. Claude will:
1. Read all chapter files and extract image references
2. Verify each referenced file exists in `Manuscript/images/`
3. Cross-check registry entries against actual files
4. Report discrepancies (missing files, broken references, unregistered images)
5. Suggest fixes for issues found

---

## Prerequisites

**Required:**
- Initialized book project (Prompt 1 executed)
- `Manuscript/images/` directory exists
- `Manuscript/images/Image_Registry.md` exists

**Recommended:**
- Run Prompt 15 first if you want text-based placeholders before adding images
- Have image files ready (JPEG, PNG, SVG formats recommended)
- Know which chapter and approximate location for the image

---

## Execution Instructions

### CRITICAL: Read First

**Before executing this prompt:**

1. **Read Module 15:**
   ```
   Process/_COMMON/15_Visual_Asset_Management_Protocol.md
   ```
   This defines the complete visual asset system, naming conventions, and coordination protocol.

2. **Read the Image Registry:**
   ```
   Manuscript/images/Image_Registry.md
   ```
   This shows existing figures and determines the next figure number for each chapter.

3. **Read Anti-Hallucination Guidelines:**
   ```
   Process/Anti-Hallucination_Guidelines.md
   ```
   Critical rules for handling image descriptions and metadata.

---

## Mode 1: Add Image to Chapter

### User Instructions

Provide the following information:

1. **Image source:** Full path to the image file on your system
2. **Target chapter:** Which chapter (e.g., "Chapter 3" or "Chapter_03.md")
3. **Image type:** Photo | Screenshot | Chart | Diagram | Infographic | Illustration
4. **Location guidance:** Where in the chapter (e.g., "After the section on data collection")
5. **Alt text:** Accessibility description (be specific and descriptive)
6. **Caption:** Full caption text including "Figure X.Y: " prefix
7. **Additional context:** Any notes about the image purpose or source

### Execution Steps

**Step 1: Validate Prerequisites**

```bash
# Verify project structure
ls -la Manuscript/images/
ls -la Manuscript/Chapters/
```

Check that:
- `Manuscript/images/` directory exists
- `Manuscript/images/Image_Registry.md` exists
- Target chapter file exists
- Source image file exists and is accessible

**Step 2: Read Current State**

Read these files to understand the current state:
- `Manuscript/images/Image_Registry.md` - Determine next figure number for the chapter
- `Manuscript/Chapters/Chapter_XX.md` - Understand chapter content and find insertion point

**Step 3: Determine Figure Number**

Parse the registry to find:
- All existing figures for the target chapter (e.g., fig-03-01, fig-03-02)
- The next sequential number (e.g., fig-03-03)

**Logic:**
```
For chapter XX:
  - Find all entries starting with "### fig-XX-"
  - Extract the YY numbers (e.g., 01, 02, 03)
  - Next number = max(YY) + 1 (zero-padded to 2 digits)
  - If no figures exist for chapter: Next number = 01
```

**Step 4: Generate Filename**

Format: `fig-XX-YY-description.ext`

Example: `fig-03-03-survey-results.png`

**Rules:**
- `XX` = Chapter number (zero-padded)
- `YY` = Sequential figure number within chapter (zero-padded)
- `description` = Kebab-case (lowercase, hyphens, no spaces)
- `.ext` = Original file extension (preserve .jpg, .png, .svg, etc.)

**Step 5: Copy Image File**

```bash
# Copy the source image to Manuscript/images/ with proper naming
cp "/path/to/source/image.png" "Manuscript/images/fig-XX-YY-description.png"
```

**Step 6: Get Image Metadata**

```bash
# Get file size and dimensions
ls -lh "Manuscript/images/fig-XX-YY-description.png" | awk '{print $5}'
file "Manuscript/images/fig-XX-YY-description.png"
```

Extract:
- File size (KB or MB)
- Image dimensions (width x height in pixels)
- File format

**Step 7: Create Registry Entry**

Add a new entry to `Image_Registry.md` in the appropriate chapter section:

```markdown
### fig-XX-YY-description
- **Figure:** X.Y
- **Title:** [Title from caption]
- **Type:** [Photo | Screenshot | Chart | Diagram | Infographic | Illustration]
- **Status:** 🖼️ Professional image ([FORMAT])
- **File:** `images/fig-XX-YY-description.ext`
- **Size:** [SIZE] ([WIDTH]x[HEIGHT]px)
- **Referenced in:** Chapter_XX.md:line
- **Alt Text:** "[Detailed accessibility description]"
- **Caption:** "Figure X.Y: [Caption text]"
- **Created:** YYYY-MM-DD by Prompt 16 (Image Manager)
- **Upgrade Priority:** N/A (professional image)
- **Notes:** [Any additional context]
```

**Step 8: Insert Chapter Reference**

Find the specified location in the chapter and insert:

```markdown
![Alt text description](../images/fig-XX-YY-description.ext)

*Figure X.Y: Caption text*
```

**Important:**
- Use relative path `../images/` (works in Typora and Pandoc)
- Alt text is required for accessibility
- Caption should be italic text on the line below
- Leave blank lines before and after the figure block

**Step 9: Update Registry Statistics**

Update the header statistics in `Image_Registry.md`:
- Increment **Total Assets**
- Increment **🖼️ images** count
- Increment type counter (e.g., "1 photos" → "2 photos")
- Update **Last Updated** date

**Step 10: Commit Changes**

```bash
git add Manuscript/images/fig-XX-YY-description.ext
git add Manuscript/images/Image_Registry.md
git add Manuscript/Chapters/Chapter_XX.md
git commit -m "ADD: Figure X.Y (professional image) to Chapter XX

- Type: [Type]
- File: fig-XX-YY-description.ext
- Size: [SIZE] ([WIDTH]x[HEIGHT]px)
- Location: Chapter_XX.md

🤖 Generated with Claude Code - Prompt 16 (Image Manager)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

**Step 11: Report Completion**

Provide a summary:
```
✅ Image Added Successfully

Figure: X.Y
File: fig-XX-YY-description.ext
Size: [SIZE] ([WIDTH]x[HEIGHT]px)
Chapter: XX
Reference inserted at: Chapter_XX.md:line

Registry updated: [OLD_TOTAL] → [NEW_TOTAL] total assets
Status: 🖼️ Professional image

Next steps:
- Review the image placement in Chapter_XX.md
- Run Prompt 8 (Consistency) to validate references
- Run Prompt 7 (Compile) to see the image in full manuscript
```

---

## Mode 2: Upgrade Text-Based to Professional Image

### User Instructions

Provide the following information:

1. **Figure to upgrade:** Figure number (e.g., "Figure 3.2" or "fig-03-02")
2. **Image source:** Full path to the replacement image file
3. **Updated caption:** If the caption should change (optional)
4. **Updated alt text:** If the alt text should change (optional)
5. **Notes:** Reason for upgrade or any context

### Execution Steps

**Step 1: Validate Prerequisites**

Verify:
- The figure exists in `Image_Registry.md`
- Current status is 📝 Text-based
- The text-based file exists at `Manuscript/images/fig-XX-YY-description.md`
- Source image file exists and is accessible

**Step 2: Read Current Entry**

Extract from `Image_Registry.md`:
- Current figure metadata
- Chapter references
- Alt text and caption
- File path

**Step 3: Archive Text-Based File**

```bash
# Create archive directory if needed
mkdir -p Manuscript/images/_archived

# Move the old text-based file with timestamp
mv "Manuscript/images/fig-XX-YY-description.md" \
   "Manuscript/images/_archived/fig-XX-YY-description_YYYY-MM-DD.md"
```

**Step 4: Copy New Image**

```bash
# Copy the professional image with the SAME base filename
cp "/path/to/source/image.png" "Manuscript/images/fig-XX-YY-description.png"
```

**Note:** Preserve the same `fig-XX-YY-description` base name to maintain reference continuity.

**Step 5: Get Image Metadata**

```bash
# Get file size and dimensions
ls -lh "Manuscript/images/fig-XX-YY-description.png" | awk '{print $5}'
file "Manuscript/images/fig-XX-YY-description.png"
```

**Step 6: Update Registry Entry**

Modify the existing entry in `Image_Registry.md`:

```markdown
### fig-XX-YY-description
- **Figure:** X.Y
- **Title:** [Title - keep or update]
- **Type:** [Keep existing type or update]
- **Status:** 🖼️ Professional image (PNG)  # CHANGED from 📝 Text-based
- **File:** `images/fig-XX-YY-description.png`  # CHANGED extension
- **Size:** [SIZE] ([WIDTH]x[HEIGHT]px)  # NEW field
- **Referenced in:** Chapter_XX.md:line  # Keep same
- **Alt Text:** "[Keep or update]"
- **Caption:** "Figure X.Y: [Keep or update]"
- **Created:** [ORIGINAL_DATE] by Prompt 15 (Visual Content Suggester)
- **Upgraded:** YYYY-MM-DD by Prompt 16 (Image Manager)  # NEW field
- **Upgrade Priority:** N/A (upgraded)  # CHANGED
- **Notes:** Upgraded from text-based to professional image. [Previous notes]. [New notes]
```

**Step 7: Update Chapter Reference**

Find the reference in `Chapter_XX.md` and update the extension:

```markdown
# OLD:
![Alt text description](../images/fig-XX-YY-description.md)

*Figure X.Y: Caption text*

# NEW:
![Alt text description](../images/fig-XX-YY-description.png)

*Figure X.Y: Caption text*
```

**If alt text or caption changed, update those too.**

**Step 8: Update Registry Statistics**

Update the header statistics:
- **Total Assets:** No change (still same figure)
- **By Status:** Decrement 📝 count, increment 🖼️ count
- **By Type:** No change unless type changed
- **Total Size:** Add the new image size
- **Last Updated:** Update to current date

**Step 9: Commit Changes**

```bash
git add Manuscript/images/fig-XX-YY-description.png
git add Manuscript/images/_archived/fig-XX-YY-description_YYYY-MM-DD.md
git add Manuscript/images/Image_Registry.md
git add Manuscript/Chapters/Chapter_XX.md
git commit -m "UPGRADE: Figure X.Y from text-based to professional image

- Was: 📝 Text-based (.md)
- Now: 🖼️ Professional image (.png)
- Size: [SIZE] ([WIDTH]x[HEIGHT]px)
- Text-based version archived

🤖 Generated with Claude Code - Prompt 16 (Image Manager)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

**Step 10: Report Completion**

```
✅ Figure Upgraded Successfully

Figure: X.Y
File: fig-XX-YY-description.png
Size: [SIZE] ([WIDTH]x[HEIGHT]px)
Status: 📝 Text-based → 🖼️ Professional image

Registry updated:
- 📝 Text-based: [OLD_COUNT] → [NEW_COUNT]
- 🖼️ Professional: [OLD_COUNT] → [NEW_COUNT]

Archived: fig-XX-YY-description_YYYY-MM-DD.md

Next steps:
- Review the upgraded image in Chapter_XX.md
- Run Prompt 8 (Consistency) to validate
- Consider upgrading other high-priority text-based figures
```

---

## Mode 3: Scan and Register Existing Images

### User Instructions

Provide:
1. **Scope:** Scan entire `Manuscript/images/` directory OR specific chapter
2. **Auto-register:** Yes (register automatically) or No (report findings for confirmation)

### Execution Steps

**Step 1: Scan for Unregistered Images**

```bash
# List all image files in Manuscript/images/
find Manuscript/images/ -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.svg" -o -iname "*.gif" \) | sort
```

**Step 2: Read Current Registry**

Parse `Image_Registry.md` to extract all registered filenames.

**Step 3: Compare and Identify Unregistered**

Compare the scanned files against the registry:
- List files that exist but are NOT in the registry
- Exclude `_archived/` directory

**Step 4: Search Chapters for References**

For each unregistered image:

```bash
# Search all chapter files for references to this image
grep -rn "image-filename" Manuscript/Chapters/
```

Extract:
- Which chapter(s) reference the image
- Line numbers
- Alt text from markdown syntax
- Caption text (italic line below image reference)

**Step 5: Infer Metadata**

For each unregistered image, infer:
- **Chapter number:** From filename (if follows convention) or from grep results
- **Figure number:** From filename or sequential assignment
- **Type:** From filename or image analysis (best guess)
- **Alt text:** From chapter reference or filename
- **Caption:** From chapter reference or placeholder

**Step 6: Get Image Metadata**

For each image:

```bash
ls -lh "Manuscript/images/[filename]" | awk '{print $5}'
file "Manuscript/images/[filename]"
```

**Step 7: Report Findings**

Generate a report:

```
📊 Image Scan Results

Scanned: Manuscript/images/
Total image files found: X
Already registered: Y
Unregistered: Z

Unregistered Images:
-------------------

1. image-name-1.png
   - Size: 245 KB (1200x800px)
   - Referenced in: Chapter_03.md:line 142
   - Inferred type: Photo
   - Suggested figure: 3.3
   - Alt text found: "Survey results showing..."

2. image-name-2.jpg
   - Size: 512 KB (1600x1200px)
   - Referenced in: Chapter_05.md:line 89
   - Inferred type: Screenshot
   - Suggested figure: 5.1
   - No alt text found (⚠ accessibility issue)

3. diagram.svg
   - Size: 48 KB (800x600px)
   - Not referenced in any chapter (⚠ orphaned file)
   - Inferred type: Diagram
   - Suggested action: Delete or reference in chapter

Auto-register these images? (requires confirmation for each)
```

**Step 8: Register Confirmed Images**

For each image the user confirms:

1. Rename to follow naming convention (if needed):
   ```bash
   mv "Manuscript/images/old-name.png" "Manuscript/images/fig-XX-YY-description.png"
   ```

2. Create registry entry with inferred metadata

3. Update chapter reference to use new filename (if renamed)

**Step 9: Update Statistics and Commit**

```bash
git add Manuscript/images/Image_Registry.md
git add Manuscript/Chapters/*.md  # If any references were updated
git commit -m "SCAN: Register X existing images

Registered:
- [List of registered images]

Updated references:
- [List of updated chapter references]

🤖 Generated with Claude Code - Prompt 16 (Image Manager)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

**Step 10: Report Completion**

```
✅ Image Scan Complete

Registered: X images
Renamed: Y images to follow naming convention
Updated references: Z chapter references
Orphaned files: N (not referenced in any chapter)

Registry updated: [OLD_TOTAL] → [NEW_TOTAL] total assets

Warnings:
- X images missing alt text (accessibility issue)
- Y images not following naming convention (consider renaming)
- Z orphaned images (not referenced in chapters)

Next steps:
- Run Prompt 8 (Consistency) to validate all references
- Add alt text to images missing it
- Delete or reference orphaned images
```

---

## Mode 4: Validate Image References

### User Instructions

Provide:
1. **Scope:** Validate entire manuscript OR specific chapter(s)
2. **Fix mode:** Report only OR auto-fix simple issues

### Execution Steps

**Step 1: Read Registry**

Parse `Image_Registry.md` to extract:
- All registered figure entries
- Expected filenames
- Referenced chapter and line numbers

**Step 2: Verify Registry Files Exist**

For each registry entry:

```bash
# Check if the file exists
test -f "Manuscript/images/[filename]" && echo "EXISTS" || echo "MISSING"
```

Create a list of:
- ✅ Files that exist
- ❌ Files missing (registry entry exists but file doesn't)

**Step 3: Scan Chapter References**

```bash
# Find all image references in chapters
grep -rn "!\[.*\](.*/images/.*)" Manuscript/Chapters/
```

Extract:
- Chapter file
- Line number
- Referenced filename
- Alt text

**Step 4: Cross-Reference**

For each chapter reference:
1. Does the file exist in `Manuscript/images/`?
2. Is the file registered in `Image_Registry.md`?
3. Does the registry entry reference this chapter?

Create lists:
- ✅ Valid references (file exists, registered, cross-referenced)
- ❌ Broken references (file doesn't exist)
- ⚠️ Unregistered references (file exists but not in registry)
- ⚠️ Orphaned registry entries (registered but not referenced in any chapter)

**Step 5: Check Naming Conventions**

For each file in `Manuscript/images/`:
- Follows `fig-XX-YY-description.ext` pattern?
- Chapter number matches reference location?
- Sequential numbering within chapter?

**Step 6: Check Accessibility**

For each image reference:
- Has alt text?
- Alt text is descriptive (not empty or just filename)?
- Has caption (italic text line below)?

**Step 7: Generate Validation Report**

```
🔍 Image Reference Validation Report

Scope: [All chapters | Specific chapters]
Date: YYYY-MM-DD

Summary:
--------
Total images in registry: X
Total chapter references: Y
Valid references: Z ✅
Issues found: N ❌

Issues:
-------

🚨 CRITICAL (Broken References):
1. Chapter_03.md:line 142
   - References: ../images/fig-03-02-missing.png
   - Status: File does not exist ❌
   - Fix: Remove reference or add missing file

2. Chapter_05.md:line 89
   - References: ../images/old-image.jpg
   - Status: File exists but not registered ⚠️
   - Fix: Run Mode 3 (Scan and Register)

⚠️ WARNINGS (Minor Issues):
1. fig-03-01-table.png
   - Registry: Chapter_03.md:line 100
   - Actual reference: Chapter_03.md:line 105
   - Fix: Update registry line number

2. Chapter_07.md:line 234
   - References: ../images/fig-07-01-photo.jpg
   - Missing alt text (empty brackets) ⚠️
   - Fix: Add descriptive alt text for accessibility

3. fig-08-03-diagram.md
   - Registered but not referenced in any chapter
   - Status: Orphaned registry entry
   - Fix: Add reference or remove from registry

📊 STATISTICS (Naming Conventions):
- Following convention: X files (Y%)
- Non-standard names: Z files
- Sequential gaps: N chapters

🎯 ACCESSIBILITY CHECK:
- Images with alt text: X (Y%)
- Missing alt text: Z ⚠️
- Images with captions: X (Y%)
- Missing captions: Z

Recommendations:
----------------
1. Fix N critical broken references immediately
2. Add alt text to Z images for accessibility compliance
3. Register Y unregistered images (run Mode 3)
4. Update N registry line numbers
5. Consider renaming Z files to follow naming convention
```

**Step 8: Auto-Fix (if enabled)**

If user requested auto-fix:

1. **Update registry line numbers** (if chapter references moved)
2. **Add placeholder alt text** (mark with [VERIFY] for user review)
3. **Remove orphaned entries** (if file doesn't exist and no references)

**DO NOT auto-fix:**
- Broken references (require user decision)
- Missing files (require user to provide file)
- Naming convention violations (require user approval for rename)

**Step 9: Commit Fixes (if any)**

```bash
git add Manuscript/images/Image_Registry.md
git commit -m "VALIDATE: Image references - fix N issues

Auto-fixed:
- Updated X registry line numbers
- Added Y placeholder alt texts (marked [VERIFY])
- Removed Z orphaned entries

Manual fixes required: N critical issues

🤖 Generated with Claude Code - Prompt 16 (Image Manager)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

**Step 10: Report Completion**

```
✅ Image Validation Complete

Scope: [Scope description]
Issues found: N
Auto-fixed: X issues
Manual fixes required: Y critical issues

See full report above for details.

Next steps:
- Review and fix Y critical issues (broken references)
- Add descriptive alt text to images marked [VERIFY]
- Re-run validation after fixes to confirm resolution
- Run Prompt 8 (Consistency) for comprehensive manuscript check
```

---

## Integration with Other Prompts

### Prompt 15 (Visual Content Suggester)
- **Prompt 15** creates text-based visuals (📝 status)
- **Prompt 16 Mode 2** upgrades them to professional images (🖼️ status)
- Both read `Image_Registry.md` to coordinate figure numbering

### Prompt 1 (Initialize)
- Creates `Manuscript/images/` directory
- Creates initial `Image_Registry.md` from template
- Sets up proper directory structure

### Prompt 8 (Consistency Checker)
- Validates image references across all chapters
- Checks registry accuracy
- Identifies missing files or broken links
- **Run after Prompt 16** to verify all changes

### Prompt 7 (Compile)
- Includes all images in compiled manuscript
- Validates relative paths work correctly
- Shows final presentation of figures

### Prompt 9 (Export)
- Includes images in EPUB/DOCX/PDF exports
- Uses `--resource-path=Manuscript` for Pandoc
- Embeds images at correct sizes
- **Always run Prompt 16 Mode 4 before export** to ensure clean references

### Prompt 10 (Dashboard)
- Shows visual asset statistics
- Reports 📝 vs 🖼️ distribution
- Recommends high-priority upgrades

---

## Supported Image Formats

### Recommended Formats

**For photographs and screenshots:**
- **JPEG (.jpg, .jpeg)** - Best for photos, good compression
- **PNG (.png)** - Best for screenshots, lossless quality

**For diagrams and graphics:**
- **SVG (.svg)** - Scalable vector graphics, ideal for diagrams
- **PNG (.png)** - Raster graphics, good for charts

**For web-optimized:**
- **WebP (.webp)** - Modern format, excellent compression (check reader support)

### Format Guidelines

**Image specifications for EPUB:**
- **Max dimensions:** 1600x2560px (standard EPUB reader size)
- **Max file size:** 2MB per image (larger files slow down readers)
- **Color mode:** RGB (not CMYK)
- **Resolution:** 72-150 DPI (higher DPI wasted in digital formats)

**Accessibility requirements:**
- **Alt text:** Always required, must be descriptive
- **Caption:** Recommended for all figures
- **Contrast:** Ensure diagrams have sufficient color contrast

---

## Best Practices

### Naming Conventions

**DO:**
- ✅ Use `fig-XX-YY-description.ext` format
- ✅ Use kebab-case for descriptions (lowercase, hyphens)
- ✅ Keep descriptions concise but meaningful (3-5 words)
- ✅ Preserve original file extension

**DON'T:**
- ❌ Use spaces in filenames
- ❌ Use underscores (use hyphens instead)
- ❌ Use special characters or Unicode
- ❌ Change file extensions (preserve original)

**Examples:**
- ✅ `fig-03-02-survey-results.png`
- ✅ `fig-07-01-data-collection.jpg`
- ✅ `fig-12-03-process-flowchart.svg`
- ❌ `Figure 3.2 Survey Results.png`
- ❌ `fig_03_02_survey.png`
- ❌ `survey-résumé.png`

### Alt Text Guidelines

**Good alt text:**
- Describes the content and purpose of the image
- Includes key data points for charts/graphs
- Mentions important visual details
- Concise but complete (aim for 1-2 sentences)

**Examples:**
```markdown
✅ ![Bar chart showing survey responses: 45% agree, 30% neutral, 25% disagree](../images/fig-03-02-survey-results.png)

✅ ![Screenshot of the dashboard settings panel with three toggle options highlighted](../images/fig-05-01-dashboard-settings.png)

❌ ![Image](../images/fig-03-02-survey-results.png)
❌ ![fig-03-02-survey-results](../images/fig-03-02-survey-results.png)
```

### Caption Guidelines

**Good captions:**
- Start with "Figure X.Y: "
- Concisely describe what the figure shows
- Provide context or interpretation if needed
- Use italic formatting

**Examples:**
```markdown
*Figure 3.2: Survey results showing strong agreement with the proposed framework (n=245 respondents)*

*Figure 5.1: Dashboard settings panel where users configure notification preferences*

*Figure 7.3: Three-stage data collection process used in the pilot study*
```

### Coordination with Prompt 15

**Workflow for text-based to professional upgrade:**

1. **During drafting (Prompt 15):**
   - Create text-based placeholders for all figures
   - Mark upgrade priority (High/Medium/Low)
   - Use generic descriptions suitable for both text and images

2. **Before publication (Prompt 16 Mode 2):**
   - Review upgrade recommendations in registry
   - Prioritize High priority figures first
   - Upgrade strategically (not necessarily all figures)

3. **Decision criteria:**
   - Upgrade if text-based is confusing or inadequate
   - Keep text-based if it's clear and professional-looking
   - Budget and timeline considerations

**When to keep text-based:**
- Simple data tables (markdown tables are fine)
- ASCII flowcharts (if clear and professional)
- Lists or structured data
- When professional design budget is limited

**When to upgrade to professional:**
- Complex charts with multiple data series
- Photographs or real-world examples required
- Diagrams requiring precise visual layout
- Branding or visual consistency requirements

---

## Troubleshooting

### Issue: Image not displaying in Typora

**Cause:** Relative path incorrect or file not in expected location

**Fix:**
1. Verify the file exists: `ls -la Manuscript/images/fig-XX-YY-description.ext`
2. Check the reference uses `../images/` (not `images/` or absolute path)
3. Ensure you're opening the chapter from `Manuscript/Chapters/` directory
4. Typora needs to resolve `../images/` from the chapter's location

### Issue: Image not included in EPUB export (Prompt 9)

**Cause:** Pandoc can't find the image file

**Fix:**
1. Run Prompt 16 Mode 4 (Validate) to check all references
2. Ensure Prompt 9 uses `--resource-path=Manuscript` flag
3. Verify the image file exists in `Manuscript/images/`
4. Check that the reference path is `../images/` (relative from Chapters/)

### Issue: Registry shows incorrect statistics

**Cause:** Manual edits not reflected in registry header

**Fix:**
1. Run Prompt 16 Mode 3 (Scan) to discover unregistered images
2. Run Prompt 16 Mode 4 (Validate) to check accuracy
3. Manually recount and update header statistics if needed
4. Use Prompt 16 for all future image operations (don't manually edit)

### Issue: Figure numbers out of sequence

**Cause:** Manual deletion or insertion disrupted numbering

**Fix:**
1. Decide: Keep current numbers (gaps are OK) OR renumber sequentially
2. If renumbering: Use Prompt 8 (Consistency) to get renumbering plan
3. Manually renumber files, references, and registry (or ask Claude for help)
4. Commit with clear message explaining the renumbering

**Note:** Gaps in figure numbers are acceptable (e.g., 3.1, 3.3, 3.4 with 3.2 deleted). Only renumber if needed for publication guidelines.

### Issue: Large file sizes slowing down repository

**Cause:** High-resolution images not optimized for digital format

**Fix:**
1. Identify large files:
   ```bash
   find Manuscript/images/ -type f -size +2M -exec ls -lh {} \;
   ```
2. Optimize images:
   - Photos: Use JPEG with 85% quality
   - Screenshots: Use PNG with compression
   - Max dimensions: 1600x2560px for EPUB
3. Replace files using Prompt 16 Mode 2 (treat as an upgrade)
4. Consider using Git LFS for very large images

### Issue: Alt text missing or inadequate

**Cause:** Alt text not provided during image addition

**Fix:**
1. Run Prompt 16 Mode 4 (Validate) to identify missing alt text
2. Review images and write descriptive alt text
3. Update chapter references with proper alt text
4. Update registry entries with the new alt text
5. Commit changes

**Accessibility requirement:** All images MUST have descriptive alt text for accessibility compliance.

---

## Common Workflows

### Workflow 1: Add Images While Writing

**Scenario:** You're drafting Chapter 3 and want to add a screenshot.

**Steps:**
1. Save the screenshot file to a temporary location
2. Open Claude Code in your book project directory
3. Execute Prompt 16, Mode 1:
   ```
   I want to add an image to Chapter 3.

   Source: C:\Users\You\Desktop\screenshot.png
   Chapter: Chapter 3
   Type: Screenshot
   Location: After the section on "Installing the Software"
   Alt text: "Screenshot of the installation wizard showing the license agreement step"
   Caption: "Figure 3.1: Installation wizard prompting user to accept license terms"
   ```
4. Claude will:
   - Determine this is Figure 3.1 (first figure in chapter)
   - Copy to `Manuscript/images/fig-03-01-installation-wizard.png`
   - Register in `Image_Registry.md`
   - Insert reference in Chapter_03.md
   - Commit changes
5. Continue writing, image is now available in your chapter

### Workflow 2: Bulk Add Images from Directory

**Scenario:** You have 10 photos from fieldwork that need to go in Chapter 5.

**Steps:**
1. Copy all 10 photos to a temporary directory
2. Execute Prompt 16, Mode 1 for each image (repeat 10 times):
   - Provide source path, chapter, type, location, alt text, caption
   - Claude processes each sequentially (fig-05-01, fig-05-02, ..., fig-05-10)
3. Alternatively: Run Mode 3 (Scan) after manually copying to `Manuscript/images/`
   - Manual copy: Place all 10 files in `Manuscript/images/`
   - Add references manually in Chapter_05.md
   - Execute Prompt 16, Mode 3 to register them all at once

**Best practice:** Mode 1 is safer and more accurate. Mode 3 is faster if you're comfortable with manual setup.

### Workflow 3: Text-Based to Professional Upgrade

**Scenario:** You used Prompt 15 to create text-based tables during drafting. Now you have budget for a designer to create professional charts.

**Steps:**
1. Review `Image_Registry.md` upgrade recommendations
   - Check "High Priority" section
   - Identify which figures would benefit most
2. Work with designer to create professional versions
   - Provide the text-based `.md` files as reference
   - Request files in PNG or SVG format
   - Ensure files follow naming convention (or you'll rename)
3. For each professional image:
   - Execute Prompt 16, Mode 2
   - Provide figure number and source file path
   - Claude upgrades the figure, archives the old version
4. Result: Professional images replace text-based, all references updated

### Workflow 4: Pre-Export Validation

**Scenario:** You're ready to run Prompt 9 (Export to EPUB). You want to ensure all images are correct.

**Steps:**
1. Execute Prompt 16, Mode 4 (Validate)
   - Scope: All chapters
   - Fix mode: Report only
2. Review the validation report:
   - Fix any critical broken references
   - Add missing alt text
   - Register any unregistered images
3. Re-run validation until report shows no critical issues
4. Execute Prompt 8 (Consistency) for full manuscript check
5. Now safe to run Prompt 9 (Export)

---

## Anti-Hallucination Guidelines for Images

**CRITICAL: Apply these rules when working with image metadata:**

### Never Fabricate Image Content

**DO NOT:**
- ❌ Assume what's in an image without viewing it
- ❌ Generate fake alt text based on filename alone
- ❌ Invent captions without user input
- ❌ Guess image dimensions or file sizes

**DO:**
- ✅ Read actual image metadata using `file` command
- ✅ Get real file sizes using `ls -lh`
- ✅ Ask user for alt text and captions
- ✅ Mark inferred metadata clearly as "[INFERRED - VERIFY]"

### Image Description Protocol

**When scanning unregistered images (Mode 3):**

1. **Use actual file analysis:**
   ```bash
   file image.png  # Get format, dimensions, color space
   ls -lh image.png  # Get file size
   ```

2. **Infer metadata from context:**
   - Chapter reference (where it's used)
   - Filename (if descriptive)
   - Surrounding text in chapter

3. **Mark uncertainties:**
   ```markdown
   - **Type:** Screenshot [INFERRED - VERIFY]
   - **Alt Text:** "[PLACEHOLDER - User must provide descriptive alt text]"
   - **Caption:** "Figure X.Y: [NEEDS CAPTION]"
   ```

4. **Ask user to verify:**
   ```
   ⚠️ Inferred metadata for fig-03-02-photo.jpg:
   - Type: Photo (inferred from extension and context)
   - Alt text: [PLACEHOLDER]

   Please provide:
   1. Descriptive alt text for this image
   2. Full caption including "Figure 3.2: " prefix
   ```

### Real vs. Inferred Metadata

**Always label the source of metadata:**

```markdown
### fig-05-03-survey-chart
- **Figure:** 5.3
- **Title:** Survey Results Chart
- **Type:** Chart [USER PROVIDED] ✓
- **Status:** 🖼️ Professional image (PNG)
- **File:** `images/fig-05-03-survey-chart.png` [VERIFIED] ✓
- **Size:** 245 KB (1200x800px) [FILE SYSTEM] ✓
- **Referenced in:** Chapter_05.md:line 187 [GREP SCAN] ✓
- **Alt Text:** "Bar chart showing..." [USER PROVIDED] ✓
- **Caption:** "Figure 5.3: Survey results..." [USER PROVIDED] ✓
- **Created:** 2025-11-21 by Prompt 16 (Image Manager) [VERIFIED] ✓
- **Notes:** [USER PROVIDED] ✓
```

### Accessibility Alt Text Standards

**Alt text MUST be:**
- Descriptive of actual content (not filename)
- Specific about key information in charts/graphs
- Concise but complete (1-2 sentences)
- Provided by user or verified by user

**Examples:**

```markdown
❌ BAD (guessed from filename):
![survey-results](../images/fig-03-02-survey-results.png)

❌ BAD (too vague):
![A chart showing data](../images/fig-03-02-survey-results.png)

✅ GOOD (descriptive, user-provided):
![Bar chart showing survey responses: 45% strongly agree, 30% agree, 15% neutral, 10% disagree with the proposed framework](../images/fig-03-02-survey-results.png)
```

**When alt text is missing:**
1. Mark clearly: `![NEEDS ALT TEXT](../images/...)`
2. Request from user: "Please provide descriptive alt text for this image"
3. Never generate fake alt text based on filename alone

---

## Version History

**v0.12.5** (2025-11-21)
- Initial creation of Prompt 16 (Image Manager)
- Four operating modes: Add, Upgrade, Scan, Validate
- Unified visual system integration with Prompt 15
- Registry-based figure numbering coordination
- Semi-automated workflow (Level 2)
- Comprehensive image format and accessibility guidelines
- Integration with Prompts 1, 7, 8, 9, 10, 15

---

## Related Documentation

**Must Read:**
- `Process/_COMMON/15_Visual_Asset_Management_Protocol.md` - Complete visual asset system
- `Process/Anti-Hallucination_Guidelines.md` - Critical accuracy rules

**Related Prompts:**
- **Prompt 15:** Visual Content Suggester (text-based visuals)
- **Prompt 1:** Initialize (creates directory structure)
- **Prompt 8:** Consistency Checker (validates references)
- **Prompt 9:** Export (includes images in EPUB/PDF)

**Templates:**
- `Process/Templates/Image_Registry_template.md` - Registry structure

---

**END OF PROMPT 16**

---

## Quick Reference Card

```
PROMPT 16: IMAGE MANAGER - Quick Commands

Mode 1: Add Image
  "Add image to Chapter X"
  Needs: source file, type, location, alt text, caption

Mode 2: Upgrade Text-Based
  "Upgrade Figure X.Y to professional image"
  Needs: figure number, source file

Mode 3: Scan and Register
  "Scan for unregistered images"
  Finds and registers existing images

Mode 4: Validate References
  "Validate image references"
  Checks for broken links and missing files

Naming: fig-XX-YY-description.ext
Location: Manuscript/images/
Registry: Manuscript/images/Image_Registry.md

Integration:
- Prompt 15 creates 📝 text-based
- Prompt 16 adds 🖼️ professional images
- Both coordinate via registry
```

---

🤖 **This prompt is part of the AI-Assisted Nonfiction Authoring Framework v0.12.5**
📖 **For help:** See `Process/Prompts/README.md` or `Process/AI-Assisted_Nonfiction_Authoring_Process.md`
