# Semantic Versioning Guide

**Framework Version:** 0.10.0
**Module:** Version Numbering Rules
**Purpose:** Standardized version increment logic

---

## Overview

All content files use semantic versioning (N.M.P) to track changes. This module defines when to increment each version component.

---

## Version Format: N.M.P

### Major.Minor.Patch
- **Major (N.0.0):** Structural changes
- **Minor (0.M.0):** Content additions/deletions
- **Patch (0.0.P):** Refinements and fixes

---

## When to Increment MAJOR (N.0.0)

**Structural changes affecting organization:**

- Chapter reordering
- Major reorganization of sections
- Restructuring that breaks existing structure
- Multiple chapters affected
- Significant architectural changes

**Examples:**
- Reordering all chapters by theme instead of chronology
- Splitting one chapter into multiple chapters
- Merging multiple chapters into one
- Complete restructure of front/back matter

**Version change:**
```
1.5.3 → 2.0.0
```

---

## When to Increment MINOR (0.M.0)

**Significant content changes:**

- Adding new sections
- Removing existing sections
- Substantial expansions (1000+ words)
- Major content revisions
- Adding/removing chapters (at file level)

**Examples:**
- Add new section "Data Validation" (500+ words)
- Remove outdated "Historical Context" section
- Expand "Methodology" from 2 paragraphs to 3 pages
- Significant rewrite of existing section
- Add multiple examples or case studies

**Version change:**
```
1.2.3 → 1.3.0
```

---

## When to Increment PATCH (0.0.P)

**Minor edits and refinements:**

- Typo corrections
- Grammar fixes
- Formatting adjustments
- Small clarifications (sentence or paragraph level)
- Word choice improvements
- Adding citations
- Fixing cross-references

**Examples:**
- Fix spelling errors throughout chapter
- Improve paragraph transitions
- Clarify ambiguous sentence
- Add missing comma
- Update quote formatting
- Fix broken internal link

**Version change:**
```
1.2.3 → 1.2.4
```

---

## Change Type Classifications

### Content Addition
- New content added
- Sections created
- Examples added
- **Typical version:** Minor (0.M.0)

### Content Deletion
- Content removed
- Sections deleted
- Examples removed
- **Typical version:** Minor (0.M.0) if significant, Patch (0.0.P) if small

### Structural Change
- Organization modified
- Sections reordered
- Headings changed
- **Typical version:** Major (N.0.0)

### Refinement
- Edits without adding/removing content
- Improving existing text
- Grammar/spelling fixes
- **Typical version:** Patch (0.0.P)

### Content Update
- Modifying existing content
- Revising sections
- Updating information
- **Typical version:** Minor (0.M.0) if substantial, Patch (0.0.P) if minor

---

## Examples

### Example 1: Patch Increment

**Change:**
```
Fixed typos in Chapter 3:
- "teh" → "the"
- "recieve" → "receive"
- Added missing period at end of paragraph
```

**Version:** 1.2.3 → 1.2.4

---

### Example 2: Minor Increment

**Change:**
```
Added new section "Data Validation" to Chapter 5:
- Validation criteria (3 paragraphs)
- Quality checks (2 paragraphs)
- Error handling (2 paragraphs)
- Example validation workflow
Total: ~600 words added
```

**Version:** 1.2.4 → 1.3.0

---

### Example 3: Major Increment

**Change:**
```
Reorganized all chapters by theme:
- Moved Chapter 3 to Chapter 1 position
- Moved Chapter 1 to Chapter 5 position
- Reordered Chapters 6-10
- Updated all cross-references
- Restructured TOC
```

**Version:** 1.3.0 → 2.0.0

---

## Decision Tree

```
Is this a structural reorganization affecting multiple chapters?
├─ YES → Major (N.0.0)
└─ NO
   │
   Is this adding/removing significant content (sections, 500+ words)?
   ├─ YES → Minor (0.M.0)
   └─ NO
      │
      Is this a refinement, typo fix, or small clarification?
      ├─ YES → Patch (0.0.P)
      └─ UNSURE → Default to Minor (0.M.0)
```

---

## Special Cases

### Initial Creation
**Version:** 1.0.0

```markdown
### Version 1.0.0 - 2025-11-19 - Initial creation

**Type:** Content Addition
**Scope:** New chapter
**Priority:** High
**Rationale:** Initial chapter creation during project initialization
```

### First Content Addition (After Placeholder)
**Version:** 1.0.0 → 1.1.0

Placeholder content doesn't count as "real" content. First substantive content is still v1.1.0.

### Multiple Small Changes
**Each gets its own patch increment:**
- Fix typo: 1.2.3 → 1.2.4
- Fix another typo: 1.2.4 → 1.2.5
- Add clarification: 1.2.5 → 1.2.6

Or, batch together:
- Fix multiple typos and add clarification: 1.2.3 → 1.2.4

### Reset Minor/Patch After Major

**After major increment, minor and patch reset to 0:**
- Before major: 1.5.8
- After major: 2.0.0 (not 2.5.8)

**After minor increment, patch resets to 0:**
- Before minor: 1.2.4
- After minor: 1.3.0 (not 1.3.4)

---

## Implementation

### In _chg Files

```markdown
### Version {N.M.P} - {YYYY-MM-DD} - {Brief Description}

**Type:** {Content Addition | Content Deletion | Structural Change | Refinement | Content Update}
**Scope:** {Specific sections or areas affected}
**Priority:** {Low | Medium | High}
**Rationale:** {Why this change was made}

**Changes Made:**
- {Detailed list of modifications}
- {What was added/removed/changed}
- {Impact on content}
```

### Version Increment Logic

```python
def increment_version(current_version, change_type, change_scope):
    major, minor, patch = parse_version(current_version)

    if change_type == "Structural Change" and affects_multiple_files(change_scope):
        return f"{major + 1}.0.0"

    elif change_type in ["Content Addition", "Content Deletion", "Content Update"]:
        if is_significant(change_scope):  # 500+ words, new sections, etc.
            return f"{major}.{minor + 1}.0"
        else:
            return f"{major}.{minor}.{patch + 1}"

    elif change_type == "Refinement":
        return f"{major}.{minor}.{patch + 1}"

    else:
        # Default to minor
        return f"{major}.{minor + 1}.0"
```

---

**Module Version:** 0.10.0
**Last Updated:** 2025-11-19
**Status:** Active
