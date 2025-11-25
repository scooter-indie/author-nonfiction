#!/bin/bash
# Compile Complete Manuscript
# Usage: compile-manuscript.sh VERSION DATE [FORMAT]
# VERSION: e.g., "1.0.0"
# DATE: YYYY-MM-DD (confirmed date from session)
# FORMAT: basic|formatted|publication (default: formatted)

set -e  # Exit on error

# Parameters
VERSION="${1}"
DATE="${2}"
FORMAT="${3:-formatted}"

# Strip leading "v" from version if present (prevents vv1.0.0)
VERSION="${VERSION#v}"

if [ -z "$VERSION" ] || [ -z "$DATE" ]; then
    echo "Error: VERSION and DATE are required"
    echo "Usage: compile-manuscript.sh VERSION DATE [FORMAT]"
    exit 1
fi

# Output file
OUTPUT_FILE="Manuscript/Drafts/Full_Draft_${DATE}_v${VERSION}.md"

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

# Start building the compiled manuscript
echo "Compiling manuscript..."
echo "Output: $OUTPUT_FILE"
echo ""

{
    # Header with metadata
    echo "# $BOOK_TITLE"
    echo ""
    echo "**Author:** $AUTHOR_NAME"
    echo "**Version:** v$VERSION"
    echo "**Compiled:** $(date '+%Y-%m-%d %H:%M:%S')"
    echo "**Format:** $FORMAT"
    echo ""
    echo "---"
    echo ""

    # Front Matter
    if [ -d "Manuscript/FrontMatter" ]; then
        echo "<!-- FRONT MATTER -->"
        echo ""
        for file in Manuscript/FrontMatter/*.md; do
            if [ -f "$file" ]; then
                cat "$file"
                echo ""
                if [ "$FORMAT" != "basic" ]; then
                    echo "---"
                    echo ""
                fi
            fi
        done
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
                        echo "---"
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
                        echo "---"
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
                cat "$file"
                echo ""
                if [ "$FORMAT" != "basic" ]; then
                    echo "---"
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
echo "  Words: $WORD_COUNT"
echo "  Lines: $LINE_COUNT"
echo "  Format: $FORMAT"
echo ""
