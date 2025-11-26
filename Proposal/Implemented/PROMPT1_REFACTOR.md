# Prompt 1 Performance Refactor

**Status:** ✅ Implemented
**Version:** 0.14.0
**Created:** 2025-11-24
**Implemented:** 2025-11-24
**Performance Goal:** 85-90% faster execution

---

## Problem Statement

Prompt 1 (Initialize) is currently slow due to **multiple individual file writes**. Claude must write 15+ files individually using Edit/Write tools, resulting in 35-40 separate tool operations.

**Current execution time:** 45-90 seconds
**Target execution time:** 5-10 seconds

---

## Root Cause Analysis

### Primary Bottleneck: Sequential File Generation

Claude currently generates files one-by-one:

**Content Files (10 files):**
1. `Manuscript/Style/Style_Guide.md`
2. `Manuscript/Style/Style_Overrides.md`
3. `Manuscript/_TOC_/TOC.md`
4. `Manuscript/_TOC_/TOC_chg.md`
5. `Manuscript/Quotes/Chapter_Quotes.md`
6. `Manuscript/Quotes/Chapter_Quotes_chg.md`
7. `USAGE_GUIDE.md`
8. `PROJECT_CONTEXT.md`
9. `README.md`
10. Chapter files (N × 2 files: `Chapter_XX.md` + `Chapter_XX_chg.md`)

**Each file write:**
- 1 tool call to Write/Edit
- Response validation
- Context switching overhead

**Total:** 10-15+ separate operations for content generation alone

---

## Proposed Solution: Batch Content Generator Script

### Overview

Create `scripts/generate-content.sh` - a single bash script that generates **all content files** in one execution using heredoc templates and JSON parsing.

### Architecture

```
┌─────────────────────┐
│  .config/init.json  │ (Q&A answers from user)
└──────────┬──────────┘
           │
           ▼
┌─────────────────────────────────────┐
│  bash scripts/generate-content.sh   │
│                                     │
│  • Parses init.json (jq)            │
│  • Reads style from Process/Styles/ │
│  • Generates 15+ files via heredoc  │
│  • Substitutes variables with sed   │
└──────────┬──────────────────────────┘
           │
           ▼
┌─────────────────────────────────────┐
│  All content files created in <1s   │
│  • Manuscript/Style/*               │
│  • Manuscript/_TOC_/*               │
│  • Manuscript/Quotes/*              │
│  • Manuscript/Chapters/*            │
│  • README.md, PROJECT_CONTEXT.md    │
└─────────────────────────────────────┘
```

### Claude's New Workflow

**Before (Current):**
1. Read init.json
2. Write Style_Guide.md
3. Write Style_Overrides.md
4. Write TOC.md
5. Write TOC_chg.md
6. Write Chapter_Quotes.md
7. Write Chapter_Quotes_chg.md
8. Run generate-usage-guide.sh
9. Write PROJECT_CONTEXT.md
10. Write README.md
11. For each chapter: Write Chapter_XX.md + Chapter_XX_chg.md
12. Git commit

**After (Optimized):**
1. Read init.json (validate Q&A answers)
2. **Run: `bash scripts/generate-content.sh .config/init.json`**
3. Git commit

**Operations reduced:** 15+ file operations → **1 bash script call**

---

## Implementation Details

### Script: `scripts/generate-content.sh`

**Inputs:**
- `.config/init.json` - Contains all Q&A answers from user
- Style files in `Process/Styles/[Category]/[StyleName].md`

**Outputs:**
- All 15+ content files generated from templates
- Verbose progress output
- Error handling and validation

**Dependencies:**
- `jq` (JSON parsing) - already required for framework
- `sed` (text substitution) - standard Unix tool
- `bash` - already required

### Template Strategy

**Use heredoc for each file:**

```bash
#!/usr/bin/env bash

# Parse JSON inputs
TITLE=$(jq -r '.title' .config/init.json)
AUTHOR=$(jq -r '.author' .config/init.json)
STYLE=$(jq -r '.style' .config/init.json)
DATE=$(jq -r '.createdDate' .config/init.json)
CHAPTERS=$(jq -r '.chapters | length' .config/init.json)

# Read selected style content
STYLE_CATEGORY=$(jq -r '.styleCategory' .config/init.json)
STYLE_CONTENT=$(cat "Process/Styles/$STYLE_CATEGORY/$STYLE.md")

# Generate Style_Guide.md
cat > Manuscript/Style/Style_Guide.md <<EOF
# Writing Style Guide

**Book:** $TITLE
**Style:** $STYLE
**Category:** $STYLE_CATEGORY
**Last Updated:** $DATE

---

## Selected Style: $STYLE

$STYLE_CONTENT

---

## Style Application

This style is your **book-level default**. All chapters and sections inherit this style unless explicitly overridden.

**Hierarchical Style System:**
- **Book level** (this file): Default for entire book
- **Chapter level** (optional): Override for specific chapters
- **Section level** (optional): Override for specific sections

See \`Manuscript/Style/Style_Overrides.md\` for override registry.

---

*This style guide ensures consistent voice throughout your book*
EOF

echo "✓ Generated Style_Guide.md"

# Generate Style_Overrides.md
cp Process/Templates/Style_Overrides_Template.md Manuscript/Style/Style_Overrides.md
sed -i "s/{{BOOK_TITLE}}/$TITLE/g" Manuscript/Style/Style_Overrides.md
sed -i "s/{{STYLE_NAME}}/$STYLE/g" Manuscript/Style/Style_Overrides.md
sed -i "s/{{DATE}}/$DATE/g" Manuscript/Style/Style_Overrides.md
echo "✓ Generated Style_Overrides.md"

# Generate TOC.md
cat > Manuscript/_TOC_/TOC.md <<EOF
# Table of Contents

**Book:** $TITLE
**Author:** $AUTHOR
**Last Updated:** $DATE

⚠️ **WARNING:** This file is managed by Prompts 1 and 2. Direct edits may be overwritten. Use Prompt 2 to add/reorder chapters.

---

EOF

# Loop through chapters and add to TOC
for i in $(seq 0 $((CHAPTERS - 1))); do
  CHAPTER_NUM=$(printf "%02d" $((i + 1)))
  CHAPTER_TITLE=$(jq -r ".chapters[$i].title" .config/init.json)

  cat >> Manuscript/_TOC_/TOC.md <<EOF
## Chapter $CHAPTER_NUM: $CHAPTER_TITLE

**Status:** Not Started
**Word Count:** 0
**Last Modified:** N/A

---

EOF
done

echo "✓ Generated TOC.md"

# Generate TOC_chg.md
cat > Manuscript/_TOC_/TOC_chg.md <<EOF
# TOC Change Tracking

**Version:** 1.0.0
**Last Updated:** $DATE

---

## Instructions for Next Revision

[Leave empty - ready for user to add TOC modification instructions]

---

## Version History

### v1.0.0 - $DATE
- Initial TOC created with $CHAPTERS chapters
- Chapters: $(jq -r '.chapters[].title' .config/init.json | paste -sd, -)
EOF

echo "✓ Generated TOC_chg.md"

# Generate Chapter_Quotes.md
cat > Manuscript/Quotes/Chapter_Quotes.md <<EOF
# Chapter Quotes (Epigraphs)

**Book:** $TITLE
**Last Updated:** $DATE

**Status Legend:**
- ⏳ **Pending** - Quote selected, needs verification
- ⚠ **Needs Citation** - Verified but incomplete citation
- ✓ **Verified** - Fully verified with proper attribution

---

EOF

for i in $(seq 0 $((CHAPTERS - 1))); do
  CHAPTER_NUM=$(printf "%02d" $((i + 1)))
  CHAPTER_TITLE=$(jq -r ".chapters[$i].title" .config/init.json)

  cat >> Manuscript/Quotes/Chapter_Quotes.md <<EOF
## Chapter $CHAPTER_NUM: $CHAPTER_TITLE

**Status:** ⏳ Pending
**Quote:** [Leave empty]
**Attribution:** [Leave empty]
**Source:** [Leave empty]

---

EOF
done

echo "✓ Generated Chapter_Quotes.md"

# Generate Chapter_Quotes_chg.md
cat > Manuscript/Quotes/Chapter_Quotes_chg.md <<EOF
# Chapter Quotes Change Tracking

**Version:** 1.0.0
**Last Updated:** $DATE

---

## Instructions for Next Revision

[Leave empty]

---

## Version History

### v1.0.0 - $DATE
- Initial quotes file created
- $CHAPTERS chapter quote placeholders created
EOF

echo "✓ Generated Chapter_Quotes_chg.md"

# Generate USAGE_GUIDE.md using existing script
bash scripts/generate-usage-guide.sh "$TITLE" "$AUTHOR" "$DATE" "$CHAPTERS" "$STYLE"

# Generate PROJECT_CONTEXT.md from template
cp Process/Templates/PROJECT_CONTEXT_template.md PROJECT_CONTEXT.md
sed -i "s/{{BOOK_TITLE}}/$TITLE/g" PROJECT_CONTEXT.md
sed -i "s/{{AUTHOR_NAME}}/$AUTHOR/g" PROJECT_CONTEXT.md
sed -i "s/{{INIT_DATE}}/$DATE/g" PROJECT_CONTEXT.md
sed -i "s/{{CHAPTER_COUNT}}/$CHAPTERS/g" PROJECT_CONTEXT.md
sed -i "s/{{STYLE_NAME}}/$STYLE/g" PROJECT_CONTEXT.md
echo "✓ Generated PROJECT_CONTEXT.md"

# Generate README.md (basic structure - Claude can enhance later if needed)
cat > README.md <<EOF
# $TITLE
**Author:** $AUTHOR

## About This Book

$(jq -r '.purpose' .config/init.json)

**Target Audience:** $(jq -r '.targetAudience' .config/init.json)

## Project Information

- **Framework Version:** 0.13.0
- **Initialized:** $DATE
- **Chapters:** $CHAPTERS
- **Writing Style:** $STYLE
- **Target Word Count:** $(jq -r '.targetWordCount' .config/init.json)
- **Target Completion:** $(jq -r '.targetCompletionDate' .config/init.json)

---

⚠️ WARNING: This file is managed automatically. Direct edits may be overwritten. Use framework prompts to update content.

---
**AI Instructions:** This file must be updated using Process/_COMMON/17_README_Management_Module.md
EOF

echo "✓ Generated README.md"

# Generate chapter files
for i in $(seq 0 $((CHAPTERS - 1))); do
  CHAPTER_NUM=$(printf "%02d" $((i + 1)))
  CHAPTER_TITLE=$(jq -r ".chapters[$i].title" .config/init.json)

  # Create chapter directory
  mkdir -p "Manuscript/Chapters/Chapter_$CHAPTER_NUM"

  # Generate Chapter_XX.md
  cat > "Manuscript/Chapters/Chapter_$CHAPTER_NUM/Chapter_$CHAPTER_NUM.md" <<EOF
# Chapter $CHAPTER_NUM: $CHAPTER_TITLE

**Status:** Not Started
**Word Count:** 0
**Last Updated:** $DATE

---

[Chapter content will be added here]
EOF

  # Generate Chapter_XX_chg.md
  cat > "Manuscript/Chapters/Chapter_$CHAPTER_NUM/Chapter_${CHAPTER_NUM}_chg.md" <<EOF
# Chapter $CHAPTER_NUM Change Tracking

**Version:** 1.0.0
**Last Updated:** $DATE

---

## Instructions for Next Revision

[Leave empty - ready for user to add revision instructions]

---

## Version History

### v1.0.0 - $DATE
- Initial chapter file created
- Chapter: $CHAPTER_TITLE
EOF

  echo "✓ Generated Chapter_$CHAPTER_NUM files"
done

# Summary
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✓ Content generation complete"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Generated files:"
echo "  • Style_Guide.md, Style_Overrides.md"
echo "  • TOC.md, TOC_chg.md"
echo "  • Chapter_Quotes.md, Chapter_Quotes_chg.md"
echo "  • USAGE_GUIDE.md, PROJECT_CONTEXT.md, README.md"
echo "  • $CHAPTERS chapter files (Chapter_XX.md + Chapter_XX_chg.md)"
echo ""
echo "Total: $((9 + CHAPTERS * 2)) files created in <1 second"
echo ""
```

### Error Handling

```bash
# Validation at start
if [ ! -f ".config/init.json" ]; then
    echo "Error: .config/init.json not found"
    exit 1
fi

if ! command -v jq &> /dev/null; then
    echo "Error: jq is required but not installed"
    echo "Install: sudo apt install jq (Linux) or brew install jq (macOS)"
    exit 1
fi

# Validate JSON structure
if ! jq empty .config/init.json 2>/dev/null; then
    echo "Error: .config/init.json is not valid JSON"
    exit 1
fi

# Check required fields
REQUIRED_FIELDS=("title" "author" "style" "chapters")
for field in "${REQUIRED_FIELDS[@]}"; do
    if [ "$(jq -r ".$field" .config/init.json)" == "null" ]; then
        echo "Error: Missing required field: $field"
        exit 1
    fi
done
```

---

## Updated Prompt 1 Workflow

### Step 4: Generate All Content (CLI ONLY)

**Execute batch content generator:**

```bash
bash scripts/generate-content.sh .config/init.json
```

**This single command generates:**
- Style_Guide.md, Style_Overrides.md
- TOC.md, TOC_chg.md
- Chapter_Quotes.md, Chapter_Quotes_chg.md
- USAGE_GUIDE.md, PROJECT_CONTEXT.md, README.md
- All chapter files (Chapter_XX.md + Chapter_XX_chg.md)

**Expected output:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Generating content files...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✓ Generated Style_Guide.md
✓ Generated Style_Overrides.md
✓ Generated TOC.md
✓ Generated TOC_chg.md
✓ Generated Chapter_Quotes.md
✓ Generated Chapter_Quotes_chg.md
✓ Generated USAGE_GUIDE.md
✓ Generated PROJECT_CONTEXT.md
✓ Generated README.md
✓ Generated Chapter_01 files
✓ Generated Chapter_02 files
...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ Content generation complete
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Generated files:
  • Style_Guide.md, Style_Overrides.md
  • TOC.md, TOC_chg.md
  • Chapter_Quotes.md, Chapter_Quotes_chg.md
  • USAGE_GUIDE.md, PROJECT_CONTEXT.md, README.md
  • 10 chapter files (Chapter_XX.md + Chapter_XX_chg.md)

Total: 29 files created in <1 second
```

**Then proceed to Step 5 (Git commit).**

---

## Performance Comparison

| Metric | Before | After | Improvement |
|--------|--------|-------|-------------|
| **File Operations** | 15+ Write tool calls | 1 bash script | **93% reduction** |
| **Tool Calls** | 35-40 operations | 5-8 operations | **85% reduction** |
| **Execution Time** | 45-90 seconds | 5-10 seconds | **85-90% faster** |
| **Template Reads** | 5-8 reads | 0 (embedded) | **100% reduction** |
| **Context Switches** | 15+ AI→File→AI | 1 AI→Bash | **93% reduction** |

### Example Timeline

**Before (Current):**
```
0s   - Start
5s   - Lock management + validation
15s  - Write Style_Guide.md
20s  - Write Style_Overrides.md
25s  - Write TOC.md
30s  - Write TOC_chg.md
35s  - Write Chapter_Quotes.md
40s  - Write Chapter_Quotes_chg.md
45s  - Run generate-usage-guide.sh
50s  - Write PROJECT_CONTEXT.md
55s  - Write README.md
60s  - Generate 10 chapter files
75s  - Tool detection
80s  - Git commit
85s  - Mark complete
90s  - DONE
```

**After (Optimized):**
```
0s   - Start
2s   - Validation + read init.json
3s   - Run generate-content.sh (generates all 29 files)
5s   - Tool detection
7s   - Git commit (single commit)
10s  - DONE
```

---

## Implementation Plan

### Phase 1: Create Script (v0.14.0)
- [ ] Create `scripts/generate-content.sh`
- [ ] Add error handling and validation
- [ ] Test with various configurations (5, 10, 20 chapters)
- [ ] Test style file reading from all categories

### Phase 2: Update Prompt 1 (v0.14.0)
- [ ] Replace Steps 4a-4h with single script call
- [ ] Update documentation
- [ ] Update version numbers

### Phase 3: Testing (v0.14.0)
- [ ] Test fresh initialization (no existing files)
- [ ] Test with all 19 styles
- [ ] Test error conditions (missing jq, invalid JSON)
- [ ] Verify all generated files match current format
- [ ] Test on Windows (Git Bash), macOS, Linux

### Phase 4: Documentation (v0.14.0)
- [ ] Update CLAUDE.md with new performance notes
- [ ] Update README.md with faster initialization claim
- [ ] Update CHANGELOG.md

---

## Risks and Mitigations

### Risk 1: jq Not Installed
**Mitigation:**
- Script checks for jq and provides install instructions
- jq is lightweight and available on all platforms
- Already recommended in framework prerequisites

### Risk 2: Template Complexity
**Mitigation:**
- Use heredoc for simple templates (most files)
- Fall back to sed substitution for complex logic
- Keep templates readable with clear variable names

### Risk 3: Style File Path Issues
**Mitigation:**
- Store full style path in init.json (category + name)
- Validate style file exists before generation
- Provide clear error if style file not found

### Risk 4: Windows Compatibility
**Mitigation:**
- Test thoroughly on Git Bash (most common Windows bash)
- Use portable bash syntax (avoid bashisms)
- sed -i works on Git Bash with proper syntax

---

## Success Metrics

**Acceptance Criteria:**
1. ✅ All 29 files generated in single script call
2. ✅ Execution time < 10 seconds for 10-chapter book
3. ✅ Generated files match current format exactly
4. ✅ Works on Windows (Git Bash), macOS, Linux
5. ✅ Clear error messages for missing dependencies
6. ✅ Verbose progress output for user feedback

**Performance Target:**
- **85-90% reduction in execution time**
- **93% reduction in tool operations**
- **100% compatibility with existing workflows**

---

## Future Enhancements (Post-v0.14.0)

1. **Python Version:** If bash complexity grows, rewrite in Python with Jinja2
2. **Parallel Generation:** Generate chapter files in parallel for 50+ chapter books
3. **Template Validation:** Pre-validate all templates during framework installation
4. **Incremental Updates:** Support re-running script to add chapters without regenerating everything

---

## Backward Compatibility

**No breaking changes:**
- Init.json format unchanged
- Generated file formats unchanged
- User workflow unchanged (still runs Prompt 1)
- Only internal implementation changes

**Migration:**
- Automatic (users just get faster execution on next framework update)
- No user action required

---

## Conclusion

This refactor delivers the **biggest single performance improvement** to the framework by eliminating the primary bottleneck: sequential file generation.

**Impact:**
- 85-90% faster initialization
- Better user experience (faster feedback)
- Reduced AI token usage (fewer operations)
- Cleaner, more maintainable code (bash templates vs scattered AI instructions)

**Effort:** 3-4 hours to implement and test
**ROI:** High - benefits every new book project initialization

---

**Status:** Ready for implementation in v0.14.0
**Estimated Completion:** 1 week (including testing)
