# Prompt 7 Reference Documentation

**Version:** 0.15.3
**Purpose:** Detailed compilation options, script usage, and troubleshooting

---

## Overview

This reference provides detailed compilation workflows, format options, and troubleshooting. Load when:
- First time using Prompt 7
- Customizing compilation settings
- Troubleshooting compilation issues
- Understanding script parameters

**For core workflow:** See `Prompt_7_Compile.md`

---

## Compilation Script Details

### Script Location

```bash
Process/Scripts/compile-manuscript.sh
```

### Script Parameters

```bash
bash Process/Scripts/compile-manuscript.sh FORMAT
```

| Parameter | Description | Example |
|-----------|-------------|---------|
| FORMAT | Output format | `formatted` |

**Note:** Version number is auto-calculated from existing files in Drafts folder.

### Format Options

**Basic:**
- Simple file concatenation
- Minimal formatting
- Fastest compilation
- Best for quick reviews

**Formatted (Default):**
- Proper heading hierarchy
- Page breaks between chapters
- Consistent spacing
- Recommended for most uses

**Publication-Ready:**
- Full formatting
- All cross-references resolved
- Epigraphs inserted
- Ready for Prompt 9 export

---

## Assembly Order

The script assembles content in this order:

### 1. Front Matter

```
Manuscript/FrontMatter/
├── Copyright.md
├── Title_Page.md
├── Dedication.md
├── Acknowledgments.md
├── Preface.md
└── Introduction.md
```

**Order:** Files are assembled in alphabetical order or by custom manifest.

### 2. Chapters

**Flat Structure:**
```
Manuscript/Chapters/
├── Chapter_01.md
├── Chapter_02.md
└── Chapter_03.md
```

**Subdirectory Structure:**
```
Manuscript/Chapters/
├── Chapter_01/
│   └── Chapter_01.md
├── Chapter_02/
│   └── Chapter_02.md
└── Chapter_03/
    └── Chapter_03.md
```

**Order:** Numerical by chapter number.

### 3. Back Matter

```
Manuscript/BackMatter/
├── Appendix_A.md
├── Appendix_B.md
├── Glossary.md
├── Bibliography/
│   └── Bibliography.md
└── About_Author.md
```

---

## Epigraph Processing

### Source File

```
Manuscript/Quotes/Chapter_Quotes.md
```

### Quote Status Handling

| Status | Symbol | Compilation Behavior |
|--------|--------|----------------------|
| Verified | ✓ | Insert as epigraph |
| Needs Citation | ⚠ | Insert with warning |
| Pending | ⏳ | Skip (not verified) |

### Epigraph Format

```markdown
# Chapter 5: The Journey Begins

> "The journey of a thousand miles begins with a single step."
>
> — Lao Tzu, *Tao Te Ching* (6th century BCE)

[Chapter content begins here...]
```

---

## Output File Format

### Metadata Header

```markdown
# [Working Title]

**Author:** [Author Name]
**Compile:** #03
**Compiled:** 2025-11-24 14:30:00
**Format:** Formatted

---

## Table of Contents

1. [Chapter 1: Introduction](#chapter-1-introduction)
2. [Chapter 2: Background](#chapter-2-background)
...

---
```

### File Naming

```
Manuscript/Drafts/[Project-Name]-[format]-vNN.md
```

**Examples:**
- `My-Book-Title-formatted-v01.md`
- `My-Book-Title-publication-v03.md`

**Version numbering:**
- Starts at v01 for first compile
- Auto-increments based on existing files matching same project and format
- Each format type has independent version sequence

---

## Statistics Report

After compilation, the script displays:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ Compilation Complete
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Output File: Manuscript/Drafts/My-Book-Title-formatted-v03.md

Statistics:
- Compile: #03
- Total word count: 45,230 words
- Total line count: 3,456 lines
- Chapters compiled: 12
- Format applied: Formatted

Epigraph Status:
- Inserted: 8 (verified quotes)
- Skipped: 2 (pending verification)
- Warnings: 2 (needs citation)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Cross-Reference Processing

### Internal Links

The script validates and processes internal links:

```markdown
See [Chapter 5](#chapter-5-title) for details.
```

### Missing Reference Handling

```
⚠️ Warning: Reference to [Chapter 8] not found
  Location: Chapter_03.md:145
  Action: Verify chapter exists or update reference
```

---

## Configuration

### Metadata Source

```
.config/metadata.json
```

```json
{
  "book": {
    "title": "Working Title",
    "author": "Author Name"
  },
  "version": {
    "current": "1.0.0"
  }
}
```

### Compilation Settings

```
.config/project.json
```

```json
{
  "settings": {
    "compilation": {
      "defaultFormat": "formatted",
      "includeEpigraphs": true,
      "generateTOC": true
    }
  }
}
```

---

## Troubleshooting

### "File not found" Error

**Error:** `Chapter_05.md not found`

**Cause:** Missing chapter file

**Solution:**
1. Check if file exists in expected location
2. Verify both flat and subdirectory structures
3. Run Prompt 10 to check project status

### "Script not found" Error

**Error:** `compile-manuscript.sh: not found`

**Solution:**
1. Verify script exists: `ls Process/Scripts/`
2. Check execute permissions: `chmod +x Process/Scripts/*.sh`
3. Run from project root directory

### Empty Output

**Cause:** No content files found

**Solution:**
1. Verify Manuscript/Chapters/ contains files
2. Check file naming (Chapter_XX.md)
3. Ensure files have content

### Large File Size

**Issue:** Compiled file very large

**Cause:** Many images embedded or large chapters

**Solution:**
1. Images are referenced, not embedded
2. Check for duplicate content
3. Normal for large books (50K+ words)

### Epigraphs Not Appearing

**Cause:** Quotes not verified

**Solution:**
1. Check `Chapter_Quotes.md` for status
2. Mark verified quotes with ✓
3. Use "Publication-Ready" format

### Wrong Chapter Order

**Cause:** Non-standard chapter naming

**Solution:**
1. Use format: `Chapter_01.md`, `Chapter_02.md`
2. Include leading zeros for 1-9
3. Check for duplicates

---

## Manual Compilation Alternative

If script fails, manual compilation:

```bash
# Determine output filename (find next version number)
PROJECT_NAME="My-Book-Title"  # Sanitized book title
FORMAT="formatted"
NEXT=$(ls Manuscript/Drafts/${PROJECT_NAME}-${FORMAT}-v*.md 2>/dev/null | \
  sed 's/.*-v\([0-9]*\)\.md/\1/' | sort -n | tail -1)
VERSION=$(printf "%02d" $((${NEXT:-0} + 1)))
OUTPUT="Manuscript/Drafts/${PROJECT_NAME}-${FORMAT}-v${VERSION}.md"

# Create output file
touch "$OUTPUT"

# Add metadata header
cat >> "$OUTPUT" << EOF
# [Title]
**Author:** [Name]
**Compile:** #${VERSION}
**Compiled:** $(date '+%Y-%m-%d %H:%M:%S')
EOF

# Concatenate front matter
cat Manuscript/FrontMatter/*.md >> "$OUTPUT"

# Concatenate chapters (sorted)
for f in $(ls -v Manuscript/Chapters/Chapter_*.md 2>/dev/null || ls -v Manuscript/Chapters/*/Chapter_*.md); do
  cat "$f" >> "$OUTPUT"
done

# Concatenate back matter
cat Manuscript/BackMatter/*.md >> "$OUTPUT"
```

---

## Related Prompts

| Prompt | Relationship |
|--------|--------------|
| Prompt 8 | Run before compilation to check consistency |
| Prompt 9 | Run after compilation to export formats |
| Prompt 10 | View progress before compilation |

---

**Version:** 0.15.3
**For Core Workflow:** See `Prompt_7_Compile.md`
