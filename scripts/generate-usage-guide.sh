#!/usr/bin/env bash

################################################################################
# Generate USAGE_GUIDE.md Script
# Version: 0.16.1
#
# Purpose: Generate USAGE_GUIDE.md from template with user-specific data
# Usage: bash scripts/generate-usage-guide.sh "Book Title" "Author Name" "2025-11-21" "10" "Conversational Expert"
################################################################################

set -e  # Exit on error

# Check arguments
if [ "$#" -ne 5 ]; then
    echo "Error: Requires exactly 5 arguments"
    echo "Usage: bash scripts/generate-usage-guide.sh BOOK_TITLE AUTHOR_NAME INIT_DATE CHAPTER_COUNT STYLE_NAME"
    echo ""
    echo "Example:"
    echo '  bash scripts/generate-usage-guide.sh "My Book" "John Doe" "2025-11-21" "10" "Conversational Expert"'
    exit 1
fi

# Parameters
BOOK_TITLE="$1"
AUTHOR_NAME="$2"
INIT_DATE="$3"
CHAPTER_COUNT="$4"
STYLE_NAME="$5"

# Check if template exists
if [ ! -f "Process/Templates/USAGE_GUIDE_template.md" ]; then
    echo "Error: Template not found at Process/Templates/USAGE_GUIDE_template.md"
    exit 1
fi

# Copy template
cp Process/Templates/USAGE_GUIDE_template.md USAGE_GUIDE.md

# Escape special characters for sed (handles /, &, etc.)
BOOK_TITLE_ESCAPED=$(echo "$BOOK_TITLE" | sed 's/[&/\]/\\&/g')
AUTHOR_NAME_ESCAPED=$(echo "$AUTHOR_NAME" | sed 's/[&/\]/\\&/g')
STYLE_NAME_ESCAPED=$(echo "$STYLE_NAME" | sed 's/[&/\]/\\&/g')

# Substitute placeholders
sed -i "s/{{BOOK_TITLE}}/$BOOK_TITLE_ESCAPED/g" USAGE_GUIDE.md
sed -i "s/{{AUTHOR_NAME}}/$AUTHOR_NAME_ESCAPED/g" USAGE_GUIDE.md
sed -i "s/{{INIT_DATE}}/$INIT_DATE/g" USAGE_GUIDE.md
sed -i "s/{{CHAPTER_COUNT}}/$CHAPTER_COUNT/g" USAGE_GUIDE.md
sed -i "s/{{STYLE_NAME}}/$STYLE_NAME_ESCAPED/g" USAGE_GUIDE.md

echo "✓ Generated USAGE_GUIDE.md"
