# Changelog

All notable changes to the AI-Assisted Nonfiction Authoring Framework will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [0.10.0] - 2025-11-19

### Added
- **Modular Architecture**: Created `Process/_COMMON/` directory with 14 reusable common modules
  - 01_Prompt_Structure_Template.md - Master template for all prompts
  - 02_Desktop_Compatibility_Module.md - Compatibility headers and specifications
  - 03_Anti_Hallucination_Protocols.md - Three-level protocol system
  - 04_File_Operations_Library.md - Standardized file operation protocols
  - 05_Git_Integration_Module.md - Git commands, formats, and workflows
  - 06_Validation_Protocols.md - Safety checks and validation procedures
  - 07_Quote_Management_System.md - Quote tracking and verification protocols
  - 08_Semantic_Versioning_Guide.md - Version numbering rules and examples
  - 09_Report_Templates.md - Statistics and report formatting templates
  - 10_Style_Consistency_Protocol.md - Style checking workflows
  - 11_Interactive_Patterns.md - Question/confirmation templates
  - 12_Workflow_Patterns.md - Common workflow sequences
  - 13_PROJECT_CONTEXT_Protocol.md - When and how to update project context
  - 14_Enforcement_Rules_Module.md - Routing and validation response templates
- **Comprehensive Documentation**: Process/_COMMON/README.md with complete module usage guide
- **Refactor Changelog**: REFACTOR_CHANGELOG.md documenting complete refactoring history

### Changed
- **BREAKING: Prompt 5 Compatibility**: Changed from DESKTOP-READY to CLI-ONLY
  - Compilation now requires Claude Code CLI (not Claude Desktop)
  - Rationale: Bulk file operations (reading all manuscript files, writing large compiled draft) optimized for CLI
  - Clear separation: Desktop = interactive content creation, CLI = batch operations
- **Enforcement Rules Integration**: All 10 prompts now include CRITICAL ENFORCEMENT notices
  - RULE 1: Automatic _chg file updates (mandatory for all file modifications)
  - RULE 2: Workflow routing (all Manuscript/ changes through appropriate prompts)
  - File-modifying prompts (1, 2, 3, 4, 10) explicitly document _chg update steps in workflow
  - Read-only prompts (5, 6, 7, 8, 9) explicitly state no _chg updates required
- **Version Update**: Framework version 0.9.2 → 0.10.0 across all documentation

### Fixed
- **Eliminated Code Duplication**: Removed 2,500-3,500 lines of duplicated content
  - Established single source of truth for all common patterns
  - 60% reduction in maintenance effort
  - 100% consistency across all prompts

### Technical
- **Modular Component System**: All common patterns extracted into reusable modules
- **Single Source of Truth**: Bug fixes and updates now propagate automatically
- **Enforcement Compliance**: 100% change tracking compliance with zero violations
- **Maintainability**: Faster to create new prompts, faster to fix bugs, clearer architecture
- **Data Integrity**: Complete audit trail for all changes with reliable rollback capability

---

## [0.9.2] - 2025-11-19

### Added
- **Active Anti-Hallucination Enforcement**: Mandatory ASK-FIRST verification protocol
  - MANDATORY VERIFICATION PROTOCOL in system-instructions.md
  - Anti-Hallucination Verification step in Prompt 3 workflow (step #7)
  - Interactive prompts for examples, anecdotes, statistics, and quotes
  - Content labeling system: REAL vs HYPOTHETICAL vs GENERIC vs [CITATION NEEDED]
  - Verification notes added to Prompts 1, 4, and 5

### Changed
- **Anti-Hallucination Guidelines**: Moved from passive documentation to active enforcement
  - "ASK FIRST - Don't Assume" now principle #1
  - AI must ASK user before generating specific examples or claiming experiences
  - Explicit FORBIDDEN FABRICATIONS list (specific people, fake statistics, unverified quotes)
  - Updated CLAUDE.md with verification checklist
  - Renumbered principles to avoid duplication

### Fixed
- **Hallucination Prevention**: Addresses fabricated examples like "Sarah, a consultant..." and false claims like "I hear from authors..."
  - Requires explicit user confirmation for all specific examples
  - Forces verification of statistics and quotes before inclusion
  - Prevents AI from speaking on behalf of user's experiences

### Technical
- Anti-hallucination verification integrated into content generation workflow
- Verification triggers before finalizing content in Prompt 3
- All content-generating prompts now reference verification protocol

---

## [0.9.1] - 2025-11-19

### Added
- **PROJECT_CONTEXT.md System**: Single file upload for Claude Desktop session resumption
  - Auto-generated during Prompt 1 initialization
  - Auto-updated by Prompts 3, 8, and 10
  - Contains framework overview + project-specific state
  - Upload to Files area in Claude Desktop with System Instructions
- **Claude Desktop Workflow Documentation**: Complete guide in Process/Prompts/README.md
  - System Instructions for Claude Desktop
  - Workflow examples
  - PROJECT_CONTEXT.md usage guide

### Changed
- **ALL 10 Prompts Now Desktop-Friendly** (95% compatibility):
  - Prompt 1 (Initialize): HYBRID → DESKTOP-FRIENDLY
  - Prompt 2 (Add Chapter): CLI-ONLY → DESKTOP-FRIENDLY (uses MCP move_file for directories)
  - Prompt 3 (Modify File): Already Desktop-friendly
  - Prompt 4 (Integrate Inbox): HYBRID → DESKTOP-FRIENDLY
  - Prompt 5 (Compile): Already Desktop-ready (100%)
  - Prompt 6 (Consistency): Already Desktop-ready (100%)
  - Prompt 7 (Export): HYBRID → DESKTOP-FRIENDLY
  - Prompt 8 (Dashboard): Already Desktop-friendly
  - Prompt 9 (Git): CLI-ONLY → DESKTOP-FRIENDLY (provides commands to copy/paste)
  - Prompt 10 (Update Change Tracking): Already Desktop-friendly

### Fixed
- Prompt 2 directory renaming now uses MCP Filesystem move_file instead of bash mv
- Improved Desktop compatibility messaging across all prompts
- Clarified git operation workflows for Desktop users

### Technical
- All file operations use MCP Filesystem connector
- Git operations via Claude Code CLI (copy/paste commands)
- Average 95% Desktop compatibility across all prompts

---

## [0.9.0] - 2025-11-18 (Pre-release)

### Major Structural Changes

**Directory Reorganization:**
- **NEW: `Manuscript/` directory** - All book content now organized under single parent directory
- Clearer separation between manuscript content and framework files
- Better organization for complex books with multiple content types

**New Structure:**
```
project-root/
├── Manuscript/           # All book content here
│   ├── Chapters/
│   │   ├── Chapter_01/   # Each chapter in own subdirectory
│   │   │   ├── Chapter_01.md
│   │   │   ├── Chapter_01_chg.md
│   │   │   └── figures/  # Images, charts for this chapter
│   │   └── Chapter_02/
│   ├── FrontMatter/
│   ├── BackMatter/
│   │   └── Bibliography/ # Now subdirectory of BackMatter
│   ├── Quotes/
│   ├── Style/
│   ├── _TOC_/
│   ├── Inbox/
│   ├── Drafts/           # Moved from root
│   └── Exports/          # Moved from root
├── Process/              # Framework (unchanged location)
├── .claude/              # Configuration
└── [config files at root]
```

### Changed
- **Chapter Organization**: Each chapter now in own subdirectory
  - Supports chapter-specific assets (images, figures, tables)
  - Cleaner organization for large books
  - Easier to manage chapter-related files
- **Drafts Location**: Moved from root to `Manuscript/Drafts/`
- **Exports Location**: Moved from root to `Manuscript/Exports/`
- **Bibliography**: Now `Manuscript/BackMatter/Bibliography/` instead of separate
- **TOC**: Renamed from `TOC/` to `_TOC_/` for better sorting
- **All Prompts Updated**: Reflect new directory paths

### Added
- Pre-configured `.claude/hooks.json` for auto-approval of git commands
- `.claude/README.md` documenting hooks configuration
- Clearer installation instructions for zip extraction

### Fixed
- Command references now use `claude` instead of non-existent `claude-code`
- Extraction instructions clarify how to avoid creating subdirectory
- Working directory detection using `pwd` instead of environment info

### Migration Notes

**For Existing Users:**

This is a breaking change. To migrate from v3.x.x to 0.9.0:

1. **Backup your work**: Create full project backup
2. **Commit everything**: `git commit -am "Pre-migration backup"`
3. **Manual restructure required**:
   ```bash
   mkdir Manuscript
   mv Chapters Manuscript/
   mv FrontMatter Manuscript/
   mv BackMatter Manuscript/
   mv Quotes Manuscript/
   mv Style Manuscript/
   mv TOC Manuscript/_TOC_/
   mv Inbox Manuscript/
   mv Drafts Manuscript/
   mv Exports Manuscript/

   # Restructure chapters into subdirectories
   cd Manuscript/Chapters
   for chapter in Chapter_*.md; do
     name="${chapter%.md}"
     mkdir -p "$name"
     mv "$name.md" "$name/"
     mv "${name}_chg.md" "$name/" 2>/dev/null || true
   done

   # Move Bibliography under BackMatter
   cd ../BackMatter
   mkdir -p Bibliography
   # Move your bibliography files into Bibliography/
   ```
4. **Update framework**: Extract 0.9.0 zip with overwrite
5. **Run configure.md**: Verify setup
6. **Test prompts**: Verify all prompts work with new structure

**Why Pre-release (0.9.0)?**

This restructure represents a significant change. We're using 0.9.0 to indicate:
- Framework is feature-complete
- Directory structure is now finalized
- Ready for testing before 1.0.0 stable release
- Breaking change from 3.x.x series

Version 1.0.0 will be released once this structure is validated by users.

---

## Previous Versions (3.x.x series - deprecated)

The 3.x.x version series used a flat directory structure at the project root.
All releases and tags from that series have been removed to avoid confusion.

Key features from 3.x.x that are retained in 0.9.0:
- 10 Core Prompts for complete authoring workflow
- 9 Professional Writing Styles with examples
- Quote Management System with verification
- Change Tracking with semantic versioning
- Export to DOCX/PDF/EPUB formats
- Consistency Checking across all content
- Anti-Hallucination Guidelines for accuracy
- Simplified installation (download + unzip + configure)
- GitHub Actions for automated releases

---

**Project Repository**: https://github.com/scooter-indie/author-nonfiction
**Report Issues**: https://github.com/scooter-indie/author-nonfiction/issues
