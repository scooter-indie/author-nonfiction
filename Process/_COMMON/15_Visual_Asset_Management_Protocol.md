# Visual Asset Management Protocol

**Framework Version:** 0.13.0
**Module:** Unified Visual Asset Management
**Purpose:** Centralized tracking and management of all visual assets (text-based and images)

---

## Overview

Unified system for managing all visual assets in a single location with centralized tracking. Supports both text-based placeholders (created by Prompt 15) and actual images (managed by Prompt 16).

**Key principle:** Single directory, single registry, unified workflow. Start with text-based visuals for rapid iteration, upgrade to professional images when resources permit.

**Major change in v0.12.1:** Consolidated from per-chapter `Chapter_XX/figures/` subdirectories to unified `Manuscript/images/` directory with single registry.

---

## Status Code System

**Two-level tracking system:**

### Level 1: Status (What it is)

| Code | Status | Format | Use Case |
|------|--------|--------|----------|
| 📝 | Text-based | .md files (markdown/ASCII) | Initial creation, rapid iteration, version control friendly |
| 🖼️ | Professional image | .jpg/.png/.svg files | Final publication, actual photos/graphics, professional appearance |

**Upgrade path:** 📝 → 🖼️ (same filename base, different extension)

### Level 2: Type (What kind)

- **Table** - Comparison tables, data tables, feature matrices
- **Diagram** - Concept diagrams, system diagrams, relationships
- **Photo** - Photographs, real-world images
- **Screenshot** - Software UI, examples, demonstrations
- **Chart** - Data visualization, graphs, plots
- **Flowchart** - Process flows, decision trees, workflows
- **Infographic** - Visual data representations
- **Cover** - Book cover image

**Example combinations:**
- Status: 📝, Type: Table → Markdown comparison table
- Status: 🖼️, Type: Photo → Actual photograph file
- Status: 📝, Type: Diagram → ASCII diagram awaiting upgrade
- Status: 🖼️, Type: Chart → Professional chart graphic

---

## Directory Structure

**Unified structure (v0.12.1+):**

```
Manuscript/
├── images/                              # Single flat directory for ALL visuals
│   ├── Image_Registry.md                # Single unified registry
│   ├── fig-01-01-table.md              # Text-based table (Prompt 15)
│   ├── fig-01-02-photo.jpg             # Actual photo (Prompt 16)
│   ├── fig-02-01-diagram.md            # ASCII diagram (Prompt 15)
│   ├── fig-02-02-screenshot.png        # Screenshot (Prompt 16)
│   ├── fig-03-01-chart.png             # Professional graphic (Prompt 16)
│   ├── cover.jpg                        # Book cover
│   └── author-photo.jpg                 # Optional author photo
└── Chapters/
    ├── Chapter_01.md                    # Chapters have no subdirectories
    ├── Chapter_01_chg.md
    ├── Chapter_02.md
    └── Chapter_02_chg.md
```

**Key benefits:**
- ✅ Single location for all visual assets
- ✅ Flat structure works in Typora preview
- ✅ Simple relative paths: `../images/fig-03-01-photo.jpg`
- ✅ Pandoc-friendly: `--resource-path=Manuscript`
- ✅ No path rewriting needed during EPUB export
- ✅ One registry tracks everything

---

## Figure File Naming Convention

**Format:** `fig-XX-YY-description.ext`

**Components:**
- `fig` - Prefix for all visual assets (except cover/author photo)
- `XX` - Chapter number (zero-padded: 01, 02, ..., 99)
- `YY` - Sequential figure number within chapter (01, 02, 03, ...)
- `description` - Brief descriptor (lowercase, hyphens instead of underscores)
- `ext` - Extension indicating type and status:
  - `.md` = Text-based placeholder (markdown table, ASCII diagram, mermaid flowchart)
  - `.jpg` = Photo or complex image
  - `.png` = Screenshot, diagram with transparency, professional graphic
  - `.svg` = Vector graphic (scalable)

**Examples:**
- `fig-03-01-survey-comparison.md` - Text-based table from Prompt 15
- `fig-03-02-lab-photo.jpg` - Actual photo added via Prompt 16
- `fig-05-01-workflow-diagram.md` - ASCII diagram from Prompt 15
- `fig-05-02-architecture.png` - Professional graphic via Prompt 16

**Special files (no fig- prefix):**
- `cover.jpg` or `cover.png` - Book cover image
- `author-photo.jpg` - Optional author photo for About section
- `Image_Registry.md` - Central registry (not a figure)

**Naming rationale:**
- Hyphens (not underscores) for better readability
- Chapter prefix ensures uniqueness
- Sequential numbering maintains order
- Descriptive names aid discovery
- Extension clearly indicates status

---

## Figure File Format

### Text-Based Figures (.md)

**Standard structure:**

```markdown
# Figure X.Y: [Title]

[Content - markdown table, ASCII diagram, or mermaid flowchart]

**Description:** [Explanation of what this figure represents]

**Type:** [Table | Diagram | Chart | Flowchart | etc.]

**Status:** 📝 Text-based

**Upgrade Note:** This text-based [type] can be replaced with a professional
graphic by creating an image file with the same base name (fig-XX-YY-description.png)
and updating the reference in Chapter_XX.md from .md to .png extension.

**Created:** [DATE] by Prompt 15 (Visual Content Suggester)
```

**Example - Markdown Table:**

```markdown
# Figure 3.1: Survey Method Comparison

| Method      | Cost  | Response Rate | Best Use Case          |
|-------------|-------|---------------|------------------------|
| Email       | Low   | 15-25%       | Large samples          |
| Phone       | High  | 60-80%       | In-depth data          |
| Online      | Low   | 20-40%       | Quick feedback         |
| In-person   | High  | 70-90%       | Complex topics         |

**Description:** Comparison table showing trade-offs between survey methods
in terms of cost, typical response rates, and optimal use cases.

**Type:** Table

**Status:** 📝 Text-based

**Upgrade Note:** This text-based table can be replaced with a styled
table graphic (fig-03-01-survey-comparison.png).

**Created:** 2025-11-21 by Prompt 15 (Visual Content Suggester)
```

### Professional Images (.jpg, .png, .svg)

**No accompanying .md file needed** - All metadata stored in `Image_Registry.md`

**Supported formats:**
- **JPG:** Photographs, complex images, compressed visuals
- **PNG:** Screenshots, diagrams with transparency, graphics with text
- **SVG:** Vector graphics, scalable diagrams (best for technical illustrations)

**Recommended specifications:**
- **For EPUB:** Max width 1200-1400px, <500KB per image
- **For print PDF:** 300 DPI at final print size, <5MB per image
- **For web/preview:** 72-96 DPI acceptable

---

## Registry Format

**File:** `Manuscript/images/Image_Registry.md`

**Purpose:** Single source of truth for ALL visual assets in the book

**Structure:**

```markdown
# Visual Asset Registry

**Last Updated:** YYYY-MM-DD
**Total Assets:** N
**By Status:** X 📝 text-based, Y 🖼️ images
**By Type:** breakdown by type

---

## Chapter XX: [Chapter Title]

### fig-XX-YY-description
- **Figure:** X.Y
- **Title:** [Figure title]
- **Type:** [Table | Diagram | Photo | Screenshot | Chart | Flowchart | Infographic]
- **Status:** [📝 Text-based (format) | 🖼️ Professional image (format)]
- **File:** `images/fig-XX-YY-description.ext`
- **Size:** [KB/MB] ([width]x[height]px) - for images only
- **Referenced in:** Chapter_XX.md:line_number
- **Alt Text:** "Description for accessibility"
- **Caption:** "Figure X.Y: Caption text"
- **Created:** YYYY-MM-DD by [Prompt 15 | Prompt 16 | Manual]
- **Upgrade Priority:** [High | Medium | Low | N/A] - text-based only
- **Notes:** [Any additional context]

---

## Front Matter

### cover
- **Figure:** N/A (Cover)
- **Title:** Book Cover
- **Type:** Cover Image
- **Status:** 🖼️ Professional image (JPG)
- **File:** `images/cover.jpg`
- **Size:** [dimensions and file size]
- **Referenced in:** EPUB export, Title Page
- **Alt Text:** "[Book Title] by [Author Name]"
- **Caption:** N/A
- **Created:** [DATE] by author
- **Upgrade Priority:** N/A (final)
- **Notes:** Professional design, meets EPUB specs (1600x2560px minimum)

---

## Upgrade Recommendations

### High Priority (Professional graphic strongly recommended)
- List figures that would significantly benefit from professional design

### Medium Priority (Would benefit from design)
- List figures that would look better as graphics but work adequately as text

### Low Priority (Text-based adequate)
- List figures that work fine as-is

---

## Statistics

**By Chapter:**
- Chapter 1: N figures (X 📝, Y 🖼️)
- Chapter 2: N figures (X 📝, Y 🖼️)
- ...

**By Status:**
- 📝 Text-based: N (X%)
- 🖼️ Professional: N (Y%)

**By Type:**
- Tables: N
- Photos: N
- Diagrams: N
- ...

**Total Size:** N.N MB
**Average Size:** N KB per image

---

**Maintained by:** Prompt 15 (Visual Content Suggester) and Prompt 16 (Image Manager)
**Last validated:** YYYY-MM-DD by Prompt 8 (Consistency Checker)
```

---

## Reference Format in Chapters

**Use standard markdown image syntax:**

```markdown
![Alt text describing the image for accessibility](../images/fig-XX-YY-description.ext)
```

**Examples:**

```markdown
In this section, we examine the research timeline
![Timeline showing research phases from 2020-2023](../images/fig-01-01-research-timeline.md)
as shown in Figure 1.1.

The laboratory setup
![Laboratory showing spectroscopy equipment and sample preparation area](../images/fig-01-02-lab-setup.jpg)
was configured according to manufacturer specifications.
```

**Key points:**
- Relative path from `Manuscript/Chapters/` to `Manuscript/images/`
- Alt text is mandatory for accessibility
- Works in Typora preview
- Pandoc converts to proper `<img>` or `<figure>` tags
- Can reference both .md (text-based) and image files

**Figure captions in text:**

```markdown
**Figure 1.1:** Research project timeline showing four phases

![Timeline showing research phases from 2020-2023](../images/fig-01-01-research-timeline.md)
```

---

## Upgrade Path: Text-Based → Professional

**Process for upgrading text-based visual to professional image:**

1. **Identify figure for upgrade**
   - Check registry Upgrade Priority field
   - Review High/Medium priority sections

2. **Create professional version**
   - Use design tools (Figma, Canva, Adobe, etc.)
   - Export as PNG/JPG/SVG
   - Use same base filename, new extension: `fig-03-01-table.png`
   - Optimize for target use (EPUB: <500KB, Print: 300 DPI)

3. **Save to `Manuscript/images/`**
   ```
   images/
   ├── fig-03-01-table.md    # Original text-based (can keep or remove)
   ├── fig-03-01-table.png   # New professional version
   ```

4. **Update chapter reference** (using Prompt 16 or manually)
   ```markdown
   # OLD:
   ![Survey method comparison table](../images/fig-03-01-table.md)

   # NEW:
   ![Survey method comparison table](../images/fig-03-01-table.png)
   ```

5. **Update registry via Prompt 16**
   - Change Status: 📝 → 🖼️
   - Change File: .md → .png
   - Add Size: KB and dimensions
   - Update Created date
   - Change Upgrade Priority: N/A

6. **Optional: Keep or remove .md file**
   - **Keep:** Preserves version history and design specifications
   - **Remove:** Cleaner directory, no ambiguity

**Rationale:** Same filename base means only extension changes in reference, minimizing edits.

---

## Replacement Priority Guidelines

**Assign based on impact and feasibility:**

### High Priority
- Complex diagrams difficult to represent in ASCII
- Charts with multiple data series or detailed visualizations
- Photographs or screenshots that are required (not placeholders)
- Publication-critical visuals that define key concepts
- Figures referenced multiple times throughout the book
- Visuals where color or professional design significantly improves comprehension

### Medium Priority
- Diagrams that would benefit from color coding or professional styling
- Tables that could be more visually appealing but are functional as text
- Flowcharts with many branches that are cramped in ASCII
- Comparative visualizations that would be clearer with design
- Secondary figures that enhance but aren't critical

### Low Priority
- Simple tables with few columns/rows (markdown is clear)
- Basic flowcharts with simple paths (ASCII is adequate)
- Quick reference tables or checklists
- Internal documentation figures
- Figures used only once in minor sections

### N/A (No upgrade needed)
- Professional images already (🖼️ status)
- Text-based figures that will remain text (e.g., code examples formatted as "figures")

---

## Figure Types and Use Cases

### Tables (📝 → 🖼️ upgrade path)
- **Text-based:** Markdown table syntax
- **Professional:** Styled tables with color, icons, emphasis
- **Best for:** Comparisons, feature matrices, specifications, data presentation

### Diagrams (📝 → 🖼️ upgrade path)
- **Text-based:** ASCII art, simple boxes and arrows
- **Professional:** Vector graphics, technical diagrams with styling
- **Best for:** System architecture, relationships, hierarchies, conceptual models

### Charts (📝 → 🖼️ upgrade path)
- **Text-based:** ASCII bar charts, simple data representations
- **Professional:** Bar/line/pie charts with proper axes and legends
- **Best for:** Data trends, distributions, quantitative analysis

### Flowcharts (📝 → 🖼️ upgrade path)
- **Text-based:** ASCII boxes and decision diamonds
- **Professional:** Styled flowcharts with icons and color coding
- **Best for:** Processes, decision trees, algorithms, workflows

### Photos (🖼️ only - no text-based version)
- **Format:** JPG primarily
- **Best for:** Real-world examples, case studies, physical evidence, people
- **Note:** Always captured as professional images via Prompt 16

### Screenshots (🖼️ only - no text-based version)
- **Format:** PNG (preserves UI text clarity)
- **Best for:** Software demonstrations, UI examples, web pages
- **Note:** Always captured as professional images via Prompt 16

### Infographics (📝 → 🖼️ upgrade path)
- **Text-based:** Structured markdown with data
- **Professional:** Designed visual with graphics, icons, and styling
- **Best for:** Complex data stories, visual summaries, marketing content

---

## Registry Coordination Between Prompts

**Key principle:** Registry is source of truth for figure numbering

### When Prompt 15 (Visual Content Suggester) creates figures:

1. Read `Manuscript/images/Image_Registry.md`
2. For target chapter XX, find highest YY number used
3. Use next sequential number: YY+1
4. Create text-based file: `fig-XX-YY-description.md`
5. Add entry to registry with 📝 status
6. Update statistics section

### When Prompt 16 (Image Manager) adds images:

1. Read `Manuscript/images/Image_Registry.md`
2. For target chapter XX, find highest YY number used
3. Use next sequential number: YY+1
4. Copy/move image file: `fig-XX-YY-description.ext`
5. Add entry to registry with 🖼️ status
6. Update statistics section

### When upgrading text-based to image (Prompt 16 Mode 2):

1. User selects existing 📝 figure from registry
2. Prompt 16 uses same fig-XX-YY-description base
3. Creates image file with new extension
4. Updates registry entry: 📝 → 🖼️
5. Updates chapter reference: .md → .png/.jpg
6. Optionally removes old .md file

**This coordination prevents duplicate numbering and maintains sequential order.**

---

## Integration with Prompts

### Prompt 15 (Visual Content Suggester)
- **Role:** Primary creator of text-based visuals
- **Creates:** Markdown tables, ASCII diagrams, mermaid flowcharts
- **Location:** `Manuscript/images/fig-XX-YY-description.md`
- **Registry:** Adds entries with 📝 status
- **Workflow:** Analyzes chapter content → suggests visuals → creates text-based placeholders
- **Output:** Ready-to-use visuals that can be upgraded later

### Prompt 16 (Image Manager)
- **Role:** Manager of actual image files
- **Adds:** Photos, screenshots, professional graphics, charts
- **Location:** `Manuscript/images/fig-XX-YY-description.jpg|png|svg`
- **Registry:** Adds entries with 🖼️ status
- **Workflow:** User provides image → copies to images/ → updates registry → inserts reference
- **Modes:** Add new, upgrade text-based, scan existing, validate references

### Prompt 8 (Consistency Checker)
- **Role:** Reporter on visual asset status
- **Reads:** `Image_Registry.md`
- **Reports:**
  - Total figures per chapter
  - 📝 vs 🖼️ distribution
  - Chapters lacking visuals
  - Orphaned images (exist but not referenced)
  - Missing images (referenced but don't exist)
  - Missing alt text
  - Upgrade recommendations
- **Recommends:** Running Prompt 15 for chapters needing visuals

### Prompts 3/4 (Change by Chg / Interactive Change)
- **Role:** Updaters of figure references and content
- **Can:** Modify existing figures, update registry metadata, change priorities
- **Workflow:** Normal _chg file workflow applies to Image_Registry.md updates

### Prompt 7 (Compile)
- **Role:** Consumer of visual assets during manuscript assembly
- **Process:** Reads chapters, resolves image references, includes in compiled output
- **Note:** Both .md and image references work; .md files can be included inline or as links

### Prompt 9 (Export)
- **Role:** Consumer for EPUB/PDF generation
- **Process:**
  - Copies entire `Manuscript/images/` directory to export package
  - Removes `Image_Registry.md` from export (not needed in EPUB)
  - Sets Pandoc `--resource-path=Manuscript`
  - Image references resolve automatically
- **Simplification:** No path rewriting needed with unified structure!

---

## Quality Standards

### For Text-Based Visuals (📝)
- ✅ Use clear, readable formatting
- ✅ Include descriptive title (Figure X.Y: ...)
- ✅ Provide context in Description field
- ✅ Note upgrade recommendations
- ✅ Be version control friendly (plain text)
- ✅ Follow markdown/ASCII best practices
- ✅ Include metadata fields (Type, Status, Created)

### For Professional Visuals (🖼️)
- ✅ Meet publication quality standards
  - EPUB: Max 1400px width, <500KB
  - Print: 300 DPI, appropriate size
- ✅ Use consistent styling within book
- ✅ Include accessibility considerations (descriptive alt text)
- ✅ Optimize for file size without losing quality
- ✅ Use appropriate format:
  - JPG for photos
  - PNG for screenshots and diagrams with text
  - SVG for vector graphics when possible
- ✅ Follow design guidelines in Style_Guide.md (if specified)

### For Registry Entries
- ✅ Complete all required fields
- ✅ Accurate line number references
- ✅ Descriptive alt text for accessibility
- ✅ Proper figure numbering (sequential within chapter)
- ✅ Appropriate upgrade priority assignment
- ✅ Updated statistics after changes

---

## Validation Checklist

**When creating/updating figures via Prompt 15 or 16:**

- [ ] Filename follows naming convention: `fig-XX-YY-description.ext`
- [ ] File saved in `Manuscript/images/` directory
- [ ] Registry entry created/updated in `Image_Registry.md`
- [ ] Chapter reference inserted with proper alt text
- [ ] Figure number is sequential (no gaps or duplicates)
- [ ] Status code correct (📝 or 🖼️)
- [ ] Type category assigned
- [ ] Created date recorded
- [ ] For images: Size and dimensions noted
- [ ] For text-based: Upgrade priority assigned
- [ ] Statistics section updated

---

## Best Practices

### For Authors Using Text-Based Visuals
1. **Keep it simple:** ASCII/markdown limitations are features, not bugs
2. **Focus on clarity:** If text version communicates well, it's good enough
3. **Use consistently:** Similar formatting across figures
4. **Document thoroughly:** Good descriptions help future upgrades
5. **Plan for upgrade:** Structure for easy conversion to professional graphics

### For Authors Using Professional Visuals
1. **Match book style:** Consistent colors, fonts, design language
2. **Optimize files:** Balance quality and file size
3. **Plan for print:** 300 DPI minimum if publishing physically
4. **Keep source files:** Maintain .ai, .fig, .psd for future edits
5. **Test accessibility:** Ensure readability, proper alt text, color contrast

### For Registry Maintenance
1. **Update before changing figures:** Modify registry before moving files
2. **Keep statistics current:** Update counts after bulk changes
3. **Document changes:** Note updates in registry
4. **Review regularly:** Check upgrade priorities at milestones
5. **Coordinate with Prompt 8:** Run consistency checks after major changes

---

## Anti-Hallucination Compliance

**When AI suggests or creates figures:**

### DO NOT:
- ❌ Fabricate data for charts/tables
- ❌ Create fake screenshots
- ❌ Invent statistics for visuals
- ❌ Generate specific people or scenarios without user confirmation
- ❌ Assume what images should show without user input

### DO:
- ✅ Use placeholder data clearly labeled as "EXAMPLE DATA"
- ✅ Mark generated content as [HYPOTHETICAL] or [GENERIC EXAMPLE]
- ✅ Ask user to verify all data before finalizing
- ✅ Base descriptions on actual user-provided content only
- ✅ Mark uncertain descriptions with [VERIFY]
- ✅ Request real data/photos from user for factual visuals

---

## Migration from v0.11.x

**For existing projects with per-chapter `figures/` subdirectories:**

### Option A: Manual Migration (Recommended)
1. Create `Manuscript/images/` directory
2. Move all files from `Chapter_XX/figures/` to `Manuscript/images/`
3. Rename files: `fig_XX_YY_desc.ext` → `fig-XX-YY-desc.ext` (underscores to hyphens)
4. Update all chapter references: `figures/` → `../images/`
5. Consolidate per-chapter `README.md` files into unified `Image_Registry.md`
6. Delete now-empty `Chapter_XX/figures/` directories
7. Run Prompt 8 to validate
8. Commit changes

### Option B: Continue with Legacy Structure
- Prompt 15 and 16 can detect old structure
- Less optimal but functional
- Not recommended - misses benefits of unified system

### Option C: Automated Migration (Future)
- Migration script planned for v0.12.1 or v0.13.0

---

## Error Handling

### Missing image file
- **Symptom:** Registry points to non-existent file
- **Detection:** Prompt 8 consistency check or Prompt 16 validation
- **Resolution:** Add missing image or remove registry entry

### Orphaned image
- **Symptom:** Image exists in `images/` but no registry entry
- **Detection:** Prompt 16 Mode 3 (Scan and Register)
- **Resolution:** Add to registry with proper metadata

### Broken reference
- **Symptom:** Chapter references image that doesn't exist
- **Detection:** Prompt 8 consistency check
- **Resolution:** Create/add missing image or update reference

### Duplicate figure numbers
- **Symptom:** Two figures with same X.Y number in one chapter
- **Detection:** Prompt 8 consistency check
- **Resolution:** Renumber sequentially, update all references and registry

### Registry out of sync
- **Symptom:** Registry statistics don't match actual files
- **Detection:** Manual review or Prompt 8
- **Resolution:** Run Prompt 16 Mode 3 to rescan and rebuild statistics

---

## Summary

Visual Asset Management Protocol v0.12.1 provides:

- ✅ **Unified location:** Single `Manuscript/images/` directory
- ✅ **Single registry:** `Image_Registry.md` tracks everything
- ✅ **Two-level tracking:** Status (📝/🖼️) + Type (Table/Photo/etc.)
- ✅ **Clear naming:** `fig-XX-YY-description.ext` with hyphens
- ✅ **Simple references:** Standard markdown image syntax
- ✅ **Smooth upgrade path:** Text-based → Professional image
- ✅ **Prompt coordination:** Registry-based figure numbering
- ✅ **Typora-friendly:** Relative paths work in preview
- ✅ **Pandoc-ready:** No path rewriting needed for EPUB
- ✅ **Version control friendly:** Plain text registry and text-based visuals

**Used by:**
- Prompt 15 (Visual Content Suggester) - Creates text-based visuals
- Prompt 16 (Image Manager) - Manages actual images
- Prompt 8 (Consistency Checker) - Validates and reports
- Prompts 3/4 (Change/Interactive) - Updates figures
- Prompt 7 (Compile) - Includes visuals in manuscript
- Prompt 9 (Export) - Copies images for EPUB/PDF

---

**Framework Version:** 0.13.0
**Last Updated:** 2025-11-21
**Status:** Active

---

*This protocol enables authors to manage all visual assets in one location with consistent tracking, while maintaining flexibility to start with text-based placeholders and upgrade to professional graphics as resources and timeline permit.*
