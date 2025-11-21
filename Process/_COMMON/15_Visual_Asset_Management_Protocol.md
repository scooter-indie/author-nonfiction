# Visual Asset Management Protocol

**Framework Version:** 0.11.0
**Module:** Centralized Visual Asset Management
**Purpose:** Standardized figure/diagram tracking and upgrade path management

---

## Overview

Centralized system for managing visual assets (figures, diagrams, tables, charts) with status tracking and upgrade path management. Supports text-based placeholders that can be upgraded to professional images.

**Key principle:** Start with text-based visuals (markdown tables, ASCII diagrams) that provide immediate value, then upgrade to professional images when resources permit.

---

## Status Code System

**Two asset types:**

| Code | Status | Format | Use Case |
|------|--------|--------|----------|
| 📝 | Text-based | Markdown/ASCII | Initial creation, rapid iteration, version control friendly |
| 🖼️ | Professional image | PNG/JPG/SVG | Final publication, complex visuals, professional appearance |

**Upgrade path:** 📝 → 🖼️ (same filename, different extension)

---

## Directory Structure

**Standard structure for each chapter:**

```
Manuscript/Chapters/Chapter_XX/
├── Chapter_XX.md                    # Chapter content
├── Chapter_XX_chg.md                # Change tracking
└── figures/                          # Visual assets directory
    ├── README.md                     # Figure registry (auto-maintained)
    ├── fig_XX_01_description.md     # Text-based figure
    ├── fig_XX_02_description.png    # Professional image
    └── fig_XX_03_description.md     # Text-based (to be upgraded)
```

**Registry file:** `figures/README.md` tracks all visuals with metadata

---

## Figure File Naming Convention

**Format:** `fig_XX_YY_description.ext`

**Components:**
- `fig` - Prefix for all figures
- `XX` - Chapter number (matches parent directory)
- `YY` - Sequential figure number within chapter (01, 02, 03...)
- `description` - Brief descriptive name (lowercase, underscores)
- `ext` - Extension (.md for text-based, .png/.jpg/.svg for images)

**Examples:**
- `fig_03_01_survey_comparison.md` (text-based table)
- `fig_03_02_workflow_diagram.md` (ASCII diagram)
- `fig_05_01_architecture.png` (professional image)
- `fig_08_03_results_chart.md` (text-based, awaiting upgrade)

**Rationale:**
- Chapter prefix ensures uniqueness if figures are moved
- Sequential numbering maintains order
- Descriptive names aid discovery
- Extension clearly indicates status

---

## Figure File Format

### Text-Based Figures (.md)

**Standard structure:**

```markdown
# Figure X.Y: [Title]

[Content - table, diagram, chart in markdown/ASCII]

**Description:** [Explanation of what this figure represents]

**Replacement Note:** This text-based [type] can be replaced with a
professional graphic by saving an image file with the same base name
(fig_XX_YY_description.png) and updating the reference in Chapter_XX.md.
```

**Examples:**

#### Markdown Table
```markdown
# Figure 3.1: Survey Method Comparison

| Method | Cost | Response Rate | Best Use Case |
|--------|------|---------------|---------------|
| Email  | Low  | 15-25%       | Large samples |
| Phone  | High | 60-80%       | In-depth data |
| Online | Low  | 20-40%       | Quick feedback|

**Description:** Comparison table showing trade-offs between survey
methods in terms of cost, typical response rates, and optimal use cases.

**Replacement Note:** This text-based table can be replaced with a
professional graphic by saving an image file (fig_03_01_survey_comparison.png)
and updating the reference in Chapter_03.md.
```

#### ASCII Diagram
```markdown
# Figure 5.2: Data Processing Workflow

```
┌─────────────┐
│  Raw Data   │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│  Validation │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│  Transform  │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│   Storage   │
└─────────────┘
```

**Description:** Sequential workflow showing data processing stages
from raw input through validation, transformation, and storage.

**Replacement Note:** This ASCII diagram can be replaced with a
professional flowchart image (fig_05_02_data_workflow.png).
```

### Professional Images (.png, .jpg, .svg)

**No accompanying .md file needed** - caption stored in registry

**Supported formats:**
- **PNG:** Screenshots, diagrams with transparency
- **JPG:** Photographs, complex images
- **SVG:** Vector graphics, scalable diagrams

**Recommended dimensions:**
- Width: 1200-2400px for print quality
- Resolution: 300 DPI for publication
- File size: <5MB per image

---

## Figure Registry Format

**File:** `Chapter_XX/figures/README.md`

**Purpose:** Central tracking of all visual assets in this chapter

**Auto-maintained by:** Prompt 14 (Visual_Content_Suggester)

**Format:**

```markdown
# Figures for Chapter XX: [Chapter Title]

**Last Updated:** YYYY-MM-DD
**Total Figures:** X (Y 📝 text-based, Z 🖼️ professional)

---

## Figure Inventory

### fig_XX_01_[description]
- **Type:** [Table | Diagram | Chart | Photo | Screenshot | Flowchart]
- **Status:** [📝 Text-based | 🖼️ Professional image]
- **Format:** [.md | .png | .jpg | .svg]
- **Location:** figures/fig_XX_01_description.ext
- **Referenced in:** Chapter_XX.md (line XXX)
- **Description:** [Brief description]
- **Created:** YYYY-MM-DD by [Prompt 14 | Manual]
- **Replacement Priority:** [High | Medium | Low | N/A]
- **Notes:** [Any additional context]

---

### fig_XX_02_[description]
[Same structure...]

---

## Upgrade Recommendations

**High Priority Upgrades:**
- fig_XX_YY_description: [Reason why professional version recommended]

**Medium Priority:**
- fig_XX_YY_description: [Reason]

**Low Priority:**
- Text-based versions adequate for current purpose

---

**Maintenance Notes:**
- This registry is auto-maintained by Prompt 14
- Manual updates should follow the same format
- When replacing text-based with image, update Status field
```

---

## Reference Format in Chapters

**How to reference figures in chapter content:**

### Inline Reference (Recommended)
```markdown
The survey methods vary significantly in cost and response rates
[See: figures/fig_03_01_survey_comparison.md]. Email surveys offer
the lowest cost but also have lower response rates.
```

### Explicit Figure Call
```markdown
As shown in Figure 3.1, email surveys provide the most cost-effective
approach for large sample sizes.

[See: figures/fig_03_01_survey_comparison.md]
```

### Multiple Figures
```markdown
The workflow consists of four stages [See: figures/fig_05_02_workflow.md],
with validation being the most resource-intensive step. Performance
metrics are detailed in [See: figures/fig_05_03_performance.md].
```

**During compilation:** References are resolved to actual figures

**Rationale for external references:**
- Keeps chapter content clean and readable
- Allows figure updates without touching chapter text
- Version control friendly
- Mirrors professional publishing workflows

---

## Upgrade Path: Text-Based → Professional

**Process:**

1. **Identify figure for upgrade** (check registry Replacement Priority)

2. **Create professional version:**
   - Use design tools (Figma, Canva, Adobe, etc.)
   - Export as PNG/JPG/SVG
   - Use same base filename: `fig_XX_YY_description.png`

3. **Save to figures/ directory:**
   ```
   figures/
   ├── fig_03_01_survey_comparison.md   # Original text-based
   ├── fig_03_01_survey_comparison.png  # New professional version
   ```

4. **Update chapter reference:**
   ```markdown
   # OLD:
   [See: figures/fig_03_01_survey_comparison.md]

   # NEW:
   [See: figures/fig_03_01_survey_comparison.png]
   ```

5. **Update registry:**
   - Change Status: 📝 → 🖼️
   - Change Format: .md → .png
   - Update Created date
   - Add replacement notes

6. **Optional:** Keep or remove .md file
   - Keep: Preserves version history and fallback
   - Remove: Cleaner directory, less confusion

**Rationale:** Same filename base ensures references remain consistent, only extension changes

---

## Replacement Priority Guidelines

**High Priority:**
- Complex diagrams difficult to represent in ASCII
- Charts with multiple data series
- Photographs or screenshots required
- Publication-critical visuals
- Figures referenced multiple times

**Medium Priority:**
- Diagrams that would benefit from color
- Tables that could be more visually appealing
- Flowcharts with many branches
- Comparative visualizations

**Low Priority:**
- Simple tables (markdown sufficient)
- Basic flowcharts (ASCII adequate)
- Quick reference diagrams
- Internal-only documentation

**N/A (Text-based sufficient):**
- Code examples
- Simple data tables
- Step-by-step lists formatted as diagrams
- Version control logs

---

## Figure Types Supported

### Tables
- **Text-based:** Markdown tables
- **Professional:** Styled tables, comparison matrices
- **Best for:** Data comparison, feature matrices, specifications

### Diagrams
- **Text-based:** ASCII art, mermaid diagrams
- **Professional:** Vector graphics, technical diagrams
- **Best for:** System architecture, relationships, hierarchies

### Charts
- **Text-based:** ASCII bar charts, simple plots
- **Professional:** Bar/line/pie charts with styling
- **Best for:** Data visualization, trends, distributions

### Flowcharts
- **Text-based:** ASCII boxes and arrows
- **Professional:** Styled flowcharts with icons
- **Best for:** Processes, decision trees, workflows

### Screenshots
- **Text-based:** N/A (description only)
- **Professional:** Actual screenshots with annotations
- **Best for:** Software UI, examples, demonstrations

### Photographs
- **Text-based:** N/A (description only)
- **Professional:** Actual photographs
- **Best for:** Real-world examples, case studies, evidence

---

## Integration with Prompts

### Prompt 14: Visual_Content_Suggester
- **Primary creator** of visual assets
- Analyzes chapters for visual opportunities
- Creates text-based versions initially
- Maintains figures registry
- Updates chapter references
- Tracks replacement priorities

### Prompt 8: Consistency Checker
- **Reporter** on visual asset status
- Counts figures per chapter
- Shows 📝 vs 🖼️ distribution
- Flags chapters lacking visuals
- Recommends running Prompt 14

### Prompt 3/4: Change by Chg / Interactive Change
- **Updaters** of figure references and content
- Can modify existing figures
- Can update registry metadata
- Can change replacement priorities

### Prompt 7: Compile
- **Consumer** of visual assets during manuscript assembly
- Resolves figure references
- Includes figures in output (format-dependent)
- May convert formats for specific outputs

---

## Quality Standards

**Text-based visuals should:**
- Use clear, readable formatting
- Include descriptive captions
- Provide context in Description field
- Note replacement recommendations
- Be version control friendly (no binary data)

**Professional visuals should:**
- Meet publication quality standards (300 DPI)
- Use consistent styling within book
- Include accessibility considerations
- Be optimized for file size
- Follow design guidelines in Style_Guide.md (if specified)

---

## Validation Checklist

**When creating/updating figures:**

- [ ] Filename follows naming convention
- [ ] File saved in correct `Chapter_XX/figures/` directory
- [ ] Registry entry created/updated in `figures/README.md`
- [ ] Chapter reference inserted at appropriate location
- [ ] Description field completed
- [ ] Replacement priority assigned (for text-based)
- [ ] Status code correct (📝 or 🖼️)
- [ ] Created date recorded
- [ ] Change tracked in chapter _chg file

---

## Best Practices

### For Text-Based Visuals
1. **Keep it simple:** ASCII/markdown limitations are features, not bugs
2. **Focus on clarity:** If text version is clear, it's good enough
3. **Use consistently:** Maintain similar style across figures
4. **Document well:** Good descriptions make replacement easier
5. **Plan for upgrade:** Structure for easy conversion to professional

### For Professional Visuals
1. **Match book style:** Consistent colors, fonts, styling
2. **Optimize files:** Balance quality and file size
3. **Plan for print:** 300 DPI minimum for publication
4. **Include source files:** Keep .ai, .fig, .svg for future edits
5. **Test accessibility:** Ensure readability, alt text, color contrast

### For Maintenance
1. **Update registry first:** Before changing figures
2. **Keep backups:** Before replacing text-based with professional
3. **Document changes:** Update _chg files
4. **Review regularly:** Check replacement priorities at milestones
5. **Coordinate with editors:** Align on which figures need upgrading

---

## Anti-Hallucination Compliance

**When suggesting figures:**
- DO NOT fabricate data for charts/tables
- DO NOT create fake screenshots
- DO NOT invent statistics for visuals
- USE placeholder data clearly labeled as "EXAMPLE DATA"
- MARK any generated content as [HYPOTHETICAL]
- ALWAYS ask user to verify data before finalizing

**When describing figures:**
- Base descriptions on actual content only
- Don't assume what image "should" show
- Don't fabricate details not present
- Mark uncertain descriptions with [VERIFY]

---

## Usage Example

**Scenario:** Chapter 3 discusses survey methods and needs a comparison table.

**Step 1: Prompt 14 creates text-based version**
- File: `Chapter_03/figures/fig_03_01_survey_comparison.md`
- Content: Markdown table comparing methods
- Registry: Entry created with 📝 status, Medium priority

**Step 2: Reference inserted in chapter**
```markdown
Survey methods vary in cost and effectiveness
[See: figures/fig_03_01_survey_comparison.md]. For this study,
we selected online surveys due to budget constraints.
```

**Step 3: (Later) Professional upgrade**
- Create: `fig_03_01_survey_comparison.png` (styled table graphic)
- Update reference: Change .md → .png
- Update registry: 📝 → 🖼️
- Result: Professional table without changing chapter text

---

## Error Handling

**Missing figure file:**
- Registry points to non-existent file
- **Resolution:** Check filename spelling, recreate if needed

**Orphaned figure:**
- Figure file exists but no registry entry
- **Resolution:** Add to registry or remove file

**Broken reference:**
- Chapter references figure that doesn't exist
- **Resolution:** Create figure or update reference

**Duplicate numbers:**
- Two figures with same number in one chapter
- **Resolution:** Renumber sequentially, update all references

---

## Migration from External Figures

**If figures are already in chapter files (inline):**

1. Extract to separate files in `figures/` directory
2. Create registry entry
3. Replace inline content with reference
4. Update _chg file with extraction record
5. Commit changes

**Benefits:**
- Cleaner chapter text
- Easier figure updates
- Better version control
- Professional workflow alignment

---

## Summary

Visual Asset Management Protocol provides:
- ✅ Clear status tracking (📝 text-based vs 🖼️ professional)
- ✅ Standardized directory structure
- ✅ Consistent naming conventions
- ✅ Central registry for all figures
- ✅ Smooth upgrade path from text to professional
- ✅ Integration with framework prompts
- ✅ Version control friendly approach
- ✅ Anti-hallucination compliance

**Used by:** Prompt 14 (primary), Prompt 8 (reporter), Prompts 3/4 (updaters), Prompt 7 (consumer)

---

**Framework Version:** 0.11.0
**Created:** 2025-11-20
**Status:** Active

---

*This protocol enables authors to start writing with text-based visuals immediately, then upgrade to professional graphics as resources and timeline permit*
