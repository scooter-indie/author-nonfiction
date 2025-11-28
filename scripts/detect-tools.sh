#!/usr/bin/env bash

################################################################################
# Tool Detection Script
# Version: 0.15.3
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
        GIT_VERSION=$(git --version | sed 's/git version //' | tr -d '\r')
        echo -e "${GREEN}✓ Git detected${NC} (version $GIT_VERSION)"
        return 0
    else
        echo -e "${RED}✗ Git not found${NC} (required)"
        return 1
    fi
}

detect_jq() {
    # Try command -v first, then check Windows locations
    # Note: tr -d '\r' removes Windows carriage returns
    local JQ_CMD=""

    if command -v jq &> /dev/null; then
        JQ_CMD="jq"
    elif command -v jq.exe &> /dev/null; then
        JQ_CMD="jq.exe"
    else
        # Check Windows winget installation path
        # winget installs to: %LOCALAPPDATA%\Microsoft\WinGet\Packages\jqlang.jq_*\jq.exe
        local WINGET_JQ=""
        if [[ -n "$LOCALAPPDATA" ]]; then
            # Convert Windows path to Unix path for Git Bash
            local LOCAL_APP_DATA_UNIX=$(echo "$LOCALAPPDATA" | sed 's/\\/\//g' | sed 's/C:/\/c/')
            WINGET_JQ=$(find "$LOCAL_APP_DATA_UNIX/Microsoft/WinGet/Packages" -name "jq.exe" 2>/dev/null | head -1)
        fi
        # Also try common Unix-style path
        if [[ -z "$WINGET_JQ" && -d "/c/Users/$USER/AppData/Local/Microsoft/WinGet/Packages" ]]; then
            WINGET_JQ=$(find "/c/Users/$USER/AppData/Local/Microsoft/WinGet/Packages" -name "jq.exe" 2>/dev/null | head -1)
        fi

        if [[ -n "$WINGET_JQ" && -x "$WINGET_JQ" ]]; then
            JQ_CMD="$WINGET_JQ"
        fi
    fi

    if [[ -n "$JQ_CMD" ]]; then
        JQ_VERSION=$("$JQ_CMD" --version | sed 's/jq-//' | tr -d '\r')
        echo -e "${GREEN}✓ jq detected${NC} (version $JQ_VERSION)"
        return 0
    else
        echo -e "${RED}✗ jq not found${NC} (required)"
        return 1
    fi
}

detect_pandoc() {
    # Try command -v first, then check Windows locations
    # Note: tr -d '\r' removes Windows carriage returns
    if command -v pandoc &> /dev/null; then
        PANDOC_VERSION=$(pandoc --version | head -n1 | sed 's/pandoc //' | tr -d '\r')
        echo -e "${GREEN}✓ Pandoc detected${NC} (version $PANDOC_VERSION)"
        return 0
    elif command -v pandoc.exe &> /dev/null; then
        PANDOC_VERSION=$(pandoc.exe --version | head -n1 | sed 's/pandoc //' | tr -d '\r')
        echo -e "${GREEN}✓ Pandoc detected${NC} (version $PANDOC_VERSION)"
        return 0
    elif [[ -f "/c/Program Files/Pandoc/pandoc.exe" ]]; then
        PANDOC_VERSION=$("/c/Program Files/Pandoc/pandoc.exe" --version | head -n1 | sed 's/pandoc //' | tr -d '\r')
        echo -e "${GREEN}✓ Pandoc detected${NC} (version $PANDOC_VERSION)"
        return 0
    else
        echo -e "${YELLOW}⊙ Pandoc not found${NC} (optional - required for Prompt 9 DOCX/PDF/EPUB export)"
        return 1
    fi
}

detect_typst() {
    # Try command -v first, then check Windows locations
    # Note: tr -d '\r' removes Windows carriage returns
    if command -v typst &> /dev/null; then
        TYPST_VERSION=$(typst --version | sed 's/typst //' | tr -d '\r')
        echo -e "${GREEN}✓ Typst detected${NC} (version $TYPST_VERSION)"
        return 0
    elif command -v typst.exe &> /dev/null; then
        TYPST_VERSION=$(typst.exe --version | sed 's/typst //' | tr -d '\r')
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
    local jq_available=$2
    local pandoc_available=$3
    local typst_available=$4

    if [[ ! -f "$MANIFEST_FILE" ]]; then
        # Silently return - manifest will be created by configure.md Step 3
        return 0
    fi

    # Check if jq is available for JSON manipulation (try both jq and jq.exe for Windows)
    local JQ_CMD=""
    if command -v jq &> /dev/null; then
        JQ_CMD="jq"
    elif command -v jq.exe &> /dev/null; then
        JQ_CMD="jq.exe"
    fi

    if [[ -n "$JQ_CMD" ]]; then
        # Use jq for clean JSON updates
        local temp_file=$(mktemp)
        $JQ_CMD ".toolsAvailable.git = $git_available | .toolsAvailable.jq = $jq_available | .toolsAvailable.pandoc = $pandoc_available | .toolsAvailable.typst = $typst_available | .lastUpdated = \"$(date -I)\"" "$MANIFEST_FILE" > "$temp_file"
        mv "$temp_file" "$MANIFEST_FILE"
        echo -e "${GREEN}✓ Updated $MANIFEST_FILE${NC}"
    else
        # Fallback: Manual sed replacement (less reliable but works without jq)
        echo -e "${YELLOW}⚠ jq not available, using sed for updates${NC}"

        sed -i "s/\"git\": [^,]*/\"git\": $git_available/" "$MANIFEST_FILE"
        sed -i "s/\"jq\": [^,]*/\"jq\": $jq_available/" "$MANIFEST_FILE"
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
    local jq_available=$2
    local pandoc_available=$3
    local typst_available=$4

    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}Tool Detection Summary${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""

    echo "Required tools:"
    if [[ $git_available == "true" ]]; then
        echo -e "  ${GREEN}✓${NC} Git - Version control (required)"
    else
        echo -e "  ${RED}✗${NC} Git - Version control (required)"
    fi

    if [[ $jq_available == "true" ]]; then
        echo -e "  ${GREEN}✓${NC} jq - JSON processing (required)"
    else
        echo -e "  ${RED}✗${NC} jq - JSON processing (required)"
    fi

    echo ""
    echo "Optional tools:"
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

    # Installation instructions for missing required tools
    if [[ $git_available == "false" ]] || [[ $jq_available == "false" ]]; then
        echo -e "${RED}⚠ REQUIRED TOOLS MISSING - Install before continuing:${NC}"
        echo ""

        if [[ $git_available == "false" ]]; then
            echo "  Git: https://git-scm.com/"
            echo "  - Windows: winget install Git.Git (or https://git-scm.com/download/win)"
            echo "  - macOS: brew install git"
            echo "  - Linux: sudo apt install git"
            echo ""
        fi

        if [[ $jq_available == "false" ]]; then
            echo "  jq: https://jqlang.org/download/"
            echo "  - Windows: winget install jqlang.jq"
            echo "  - macOS: brew install jq"
            echo "  - Linux: sudo apt install jq"
            echo ""
        fi
    fi

    # Installation instructions for missing optional tools
    if [[ $pandoc_available == "false" ]] || [[ $typst_available == "false" ]]; then
        echo -e "${YELLOW}Optional tools (for Prompt 9 exports):${NC}"
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
    fi

    echo -e "${BLUE}After installing tools, run this script again to update detection.${NC}"
    echo ""
}

################################################################################
# Main Execution
################################################################################

main() {
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}Tool Detection Script v0.15.3${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""

    # Change to project root
    cd "$PROJECT_ROOT"

    echo "Detecting available tools..."
    echo ""

    # Detect required tools
    detect_git && GIT_AVAILABLE="true" || GIT_AVAILABLE="false"
    detect_jq && JQ_AVAILABLE="true" || JQ_AVAILABLE="false"

    # Detect optional tools
    detect_pandoc && PANDOC_AVAILABLE="true" || PANDOC_AVAILABLE="false"
    detect_typst && TYPST_AVAILABLE="true" || TYPST_AVAILABLE="false"

    echo ""

    # Update manifest if it exists (silently skip if not - configure.md creates it later)
    if [[ -f "$MANIFEST_FILE" ]]; then
        update_manifest "$GIT_AVAILABLE" "$JQ_AVAILABLE" "$PANDOC_AVAILABLE" "$TYPST_AVAILABLE"
    fi

    # Display summary
    display_summary "$GIT_AVAILABLE" "$JQ_AVAILABLE" "$PANDOC_AVAILABLE" "$TYPST_AVAILABLE"
}

# Run main function
main "$@"
