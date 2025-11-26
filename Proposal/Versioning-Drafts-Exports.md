# Proposal: Versioning for Drafts and Exports

**Issue:** #58
**Status:** Proposed
**Created:** 2025-11-25

---

## Problem Statement

Current naming conventions for compiled drafts and exports:
- Drafts: `Full_Draft_[YYYY-MM-DD]_v[semantic-version].md` (e.g., `Full_Draft_2025-11-25_v1.0.0.md`)
- Exports: `[Book-Title].[extension]` (e.g., `My Book.epub`)

Issues:
1. User must manually provide semantic version for each compile
2. No sequential tracking of compile iterations
3. Export files overwrite previous versions (no versioning)
4. Date-based naming doesn't show compile sequence clearly

---

## Proposed Solution

### New Naming Conventions

**Drafts:**
```
[Project-Name]-[Compile-Type]-vNN.md
```
- `Project-Name`: Sanitized/slug version of book title (e.g., "My-Book-Title")
- `Compile-Type`: `basic`, `formatted`, or `publication`
- `vNN`: Two-digit sequential number starting at 01, auto-incremented

**Examples:**
- `My-Book-Title-formatted-v01.md`
- `My-Book-Title-formatted-v02.md`
- `My-Book-Title-publication-v01.md`

**Exports:**
```
[Project-Name]-vNN.[extension]
```
- Independent versioning from drafts
- Extensions: `epub`, `docx`, `pdf`

**Examples:**
- `My-Book-Title-v01.epub`
- `My-Book-Title-v01.docx`
- `My-Book-Title-v02.pdf`

---

## Version Number Calculation

### For Drafts

1. Scan `Manuscript/Drafts/` for files matching pattern: `[Project-Name]-[Compile-Type]-v*.md`
2. Extract version numbers from matching files
3. Find highest NN value
4. Increment by 1 for new file
5. If no matching files exist, start at 01

**Example logic:**
```bash
# Find highest version for project "My-Book" with type "formatted"
existing=$(ls Manuscript/Drafts/My-Book-Title-formatted-v*.md 2>/dev/null | \
  sed 's/.*-v\([0-9]*\)\.md/\1/' | sort -n | tail -1)
next_version=$(printf "%02d" $((${existing:-0} + 1)))
```

### For Exports

1. Scan `Manuscript/Exports/` for files matching pattern: `[Project-Name]-v*.[extension]`
2. Find highest NN across ALL export types (epub, docx, pdf share same version sequence)
3. Increment by 1 for new export batch
4. If no matching files exist, start at 01

**Note:** All formats in a single export operation share the same version number.

---

## Project Name Sanitization

Convert book title to URL-safe slug:

1. Replace spaces with hyphens
2. Remove special characters (keep alphanumeric and hyphens)
3. Convert to title case or preserve case
4. Collapse multiple hyphens to single hyphen
5. Trim leading/trailing hyphens

**Examples:**
| Book Title | Sanitized |
|------------|-----------|
| "My Book Title" | `My-Book-Title` |
| "The Author's Guide: 2nd Edition" | `The-Authors-Guide-2nd-Edition` |
| "Why? Because!" | `Why-Because` |

**Implementation:**
```bash
sanitize_name() {
  echo "$1" | \
    sed 's/ /-/g' | \
    sed 's/[^a-zA-Z0-9-]//g' | \
    sed 's/--*/-/g' | \
    sed 's/^-//;s/-$//'
}
```

---

## Metadata Header Changes

### Current (semantic versioning):
```markdown
# My Book Title

**Author:** John Smith
**Version:** v1.0.0
**Compiled:** 2025-11-25 14:30:00
**Format:** formatted
```

### New (sequential versioning):
```markdown
# My Book Title

**Author:** John Smith
**Compile:** #03
**Compiled:** 2025-11-25 14:30:00
**Format:** formatted
```

- Replace `**Version:**` with `**Compile:**`
- Use `#NN` format in header for clarity

---

## Files to Update

### Scripts
| File | Changes |
|------|---------|
| `Process/Scripts/compile-manuscript.sh` | New filename logic, version detection, sanitization |

### Prompts
| File | Changes |
|------|---------|
| `Process/Prompts/Prompt_7_Compile.md` | Remove version question, update output format |
| `Process/Prompts/Prompt_7_Reference.md` | Update examples and documentation |
| `Process/Prompts/Prompt_9_Export.md` | New export filename logic, version detection |
| `Process/Prompts/Prompt_9_Reference.md` | Update examples and documentation |

### Documentation
| File | Changes |
|------|---------|
| `CLAUDE.md` | Update output format references |
| `Documentation/AI-Assisted_Nonfiction_Authoring_Process.md` | Update format documentation |
| `Process/Scripts/README.md` | Update script documentation |
| `Process/Prompts/README.md` | Update prompt output references |

---

## Prompt 7 Workflow Changes

### Current:
1. Ask version number (e.g., v1.0.0)
2. Ask format option
3. Compile

### New:
1. Ask format option (basic/formatted/publication)
2. Auto-detect next version number
3. Compile

**User interaction reduced** - no version input needed.

---

## Prompt 9 Workflow Changes

### Current:
- Exports to: `Exports/[date]/[Book-Title].epub`
- No versioning on export files

### New:
- Exports to: `Exports/[Project-Name]-vNN.epub`
- Each export batch gets next sequential version
- All formats in batch share same version

**Directory structure change:**
```
# Current
Exports/
├── 2025-11-25/
│   ├── My Book.epub
│   ├── My Book.docx
│   └── README.md

# New
Exports/
├── My-Book-Title-v01.epub
├── My-Book-Title-v01.docx
├── My-Book-Title-v01.pdf
├── My-Book-Title-v02.epub
└── ...
```

---

## Edge Cases

### 1. Version number gaps
If user deletes `v02`, next compile still creates `v04` (based on highest existing).

### 2. Different compile types
Each compile type has independent versioning:
- `My-Book-Title-basic-v03.md`
- `My-Book-Title-formatted-v07.md`
- `My-Book-Title-publication-v02.md`

### 3. Project name changes
If book title changes mid-project, new sequence starts for new name. Old files remain.

### 4. Version number overflow
If NN exceeds 99, use 3 digits (v100, v101). Unlikely in practice.

---

## Implementation Steps

1. **Create sanitization function** in compile script
2. **Add version detection logic** to compile script
3. **Update compile script** output filename
4. **Update Prompt 7** - remove version question
5. **Add version detection** to Prompt 9 / export workflow
6. **Update Prompt 9** export filenames
7. **Update documentation** (CLAUDE.md, Process docs)
8. **Test** with sample compiles and exports

---

## Testing Checklist

- [ ] First compile creates v01
- [ ] Second compile creates v02
- [ ] Different compile types have independent versions
- [ ] Project name sanitization handles special characters
- [ ] Export versioning works independently
- [ ] All formats in export batch share version
- [ ] Version detection handles missing files gracefully
- [ ] Documentation updated and accurate

---

## Questions Resolved

1. **Project-Name format**: Sanitized/slug version
2. **Compile-Type values**: basic, formatted, publication
3. **Version scheme**: Sequential only (Option B), no semantic versioning
4. **Export versioning**: Independent from drafts

---

**Next Steps:** Await user approval, then implement.
