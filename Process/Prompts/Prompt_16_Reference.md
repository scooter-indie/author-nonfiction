# Prompt 16 Reference Documentation

**Version:** 0.14.4
**Purpose:** Detailed examples, image format guidelines, and troubleshooting

---

## Overview

This reference provides detailed workflows, format guidelines, and troubleshooting for image management. Load when:
- First time using Prompt 16
- Adding complex image types
- Troubleshooting validation issues
- Understanding image specifications

**For core workflow:** See `Prompt_16_Image_Manager.md`

---

## Mode 1: Add Image - Full Example

### User Request
"Add the survey results chart to Chapter 3, after the methodology section"

### Interaction

**Claude asks:**
1. What's the source file path?
   > `~/Downloads/survey-chart.png`

2. Image type?
   > Chart

3. Describe the image (for alt text):
   > Bar chart showing survey responses with 45% agree, 30% neutral, 25% disagree

4. Caption text:
   > Survey results from 500 participants (2024 study)

### Execution

```bash
# 1. Determine next figure number
# Read registry: Chapter 3 has fig-03-01, fig-03-02
# Next: fig-03-03

# 2. Copy and rename
cp ~/Downloads/survey-chart.png Manuscript/images/fig-03-03-survey-results.png

# 3. Get dimensions
identify Manuscript/images/fig-03-03-survey-results.png
# Output: 1200x800 pixels, 245 KB
```

### Registry Entry Added

```markdown
### fig-03-03-survey-results
- **Figure:** 3.3
- **Title:** Survey Results Chart
- **Type:** Chart
- **Status:** 🖼️ Professional image (PNG)
- **File:** `images/fig-03-03-survey-results.png`
- **Size:** 245 KB (1200x800px)
- **Referenced in:** Chapter_03.md:156
- **Alt Text:** "Bar chart showing survey responses: 45% agree, 30% neutral, 25% disagree"
- **Caption:** "Figure 3.3: Survey results from 500 participants (2024 study)"
- **Created:** 2025-11-24 by Prompt 16 (Image Manager)
- **Upgrade Priority:** N/A (professional image)
- **Notes:** Data from Q2 2024 participant survey
```

### Chapter Reference Inserted

```markdown
The methodology section demonstrates our rigorous approach to data collection.

![Bar chart showing survey responses: 45% agree, 30% neutral, 25% disagree](../images/fig-03-03-survey-results.png)

**Figure 3.3:** Survey results from 500 participants (2024 study)

The results clearly indicate...
```

---

## Mode 2: Upgrade - Full Example

### User Request
"Upgrade fig-03-01 (the data table) to this new infographic"

### Before (Text-Based)

**Registry entry:**
```markdown
### fig-03-01-data-table
- **Status:** 📝 Text-based (Markdown)
- **File:** `images/fig-03-01-data-table.md`
- **Upgrade Priority:** High
```

**In chapter:**
```markdown
![Data comparison table](../images/fig-03-01-data-table.md)
```

### Execution

```bash
# 1. Archive old file
mv Manuscript/images/fig-03-01-data-table.md \
   Manuscript/images/_archive/fig-03-01-data-table_v1.md

# 2. Copy new image
cp ~/Downloads/data-infographic.png \
   Manuscript/images/fig-03-01-data-table.png
```

### After (Professional Image)

**Registry entry:**
```markdown
### fig-03-01-data-table
- **Status:** 🖼️ Professional image (PNG)
- **File:** `images/fig-03-01-data-table.png`
- **Size:** 380 KB (1600x1200px)
- **Upgrade Priority:** N/A (professional image)
- **Notes:** Upgraded from text-based on 2025-11-24
```

**In chapter:**
```markdown
![Data comparison infographic showing key metrics](../images/fig-03-01-data-table.png)
```

---

## Mode 3: Scan - Full Example

### Scan Results

```
📊 Scan Complete: Manuscript/images/

Found 5 unregistered files:
1. screenshot-login.png (245 KB) - No chapter reference found
2. chart-revenue.jpg (180 KB) - Referenced in Chapter_04.md:234
3. diagram-flow.svg (45 KB) - Referenced in Chapter_05.md:89
4. photo-team.jpg (890 KB) - Referenced in Chapter_01.md:45
5. old-draft.png (120 KB) - No reference, filename suggests draft

Action Required:
- Files 2, 3, 4: Ready to register (have chapter references)
- File 1: Needs chapter placement or deletion
- File 5: Likely obsolete - recommend deletion

Register files 2, 3, 4 now? (yes/no)
```

### After Registration

```
✓ Registered 3 images:
- fig-04-03-chart-revenue.jpg (Chapter 4)
- fig-05-02-diagram-flow.svg (Chapter 5)
- fig-01-02-photo-team.jpg (Chapter 1)

Remaining unregistered: 2 files (user decision required)
```

---

## Mode 4: Validate - Full Report

```markdown
## Image Validation Report

**Scan Date:** 2025-11-24
**Registry Mode:** Single (45 entries)

---

### ✓ VALID (40 images)

All references correct, files exist, registry accurate.

---

### ❌ CRITICAL (2 issues)

1. **fig-03-05-process.png**
   - Registry: Exists
   - File: ❌ NOT FOUND
   - Chapter reference: Chapter_03.md:234
   - Status: Broken reference
   - Fix: Restore file or remove reference

2. **Chapter_07.md:156**
   - References: `../images/fig-07-03-results.png`
   - Registry: ❌ No entry
   - File: ❌ NOT FOUND
   - Status: Orphaned reference
   - Fix: Add image or remove reference

---

### ⚠️ WARNINGS (3 issues)

1. **fig-03-03-comparison.md**
   - Registry: Chapter_03.md:line 100
   - Actual: Chapter_03.md:line 108
   - Fix: Update registry line number

2. **fig-04-02-screenshot.png**
   - Missing alt text (empty brackets)
   - Fix: Add descriptive alt text

3. **fig-06-01-diagram.png**
   - File exists but not referenced
   - Status: Orphaned file
   - Fix: Add reference or remove file

---

### 📊 STATISTICS

| Category | Count | % |
|----------|-------|---|
| Valid | 40 | 89% |
| Critical | 2 | 4% |
| Warnings | 3 | 7% |

**Naming Convention:**
- Following: 43 (96%)
- Non-standard: 2 (4%)

**Accessibility:**
- With alt text: 41 (91%)
- Missing alt text: 4 (9%)
- With captions: 38 (84%)

---

### Recommendations

1. **Immediate:** Fix 2 critical broken references
2. **High:** Add alt text to 4 images
3. **Medium:** Update 3 registry line numbers
4. **Low:** Review 1 orphaned file
```

---

## Supported Image Formats

### Recommended Formats

| Format | Best For | Max Size | Notes |
|--------|----------|----------|-------|
| JPEG (.jpg) | Photos | 2 MB | Lossy, good compression |
| PNG (.png) | Screenshots, diagrams | 2 MB | Lossless, transparency |
| SVG (.svg) | Vector diagrams | 500 KB | Scalable, small size |
| WebP (.webp) | Web-optimized | 2 MB | Check reader support |

### Image Specifications for EPUB

| Specification | Requirement |
|---------------|-------------|
| Max dimensions | 1600x2560px |
| Max file size | 2 MB per image |
| Color mode | RGB (not CMYK) |
| Resolution | 72-150 DPI |
| Format | JPEG, PNG preferred |

### Cover Image Requirements

| Specification | Requirement |
|---------------|-------------|
| Dimensions | 1600x2560px minimum |
| Aspect ratio | 1:1.6 (standard EPUB) |
| Format | JPEG or PNG |
| File size | < 5 MB |
| File name | `cover.jpg` or `cover.png` |

---

## Alt Text Guidelines

### Good Alt Text

**Describes content and purpose:**
```markdown
![Bar chart showing survey responses: 45% agree, 30% neutral, 25% disagree](...)
```

**Includes key data:**
```markdown
![Line graph showing revenue growth from $1M in 2020 to $5M in 2024](...)
```

**Mentions important details:**
```markdown
![Screenshot of dashboard settings panel with three toggle options highlighted](...)
```

### Bad Alt Text

```markdown
❌ ![Image](...)
❌ ![fig-03-02-survey-results](...)
❌ ![Chart](...)
❌ ![](...)
```

---

## Caption Guidelines

### Standard Format

```markdown
**Figure X.Y:** Caption describing the figure's content and significance.
```

### Examples

```markdown
**Figure 3.2:** Survey results from 500 participants showing strong preference for hybrid work models (2024 study).

**Figure 5.1:** The three-phase implementation process, highlighting key decision points.

**Figure 7.3:** Team photo from the 2024 annual conference in Boston.
```

---

## Registry Split Details

### When to Split

| Entries | Status | Action |
|---------|--------|--------|
| < 100 | Optimal | No action needed |
| 100-199 | Good | Monitor growth |
| 200-299 | Warning | Consider splitting |
| 300-399 | Recommend | Split recommended |
| 400+ | Critical | Split required |

### Split File Structure

```
Manuscript/images/
├── Image_Registry.md                    # Master index
├── Image_Registry_Chapter_01.md         # Chapter 1 images
├── Image_Registry_Chapter_02.md         # Chapter 2 images
├── Image_Registry_Chapter_03.md         # Chapter 3 images
├── Image_Registry_Frontmatter.md        # Cover, author photo
├── Image_Registry_LEGACY_2025-11-24.md  # Archived original
└── [image files...]
```

### Master Index Format

```markdown
# Image Registry (Master Index)

**Registry Type:** Split (Chapter-Based)
**Total Images:** 347
**Split Date:** 2025-11-24

## Registry Distribution

| Chapter | Registry File | Images | Last Updated |
|---------|--------------|--------|--------------|
| Frontmatter | Image_Registry_Frontmatter.md | 3 | 2025-11-24 |
| Chapter 01 | Image_Registry_Chapter_01.md | 23 | 2025-11-24 |
| Chapter 02 | Image_Registry_Chapter_02.md | 45 | 2025-11-24 |
...
```

📖 **Full split algorithm:** See `Process/_COMMON/19_Image_Registry_Splitting_Module.md`

---

## Troubleshooting

### Issue: "File not found" during add

**Cause:** Source path incorrect or file moved
**Fix:** Verify file exists at specified path

### Issue: Image doesn't display in export

**Causes:**
1. Path incorrect (use `../images/` from chapter)
2. File extension case mismatch (`.PNG` vs `.png`)
3. Image too large for EPUB reader

**Fix:** Validate with Mode 4, check path format

### Issue: Registry out of sync

**Cause:** Manual file operations
**Fix:** Run Mode 3 (Scan) then Mode 4 (Validate)

### Issue: Split validation failed

**Cause:** Entry parsing error
**Fix:** Check legacy file, manually verify counts

### Issue: Lock conflict

**Cause:** Another operation in progress
**Fix:** Wait or override stale lock (>15 min)

---

## Module References

- **Visual Asset Protocol:** Process/_COMMON/15_Visual_Asset_Management_Protocol.md
- **Registry Splitting:** Process/_COMMON/19_Image_Registry_Splitting_Module.md
- **Lock Management:** Process/_COMMON/18_Lock_Management_Module.md
- **Anti-Hallucination:** Process/Anti-Hallucination_Guidelines.md

---

**Version:** 0.14.4
**For Core Workflow:** See `Prompt_16_Image_Manager.md`
