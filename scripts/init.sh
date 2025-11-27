#!/usr/bin/env bash

################################################################################
# Nonfiction Framework Initialization Script
# Version: 0.14.3
#
# Purpose: Fast project structure creation for Prompt 1
# Usage: bash scripts/init.sh .config/init.json
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
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

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

    # Check if config is valid JSON
    if command -v jq &> /dev/null; then
        if ! jq empty "$CONFIG_FILE" 2>/dev/null; then
            echo -e "${RED}✗ Invalid JSON in config file${NC}"
            ((errors++))
        else
            echo -e "${GREEN}✓ Valid JSON config${NC}"
        fi
    else
        echo -e "${YELLOW}⚠ jq not installed, skipping JSON validation${NC}"
    fi

    # Check if git is installed
    if ! command -v git &> /dev/null; then
        echo -e "${RED}✗ Git not installed (required)${NC}"
        ((errors++))
    else
        echo -e "${GREEN}✓ Git is installed${NC}"
    fi

    # Check if Process/Templates exists
    if [[ ! -d "$PROJECT_ROOT/Process/Templates" ]]; then
        echo -e "${RED}✗ Process/Templates directory not found${NC}"
        ((errors++))
    else
        echo -e "${GREEN}✓ Process/Templates directory found${NC}"
    fi

    # Check if required templates exist
    local required_templates=(
        "Image_Registry_template.md"
        "Copyright_template.md"
        "About_Author_template.md"
        "epub-style.css"
        "reference.docx"
        "gitignore_template"
    )

    for template in "${required_templates[@]}"; do
        if [[ ! -f "$PROJECT_ROOT/Process/Templates/$template" ]]; then
            echo -e "${RED}✗ Missing template: $template${NC}"
            ((errors++))
        fi
    done

    if [[ $errors -eq 0 ]]; then
        echo -e "${GREEN}✓ All required templates found${NC}"
    fi

    # Check if re-initializing (smart merge mode)
    if [[ -f ".config/project.json" ]]; then
        local initialized=$(jq -r '.initialized' .config/project.json 2>/dev/null || echo "false")
        if [[ "$initialized" == "true" ]]; then
            echo -e "${YELLOW}⚠ Project already initialized (will preserve user content)${NC}"
        fi
    fi

    if [[ $errors -gt 0 ]]; then
        echo -e "${RED}✗ Validation failed with $errors error(s)${NC}"
        echo -e "${YELLOW}Please fix the errors above and try again.${NC}"
        exit 1
    fi

    echo -e "${GREEN}✓ All preconditions met${NC}"
    echo ""
}

################################################################################
# Directory Creation
################################################################################

create_directory_structure() {
    echo -e "${BLUE}Creating directory structure...${NC}"

    local directories=(
        "Manuscript/Chapters"
        "Manuscript/FrontMatter"
        "Manuscript/BackMatter/Bibliography"
        "Manuscript/Quotes"
        "Manuscript/Style"
        "Manuscript/_TOC_"
        "Manuscript/Inbox"
        "Manuscript/Drafts"
        "Manuscript/Exports"
        "Manuscript/images"
    )

    for dir in "${directories[@]}"; do
        if [[ -d "$dir" ]]; then
            echo -e "${YELLOW}⊙ Directory exists: $dir${NC}"
        else
            mkdir -p "$dir"
            echo -e "${GREEN}✓ Created: $dir${NC}"
        fi
    done

    echo ""
}

################################################################################
# Template Copying
################################################################################

copy_templates() {
    echo -e "${BLUE}Copying templates...${NC}"

    # Visual asset templates (skip if exists - preserve user content)
    if [[ ! -f "Manuscript/images/Image_Registry.md" ]]; then
        cp "$PROJECT_ROOT/Process/Templates/Image_Registry_template.md" "Manuscript/images/Image_Registry.md"
        echo -e "${GREEN}✓ Copied: Manuscript/images/Image_Registry.md${NC}"
    else
        echo -e "${YELLOW}⊙ Preserved: Manuscript/images/Image_Registry.md${NC}"
    fi

    # EPUB templates (skip if exists - preserve user content)
    if [[ ! -f "Manuscript/FrontMatter/Copyright.md" ]]; then
        cp "$PROJECT_ROOT/Process/Templates/Copyright_template.md" "Manuscript/FrontMatter/Copyright.md"
        echo -e "${GREEN}✓ Copied: Manuscript/FrontMatter/Copyright.md${NC}"
    else
        echo -e "${YELLOW}⊙ Preserved: Manuscript/FrontMatter/Copyright.md${NC}"
    fi

    if [[ ! -f "Manuscript/BackMatter/About_Author.md" ]]; then
        cp "$PROJECT_ROOT/Process/Templates/About_Author_template.md" "Manuscript/BackMatter/About_Author.md"
        echo -e "${GREEN}✓ Copied: Manuscript/BackMatter/About_Author.md${NC}"
    else
        echo -e "${YELLOW}⊙ Preserved: Manuscript/BackMatter/About_Author.md${NC}"
    fi

    if [[ ! -f "Manuscript/Style/epub-style.css" ]]; then
        cp "$PROJECT_ROOT/Process/Templates/epub-style.css" "Manuscript/Style/epub-style.css"
        echo -e "${GREEN}✓ Copied: Manuscript/Style/epub-style.css${NC}"
    else
        echo -e "${YELLOW}⊙ Preserved: Manuscript/Style/epub-style.css${NC}"
    fi

    # DOCX reference template (skip if exists - preserve user customization)
    if [[ ! -f "Manuscript/Style/reference.docx" ]]; then
        cp "$PROJECT_ROOT/Process/Templates/reference.docx" "Manuscript/Style/reference.docx"
        echo -e "${GREEN}✓ Copied: Manuscript/Style/reference.docx${NC}"
    else
        echo -e "${YELLOW}⊙ Preserved: Manuscript/Style/reference.docx${NC}"
    fi

    # Git ignore (always overwrite)
    cp "$PROJECT_ROOT/Process/Templates/gitignore_template" ".gitignore"
    echo -e "${GREEN}✓ Copied: .gitignore${NC}"

    echo ""
}

################################################################################
# Git Initialization
################################################################################

initialize_git() {
    echo -e "${BLUE}Initializing git repository...${NC}"

    if [[ -d ".git" ]]; then
        echo -e "${YELLOW}⊙ Git repository already initialized${NC}"
    else
        git init
        echo -e "${GREEN}✓ Git repository initialized${NC}"
    fi

    echo ""
}

################################################################################
# Summary Report
################################################################################

print_summary() {
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}✓ Initialization script completed successfully${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${BLUE}Structure created:${NC}"
    echo "  • 10 directories (Manuscript structure)"
    echo "  • 6 template files copied"
    echo "  • Git repository initialized"
    echo ""
    echo -e "${YELLOW}Next steps:${NC}"
    echo "  • Claude will now generate content files (Style_Guide, TOC, etc.)"
    echo "  • Claude will run tool detection (pandoc/typst)"
    echo "  • Claude will create initial git commit"
    echo ""
}

################################################################################
# Main Execution
################################################################################

main() {
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}Nonfiction Framework Initialization Script v0.14.3${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""

    # Change to project root
    cd "$PROJECT_ROOT"

    # Run validation
    validate_preconditions

    # Create structure
    create_directory_structure

    # Copy templates
    copy_templates

    # Initialize git
    initialize_git

    # Detect export tools (will update manifest after Claude populates it)
    echo ""
    echo -e "${BLUE}Detecting export tools...${NC}"
    echo ""

    # Note: Tool detection will be run again by Claude after manifest is populated
    # This is just for user information during init
    if command -v bash &> /dev/null; then
        bash "$SCRIPT_DIR/detect-tools.sh" .config/manifest.json 2>/dev/null || echo -e "${YELLOW}⊙ Tool detection will complete after Claude populates manifest${NC}"
    fi

    # Print summary
    print_summary
}

# Run main function
main "$@"
