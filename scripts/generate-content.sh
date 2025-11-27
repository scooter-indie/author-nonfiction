#!/usr/bin/env bash

################################################################################
# Batch Content Generator for Prompt 1
# Version: 0.15.1
#
# Purpose: Generate ALL content files from init.json in single operation
# Usage:
#   Legacy mode:     bash scripts/generate-content.sh .config/init.json
#   Multi-book mode: bash [FW_ROOT]/scripts/generate-content.sh [BOOK_PATH]/.config/init.json [FW_ROOT]
################################################################################

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
CONFIG_FILE="${1:-.config/init.json}"
FW_ROOT="${2:-}"  # Optional: Framework root for multi-book mode

# Determine paths based on mode
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ -n "$FW_ROOT" ]]; then
    # Multi-book mode: FW_ROOT provided
    FRAMEWORK_ROOT="$FW_ROOT"
    # Book path is parent of .config/init.json
    BOOK_PATH="$(cd "$(dirname "$CONFIG_FILE")/.." && pwd)"
    PROJECT_ROOT="$BOOK_PATH"
    MULTI_BOOK_MODE=true
    echo -e "${BLUE}Mode: Multi-book${NC}"
    echo -e "  Framework: $FRAMEWORK_ROOT"
    echo -e "  Book path: $BOOK_PATH"
else
    # Legacy mode: script and project in same location
    FRAMEWORK_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
    PROJECT_ROOT="$FRAMEWORK_ROOT"
    MULTI_BOOK_MODE=false
    echo -e "${BLUE}Mode: Legacy (single-book)${NC}"
fi

################################################################################
# Validation Functions
################################################################################

validate_preconditions() {
    echo -e "${BLUE}Validating preconditions...${NC}"
    local errors=0

    # Check if config file exists
    if [[ ! -f "$CONFIG_FILE" ]]; then
        echo -e "${RED}✗ Config file not found: $CONFIG_FILE${NC}"
        ((errors++))
    else
        echo -e "${GREEN}✓ Config file found${NC}"
    fi

    # Check if jq is installed
    if ! command -v jq &> /dev/null; then
        echo -e "${RED}✗ jq not installed (required for JSON parsing)${NC}"
        echo -e "${YELLOW}Install instructions:${NC}"
        echo -e "  - Windows: winget install jqlang.jq"
        echo -e "  - macOS: brew install jq"
        echo -e "  - Linux: sudo apt install jq"
        ((errors++))
    else
        echo -e "${GREEN}✓ jq is installed${NC}"
    fi

    # Check if config is valid JSON
    if command -v jq &> /dev/null; then
        if ! jq empty "$CONFIG_FILE" 2>/dev/null; then
            echo -e "${RED}✗ Invalid JSON in config file${NC}"
            ((errors++))
        else
            echo -e "${GREEN}✓ Valid JSON config${NC}"
        fi
    fi

    # Check required fields in JSON
    if command -v jq &> /dev/null && jq empty "$CONFIG_FILE" 2>/dev/null; then
        local required_fields=("title" "author" "writingStyleId" "chapters" "createdDate")
        for field in "${required_fields[@]}"; do
            if [[ "$(jq -r ".$field // \"null\"" "$CONFIG_FILE")" == "null" ]]; then
                echo -e "${RED}✗ Missing required field: $field${NC}"
                ((errors++))
            fi
        done
        if [[ $errors -eq 0 ]]; then
            echo -e "${GREEN}✓ All required fields present${NC}"
        fi
    fi

    # Check if Process/Styles directory exists (in FRAMEWORK_ROOT)
    if [[ ! -d "$FRAMEWORK_ROOT/Process/Styles" ]]; then
        echo -e "${RED}✗ Process/Styles directory not found at $FRAMEWORK_ROOT${NC}"
        ((errors++))
    else
        echo -e "${GREEN}✓ Process/Styles directory found${NC}"
    fi

    if [[ $errors -gt 0 ]]; then
        echo -e "${RED}✗ Validation failed with $errors error(s)${NC}"
        exit 1
    fi

    echo -e "${GREEN}✓ All preconditions met${NC}"
    echo ""
}

################################################################################
# Parse JSON Configuration
################################################################################

parse_config() {
    echo -e "${BLUE}Parsing configuration...${NC}"

    TITLE=$(jq -r '.title' "$CONFIG_FILE")
    AUTHOR=$(jq -r '.author' "$CONFIG_FILE")
    STYLE_ID=$(jq -r '.writingStyleId' "$CONFIG_FILE")
    STYLE_DISPLAY=$(jq -r '.writingStyle' "$CONFIG_FILE")
    DATE=$(jq -r '.createdDate' "$CONFIG_FILE")
    CHAPTERS=$(jq -r '.chapters | length' "$CONFIG_FILE")
    TARGET_WORD_COUNT=$(jq -r '.targetWordCount // "50000"' "$CONFIG_FILE")
    TARGET_AUDIENCE=$(jq -r '.targetAudience // ""' "$CONFIG_FILE")
    PURPOSE=$(jq -r '.purpose // ""' "$CONFIG_FILE")
    TARGET_COMPLETION=$(jq -r '.targetCompletionDate // ""' "$CONFIG_FILE")

    # Convert writingStyleId to filename format
    # FW_PRACTICAL_GUIDE -> Practical_Guide
    STYLE=$(echo "$STYLE_ID" | sed 's/^FW_//' | sed 's/_/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))}1' | sed 's/ /_/g')

    echo -e "${GREEN}✓ Configuration parsed${NC}"
    echo -e "  • Title: $TITLE"
    echo -e "  • Author: $AUTHOR"
    echo -e "  • Style: $STYLE_DISPLAY ($STYLE)"
    echo -e "  • Chapters: $CHAPTERS"
    echo ""
}

################################################################################
# Find Style File
################################################################################

find_style_file() {
    echo -e "${BLUE}Locating style file...${NC}"

    # Search all category directories for the style (in FRAMEWORK_ROOT)
    STYLE_FILE=""
    for category_dir in "$FRAMEWORK_ROOT/Process/Styles"/*/ ; do
        if [[ -f "${category_dir}${STYLE}.md" ]]; then
            STYLE_FILE="${category_dir}${STYLE}.md"
            STYLE_CATEGORY=$(basename "$category_dir")
            break
        fi
    done

    if [[ -z "$STYLE_FILE" ]]; then
        echo -e "${RED}✗ Style file not found: $STYLE.md${NC}"
        echo -e "${YELLOW}Available styles:${NC}"
        find "$FRAMEWORK_ROOT/Process/Styles" -name "*.md" -not -name "README.md" -not -name "Style_Catalog.md" -exec basename {} .md \; | sort
        exit 1
    fi

    echo -e "${GREEN}✓ Style file found: $STYLE_CATEGORY/$STYLE.md${NC}"
    echo ""
}

################################################################################
# Generate Content Files
################################################################################

generate_style_guide() {
    echo -e "${BLUE}Generating Style_Guide.md...${NC}"

    # Read style content
    STYLE_CONTENT=$(cat "$STYLE_FILE")

    cat > Manuscript/Style/Style_Guide.md <<EOF
# Writing Style Guide

**Book:** $TITLE
**Style:** $STYLE_DISPLAY
**Category:** $STYLE_CATEGORY
**Last Updated:** $DATE

---

## Selected Style: $STYLE_DISPLAY

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

    echo -e "${GREEN}✓ Generated Style_Guide.md${NC}"
}

generate_style_overrides() {
    echo -e "${BLUE}Generating Style_Overrides.md...${NC}"

    cat > Manuscript/Style/Style_Overrides.md <<EOF
# Style Overrides Registry

**Book:** $TITLE
**Book-Level Style:** $STYLE_DISPLAY
**Last Updated:** $DATE

---

## Overview

This file tracks all style overrides in your book. The framework uses a hierarchical style system with three levels:

1. **Book-Level Style** (default for entire book): $STYLE_DISPLAY
2. **Chapter-Level Overrides** (optional): Specific chapters with different styles
3. **Section-Level Overrides** (optional): Specific sections within chapters

**Purpose:**
- Track all style deviations from book default
- Monitor override distribution (30% threshold guideline)
- Document style transitions for reader experience

---

## Chapter-Level Overrides

**Current Count:** 0 / $CHAPTERS chapters (0%)

| Chapter | Title | Override Style | Reason |
|---------|-------|----------------|--------|
| *None* | | | |

---

## Section-Level Overrides

**Current Count:** 0 sections

| Chapter | Section | Override Style | Reason |
|---------|---------|----------------|--------|
| *None* | | | |

---

## Style Distribution

**Book Default ($STYLE_DISPLAY):** $CHAPTERS chapters (100%)

**Override Styles:**
- *None*

**Threshold Check:**
- Override percentage: 0%
- Status: ✓ Within guideline (< 30%)

---

## Style Transitions

*Document any style transitions to ensure smooth reader experience*

| From Chapter | To Chapter | Transition Type | Notes |
|--------------|------------|-----------------|-------|
| *None* | | | |

---

## Notes

- Use Prompt 11 (Style Manager) to add/remove overrides
- If overrides exceed 30%, consider changing book-level style
- Document transition reasoning to maintain reader flow

---

**Last Modified:** $DATE
**Managed by:** Prompt 11 (Style Manager)
EOF

    echo -e "${GREEN}✓ Generated Style_Overrides.md${NC}"
}

generate_toc() {
    echo -e "${BLUE}Generating TOC.md...${NC}"

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
        CHAPTER_TITLE=$(jq -r ".chapters[$i].title" "$CONFIG_FILE")

        cat >> Manuscript/_TOC_/TOC.md <<EOF
## Chapter $CHAPTER_NUM: $CHAPTER_TITLE

**Status:** Not Started
**Word Count:** 0
**Last Modified:** N/A

---

EOF
    done

    echo -e "${GREEN}✓ Generated TOC.md${NC}"
}

generate_toc_chg() {
    echo -e "${BLUE}Generating TOC_chg.md...${NC}"

    # Build chapter list for version history
    CHAPTER_LIST=""
    for i in $(seq 0 $((CHAPTERS - 1))); do
        CHAPTER_TITLE=$(jq -r ".chapters[$i].title" "$CONFIG_FILE")
        if [[ $i -gt 0 ]]; then
            CHAPTER_LIST="${CHAPTER_LIST}, "
        fi
        CHAPTER_LIST="${CHAPTER_LIST}${CHAPTER_TITLE}"
    done

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
- Chapters: $CHAPTER_LIST
EOF

    echo -e "${GREEN}✓ Generated TOC_chg.md${NC}"
}

generate_chapter_quotes() {
    echo -e "${BLUE}Generating Chapter_Quotes.md...${NC}"

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
        CHAPTER_TITLE=$(jq -r ".chapters[$i].title" "$CONFIG_FILE")

        cat >> Manuscript/Quotes/Chapter_Quotes.md <<EOF
## Chapter $CHAPTER_NUM: $CHAPTER_TITLE

**Status:** ⏳ Pending
**Quote:** [Leave empty]
**Attribution:** [Leave empty]
**Source:** [Leave empty]

---

EOF
    done

    echo -e "${GREEN}✓ Generated Chapter_Quotes.md${NC}"
}

generate_chapter_quotes_chg() {
    echo -e "${BLUE}Generating Chapter_Quotes_chg.md...${NC}"

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

    echo -e "${GREEN}✓ Generated Chapter_Quotes_chg.md${NC}"
}

generate_usage_guide() {
    echo -e "${BLUE}Generating USAGE_GUIDE.md...${NC}"

    # Call existing generation script (from FRAMEWORK_ROOT)
    bash "$FRAMEWORK_ROOT/scripts/generate-usage-guide.sh" "$TITLE" "$AUTHOR" "$DATE" "$CHAPTERS" "$STYLE_DISPLAY"
}

generate_project_context() {
    echo -e "${BLUE}Generating PROJECT_CONTEXT.md...${NC}"

    if [[ "$MULTI_BOOK_MODE" == "true" ]]; then
        # Multi-book mode: reference FW_ROOT
        cat > PROJECT_CONTEXT.md <<EOF
# Project Context

**Book Title:** $TITLE
**Author:** $AUTHOR
**Initialized:** $DATE
**Framework Version:** 0.15.0
**Mode:** Multi-book

---

## Project Overview

**Chapters:** $CHAPTERS
**Writing Style:** $STYLE_DISPLAY
**Target Word Count:** $TARGET_WORD_COUNT
**Target Completion:** $TARGET_COMPLETION

**Target Audience:**
$TARGET_AUDIENCE

**Book Purpose:**
$PURPOSE

---

## For Claude Desktop Users

Upload this file to Claude Desktop's Files area (not pasted as text) to provide full project context when resuming work.

**System Instructions:**
Also upload the System Instructions from the framework (at FW_ROOT).

---

## Quick Reference

**Framework Location:** [FW_ROOT]/Process/
**Book Location:** [BOOKS_ROOT]/[Book-Name]/
**Prompts:** [FW_ROOT]/Process/Prompts/
**Manuscript:** Manuscript/
**Configuration:** .config/

**Key Prompts:**
- Prompt 3: Change by Chg (automated editing)
- Prompt 4: Interactive Change (conversational editing)
- Prompt 8: Consistency Checker
- Prompt 10: Progress Dashboard

**Book Switching:**
- Say "switch to [Book Name]" to change active book
- Say "list books" to see all registered books

---

**Generated:** $DATE
**Framework Version:** 0.15.0
EOF
    else
        # Legacy mode: Process/ in same directory
        cat > PROJECT_CONTEXT.md <<EOF
# Project Context

**Book Title:** $TITLE
**Author:** $AUTHOR
**Initialized:** $DATE
**Framework Version:** 0.15.0

---

## Project Overview

**Chapters:** $CHAPTERS
**Writing Style:** $STYLE_DISPLAY
**Target Word Count:** $TARGET_WORD_COUNT
**Target Completion:** $TARGET_COMPLETION

**Target Audience:**
$TARGET_AUDIENCE

**Book Purpose:**
$PURPOSE

---

## For Claude Desktop Users

Upload this file to Claude Desktop's Files area (not pasted as text) to provide full project context when resuming work.

**System Instructions:**
Also upload \`Process/Prompts/README.md\` which contains the System Instructions for Claude Desktop.

---

## Quick Reference

**Framework Location:** Process/
**Prompts:** Process/Prompts/
**Manuscript:** Manuscript/
**Configuration:** .config/

**Key Prompts:**
- Prompt 3: Change by Chg (automated editing)
- Prompt 4: Interactive Change (conversational editing)
- Prompt 8: Consistency Checker
- Prompt 10: Progress Dashboard

---

**Generated:** $DATE
**Framework Version:** 0.15.0
EOF
    fi

    echo -e "${GREEN}✓ Generated PROJECT_CONTEXT.md${NC}"
}

generate_readme() {
    echo -e "${BLUE}Generating README.md...${NC}"

    cat > README.md <<EOF
# $TITLE
**Author:** $AUTHOR

## About This Book

$PURPOSE

**Target Audience:** $TARGET_AUDIENCE

## Project Information

- **Framework Version:** 0.15.0
- **Initialized:** $DATE
- **Chapters:** $CHAPTERS
- **Writing Style:** $STYLE_DISPLAY
- **Target Word Count:** $TARGET_WORD_COUNT
- **Target Completion:** $TARGET_COMPLETION

---

⚠️ WARNING: This file is managed automatically. Direct edits may be overwritten. Use framework prompts to update content.

---
**AI Instructions:** This file must be updated using Process/_COMMON/17_README_Management_Module.md
EOF

    echo -e "${GREEN}✓ Generated README.md${NC}"
}

generate_chapter_files() {
    echo -e "${BLUE}Generating chapter files...${NC}"

    for i in $(seq 0 $((CHAPTERS - 1))); do
        CHAPTER_NUM=$(printf "%02d" $((i + 1)))
        CHAPTER_TITLE=$(jq -r ".chapters[$i].title" "$CONFIG_FILE")

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

        echo -e "${GREEN}✓ Generated Chapter_$CHAPTER_NUM files${NC}"
    done
}

################################################################################
# Summary Report
################################################################################

print_summary() {
    local total_files=$((9 + CHAPTERS * 2))

    echo ""
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}✓ Content generation complete${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${BLUE}Generated files:${NC}"
    echo "  • Style_Guide.md, Style_Overrides.md"
    echo "  • TOC.md, TOC_chg.md"
    echo "  • Chapter_Quotes.md, Chapter_Quotes_chg.md"
    echo "  • USAGE_GUIDE.md, PROJECT_CONTEXT.md, README.md"
    echo "  • $CHAPTERS chapter files (Chapter_XX.md + Chapter_XX_chg.md)"
    echo ""
    echo -e "${GREEN}Total: $total_files files created${NC}"
    echo ""
}

################################################################################
# Main Execution
################################################################################

main() {
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}Batch Content Generator v0.15.0${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""

    # Change to project/book root
    cd "$PROJECT_ROOT"

    # Run validation
    validate_preconditions

    # Parse configuration
    parse_config

    # Find style file
    find_style_file

    # Generate all content files
    echo -e "${BLUE}Generating content files...${NC}"
    echo ""

    generate_style_guide
    generate_style_overrides
    generate_toc
    generate_toc_chg
    generate_chapter_quotes
    generate_chapter_quotes_chg
    generate_usage_guide
    generate_project_context
    generate_readme
    generate_chapter_files

    # Print summary
    print_summary
}

# Run main function
main "$@"
