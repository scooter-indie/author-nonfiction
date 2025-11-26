#!/bin/bash
# Compile Complete Manuscript
# Usage: compile-manuscript.sh [FORMAT]
# FORMAT: basic|formatted|publication (default: formatted)

set -e  # Exit on error

# Parameters
FORMAT="${1:-formatted}"

# Validate format
if [[ ! "$FORMAT" =~ ^(basic|formatted|publication)$ ]]; then
    echo "Error: FORMAT must be basic, formatted, or publication"
    echo "Usage: compile-manuscript.sh [FORMAT]"
    exit 1
fi

# Sanitize project name for filename
sanitize_name() {
    echo "$1" | \
        sed 's/ /-/g' | \
        sed 's/[^a-zA-Z0-9-]//g' | \
        sed 's/--*/-/g' | \
        sed 's/^-//;s/-$//'
}

# Create Drafts directory if needed
mkdir -p Manuscript/Drafts

# Check if jq is available for JSON parsing
if ! command -v jq &> /dev/null; then
    echo "Warning: jq not found. Install jq for metadata extraction."
    echo "Proceeding with basic compilation..."
    BOOK_TITLE="[Book Title]"
    AUTHOR_NAME="[Author Name]"
else
    # Read metadata from .config/metadata.json
    if [ -f ".config/metadata.json" ]; then
        BOOK_TITLE=$(jq -r '.bookTitle // "[Book Title]"' .config/metadata.json)
        AUTHOR_NAME=$(jq -r '.authorName // "[Author Name]"' .config/metadata.json)
    else
        echo "Warning: .config/metadata.json not found"
        BOOK_TITLE="[Book Title]"
        AUTHOR_NAME="[Author Name]"
    fi
fi

# Sanitize project name for filename
PROJECT_NAME=$(sanitize_name "$BOOK_TITLE")

# Find highest existing version for this project and format
find_next_version() {
    local pattern="Manuscript/Drafts/${PROJECT_NAME}-${FORMAT}-v*.md"
    local highest=0

    for file in $pattern; do
        if [ -f "$file" ]; then
            # Extract version number from filename
            local num=$(echo "$file" | sed "s/.*-v\([0-9]*\)\.md/\1/" | sed 's/^0*//')
            if [ -n "$num" ] && [ "$num" -gt "$highest" ] 2>/dev/null; then
                highest=$num
            fi
        fi
    done

    echo $((highest + 1))
}

NEXT_VERSION=$(find_next_version)
VERSION_PADDED=$(printf "%02d" $NEXT_VERSION)

# Output file with new naming convention
OUTPUT_FILE="Manuscript/Drafts/${PROJECT_NAME}-${FORMAT}-v${VERSION_PADDED}.md"

# Start building the compiled manuscript
echo "Compiling manuscript..."
echo "Output: $OUTPUT_FILE"
echo ""

{
    # Header with metadata (wrapped in HTML comment to hide from export)
    echo "<!--"
    echo "COMPILE_METADATA"
    echo "Title: $BOOK_TITLE"
    echo "Author: $AUTHOR_NAME"
    echo "Compile: #${VERSION_PADDED}"
    echo "Compiled: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "Format: $FORMAT"
    echo "-->"
    echo ""
    echo "# $BOOK_TITLE"
    echo ""

    # Get current year for placeholder substitution
    CURRENT_YEAR=$(date '+%Y')

    # Front Matter
    if [ -d "Manuscript/FrontMatter" ]; then
        echo "<!-- FRONT MATTER -->"
        echo ""
        for file in Manuscript/FrontMatter/*.md; do
            if [ -f "$file" ]; then
                # Substitute placeholders with metadata values
                sed -e "s/\[YEAR\]/$CURRENT_YEAR/g" \
                    -e "s/\[AUTHOR NAME\]/$AUTHOR_NAME/g" \
                    -e "s/\[AUTHOR\]/$AUTHOR_NAME/g" \
                    -e "s/\[Book Title\]/$BOOK_TITLE/g" \
                    -e "s/\[BOOK TITLE\]/$BOOK_TITLE/g" \
                    "$file"
                echo ""
                if [ "$FORMAT" != "basic" ]; then
                    echo '<div style="page-break-before: always;"></div>'
                    echo ""
                fi
            fi
        done
    fi

    # Table of Contents (generated dynamically from chapters)
    if [ -d "Manuscript/Chapters" ]; then
        echo "<!-- TABLE OF CONTENTS -->"
        echo ""
        echo "# Table of Contents"
        echo ""

        # Generate TOC from chapter headings
        if ls Manuscript/Chapters/Chapter_*/ &> /dev/null; then
            for chapter_dir in Manuscript/Chapters/Chapter_*/; do
                chapter_name=$(basename "$chapter_dir")
                chapter_file="${chapter_dir}${chapter_name}.md"
                if [ -f "$chapter_file" ]; then
                    # Extract first heading (# Chapter XX: Title)
                    head -1 "$chapter_file"
                    echo ""
                fi
            done
        elif ls Manuscript/Chapters/Chapter_*.md &> /dev/null; then
            for chapter_file in Manuscript/Chapters/Chapter_*.md; do
                if [ -f "$chapter_file" ]; then
                    head -1 "$chapter_file"
                    echo ""
                fi
            done
        fi

        echo "---"
        echo ""
        if [ "$FORMAT" != "basic" ]; then
            echo '<div style="page-break-before: always;"></div>'
            echo ""
        fi
    fi

    # Main Content - Chapters
    if [ -d "Manuscript/Chapters" ]; then
        echo "<!-- MAIN CONTENT -->"
        echo ""

        # Handle both subdirectory and flat file structures
        # First try subdirectories (Chapter_XX/)
        if ls Manuscript/Chapters/Chapter_*/ &> /dev/null; then
            for chapter_dir in Manuscript/Chapters/Chapter_*/; do
                chapter_name=$(basename "$chapter_dir")
                chapter_file="${chapter_dir}${chapter_name}.md"

                if [ -f "$chapter_file" ]; then
                    # Strip metadata block (Status, Word Count, Last Updated lines and following ---)
                    sed -E '/^\*\*Status:\*\*/d; /^\*\*Word Count:\*\*/d; /^\*\*Last Updated:\*\*/d' "$chapter_file" | \
                    sed '0,/^---$/d'
                    echo ""
                    if [ "$FORMAT" != "basic" ]; then
                        echo '<div style="page-break-before: always;"></div>'
                        echo ""
                    fi
                fi
            done
        # If no subdirectories, try flat files (Chapter_XX.md)
        elif ls Manuscript/Chapters/Chapter_*.md &> /dev/null; then
            for chapter_file in Manuscript/Chapters/Chapter_*.md; do
                if [ -f "$chapter_file" ]; then
                    # Strip metadata block (Status, Word Count, Last Updated lines and following ---)
                    sed -E '/^\*\*Status:\*\*/d; /^\*\*Word Count:\*\*/d; /^\*\*Last Updated:\*\*/d' "$chapter_file" | \
                    sed '0,/^---$/d'
                    echo ""
                    if [ "$FORMAT" != "basic" ]; then
                        echo '<div style="page-break-before: always;"></div>'
                        echo ""
                    fi
                fi
            done
        else
            echo "[No chapters found]"
            echo ""
        fi
    fi

    # Back Matter
    if [ -d "Manuscript/BackMatter" ]; then
        echo "<!-- BACK MATTER -->"
        echo ""
        for file in Manuscript/BackMatter/*.md; do
            if [ -f "$file" ]; then
                # Substitute placeholders with metadata values
                sed -e "s/\[YEAR\]/$CURRENT_YEAR/g" \
                    -e "s/\[AUTHOR NAME\]/$AUTHOR_NAME/g" \
                    -e "s/\[AUTHOR\]/$AUTHOR_NAME/g" \
                    -e "s/\[Book Title\]/$BOOK_TITLE/g" \
                    -e "s/\[BOOK TITLE\]/$BOOK_TITLE/g" \
                    "$file"
                echo ""
                if [ "$FORMAT" != "basic" ]; then
                    echo '<div style="page-break-before: always;"></div>'
                    echo ""
                fi
            fi
        done
    fi

    # Footer
    echo ""
    echo "---"
    echo ""
    echo "**End of Manuscript**"
    echo ""
    echo "*Compiled with AI-Assisted Nonfiction Authoring Framework*"

} > "$OUTPUT_FILE"

# Calculate statistics
WORD_COUNT=$(wc -w < "$OUTPUT_FILE" | tr -d ' ')
LINE_COUNT=$(wc -l < "$OUTPUT_FILE" | tr -d ' ')

echo "✓ Compilation complete!"
echo ""
echo "Statistics:"
echo "  File: $OUTPUT_FILE"
echo "  Compile: #${VERSION_PADDED}"
echo "  Words: $WORD_COUNT"
echo "  Lines: $LINE_COUNT"
echo "  Format: $FORMAT"
echo ""

# Parseable output for script integration (must be last line)
echo "OUTPUT_FILE: $OUTPUT_FILE"
