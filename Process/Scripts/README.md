# Framework Scripts

**Directory:** Process/Scripts/
**Purpose:** Bash scripts for efficient bulk operations in the AI-Assisted Nonfiction Authoring Framework

---

## Available Scripts

### compile-manuscript.sh

**Purpose:** Compile complete manuscript from all content files

**Usage:**
```bash
bash Process/Scripts/compile-manuscript.sh VERSION DATE [FORMAT]
```

**Parameters:**
- `VERSION` (required): Version number (e.g., "1.0.0")
- `DATE` (required): Compilation date in YYYY-MM-DD format (use CONFIRMED_DATE from session)
- `FORMAT` (optional): Compilation format
  - `basic` - Simple concatenation, minimal formatting
  - `formatted` - Proper hierarchy, page breaks, spacing (default)
  - `publication` - Full formatting, ready for export

**Example:**
```bash
bash Process/Scripts/compile-manuscript.sh 1.0.0 2025-11-22 formatted
```

**Output:**
- Creates: `Manuscript/Drafts/Full_Draft_[DATE]_v[VERSION].md`
- Displays: Word count, line count, statistics

**Requirements:**
- `jq` (optional, for metadata extraction from .config/metadata.json)
- If jq not available, uses placeholder values for book title and author

**Used by:**
- **Prompt 7:** Compile Complete Manuscript

**Features:**
- Reads metadata from `.config/metadata.json`
- Assembles content in correct order (Front Matter → Chapters → Back Matter)
- Handles both flat and subdirectory chapter structures
- Adds compilation header with metadata
- Calculates word and line count statistics

**Structure Support:**
- Flat: `Manuscript/Chapters/Chapter_XX.md`
- Subdirectory: `Manuscript/Chapters/Chapter_XX/Chapter_XX.md`

---

## Script Development Guidelines

When adding new scripts to this directory:

1. **Use bash** for file operations, text processing, bulk operations
2. **Include usage documentation** in script header
3. **Add to this README** with purpose, usage, and examples
4. **Make scripts robust**: Check for required parameters, handle errors, provide clear output
5. **Support both Windows and Unix**: Use portable bash constructs
6. **Document requirements**: List any external tools needed (jq, pandoc, etc.)

---

## Why Scripts?

Scripts are used for operations that:
- Require reading/concatenating many files (e.g., compilation)
- Benefit from shell efficiency (less token usage)
- Are repetitive and automatable
- Don't require AI intelligence (just file operations)

Complex operations that require AI intelligence (epigraph insertion, TOC generation, cross-reference validation) remain in prompt workflows.

---

**Framework Version:** 0.12.10
**Last Updated:** 2025-11-22
