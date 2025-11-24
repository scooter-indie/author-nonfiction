#!/usr/bin/env bash

################################################################################
# Tool Detection Script
# Version: 0.13.2
#
# Purpose: Detect available export tools and update .config/manifest.json
# Usage: bash scripts/detect-tools.sh [path-to-manifest.json]
################################################################################

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
MANIFEST_FILE="${1:-.config/manifest.json}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

################################################################################
# Tool Detection Functions
################################################################################

detect_git() {
    if command -v git &> /dev/null; then
        GIT_VERSION=$(git --version | sed 's/git version //')
        echo -e "${GREEN}✓ Git detected${NC} (version $GIT_VERSION)"
        return 0
    else
        echo -e "${RED}✗ Git not found${NC}"
        return 1
    fi
}

detect_pandoc() {
    if command -v pandoc &> /dev/null; then
        PANDOC_VERSION=$(pandoc --version | head -n1 | sed 's/pandoc //')
        echo -e "${GREEN}✓ Pandoc detected${NC} (version $PANDOC_VERSION)"
        return 0
    else
        echo -e "${YELLOW}⊙ Pandoc not found${NC} (optional - required for Prompt 9 DOCX/PDF/EPUB export)"
        return 1
    fi
}

detect_typst() {
    if command -v typst &> /dev/null; then
        TYPST_VERSION=$(typst --version | sed 's/typst //')
        echo -e "${GREEN}✓ Typst detected${NC} (version $TYPST_VERSION)"
        return 0
    else
        echo -e "${YELLOW}⊙ Typst not found${NC} (optional - alternative to LaTeX for PDF export)"
        return 1
    fi
}

################################################################################
# Update Manifest Function
################################################################################

update_manifest() {
    local git_available=$1
    local pandoc_available=$2
    local typst_available=$3

    if [[ ! -f "$MANIFEST_FILE" ]]; then
        echo -e "${RED}✗ Manifest file not found: $MANIFEST_FILE${NC}"
        echo -e "${YELLOW}Run this script after Prompt 1 initialization${NC}"
        return 1
    fi

    # Check if jq is available for JSON manipulation
    if command -v jq &> /dev/null; then
        # Use jq for clean JSON updates
        local temp_file=$(mktemp)
        jq ".toolsAvailable.git = $git_available | .toolsAvailable.pandoc = $pandoc_available | .toolsAvailable.typst = $typst_available | .lastUpdated = \"$(date -I)\"" "$MANIFEST_FILE" > "$temp_file"
        mv "$temp_file" "$MANIFEST_FILE"
        echo -e "${GREEN}✓ Updated $MANIFEST_FILE${NC}"
    else
        # Fallback: Manual sed replacement (less reliable but works without jq)
        echo -e "${YELLOW}⚠ jq not available, using sed for updates${NC}"

        sed -i "s/\"git\": [^,]*/\"git\": $git_available/" "$MANIFEST_FILE"
        sed -i "s/\"pandoc\": [^,]*/\"pandoc\": $pandoc_available/" "$MANIFEST_FILE"
        sed -i "s/\"typst\": [^,]*/\"typst\": $typst_available/" "$MANIFEST_FILE"
        sed -i "s/\"lastUpdated\": \"[^\"]*\"/\"lastUpdated\": \"$(date -I)\"/" "$MANIFEST_FILE"

        echo -e "${GREEN}✓ Updated $MANIFEST_FILE${NC}"
    fi
}

################################################################################
# Display Summary Function
################################################################################

display_summary() {
    local git_available=$1
    local pandoc_available=$2
    local typst_available=$3

    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}Tool Detection Summary${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""

    echo "Available tools:"
    if [[ $git_available == "true" ]]; then
        echo -e "  ${GREEN}✓${NC} Git - Version control (required)"
    else
        echo -e "  ${RED}✗${NC} Git - Version control (required)"
    fi

    if [[ $pandoc_available == "true" ]]; then
        echo -e "  ${GREEN}✓${NC} Pandoc - DOCX/PDF/EPUB export (Prompt 9)"
    else
        echo -e "  ${YELLOW}⊙${NC} Pandoc - Install for DOCX/PDF/EPUB export"
    fi

    if [[ $typst_available == "true" ]]; then
        echo -e "  ${GREEN}✓${NC} Typst - Fast PDF export (Prompt 9 alternative)"
    else
        echo -e "  ${YELLOW}⊙${NC} Typst - Install for fast PDF export"
    fi

    echo ""

    # Installation instructions for missing tools
    if [[ $pandoc_available == "false" ]] || [[ $typst_available == "false" ]]; then
        echo -e "${YELLOW}Installation instructions:${NC}"
        echo ""

        if [[ $pandoc_available == "false" ]]; then
            echo "  Pandoc: https://pandoc.org/installing.html"
            echo "  - Windows: winget install JohnMacFarlane.Pandoc"
            echo "  - macOS: brew install pandoc"
            echo "  - Linux: sudo apt install pandoc"
            echo ""
        fi

        if [[ $typst_available == "false" ]]; then
            echo "  Typst: https://github.com/typst/typst#installation"
            echo "  - Windows: winget install Typst.Typst"
            echo "  - macOS: brew install typst"
            echo "  - Linux: Download from releases"
            echo ""
        fi

        echo -e "${BLUE}After installing, run this script again to update detection.${NC}"
    fi

    echo ""
}

################################################################################
# Main Execution
################################################################################

main() {
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}Tool Detection Script v0.13.2${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""

    # Change to project root
    cd "$PROJECT_ROOT"

    echo "Detecting available tools..."
    echo ""

    # Detect tools
    detect_git && GIT_AVAILABLE="true" || GIT_AVAILABLE="false"
    detect_pandoc && PANDOC_AVAILABLE="true" || PANDOC_AVAILABLE="false"
    detect_typst && TYPST_AVAILABLE="true" || TYPST_AVAILABLE="false"

    echo ""

    # Update manifest if it exists
    if [[ -f "$MANIFEST_FILE" ]]; then
        update_manifest "$GIT_AVAILABLE" "$PANDOC_AVAILABLE" "$TYPST_AVAILABLE"
    else
        echo -e "${YELLOW}⚠ Manifest file not found (run after Prompt 1)${NC}"
        echo -e "${YELLOW}Detection results not saved to manifest${NC}"
    fi

    # Display summary
    display_summary "$GIT_AVAILABLE" "$PANDOC_AVAILABLE" "$TYPST_AVAILABLE"
}

# Run main function
main "$@"
