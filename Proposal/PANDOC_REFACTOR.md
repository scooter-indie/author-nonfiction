# Pandoc EPUB Export & Unified Visual System Refactor

**Status:** Proposal
**Target Version:** 0.12.0
**Created:** 2025-11-21
**Updated:** 2025-11-21
**Priority:** High

---

## Table of Contents

1. [Purpose](#purpose)
2. [Problems Identified](#problems-identified)
3. [Part 1: Unified Visual Asset System](#part-1-unified-visual-asset-system)
4. [Part 2: EPUB Export Improvements](#part-2-epub-export-improvements)
5. [Part 3: Prompt Renumbering](#part-3-prompt-renumbering)
6. [Implementation Checklist](#implementation-checklist)
7. [Breaking Changes](#breaking-changes)
8. [Success Criteria](#success-criteria)

---

## Purpose

This refactor accomplishes three interconnected goals:

1. **Unify visual asset management** - Consolidate text-based visual suggestions and actual image files into a single, simple directory structure
2. **Optimize EPUB export** - Enable proper Pandoc EPUB generation with metadata, styling, and image handling
3. **Improve organization** - Renumber prompts for better logical flow and create dedicated image management workflow

---

## Problems Identified

### Problem 1: Complex, Fragmented Visual Asset System

**Current State:**
- Prompt 14 creates text-based visuals in per-chapter `Chapter_XX/figures/` subdirectories
- No system for managing actual image files (photos, screenshots, graphics)
- Complex path structure makes Typora preview and EPUB export difficult
- Confusing for users: "where do I put images?"

**Impact:**
- Authors manually place images without tracking
- Images not properly referenced or registered
- Complex paths break in Pandoc/EPUB export
- No unified view of all visual assets

### Problem 2: Image Path Resolution for EPUB

**Current State:**
- Per-chapter `figures/` subdirectories with relative paths
- Compiled markdown references like `![](figures/image.png)` don't resolve in EPUB
- Pandoc requires proper resource paths from compiled draft location

**Impact:**
- Images won't display in generated EPUBs
- Complex post-processing needed to rewrite paths
- Not user-friendly for authors using Typora

### Problem 3: Missing EPUB Metadata and Styling

**Current State:**
- No EPUB metadata fields in `Project_Config.md` (ISBN, publisher, language)
- No default CSS template for EPUB styling
- Missing Copyright and About Author pages
- No standardized cover image location

**Impact:**
- Unprofessional EPUBs missing critical metadata
- Inconsistent appearance across e-readers
- Incomplete front/back matter structure

### Problem 4: Logical Organization of Prompts

**Current State:**
- Prompt 14 (Visual Content Suggester) is 965 lines - very complex
- Prompt 15 (Citation Finder) is 937 lines - simpler, more focused
- No dedicated image management prompt
- Numbering doesn't reflect complexity/workflow order

**Impact:**
- Confusing prompt sequence
- Missing functionality for actual image management
- Large complex prompt at Prompt 14 position

---

## Part 1: Unified Visual Asset System

### Overview

**Goal:** Consolidate all visual assets (text-based suggestions AND actual images) into a single, flat directory with unified tracking.

**Key Decision:** Merge Prompt 14's text-based visual system and new image management into one directory structure.

---

### Change 1.1: New Directory Structure

**From (Current - Complex):**
```
Manuscript/
├── Chapters/
│   ├── Chapter_01/
│   │   ├── Chapter_01.md
│   │   ├── Chapter_01_chg.md
│   │   └── figures/                    # Per-chapter subdirectory
│   │       ├── README.md               # Per-chapter registry
│   │       ├── fig_01_01_table.md
│   │       └── fig_01_02_diagram.md
│   └── Chapter_02/
│       └── figures/
│           └── ...
```

**To (New - Unified):**
```
Manuscript/
├── images/                              # Single flat directory
│   ├── Image_Registry.md                # Single unified registry
│   ├── fig-01-01-table.md              # Text-based table (Prompt 15)
│   ├── fig-01-02-photo.jpg             # Actual photo (Prompt 16)
│   ├── fig-02-01-diagram.md            # ASCII diagram (Prompt 15)
│   ├── fig-02-02-screenshot.png        # Screenshot (Prompt 16)
│   ├── fig-03-01-chart.png             # Professional graphic (Prompt 16)
│   └── cover.jpg                        # Book cover
└── Chapters/
    ├── Chapter_01.md                    # No subdirectories
    ├── Chapter_01_chg.md
    ├── Chapter_02.md
    └── Chapter_02_chg.md
```

**Benefits:**
- ✅ Single location for all visual assets
- ✅ Flat structure works perfectly in Typora
- ✅ Simple relative paths: `../images/fig-03-01-photo.jpg`
- ✅ Pandoc-friendly: `--resource-path=Manuscript`
- ✅ No complex path rewriting needed during export
- ✅ Easy to see all visuals at once
- ✅ One registry to track everything

---

### Change 1.2: Unified Naming Convention

**Format:** `fig-XX-YY-description.ext`

**Components:**
- `fig` - Prefix for all visual assets
- `XX` - Chapter number (zero-padded: 01, 02, ..., 99)
- `YY` - Sequential figure number within chapter (01, 02, ...)
- `description` - Brief descriptor (lowercase, hyphens)
- `ext` - Extension indicating type/status:
  - `.md` = Text-based placeholder (markdown table, ASCII diagram, mermaid flowchart)
  - `.jpg` = Photo or complex image
  - `.png` = Screenshot, diagram with transparency, professional graphic
  - `.svg` = Vector graphic (scalable)

**Examples:**
- `fig-03-01-survey-comparison.md` - Text-based table from Prompt 15
- `fig-03-02-lab-photo.jpg` - Actual photo added via Prompt 16
- `fig-05-01-workflow-diagram.md` - ASCII diagram from Prompt 15
- `fig-05-02-architecture.png` - Professional graphic via Prompt 16
- `cover.jpg` - Book cover image

**Special files:**
- `cover.jpg` or `cover.png` - Book cover (no fig- prefix)
- `Image_Registry.md` - Central registry

---

### Change 1.3: Unified Registry Format

**File:** `Manuscript/images/Image_Registry.md`

**Purpose:** Single source of truth for all visual assets in the book

**Format:**

```markdown
# Visual Asset Registry

**Last Updated:** 2025-11-21
**Total Assets:** 15
**By Status:** 8 📝 text-based, 7 🖼️ images
**By Type:** 4 Tables, 3 Photos, 3 Diagrams, 2 Screenshots, 2 Charts, 1 Cover

---

## Chapter 01: Introduction

### fig-01-01-research-timeline
- **Figure:** 1.1
- **Title:** Research Project Timeline
- **Type:** Table
- **Status:** 📝 Text-based (markdown table)
- **File:** `images/fig-01-01-research-timeline.md`
- **Referenced in:** Chapter_01.md:45
- **Alt Text:** "Timeline showing research phases from 2020-2023"
- **Caption:** "Figure 1.1: Four-phase research timeline with key milestones"
- **Created:** 2025-11-15 by Prompt 15 (Visual Content Suggester)
- **Upgrade Priority:** Medium
- **Notes:** Functional as text-based table, could be designed graphic

---

### fig-01-02-lab-setup
- **Figure:** 1.2
- **Title:** Laboratory Equipment Setup
- **Type:** Photo
- **Status:** 🖼️ Professional image (JPG)
- **File:** `images/fig-01-02-lab-setup.jpg`
- **Size:** 892 KB (2400x1600px)
- **Referenced in:** Chapter_01.md:120
- **Alt Text:** "Laboratory showing spectroscopy equipment and sample preparation area"
- **Caption:** "Figure 1.2: Equipment configuration used for all experiments"
- **Created:** 2025-11-16 by Prompt 16 (Image Manager)
- **Upgrade Priority:** N/A (final)
- **Notes:** High-res photo, original in Research/Assets/photos/

---

## Chapter 02: Methodology

### fig-02-01-data-workflow
- **Figure:** 2.1
- **Title:** Data Processing Workflow
- **Type:** Diagram
- **Status:** 📝 Text-based (ASCII diagram)
- **File:** `images/fig-02-01-data-workflow.md`
- **Referenced in:** Chapter_02.md:67
- **Alt Text:** "Flowchart showing data processing from collection through analysis"
- **Caption:** "Figure 2.1: Five-stage data processing pipeline"
- **Created:** 2025-11-17 by Prompt 15 (Visual Content Suggester)
- **Upgrade Priority:** High
- **Notes:** Complex workflow - professional flowchart highly recommended

---

## Front Matter

### cover
- **Figure:** N/A (Cover)
- **Title:** Book Cover
- **Type:** Cover Image
- **Status:** 🖼️ Professional image (JPG)
- **File:** `images/cover.jpg`
- **Size:** 1.2 MB (1600x2560px)
- **Referenced in:** EPUB export, Title Page
- **Alt Text:** "[Book Title] by [Author Name]"
- **Caption:** N/A
- **Created:** 2025-11-10 by author
- **Upgrade Priority:** N/A (final)
- **Notes:** Professional design by [Designer Name], meets EPUB specs

---

## Upgrade Recommendations

### High Priority (Professional graphic recommended)
- **fig-02-01-data-workflow** - Complex flowchart, hard to represent in ASCII

### Medium Priority (Would benefit from design)
- **fig-01-01-research-timeline** - Timeline would be clearer as visual
- **fig-03-02-comparison-table** - Table could use visual styling

### Low Priority (Text-based adequate)
- **fig-04-01-simple-checklist** - Simple table works fine as markdown

---

## Statistics

**By Chapter:**
- Chapter 1: 2 figures (1 📝, 1 🖼️)
- Chapter 2: 1 figure (1 📝)
- Chapter 3: 3 figures (2 📝, 1 🖼️)
- ...

**By Status:**
- 📝 Text-based: 8 (53%)
- 🖼️ Professional: 7 (47%)

**By Type:**
- Tables: 4
- Photos: 3
- Diagrams: 3
- Screenshots: 2
- Charts: 2
- Cover: 1

**Total Size:** 12.3 MB
**Average Size:** 820 KB per image

---

**Maintained by:** Prompt 15 (Visual Content Suggester) and Prompt 16 (Image Manager)
**Last validated:** 2025-11-21 by Prompt 8 (Consistency Checker)
```

---

### Change 1.4: Two-Level Status Tracking

**Status Codes (What it is):**
- 📝 **Text-based** - Markdown table, ASCII diagram, mermaid flowchart (can be upgraded)
- 🖼️ **Professional image** - JPG, PNG, SVG (final version)

**Type Categories (What kind):**
- Table
- Diagram
- Photo
- Screenshot
- Chart
- Flowchart
- Infographic
- Cover

**Examples:**
- Status: 📝, Type: Table → Text-based markdown table
- Status: 🖼️, Type: Photo → Actual photograph
- Status: 📝, Type: Diagram → ASCII diagram awaiting professional version
- Status: 🖼️, Type: Chart → Professionally designed chart

---

### Change 1.5: Reference Format in Chapters

**Standard markdown image syntax:**

```markdown
In this section, we examine the research timeline
![Timeline showing research phases from 2020-2023](../images/fig-01-01-research-timeline.md)
as shown in Figure 1.1.

The laboratory setup
![Laboratory showing spectroscopy equipment and sample preparation area](../images/fig-01-02-lab-setup.jpg)
was configured according to manufacturer specifications.
```

**Benefits:**
- ✅ Works in Typora preview
- ✅ Works in any markdown editor
- ✅ Pandoc converts to proper `<img>` or figure blocks
- ✅ Alt text for accessibility
- ✅ Simple relative paths from `Manuscript/Chapters/` → `Manuscript/images/`

---

### Change 1.6: Upgrade Path (Text → Image)

**Process for upgrading text-based visual to professional image:**

1. **Identify figure for upgrade** (check registry Upgrade Priority)

2. **Create professional version:**
   - Use design tools (Figma, Canva, Adobe, etc.)
   - Export as PNG/JPG/SVG
   - Use same filename, change extension: `fig-03-01-table.png`

3. **Save to `Manuscript/images/`:**
   ```
   images/
   ├── fig-03-01-table.md    # Original text-based
   ├── fig-03-01-table.png   # New professional version
   ```

4. **Update chapter reference:**
   ```markdown
   # OLD:
   ![Survey method comparison table](../images/fig-03-01-table.md)

   # NEW:
   ![Survey method comparison table](../images/fig-03-01-table.png)
   ```

5. **Update registry via Prompt 16:**
   - Change Status: 📝 → 🖼️
   - Change File extension: .md → .png
   - Add file size and dimensions
   - Update Created date
   - Set Upgrade Priority: N/A

6. **Optional:** Keep or remove `.md` file
   - Keep: Preserves version history and specifications
   - Remove: Cleaner directory

---

## Part 2: EPUB Export Improvements

### Change 2.1: Simplified Image Handling in Export

**Location:** `Process/Prompts/Prompt_9_Export.md`

**Implementation:**

With the new unified `Manuscript/images/` directory, export is drastically simplified:

```bash
# Step: Copy images for EPUB
cp -r "Manuscript/images" "${OUTPUT_DIR}/images"

# Remove registry file from export (not needed in EPUB)
rm -f "${OUTPUT_DIR}/images/Image_Registry.md"

# Pandoc command - images just work!
"${PANDOC_PATH}" "${DRAFT_FILE}" \
  -o "${OUTPUT_DIR}/${BOOK_TITLE}.epub" \
  --resource-path="Manuscript:${OUTPUT_DIR}" \
  --epub-cover-image="Manuscript/images/cover.jpg" \
  --metadata title="${BOOK_TITLE}" \
  --metadata author="${AUTHOR_NAME}" \
  --metadata lang="en-US" \
  --toc \
  --toc-depth=2 \
  --css="Manuscript/Style/epub.css" \
  --standalone
```

**That's it!** No complex path rewriting, no renaming, no chapter tracking.

**Benefits:**
- ✅ Simple copy operation
- ✅ Paths in compiled markdown work as-is: `../images/fig-01-01.jpg`
- ✅ Pandoc resolves paths correctly with `--resource-path`
- ✅ No sed/awk post-processing needed

---

### Change 2.2: EPUB Metadata in Project_Config.md

**Location:** `Process/Templates/manifest_template.json` and `Process/Prompts/Prompt_1_Initialize.md`

**Add to Project_Config.md during initialization:**

```markdown
## EPUB Export Settings

### Metadata
- **Identifier:** [ISBN or UUID - unique book identifier]
- **Language:** en-US
- **Publisher:** [Publisher name or "Self-Published"]
- **Publication Date:** [YYYY-MM-DD or "TBD"]
- **Rights:** Copyright © [YEAR] [AUTHOR]. All rights reserved.
- **Cover Image:** Manuscript/images/cover.jpg
- **Description:** [Book description for EPUB metadata - 1-2 sentences]

### Styling
- **CSS File:** Manuscript/Style/epub.css
- **Custom Fonts:** Manuscript/Style/fonts/ (optional)
- **Font Embedding:** true

### Structure
- **TOC Depth:** 2 (1=chapters only, 2=chapters+sections, 3=subsections)
- **Include Front Matter:** Title Page, Copyright, Dedication, TOC, Foreword, Preface, Acknowledgments
- **Include Back Matter:** Appendices, Glossary, Bibliography, About the Author
```

**Prompt 1 Questions to Add:**

```
8. What is your book's ISBN? (or "Generate UUID" for unique identifier)
9. Who is the publisher? (or "Self-Published")
10. What is the publication date? (or "TBD")
```

**UUID Generation in Prompt 1:**

```bash
# If user chose "Generate UUID"
BOOK_UUID=$(uuidgen 2>/dev/null || cat /proc/sys/kernel/random/uuid 2>/dev/null || echo "$(date +%s)-$(( RANDOM ))")
# Write to Project_Config.md: Identifier: urn:uuid:$BOOK_UUID
```

---

### Change 2.3: EPUB CSS Template

**Location:** `Process/Templates/epub-style.css` (new file)

**Create default EPUB stylesheet** (full CSS in implementation section below)

**Copy during Prompt 1 initialization:**
```bash
cp "Process/Templates/epub-style.css" "Manuscript/Style/epub.css"
```

---

### Change 2.4: Cover Image Standardization

**Location:** `Manuscript/images/cover.jpg`

**During Prompt 1, create placeholder:**

```bash
# Create placeholder cover image file marker
cat > "Manuscript/images/cover.jpg" <<'COVER_INFO'
PLACEHOLDER: Replace this file with your book cover image.

Requirements:
- Format: JPG or PNG
- Minimum size: 1600 x 2560 pixels (portrait)
- Aspect ratio: 1:1.6 (standard book cover)
- File size: Under 2MB recommended
- Resolution: 300 DPI for print, 72 DPI acceptable for EPUB

Recommended:
- Use professional cover design
- Include title and author name
- Ensure text is readable at thumbnail size
COVER_INFO
```

**Update Prompt 9 to validate cover:**

```bash
# Validate cover image exists and is valid
if [ ! -f "Manuscript/images/cover.jpg" ] && [ ! -f "Manuscript/images/cover.png" ]; then
  echo "⚠️  WARNING: No cover image found"
  echo "    Add cover.jpg (1600x2560px) to Manuscript/images/"
  COVER_ARG=""
else
  COVER_PATH=$(ls Manuscript/images/cover.{jpg,png} 2>/dev/null | head -1)

  # Check if it's the placeholder text file
  if file "$COVER_PATH" | grep -q "ASCII text"; then
    echo "⚠️  WARNING: Cover image is placeholder text file"
    echo "    Replace with actual JPG/PNG image"
    COVER_ARG=""
  else
    COVER_ARG="--epub-cover-image=${COVER_PATH}"
  fi
fi
```

---

### Change 2.5: Copyright and About Author Templates

**Location:** `Process/Templates/` (new templates)

**Create `Copyright_template.md`:**

```markdown
# Copyright

Copyright © [YEAR] by [AUTHOR NAME]. All rights reserved.

No part of this publication may be reproduced, distributed, or transmitted in any form or by any means, including photocopying, recording, or other electronic or mechanical methods, without the prior written permission of the publisher, except in the case of brief quotations embodied in critical reviews and certain other noncommercial uses permitted by copyright law.

**Publisher:** [PUBLISHER NAME or "Self-Published"]

**ISBN:** [ISBN NUMBER or "Not yet assigned"]

**First Edition:** [PUBLICATION DATE or "TBD"]

---

**Disclaimer:**

[Add any necessary disclaimers here - e.g., "The information in this book is provided for educational purposes only..." or "Names and identifying details have been changed to protect privacy..."]

---

**Contact:**

For permissions requests, write to the publisher at:

[CONTACT EMAIL or ADDRESS]

---

[ADDITIONAL COPYRIGHT NOTICES OR CREDITS]
```

**Create `About_Author_template.md`:**

```markdown
# About the Author

[AUTHOR PHOTO - Optional: Place image at Manuscript/images/author-photo.jpg]

**[AUTHOR NAME]** is [brief bio - 2-3 sentences about professional background, expertise, credentials].

[Longer bio - 1-2 paragraphs about author's work, experience, achievements, and why they're qualified to write this book]

[Optional: Personal details that humanize the author - where they live, hobbies, family, etc.]

---

## Connect with the Author

- **Website:** [URL]
- **Email:** [EMAIL]
- **Twitter/X:** [@handle]
- **LinkedIn:** [profile URL]
- **Other Social Media:** [platforms and handles]

---

## Other Books by [AUTHOR NAME]

[List previous publications if applicable, or remove this section]

- *Book Title 1* (Year)
- *Book Title 2* (Year)

---

[Optional: Call to action - "For more resources, visit..." or "Subscribe to newsletter at..."]
```

**Prompt 1 creates these during initialization** with user info populated.

---

### Change 2.6: Update Compilation Order (Prompt 7)

**Update front and back matter order:**

```markdown
**Front Matter order:**
1. Title Page
2. Copyright (NEW)
3. Dedication
4. Table of Contents (auto-generated)
5. Foreword
6. Preface
7. Acknowledgments

**Back Matter order:**
1. Appendices
2. Glossary
3. Bibliography
4. Index
5. About the Author (NEW)
```

---

## Part 3: Prompt Renumbering

### Change 3.1: Swap Prompts 14 and 15

**Rationale:**
- Current Prompt 15 (Citation Finder - 937 lines) is simpler and more focused
- Current Prompt 14 (Visual Content Suggester - 965 lines) is complex and large
- Better logical flow: Citations (14) → Visual Content (15) → Image Management (16)

**Changes:**

**Current:**
- `Prompt_14_Visual_Content_Suggester.md` (965 lines)
- `Prompt_15_Citation_Finder.md` (937 lines)

**New:**
- `Prompt_14_Citation_Finder.md` (937 lines) - MOVED FROM 15
- `Prompt_15_Visual_Content_Suggester.md` (965 lines) - MOVED FROM 14
- `Prompt_16_Image_Manager.md` (NEW)

**File operations:**
```bash
# Rename files
mv Process/Prompts/Prompt_14_Visual_Content_Suggester.md Process/Prompts/Prompt_15_Visual_Content_Suggester.md
mv Process/Prompts/Prompt_15_Citation_Finder.md Process/Prompts/Prompt_14_Citation_Finder.md
```

**Update references in:**
- `CLAUDE.md` - Update prompt list
- `QUICK_REFERENCE.md` - Update prompt numbers
- `Process/Prompts/README.md` - Update prompt index
- All prompts that reference 14 or 15
- Module 15 (Visual Asset Management Protocol)

---

### Change 3.2: New Prompt 16 - Image Manager

**File:** `Process/Prompts/Prompt_16_Image_Manager.md`

**Purpose:** Manage actual image files (photos, screenshots, professional graphics)

**Automation Level:** Semi-automated
- Claude asks questions and performs file operations
- User controls placement and confirms actions
- Balance of convenience and control

**Core Functionality:**

#### Mode 1: Add Image to Chapter
1. Ask which chapter
2. Ask for image source (Inbox/, external path, already in images/)
3. Ask for type (Photo, Screenshot, Diagram, Chart, etc.)
4. Ask for description (generates filename: `fig-XX-YY-description.ext`)
5. Ask for alt text (accessibility)
6. Ask for caption (optional, figure numbering)
7. **Claude performs:**
   - Copies/moves image to `Manuscript/images/fig-XX-YY-description.ext`
   - Reads `Image_Registry.md` to determine next figure number
   - Updates `Image_Registry.md` with new entry (🖼️ status)
   - Generates markdown snippet
8. Ask user where to insert
9. **Claude inserts** (if user confirms) using Edit tool
10. **Claude commits** to git

#### Mode 2: Upgrade Text-Based to Professional Image
1. Show list of 📝 text-based figures from registry
2. User selects figure to upgrade
3. Ask for image source
4. **Claude performs:**
   - Copies image with same base filename, new extension
   - Updates registry entry: 📝 → 🖼️
   - Updates chapter reference: .md → .png/.jpg
   - Optionally removes old .md file
5. **Claude commits** to git

#### Mode 3: Scan and Register Existing Images
1. Scan `Manuscript/images/` for image files not in registry
2. For each unregistered image:
   - Ask user for details (chapter, type, alt text, caption)
   - Add to registry
3. Scan chapters for image references not in registry
4. Report orphaned images and broken references
5. **Claude commits** updated registry

#### Mode 4: Validate Image References
1. Read `Image_Registry.md`
2. Check all images exist in `Manuscript/images/`
3. Check all chapter references point to existing files
4. Report:
   - Missing images (referenced but not found)
   - Orphaned images (exist but not referenced)
   - Images missing alt text
   - Oversized images (>2MB warning for EPUB)

**Registry Coordination:**
- Both Prompt 15 and 16 read `Image_Registry.md` before adding figures
- Find highest YY number for chapter XX
- Use next sequential number
- Registry is source of truth for figure numbering

**Integration with Prompt 15:**
- Prompt 15 creates text-based suggestions (tables, diagrams, flowcharts)
- Prompt 16 adds actual images (photos, screenshots, professional graphics)
- Both update same `Image_Registry.md`
- Same naming convention: `fig-XX-YY-description.ext`
- User can upgrade from 15's text-based to 16's professional image

---

### Change 3.3: Update Module 15 - Visual Asset Management Protocol

**Location:** `Process/_COMMON/15_Visual_Asset_Management_Protocol.md`

**Changes needed:**

1. **Update directory structure** to `Manuscript/images/` (single flat directory)
2. **Update naming convention** to `fig-XX-YY-description.ext` (hyphens instead of underscores)
3. **Update registry format** to unified `Image_Registry.md` (not per-chapter)
4. **Update reference format** to use standard markdown image syntax
5. **Add coordination protocol** between Prompt 15 and 16
6. **Expand scope** to cover both text-based and actual images
7. **Update status tracking** to two-level system (Status + Type)
8. **Update "Used by" section:**
   - Prompt 15 (Visual Content Suggester) - primary creator of text-based
   - Prompt 16 (Image Manager) - primary creator of actual images
   - Prompt 8 (Consistency) - reporter
   - Prompts 3/4 (Change/Interactive) - updaters
   - Prompt 7 (Compile) - consumer
   - Prompt 9 (Export) - consumer

---

### Change 3.4: Update Prompt 15 for Unified System

**Location:** `Process/Prompts/Prompt_15_Visual_Content_Suggester.md`

**Changes needed:**

1. **Update directory references:**
   - FROM: `Manuscript/Chapters/Chapter_XX/figures/`
   - TO: `Manuscript/images/`

2. **Update file naming:**
   - FROM: `fig_XX_YY_description.md`
   - TO: `fig-XX-YY-description.md`

3. **Update registry references:**
   - FROM: `Chapter_XX/figures/README.md` (per-chapter)
   - TO: `Manuscript/images/Image_Registry.md` (unified)

4. **Add registry coordination:**
   - Read `Image_Registry.md` before creating figures
   - Find next figure number for chapter
   - Update unified registry (not per-chapter)

5. **Update reference format:**
   - FROM: `[See: figures/fig_03_01_table.md]`
   - TO: `![Alt text](../images/fig-03-01-table.md)`

6. **Add integration notes:**
   - Mention Prompt 16 for actual images
   - Explain upgrade path from text-based (.md) to image (.png/.jpg)
   - Note that both prompts work with same registry

7. **Remove per-chapter registry creation:**
   - Don't create `figures/README.md`
   - Update single `Image_Registry.md` instead

---

## Implementation Checklist

### Phase 1: Templates and Structure

- [ ] Create `Process/Templates/epub-style.css` with full CSS
- [ ] Create `Process/Templates/Copyright_template.md`
- [ ] Create `Process/Templates/About_Author_template.md`
- [ ] Create `Process/Templates/Image_Registry_template.md`

### Phase 2: Update Module 15

- [ ] Update directory structure to `Manuscript/images/`
- [ ] Update naming convention to hyphens
- [ ] Update to unified registry format
- [ ] Add coordination protocol for Prompt 15 & 16
- [ ] Update status tracking to two-level system
- [ ] Update "Used by" section with new prompt numbers
- [ ] Add reference to Prompt 16

### Phase 3: Prompt Renumbering

- [ ] Rename `Prompt_14_Visual_Content_Suggester.md` → `Prompt_15_Visual_Content_Suggester.md`
- [ ] Rename `Prompt_15_Citation_Finder.md` → `Prompt_14_Citation_Finder.md`
- [ ] Update `CLAUDE.md` prompt list with new numbers
- [ ] Update `QUICK_REFERENCE.md` with new numbers
- [ ] Update `Process/Prompts/README.md` index
- [ ] Update cross-references in all prompts mentioning 14/15
- [ ] Update system-instructions.md if it references prompt numbers

### Phase 4: Update Prompt 15 (Visual Content Suggester)

- [ ] Update all directory references to `Manuscript/images/`
- [ ] Update file naming to `fig-XX-YY-description.md`
- [ ] Update registry references to unified `Image_Registry.md`
- [ ] Add registry coordination logic (read, find next number)
- [ ] Update reference format to markdown image syntax
- [ ] Add integration notes for Prompt 16
- [ ] Remove per-chapter registry creation code
- [ ] Test text-based visual creation workflow

### Phase 5: Create Prompt 16 (Image Manager)

- [ ] Create `Process/Prompts/Prompt_16_Image_Manager.md`
- [ ] Implement Mode 1: Add Image to Chapter
- [ ] Implement Mode 2: Upgrade Text-Based to Image
- [ ] Implement Mode 3: Scan and Register Existing
- [ ] Implement Mode 4: Validate Image References
- [ ] Add registry coordination (read, find next number)
- [ ] Add semi-automated workflow (ask, perform, confirm, commit)
- [ ] Add integration notes for Prompt 15
- [ ] Test all four modes

### Phase 6: Update Prompt 1 (Initialize)

- [ ] Add `Manuscript/images/` directory creation
- [ ] Remove per-chapter `figures/` subdirectory creation
- [ ] Create `Image_Registry.md` from template
- [ ] Add EPUB metadata questions (ISBN, publisher, date)
- [ ] Add EPUB section to `Project_Config.md` template
- [ ] Copy `epub-style.css` to `Manuscript/Style/epub.css`
- [ ] Create `Copyright.md` + `_chg.md` from template
- [ ] Create `About_Author.md` + `_chg.md` from template
- [ ] Create cover placeholder at `Manuscript/images/cover.jpg`
- [ ] Update `_TOC_/TOC.md` to reference Copyright and About_Author
- [ ] Test initialization creates correct structure

### Phase 7: Update Prompt 7 (Compile)

- [ ] Update image path references for unified `images/` directory
- [ ] Update front matter order (add Copyright after Title Page)
- [ ] Update back matter order (add About_Author at end)
- [ ] Implement fixed-order compilation arrays
- [ ] Test compilation with new structure

### Phase 8: Update Prompt 9 (Export)

- [ ] Simplify image copying to flat `cp -r Manuscript/images/`
- [ ] Remove complex path rewriting (no longer needed!)
- [ ] Add cover image validation and warnings
- [ ] Update Pandoc command with EPUB metadata from config
- [ ] Add CSS embedding: `--css=Manuscript/Style/epub.css`
- [ ] Update resource path: `--resource-path=Manuscript`
- [ ] Add font embedding if exists: `--epub-embed-font=Manuscript/Style/fonts/*.ttf`
- [ ] Test EPUB generation with images

### Phase 9: Update Prompt 8 (Consistency)

- [ ] Update visual asset checks for unified `images/` directory
- [ ] Read `Image_Registry.md` for validation
- [ ] Report 📝 vs 🖼️ distribution
- [ ] Check for missing images
- [ ] Check for orphaned images
- [ ] Check for missing alt text
- [ ] Report upgrade recommendations
- [ ] Test consistency checking

### Phase 10: Update Prompt 2 (Add Chapter)

- [ ] Remove creation of per-chapter `figures/` subdirectory
- [ ] Test chapter creation doesn't create figures directory

### Phase 11: Documentation

- [ ] Update `USAGE_GUIDE.md` template with:
  - Visual asset management section
  - EPUB requirements section
  - Image best practices
- [ ] Update `README_AUTHORS_template.md` with:
  - Cover image requirements
  - Image directory explanation
- [ ] Update `QUICK_REFERENCE.md` with:
  - New prompt numbers (14↔15)
  - Prompt 16 (Image Manager) workflow
  - EPUB export workflow
- [ ] Update `CLAUDE.md` with:
  - New prompt list (14, 15, 16)
  - Compatibility notes
  - Visual system explanation

### Phase 12: Testing

- [ ] Test Prompt 1 initialization creates correct structure
- [ ] Test Prompt 15 creates text-based visuals in `images/`
- [ ] Test Prompt 16 adds images in all modes
- [ ] Test registry coordination (no duplicate numbers)
- [ ] Test upgrade path (text → image)
- [ ] Test Prompt 7 compilation includes all front/back matter
- [ ] Test Prompt 9 EPUB export with images
- [ ] Test Prompt 8 consistency checks for images
- [ ] Test in Typora (image previews work)
- [ ] Test generated EPUB in multiple readers
- [ ] Validate EPUB with epubcheck tool

---

## Breaking Changes

### For New Projects

**None** - New projects use the new unified structure from initialization.

### For Existing Projects (Migration Path)

**Breaking Change:** Directory structure change from per-chapter `figures/` to unified `images/`

**Migration Options:**

**Option A: Manual Migration (Recommended for active projects)**
1. Create `Manuscript/images/` directory
2. Move all images from `Chapter_XX/figures/` to `Manuscript/images/`
3. Rename files: `fig_XX_YY_desc.ext` → `fig-XX-YY-desc.ext`
4. Update all chapter references: `figures/` → `../images/`
5. Consolidate per-chapter registries into unified `Image_Registry.md`
6. Run Prompt 8 to validate
7. Commit changes

**Option B: Migration Script (Future enhancement)**
- Automated script to perform Option A steps
- Target: v0.12.1 or v0.13.0

**Option C: Leave as-is (Legacy support)**
- Existing projects can continue using per-chapter `figures/`
- Prompt 15 and 16 detect structure and adapt
- Not recommended - misses benefits of unified system

**Recommendation:** Migrate active projects manually (Option A), especially before EPUB export.

---

## Success Criteria

### Visual Asset System

1. ✅ All visual assets in single `Manuscript/images/` directory
2. ✅ Unified naming convention working (`fig-XX-YY-description.ext`)
3. ✅ Single registry tracking all assets
4. ✅ Prompt 15 creates text-based visuals correctly
5. ✅ Prompt 16 adds actual images correctly
6. ✅ Registry coordination prevents duplicate numbering
7. ✅ Upgrade path works (text → professional image)
8. ✅ Images display correctly in Typora preview
9. ✅ Prompt 8 validates visual assets
10. ✅ Module 15 protocol fully documented

### EPUB Export

11. ✅ EPUBs generate with all images displaying correctly
12. ✅ EPUBs contain proper metadata (title, author, ISBN, language, publisher)
13. ✅ EPUBs include custom CSS styling
14. ✅ EPUBs include cover image when present
15. ✅ EPUBs have complete front matter (including Copyright)
16. ✅ EPUBs have complete back matter (including About Author)
17. ✅ Generated EPUBs pass epubcheck validation
18. ✅ EPUBs display correctly in multiple e-readers (Calibre, Apple Books, Kindle Previewer)

### Prompt Organization

19. ✅ Prompts renumbered correctly (14↔15)
20. ✅ All cross-references updated
21. ✅ Prompt 16 created and functional
22. ✅ Documentation updated with new prompt numbers
23. ✅ Logical flow makes sense to users

---

## Implementation Timeline

**Target:** v0.12.0

**Estimated Effort:**
- Phase 1-3: 2-4 hours (templates, module, renumbering)
- Phase 4-5: 4-6 hours (update Prompt 15, create Prompt 16)
- Phase 6-9: 3-5 hours (update Prompts 1, 7, 8, 9)
- Phase 10-12: 2-3 hours (final updates, documentation, testing)

**Total:** 11-18 hours

---

## Future Enhancements (v0.13.0+)

See `PANDOC_MAYBE.md` for optional enhancements:
- Font embedding support
- EPUB validation integration (epubcheck)
- Batch export (multiple formats)
- Migration script for existing projects
- Enhanced figure captions
- BibTeX/CSL bibliography support

---

## Appendix: Full EPUB CSS Template

**File:** `Process/Templates/epub-style.css`

```css
/* AI-Assisted Nonfiction Authoring Framework - EPUB Default Style */
/* Version: 0.12.0 */

/* Body and Base Typography */
body {
  font-family: "Georgia", "Times New Roman", serif;
  font-size: 1em;
  line-height: 1.6;
  margin: 1em;
  text-align: left;
  color: #000000;
}

/* Headings */
h1, h2, h3, h4, h5, h6 {
  font-family: "Helvetica", "Arial", sans-serif;
  font-weight: bold;
  page-break-after: avoid;
  page-break-inside: avoid;
  margin-top: 1.5em;
  margin-bottom: 0.5em;
  color: #000000;
}

h1 {
  font-size: 2em;
  margin-top: 0;
  text-align: center;
  page-break-before: always;  /* Chapter breaks */
}

h2 {
  font-size: 1.5em;
  margin-top: 1.2em;
}

h3 {
  font-size: 1.2em;
  margin-top: 1em;
}

h4 { font-size: 1.1em; }
h5 { font-size: 1em; }
h6 { font-size: 0.9em; }

/* Paragraphs */
p {
  margin: 0;
  text-align: justify;
  text-indent: 1.5em;
  orphans: 2;
  widows: 2;
}

/* First paragraph after heading - no indent */
h1 + p, h2 + p, h3 + p, h4 + p, h5 + p, h6 + p {
  text-indent: 0;
}

/* First paragraph of chapter - no indent */
p:first-of-type {
  text-indent: 0;
}

/* Blockquotes (including chapter epigraphs) */
blockquote {
  margin: 1.5em 2em;
  padding-left: 1em;
  border-left: 3px solid #666666;
  font-style: italic;
  font-size: 0.95em;
  page-break-inside: avoid;
}

/* Chapter epigraphs (first blockquote after h1) */
h1 + blockquote {
  text-align: right;
  border-left: none;
  margin: 1em 2em 2em 4em;
  font-size: 0.9em;
}

/* Lists */
ul, ol {
  margin: 0.5em 0;
  padding-left: 2em;
}

li {
  margin: 0.3em 0;
}

/* Code and Preformatted Text */
code {
  font-family: "Courier New", "Courier", monospace;
  font-size: 0.9em;
  background-color: #f5f5f5;
  padding: 0.1em 0.3em;
  border-radius: 3px;
}

pre {
  font-family: "Courier New", "Courier", monospace;
  font-size: 0.85em;
  background-color: #f5f5f5;
  padding: 1em;
  border: 1px solid #cccccc;
  border-radius: 5px;
  overflow-x: auto;
  page-break-inside: avoid;
}

pre code {
  background-color: transparent;
  padding: 0;
}

/* Images and Figures */
img {
  max-width: 100%;
  height: auto;
  display: block;
  margin: 1em auto;
  page-break-inside: avoid;
}

figure {
  margin: 1em 0;
  text-align: center;
  page-break-inside: avoid;
}

figcaption {
  font-size: 0.9em;
  font-style: italic;
  margin-top: 0.5em;
  text-align: center;
}

/* Tables */
table {
  border-collapse: collapse;
  margin: 1em auto;
  width: 100%;
  page-break-inside: avoid;
}

th, td {
  border: 1px solid #cccccc;
  padding: 0.5em;
  text-align: left;
}

th {
  background-color: #f0f0f0;
  font-weight: bold;
}

/* Links */
a {
  color: #0066cc;
  text-decoration: underline;
}

a:visited {
  color: #551a8b;
}

/* Horizontal Rules */
hr {
  border: none;
  border-top: 1px solid #cccccc;
  margin: 2em 0;
  page-break-after: avoid;
}

/* Emphasis */
em, i {
  font-style: italic;
}

strong, b {
  font-weight: bold;
}

/* Front Matter - Title Page */
.title-page {
  text-align: center;
  page-break-after: always;
}

.title-page h1 {
  font-size: 2.5em;
  margin-top: 30%;
  margin-bottom: 0.5em;
}

.title-page .author {
  font-size: 1.5em;
  margin-top: 1em;
}

/* Front Matter - Copyright Page */
.copyright-page {
  font-size: 0.9em;
  text-align: left;
  page-break-after: always;
}

.copyright-page p {
  text-indent: 0;
  margin-bottom: 0.5em;
}

/* Front Matter - Dedication */
.dedication {
  text-align: center;
  font-style: italic;
  margin-top: 30%;
  page-break-after: always;
}

/* Page Breaks */
.page-break {
  page-break-after: always;
}

.page-break-before {
  page-break-before: always;
}

/* Accessibility */
.sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border-width: 0;
}
```

---

**End of Proposal**
