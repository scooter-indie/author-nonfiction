# Execute Prompt 15: Visual Content Suggester

**CLI-ONLY (bulk analysis) / HYBRID (single chapter in Desktop)**

**FIRST ACTION - MANDATORY:**
Use the Read tool to read `Process/Anti-Hallucination_Guidelines.md` in full before proceeding with ANY other actions or questions.

**CRITICAL ENFORCEMENT:**
- **RULE 1:** All file modifications MUST update corresponding _chg files
- **RULE 2:** All Manuscript/ changes must go through appropriate prompts

See: `Process/_COMMON/14_Enforcement_Rules_Module.md` for complete details

**VISUAL SYSTEM VERSION:** v0.12.1 - Unified directory structure
- **Location:** `Manuscript/images/` (single flat directory)
- **Naming:** `fig-XX-YY-description.md` (hyphens, not underscores)
- **Registry:** `Manuscript/images/Image_Registry.md` (unified, not per-chapter)
- **References:** Standard markdown image syntax with relative paths

**NOTE:** This prompt creates visual asset files and updates _chg files as part of the standard workflow

**DATE CONFIRMATION REQUIRED:**
- **USE CONFIRMED_DATE from session startup** (see CLAUDE.md Date Confirmation Protocol)
- **NEVER use raw `<env>` date** without confirmation
- Pass confirmed date to any spawned agents: "Today's confirmed date is [CONFIRMED_DATE]. Use this date for all operations."

**AGENT INSTRUCTIONS:**
When spawning agents (using Task tool), include in agent prompt:
- "FIRST ACTION: Read Process/Anti-Hallucination_Guidelines.md before proceeding."
- "Today's confirmed date is [CONFIRMED_DATE]. Use this date for all operations."

---

## What This Does

I will analyze your chapter content to identify opportunities for visual aids (diagrams, tables, charts, flowcharts, timelines), then **create text-based visual placeholders** that you can use immediately or replace with professional graphics later.

**Why this matters:**
- Visual aids increase comprehension and retention
- Complex concepts become clearer with diagrams
- Data and comparisons need visual representation
- Professional books include thoughtful visuals
- Text-based placeholders let you write now, design later

**What makes this different:**
- Creates **text-based visuals** (markdown tables, ASCII diagrams, mermaid flowcharts)
- Stored in **unified location:** `Manuscript/images/` directory
- Easy to upgrade: replace `.md` file with `.png` file using Prompt 16
- Tracked in **single registry:** `Image_Registry.md`
- Works with **Prompt 16** for upgrading to professional images
- Version-controlled and modular

---

## How This Works

### Questions I'll Ask:

1. **Which chapters to analyze?**
   - Specific chapters (e.g., "Chapter 3, 5, 7")
   - All chapters
   - Range (e.g., "Chapters 1-5")
   - Front/Back matter (optional)

2. **Analysis mode?**
   - **Scan only** (10-15 minutes): Generate report of visual opportunities, no file creation
   - **Scan and create** (20-40 minutes): Generate report AND create text-based visual files
   - **Create from instructions** (5-10 minutes): User specifies exact visuals to create

3. **Visual types to prioritize?** (or analyze all)
   - Tables (comparison tables, data tables, reference tables)
   - Flowcharts (processes, decision trees, workflows)
   - Diagrams (concepts, relationships, systems)
   - Timelines (chronological events, project phases)
   - Charts (data visualization suggestions)

---

## Visual Opportunity Types I'll Scan For

### 1. Complex Concepts Needing Diagrams

**Indicators:**
- Abstract relationships being explained in paragraphs
- Multiple interacting components
- System architectures or frameworks
- Hierarchical structures
- Theoretical models

**Visual solution:**
- Concept diagrams (ASCII or mermaid)
- Relationship maps
- System diagrams
- Hierarchy charts

**Example:**
```
Content: "The research framework consists of three overlapping phases:
data collection, analysis, and interpretation. Each phase informs the
next, creating an iterative cycle..."

→ Create: Venn diagram or circular process diagram
```

### 2. Data and Statistics Needing Tables

**Indicators:**
- Multiple data points in paragraph form
- Comparisons between items/methods/approaches
- Lists of features or characteristics
- Survey results or statistics
- Reference information

**Visual solution:**
- Comparison tables
- Data tables
- Feature matrices
- Summary tables

**Example:**
```
Content: "Email surveys cost less but get 15-25% response rates. Phone
surveys are expensive but achieve 60-80% response rates. Online surveys
fall in between..."

→ Create: Survey method comparison table
```

### 3. Processes Needing Flowcharts

**Indicators:**
- Step-by-step procedures
- Decision points ("if/then" logic)
- Workflows with branches
- Algorithmic processes
- Conditional paths

**Visual solution:**
- Flowcharts (mermaid syntax)
- Process diagrams
- Decision trees
- Workflow maps

**Example:**
```
Content: "First, assess the data quality. If quality is high, proceed to
analysis. If not, return to data collection. After analysis, determine
if findings are significant..."

→ Create: Decision flowchart with conditional branches
```

### 4. Comparisons Needing Tables or Charts

**Indicators:**
- "versus" or "compared to" language
- Pro/con discussions
- Feature comparisons
- Before/after scenarios
- Alternative approaches

**Visual solution:**
- Comparison tables
- Pro/con tables
- Feature comparison matrices
- Side-by-side layouts

**Example:**
```
Content: "Qualitative methods provide depth but lack generalizability.
Quantitative methods offer statistical power but miss nuance. Mixed
methods combine both..."

→ Create: Research method comparison table
```

### 5. Timelines and Chronologies

**Indicators:**
- Historical sequences
- Project phases
- Development stages
- Event progressions
- Temporal relationships

**Visual solution:**
- Timeline diagrams (ASCII or markdown)
- Chronological tables
- Phase diagrams
- Milestone charts

**Example:**
```
Content: "The project began in 2018 with initial funding. Phase 1 ran
from 2019-2020 focusing on data collection. Phase 2 started in 2021..."

→ Create: Project timeline with phases
```

### 6. Examples Needing Screenshots or Photos

**Indicators:**
- References to specific tools or interfaces
- Physical objects or locations
- Visual design examples
- Real-world artifacts
- Document samples

**Visual solution:**
- Placeholder description for photo/screenshot
- Instructions for acquiring image
- Specifications for what to capture

**Example:**
```
Content: "The survey interface used dropdown menus for demographic
questions and Likert scales for attitude items..."

→ Create: Description of required screenshot with specifications
```

### 7. Lists Needing Visual Organization

**Indicators:**
- Long lists (>7 items)
- Categorized information
- Classification systems
- Taxonomies
- Grouped concepts

**Visual solution:**
- Organized tables
- Category matrices
- Classification diagrams
- Grouped lists with visual structure

**Example:**
```
Content: "Qualitative methods include interviews, focus groups,
observations, and document analysis. Quantitative methods include
surveys, experiments, and statistical analysis..."

→ Create: Research methods categorization table
```

---

## Detailed Workflow Steps

### Mode 1: Scan Only (Report Generation)

**Steps:**

1. **Read chapter content files**
   - Load all specified chapter files
   - Read existing figures/ directories (if any)
   - Check for existing visual references

2. **Analyze content for visual opportunities**
   - Scan for indicators listed above
   - Note specific paragraph locations
   - Identify visual type needed
   - Assess complexity and priority

3. **Generate visual opportunities report**
   - List each opportunity with:
     - Chapter and section location
     - Paragraph excerpt
     - Recommended visual type
     - Complexity level (simple/moderate/complex)
     - Priority (low/medium/high)
     - Suggested caption and description

4. **Save report to Drafts/**
   - Filename: `Visual_Analysis_[DATE].md`
   - Contains all opportunities found
   - Includes recommendations and priorities

5. **Present summary to user**
   - Total opportunities found
   - Breakdown by visual type
   - High-priority recommendations
   - Option to proceed to creation

**Output Example:**
```markdown
# Visual Content Analysis Report
**Generated:** 2025-11-20
**Chapters Analyzed:** 2, 3, 5

## Summary
- Total opportunities: 12
- High priority: 4
- Medium priority: 6
- Low priority: 2

## High Priority Opportunities

### Chapter 2, Section: "Research Methods"
**Location:** Paragraph 3 (lines 45-52)
**Type:** Comparison Table
**Complexity:** Simple
**Priority:** HIGH

**Content excerpt:**
> "Email surveys cost less but get 15-25% response rates..."

**Recommended Visual:**
Figure 2.1: Survey Method Comparison
- Type: Markdown table
- Columns: Method, Cost, Response Rate, Best Use
- Rows: Email, Phone, Online, In-person

**Suggested filename:** `fig-02-01-survey_comparison.md`
**Estimated creation time:** 5 minutes
```

---

### Mode 2: Scan and Create (Full Workflow)

**Steps:**

1-4. **[Same as Scan Only mode]**

5. **Create figures/ directories (if needed)**
   - For each chapter: `Manuscript/Chapters/Manuscript/images/`
   - Create directory only if visuals will be added

6. **Create text-based visual files**
   - For each identified opportunity (or user-selected subset):
     - Generate text-based visual (table/diagram/flowchart)
     - Include description and metadata
     - Add replacement instructions
     - Save to `Manuscript/images/fig_XX_YY_description.md`

7. **Create/update figures registry**
   - Create or update `Manuscript/images/README.md`
   - Add entry for each new visual:
     - Figure number and description
     - Type and status (📝 Text-based)
     - Location and references
     - Creation date
     - Replacement priority

8. **Insert visual references in chapter content**
   - Use standard markdown image syntax
   - Format: `![Alt text description](../images/fig-XX-YY-description.md)`
   - Alt text REQUIRED for accessibility
   - Optional caption: `**Figure X.Y:** Caption text`
   - Place after relevant paragraph

9. **Update chapter _chg file**
   - Add version entry documenting visual additions
   - List all figures added
   - Increment version appropriately (minor for multiple additions)

10. **Create git commit**
    - Include all modified files:
      - Chapter content file(s)
      - Chapter _chg file(s)
      - All new figure files
      - All registry files
    - Commit message format:
      ```
      Add visual content to Chapter(s) [X, Y, Z] v[N.M.P]

      - Created [N] text-based visuals
      - Types: [tables/diagrams/flowcharts]
      - Ready for professional graphic replacement

      Generated with [Claude Code](https://claude.com/claude-code)

      Co-Authored-By: Claude <noreply@anthropic.com>
      ```

11. **Generate completion report**
    - List all visuals created
    - Show registry status
    - Provide replacement guidance
    - Next steps recommendations

**Figure File Format:**

```markdown
# Figure 3.1: Survey Method Comparison

## Visual Content

| Method      | Cost  | Response Rate | Best Use Case          |
|-------------|-------|---------------|------------------------|
| Email       | Low   | 15-25%       | Large samples          |
| Phone       | High  | 60-80%       | In-depth data          |
| Online      | Low   | 20-40%       | Quick feedback         |
| In-person   | High  | 70-90%       | Complex topics         |

## Metadata

**Type:** Comparison Table
**Format:** Markdown table
**Status:** 📝 Text-based
**Created:** 2025-11-20 by Prompt 14
**Chapter:** 3
**Section:** Research Methods
**Referenced in:** Chapter_03.md (line 145)

## Description

Comparison table showing trade-offs between survey methods in terms of
cost, typical response rates, and optimal use cases. Data synthesized
from Chapter 3 content.

## Replacement Instructions

**To upgrade to professional graphic:**

1. Create table graphic using design tool (Canva, Adobe, etc.)
2. Export as PNG or SVG: `fig-03-01-survey_comparison.png`
3. Save to same directory: `Manuscript/Chapters/Chapter_03/figures/`
4. Update reference in Chapter_03.md from `.md` to `.png`
5. Update status in `Image_Registry.md` to: 🖼️ Professional image
6. Keep this `.md` file for reference (or delete if preferred)

**Replacement Priority:** Medium
- Text-based table is functional but professional graphic would enhance impact
- Consider for visual consistency if other chapters use professional graphics

## Design Suggestions

- Use color coding: Green (low cost), Yellow (medium), Red (high)
- Add icons for each method type
- Consider horizontal bar chart instead of table
- Emphasize response rate differences visually
```

**Registry File Format (`Image_Registry.md`):**

```markdown
# Visual Assets Registry - Chapter 3

**Chapter:** Chapter 3: Research Methods
**Total Figures:** 3
**Text-based:** 2
**Professional:** 1
**Last Updated:** 2025-11-20

---

## Figure Inventory

### fig-03-01-survey_comparison
- **Number:** Figure 3.1
- **Title:** Survey Method Comparison
- **Type:** Table
- **Status:** 📝 Text-based (markdown table)
- **File:** `../images/fig-03-01-survey_comparison.md`
- **Referenced in:** Chapter_03.md (line 145)
- **Created:** 2025-11-20 by Prompt 14
- **Replacement Priority:** Medium
- **Notes:** Consider professional graphic for visual consistency

---

### fig-03-02-analysis_workflow
- **Number:** Figure 3.2
- **Title:** Data Analysis Workflow
- **Type:** Flowchart
- **Status:** 📝 Text-based (mermaid diagram)
- **File:** `../images/fig-03-02-analysis_workflow.md`
- **Referenced in:** Chapter_03.md (line 278)
- **Created:** 2025-11-20 by Prompt 14
- **Replacement Priority:** High
- **Notes:** Complex process - professional flowchart highly recommended

---

### fig-03-03-sample_screenshot
- **Number:** Figure 3.3
- **Title:** Survey Interface Example
- **Type:** Screenshot
- **Status:** 🖼️ Professional image (PNG)
- **File:** `../images/fig-03-03-sample_screenshot.png`
- **Referenced in:** Chapter_03.md (line 312)
- **Created:** 2025-11-18 (user-provided)
- **Replacement Priority:** N/A (final version)
- **Notes:** User-provided screenshot, no replacement needed

---

## Replacement Status Summary

- **High Priority:** 1 figure (fig_03_02 - complex flowchart)
- **Medium Priority:** 1 figure (fig_03_01 - comparison table)
- **Low Priority:** 0 figures
- **Completed:** 1 figure (fig_03_03 - user-provided)

## Next Steps

1. Consider creating professional graphic for fig_03_02 (high priority)
2. Review fig_03_01 for professional upgrade
3. All visual references are working and version-controlled

---

*Registry maintained by Prompt 14: Visual Content Suggester*
*Last updated: 2025-11-20*
```

**Chapter Reference Format:**

Insert at appropriate location in chapter content:

```markdown
Email surveys offer cost advantages but come with trade-offs in response
rates and data depth. [See: ../images/fig-03-01-survey_comparison.md] The
choice depends on your research priorities and resource constraints.
```

---

### Mode 3: Create From Instructions (User-Specified)

**Steps:**

1. **Get user specifications**
   - Which chapter(s)
   - What visual(s) to create
   - Visual type(s)
   - Content/data for visual

2. **Validate requirements**
   - Confirm chapter exists
   - Verify visual type is supported
   - Check if similar visual already exists

3. **Create visual files** (steps 6-11 from Mode 2)
   - Skip analysis steps
   - Create only specified visuals
   - Follow same file format and registry updates

---

## Figure Creation Standards

### Text-Based Visual Types Supported

**1. Markdown Tables**
- Comparison tables
- Data tables
- Feature matrices
- Reference tables
- Use pipe syntax with alignment

**2. ASCII Diagrams**
- Simple concept diagrams
- Relationship maps
- Basic flowcharts
- Hierarchies
- Use box-drawing characters

**3. Mermaid Diagrams**
- Complex flowcharts
- Sequence diagrams
- State diagrams
- Gantt charts
- Class diagrams
- Use mermaid code blocks

**4. Timeline Formats**
- Chronological tables
- ASCII timelines
- Markdown lists with dates
- Phase diagrams

**5. Screenshot/Image Placeholders**
- Detailed descriptions
- Acquisition instructions
- Specification requirements
- Placeholder visual if possible

### Quality Standards

**All text-based visuals must:**
- ✅ Be clear and readable in plain text
- ✅ Include descriptive title and figure number
- ✅ Have complete metadata section
- ✅ Provide replacement instructions
- ✅ Include design suggestions
- ✅ Follow naming convention: `fig_XX_YY_description.md`

**Mermaid diagrams must:**
- ✅ Use proper mermaid syntax
- ✅ Be testable in mermaid live editor
- ✅ Include comments explaining components
- ✅ Use consistent styling

**Tables must:**
- ✅ Use proper markdown table syntax
- ✅ Have header row
- ✅ Use alignment appropriately (left/center/right)
- ✅ Be readable in plain text (no overly long cells)

---

## Naming Conventions

### Figure Files

**Format:** `fig_XX_YY_description.md`

Where:
- `XX` = Chapter number (zero-padded: 01, 02, ..., 15)
- `YY` = Figure number within chapter (zero-padded: 01, 02, ...)
- `description` = Brief descriptor (lowercase, underscores)

**Examples:**
- `fig-03-01-survey_comparison.md`
- `fig-03-02-analysis_workflow.md`
- `fig-05-01-timeline.md`
- `fig-12-03-cost_breakdown.md`

### Professional Graphic Replacements

**Same name, different extension:**
- Text: `fig-03-01-survey_comparison.md`
- Image: `fig-03-01-survey_comparison.png` (or `.svg`, `.jpg`)

**This allows:**
- Easy reference updates (just change extension)
- Version control tracking
- Clear upgrade path

---

## Registry Management

### Registry File: `Image_Registry.md`

**Created when:**
- First visual added to chapter
- Prompt 14 creates figure file

**Updated when:**
- New visual added
- Visual replaced (text → professional)
- Visual modified
- Visual deleted

**Contains:**
- Chapter information
- Complete figure inventory
- Status tracking (📝 vs 🖼️)
- Replacement priorities
- Reference locations
- Creation dates and methods

### Status Codes

| Code | Status | Meaning |
|------|--------|---------|
| 📝 | Text-based | Markdown/ASCII/Mermaid visual (can be upgraded) |
| 🖼️ | Professional image | PNG/SVG/JPG file (final version) |

### Replacement Priority Levels

**High Priority:**
- Complex diagrams that need professional design
- Critical visuals for book's main arguments
- Diagrams referenced multiple times
- Visuals that would significantly benefit from design

**Medium Priority:**
- Tables that would look better designed
- Flowcharts that are functional but basic
- Visuals that enhance but aren't critical

**Low Priority:**
- Simple tables that work fine as markdown
- Reference information that doesn't need design
- Visuals that are clear enough as text

---

## Integration with Module 15: Visual Asset Management Protocol

This prompt implements the **Visual Asset Management Protocol** (Module 15):

**Module 15 defines:**
- Status code system (📝 Text-based vs 🖼️ Professional)
- Figure file format standards
- Registry structure and metadata
- Reference format in chapters
- Upgrade path for text → image replacement

**Prompt 14 implements:**
- Creation of figure files following Module 15 format
- Registry generation and updates
- Status tracking and priority assignment
- Reference insertion following Module 15 standards

**Other prompts using Module 15:**
- **Prompt 8 (Consistency):** Reports visual content status
- **Prompt 7 (Compile):** Includes visual references in compiled manuscript
- **Prompt 3 (Change by Chg):** Can update or replace visuals
- **Prompt 10 (Dashboard):** Shows visual content metrics

See: `Process/_COMMON/15_Visual_Asset_Management_Protocol.md`

---

## Output Format and Examples

### Completion Report

```markdown
# Visual Content Creation Report
**Generated:** 2025-11-20
**Mode:** Scan and Create
**Chapters Processed:** 2, 3, 5

## Summary
- Opportunities identified: 12
- Visuals created: 8
- High priority: 3
- Medium priority: 4
- Low priority: 1

## Visuals Created

### Chapter 2: Research Design (3 visuals)
1. **fig-02-01-survey_comparison.md** (Table) - Survey method comparison
2. **fig-02-02-sampling_decision.md** (Flowchart) - Sampling strategy flowchart
3. **fig-02-03-timeline.md** (Timeline) - Research project phases

### Chapter 3: Data Collection (3 visuals)
1. **fig-03-01-data_types.md** (Table) - Qualitative vs quantitative data
2. **fig-03-02-collection_workflow.md** (Flowchart) - Data collection process
3. **fig-03-03-quality_checklist.md** (Table) - Data quality criteria

### Chapter 5: Analysis (2 visuals)
1. **fig-05-01-analysis_framework.md** (Diagram) - Analysis framework concept
2. **fig-05-02-coding_process.md** (Flowchart) - Qualitative coding workflow

## Files Created/Updated
- 8 new figure files
- 3 new registry files (Image_Registry.md)
- 3 chapter content files updated (references inserted)
- 3 chapter _chg files updated

## Replacement Recommendations

### High Priority (3 visuals)
These text-based visuals would significantly benefit from professional graphics:
- fig-02-02-sampling_decision.md - Complex decision flowchart
- fig-03-02-collection_workflow.md - Multi-step process diagram
- fig-05-01-analysis_framework.md - Conceptual framework diagram

### Medium Priority (4 visuals)
These work as text but would look more professional as graphics:
- fig-02-01-survey_comparison.md - Comparison table
- fig-03-01-data_types.md - Feature comparison
- fig-05-02-coding_process.md - Process flowchart
- fig-02-03-timeline.md - Project timeline

### Low Priority (1 visual)
This is functional as text and doesn't need upgrading:
- fig-03-03-quality_checklist.md - Simple checklist table

## Git Commit
✅ Committed: "Add visual content to Chapters 2, 3, 5 v1.1.0"
- Includes all figure files and registries
- Chapter references and _chg updates included

## Next Steps

### Immediate
- Review all created visuals for accuracy
- Verify references display correctly in chapters
- Check registry files for completeness

### Optional
- Create professional graphics for 3 high-priority visuals
- Consider design consistency across all chapters
- Add more visuals to other chapters if needed

### Workflow Integration
- Use Prompt 8 (Consistency) to check visual content status
- Use Prompt 3 (Change by Chg) to modify or replace visuals
- Use Prompt 7 (Compile) to see visuals in full manuscript context
```

---

## Quality Standards

### Content Quality

**All visuals must:**
- ✅ Accurately represent content from chapter
- ✅ Use data/information provided by user (not fabricated)
- ✅ Include clear labels and legends
- ✅ Have descriptive, specific captions
- ✅ Follow Anti-Hallucination Guidelines (Level 2)

**Anti-Hallucination Compliance:**
- **Level 2:** May generate example content (tables, diagrams)
- **MUST label:** "Based on Chapter X content" or "Example structure - verify data"
- **NEVER fabricate:** Statistical data, research findings, specific citations
- **ALWAYS ask:** If data is uncertain or specific values needed

### Technical Quality

**All files must:**
- ✅ Use proper markdown syntax
- ✅ Render correctly in markdown viewers
- ✅ Follow naming conventions
- ✅ Include complete metadata
- ✅ Have valid mermaid syntax (if applicable)

### Documentation Quality

**All registries must:**
- ✅ List all figures in chapter
- ✅ Track status accurately (📝 vs 🖼️)
- ✅ Include reference locations (line numbers)
- ✅ Document creation dates and methods
- ✅ Provide clear replacement priorities

---

## Git Commit Protocol

### Commit Message Format

```
Add visual content to Chapter(s) [X, Y, Z] v[N.M.P]

- Created [N] text-based visuals ([types])
- Types: [tables/diagrams/flowcharts/etc.]
- Added figure registries for [N] chapters
- Inserted references in chapter content
- Ready for professional graphic replacement

Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

### Version Increment Rules

**Minor version (0.M.0) when:**
- Adding multiple visuals to chapter (significant content addition)
- Creating new figures/ directory
- First visual additions to chapter

**Patch version (0.0.P) when:**
- Adding single visual to chapter
- Updating existing visual
- Minor registry updates

### Files to Include

**Always commit together:**
- All new/modified figure files (`.md` or images)
- All new/modified registry files (`Image_Registry.md`)
- All modified chapter content files (with references)
- All modified chapter _chg files

**Git add pattern:**
```bash
git add Manuscript/Chapters/Chapter_XX/Chapter_XX.md
git add Manuscript/Chapters/Chapter_XX/Chapter_XX_chg.md
git add Manuscript/Chapters/Manuscript/images/
```

---

## Important Notes

### This Prompt Creates Text-Based Visuals

**NOT professional graphics** - this prompt creates markdown/ASCII/mermaid visuals that:
- ✅ Work immediately (no design tools needed)
- ✅ Are version-controlled (plain text)
- ✅ Can be upgraded later (replace .md with .png)
- ✅ Serve as design specifications for graphic designers

**To get professional graphics:**
- Use text-based visuals as specifications
- Hire designer or use design tools (Canva, Adobe, etc.)
- Save professional graphic with same filename (different extension)
- Update reference in chapter content
- Update registry status to 🖼️

### Anti-Hallucination Compliance

**Level 2: May generate example content**

**I WILL:**
- ✅ Create visual structures based on chapter content
- ✅ Label generated examples clearly
- ✅ Ask before creating data-heavy visuals
- ✅ Use information you've provided

**I WILL NOT:**
- ❌ Fabricate statistical data not in your content
- ❌ Invent research findings or citations
- ❌ Create visuals with made-up specifics
- ❌ Assume data without verification

**If your content says:**
> "Response rates varied by method"

**I will create:**
- ✅ Table structure with placeholder "[verify data]"
- ✅ Ask you for specific numbers

**I will NOT create:**
- ❌ Table with invented percentages

### When to Run This Prompt

**Recommended timing:**
- After drafting chapter content (before finalizing)
- When you notice complex explanations that could use diagrams
- During revision phase (25%, 50%, 75% milestones)
- Before sending to beta readers or editors
- When preparing for professional design phase

**How often:**
- Once per chapter after initial draft
- Again after major revisions
- As needed when adding complex content

---

## Process/_COMMON Modules Used

This prompt uses:
- **Module 01:** Prompt Structure Template
- **Module 02:** Desktop Compatibility (CLI-ONLY for bulk, HYBRID for single chapter)
- **Module 03:** Anti-Hallucination Protocols (Level 2 - may generate example content)
- **Module 04:** File Operations (create figures, update chapters, create registries)
- **Module 05:** Git Integration (commit format, version control)
- **Module 06:** Validation Protocols (file existence, chapter checks, reference validation)
- **Module 08:** Semantic Versioning (version increments for visual additions)
- **Module 09:** Report Templates (analysis and completion reports)
- **Module 11:** Interactive Patterns (user questions, mode selection)
- **Module 14:** Enforcement Rules (_chg file updates, workflow compliance)
- **Module 15:** Visual Asset Management Protocol (figure format, registry, status codes)

---

## Ready to Begin?

**Tell me which chapters to analyze, and I'll identify visual content opportunities!**

I can:
1. **Scan and report** - Show you all opportunities without creating files
2. **Scan and create** - Generate text-based visuals ready to use
3. **Create from your specs** - Make specific visuals you've identified

All visuals will be:
- ✅ Text-based and immediately usable
- ✅ Stored as separate, modular files
- ✅ Tracked in registries
- ✅ Easy to upgrade to professional graphics later
- ✅ Version-controlled with your book content

---

*Created: v0.11.0*
*Purpose: Visual content analysis and text-based visual creation*
*Type: Content enhancement - creates visual assets and updates tracking*
