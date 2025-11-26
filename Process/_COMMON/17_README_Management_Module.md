# README Management Module

**Module ID:** 17_README_Management_Module
**Version:** 0.13.0
**Purpose:** Manage root-level README.md to prevent bloat and maintain consistent structure

---

## Overview

This module defines the structure and update rules for the user's root-level `README.md` file. The README serves as the project landing page, displaying book metadata, dashboard access, and links to recent reports.

**Key Principles:**
- README.md is **completely regenerated** on each update (user edits are not preserved)
- User warning clearly states that direct edits will be overwritten
- AI directive requires all updates to follow this module
- Structure is consistent and predictable

---

## README.md Structure

The README.md follows this exact structure:

```markdown
# [Book Title]
**Author:** [Author Name]

## About This Book

[Content from Q&A answers during Prompt 1: description, target audience, key themes, etc.]

## Project Information

- **Field Name:** Value
- **Another Field:** Value
[All non-empty fields from .config/metadata.json EXCEPT targetAudience, description, keywords]

## Dashboard

📊 [View Current Dashboard](Manuscript/Dashboard/Dashboard.md)

## Reports

### AI Detection Analysis

| Date | Report Link |
|------|-------------|
| 2025-11-21 | [Chapter 1 Analysis](Manuscript/Reports/ai-detection-chapter-01-2025-11-21.md) |
| 2025-11-20 | [Full Book Analysis](Manuscript/Reports/ai-detection-2025-11-20.md) |

*Showing 5 most recent reports*

### Consistency Check Reports

| Date | Report Link |
|------|-------------|
| 2025-11-21 | [Full Book](Manuscript/Reports/consistency-2025-11-21.md) |
| 2025-11-20 | [Chapter 3](Manuscript/Reports/consistency-chapter-03-2025-11-20.md) |

*Showing 5 most recent reports*

---

⚠️ WARNING: This file is managed automatically. Direct edits may be overwritten. Use framework prompts to update content.

---
**AI Instructions:** This file must be updated using Process/_COMMON/17_README_Management_Module.md
```

---

## Section Definitions

### Title and Author
- **Source:** `.config/metadata.json` (`bookTitle`, `authorName`)
- **Format:** `# [Book Title]` followed by `**Author:** [Author Name]`

### About This Book
- **Source:** Q&A answers from Prompt 1 initialization
  - Book description
  - Target audience
  - Key themes
  - Any other descriptive content collected during initialization
- **Fallback:** If no description available, use: `[Add book description during initialization]`

### Project Information
- **Source:** `.config/metadata.json`
- **Include:** All non-empty fields
- **Exclude:** `targetAudience`, `description`, `keywords` (these go in "About This Book")
- **Format:** Bulleted list with `- **Field Name:** Value`
- **Common fields:**
  - `frameworkVersion`
  - `initDate`
  - `chapterCount`
  - `styleName`
  - `gitVersion`
  - `exportTools`
  - Any other custom metadata

### Dashboard
- **Format:** `📊 [View Current Dashboard](Manuscript/Dashboard/Dashboard.md)`
- **Display:** Only show if `Manuscript/Dashboard/Dashboard.md` exists
- **Creation:** Added by Prompt 10 when first dashboard is created

### Reports
Two tables showing the 5 most recent reports of each type:

#### AI Detection Analysis Table
- **Source:** Scan `Manuscript/Reports/` for files matching `ai-detection-*.md`
- **Sorting:** Newest first (by date parsed from filename)
- **Limit:** 5 most recent reports
- **Link Text:**
  - Chapter-specific files (`ai-detection-chapter-XX-YYYY-MM-DD.md`): `[Chapter X Analysis](...)`
  - Full-book files (`ai-detection-YYYY-MM-DD.md`): `[Full Book Analysis](...)`
- **Empty state:** If no reports, show: `*No reports yet*`

#### Consistency Check Reports Table
- **Source:** Scan `Manuscript/Reports/` for files matching `consistency-*.md`
- **Sorting:** Newest first (by date parsed from filename)
- **Limit:** 5 most recent reports
- **Link Text:**
  - Chapter-specific files (`consistency-chapter-XX-YYYY-MM-DD.md`): `[Chapter X](...)`
  - Full-book files (`consistency-YYYY-MM-DD.md`): `[Full Book](...)`
- **Empty state:** If no reports, show: `*No reports yet*`

### Footer Warnings
Two warnings at the bottom:

1. **User Warning:**
   ```markdown
   ⚠️ WARNING: This file is managed automatically. Direct edits may be overwritten. Use framework prompts to update content.
   ```

2. **AI Directive:**
   ```markdown
   **AI Instructions:** This file must be updated using Process/_COMMON/17_README_Management_Module.md
   ```

---

## Update Triggers

README.md is regenerated when:

1. **Prompt 1 (Initialize)** - Creates initial README.md with metadata
2. **Prompt 8 (Consistency Check)** - After creating report in `Manuscript/Reports/`
3. **Prompt 10 (Dashboard)** - After creating/updating `Manuscript/Dashboard/Dashboard.md`
4. **Prompt 13 (AI Detection)** - After creating report in `Manuscript/Reports/`

---

## Update Procedure

When any prompt needs to update README.md:

### Step 1: Read Metadata
```bash
# Read .config/metadata.json for Project Information
```

### Step 2: Read About Content
```bash
# Read PROJECT_CONTEXT.md or initialization Q&A answers for About This Book
```

### Step 3: Scan for Reports
```bash
# Scan Manuscript/Reports/ for:
# - ai-detection-*.md
# - consistency-*.md
# Parse dates from filenames, sort newest first, take 5 most recent
```

### Step 4: Check Dashboard
```bash
# Check if Manuscript/Dashboard/Dashboard.md exists
```

### Step 5: Generate README.md
- Assemble all sections following exact structure above
- Omit empty sections (e.g., if no reports exist yet)
- Omit Dashboard section if Dashboard.md doesn't exist
- Include footer warnings

### Step 6: Write File
```bash
# Overwrite existing README.md completely
# No preservation of user edits
```

---

## Report Filename Formats

### AI Detection Analysis (Prompt 13)

**Chapter-specific:**
```
ai-detection-chapter-01-2025-11-21.md
ai-detection-chapter-02-2025-11-21.md
```
- Format: `ai-detection-chapter-XX-YYYY-MM-DD.md`
- Link text: `[Chapter X Analysis](...)`

**Full-book:**
```
ai-detection-2025-11-21.md
```
- Format: `ai-detection-YYYY-MM-DD.md`
- Link text: `[Full Book Analysis](...)`

**Duplicate handling:** Overwrite if same date and scope

### Consistency Check Reports (Prompt 8)

**Chapter-specific:**
```
consistency-chapter-01-2025-11-21.md
consistency-chapter-02-2025-11-21.md
```
- Format: `consistency-chapter-XX-YYYY-MM-DD.md`
- Link text: `[Chapter X](...)`

**Full-book:**
```
consistency-2025-11-21.md
```
- Format: `consistency-YYYY-MM-DD.md`
- Link text: `[Full Book](...)`

**Duplicate handling:** Overwrite if same date and scope

---

## Directory Creation

Directories are created **on-demand** when first needed:

- `Manuscript/Reports/` - Created by Prompt 8 or Prompt 13 when first report is generated
- `Manuscript/Dashboard/` - Created by Prompt 10 when first dashboard is generated

Do not pre-create these directories during initialization.

---

## Dashboard Management (Prompt 10 Specific)

When Prompt 10 creates/updates the dashboard:

1. **Check if Dashboard.md exists:**
   - If exists: Ask user to commit before overwriting (git safety)
   - If not exists: Create directory and file

2. **Create/Update Dashboard.md:**
   - Write to `Manuscript/Dashboard/Dashboard.md`
   - Only one dashboard file exists at a time (always overwrite)

3. **Update README.md:**
   - If Dashboard section doesn't exist in README.md, add it
   - Regenerate complete README.md following this module

---

## Example README.md

```markdown
# The Art of Nonfiction Writing
**Author:** Jane Smith

## About This Book

A comprehensive guide to writing professional nonfiction books with AI assistance. This book explores the intersection of traditional authorship and modern AI tools, providing practical frameworks for maintaining creative control while leveraging AI capabilities.

**Target Audience:** Authors, writers, content creators, and anyone interested in AI-assisted writing.

**Key Themes:** AI collaboration, writing frameworks, version control for authors, factual accuracy

## Project Information

- **Framework Version:** 0.13.0
- **Initialized:** 2025-11-21
- **Chapters:** 12
- **Writing Style:** Conversational Expert
- **Git Version:** v1.0.0
- **Export Tools:** pandoc, typst

## Dashboard

📊 [View Current Dashboard](Manuscript/Dashboard/Dashboard.md)

## Reports

### AI Detection Analysis

| Date | Report Link |
|------|-------------|
| 2025-11-21 | [Chapter 3 Analysis](Manuscript/Reports/ai-detection-chapter-03-2025-11-21.md) |
| 2025-11-21 | [Chapter 1 Analysis](Manuscript/Reports/ai-detection-chapter-01-2025-11-21.md) |
| 2025-11-20 | [Full Book Analysis](Manuscript/Reports/ai-detection-2025-11-20.md) |

*Showing 5 most recent reports*

### Consistency Check Reports

| Date | Report Link |
|------|-------------|
| 2025-11-21 | [Full Book](Manuscript/Reports/consistency-2025-11-21.md) |
| 2025-11-20 | [Chapter 5](Manuscript/Reports/consistency-chapter-05-2025-11-20.md) |
| 2025-11-19 | [Full Book](Manuscript/Reports/consistency-2025-11-19.md) |

*Showing 5 most recent reports*

---

⚠️ WARNING: This file is managed automatically. Direct edits may be overwritten. Use framework prompts to update content.

---
**AI Instructions:** This file must be updated using Process/_COMMON/17_README_Management_Module.md
```

---

## Integration with Prompts

### Prompt 1 (Initialize)
- Creates initial README.md after Q&A
- Populates About This Book with user's answers
- Populates Project Information from metadata.json
- No Dashboard section (not created yet)
- No Reports section (no reports yet)
- Includes footer warnings

### Prompt 8 (Consistency Check)
- Creates `Manuscript/Reports/` if doesn't exist
- Generates report with appropriate filename format
- Regenerates README.md with updated Consistency table
- Preserves existing AI Detection table

### Prompt 10 (Dashboard)
- Creates `Manuscript/Dashboard/` if doesn't exist
- Creates/overwrites Dashboard.md (ask for commit if exists)
- Regenerates README.md with Dashboard link (if first time)
- Updates README.md timestamp

### Prompt 13 (AI Detection Analysis)
- Creates `Manuscript/Reports/` if doesn't exist
- Generates report with appropriate filename format
- Regenerates README.md with updated AI Detection table
- Preserves existing Consistency table

---

## Module Version History

### v0.12.9 - 2025-11-21
- Initial creation of README Management Module
- Defines structure, update triggers, and integration rules
- Implements on-demand directory creation
- Establishes report filename formats and table generation rules

---

**End of Module**
