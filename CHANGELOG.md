# Changelog

All notable changes to the AI-Assisted Nonfiction Authoring Framework will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [0.11.0] - 2025-11-20

### Added
- **Prompt 4: Interactive Change** - Conversational editing workflow that writes instructions to _chg files
  - Interactive dialogue for discussing changes before applying
  - Writes formatted instructions to _chg files
  - Optionally executes Prompt 3 to apply changes immediately
  - DESKTOP-FRIENDLY compatibility (95% - single git commit at end)
- **Prompt 13: AI Detection Analysis** - Analyze chapters for AI-generated text indicators
  - Scans for repetitive patterns, generic transitions, and AI text markers
  - Generates authenticity scores per chapter (1-10 scale)
  - Provides rewriting suggestions to improve human voice
  - CLI-ONLY compatibility (bulk chapter analysis)
- **Prompt 14: Visual Content Suggester** - Create and manage visual assets
  - Analyzes chapters for visual opportunities (diagrams, tables, charts)
  - Creates text-based visuals (markdown tables, ASCII diagrams)
  - Saves to `figures/` subdirectories with registry tracking
  - Auto-maintains `figures/README.md` for each chapter
  - Tracks replacement priority (📝 text-based → 🖼️ professional upgrade path)
  - CLI-ONLY/HYBRID compatibility
- **Prompt 15: Citation Finder** - WebSearch-based citation discovery and insertion
  - Scans for uncited statistical claims and facts
  - Uses WebSearch to find real academic sources
  - Auto-inserts citations with ⏳ Pending status
  - Updates Bibliography with full citation details
  - Strictest anti-hallucination compliance (Level 3 - NEVER fabricate)
  - CLI-ONLY compatibility (requires WebSearch tool)
- **Module 15: Visual_Asset_Management_Protocol** - Standardized figure management system
  - Status codes: 📝 text-based vs 🖼️ professional images
  - Figure registry format and metadata standards
  - Upgrade path from text-based to professional graphics
- **Module 16: Citation_Management_Protocol** - Citation verification workflow
  - Status codes: ⏳ Pending | ✓ Verified | ❌ Rejected
  - WebSearch verification procedures
  - Integration with Anti-Hallucination Guidelines
- **Natural Language Intent Recognition** - Conversational prompt invocation
  - Added to book-writing-assistant.md for Claude Code CLI
  - Supports phrases like "I want to modify chapter 4" → triggers Prompt 4
  - Works for all 15 prompts with natural variations

### Changed
- **Prompt Structure: 11→15 prompts** (expanded framework)
  - OLD Prompt 3 → NEW Prompt 3: Change_by_Chg (renamed, clarified purpose)
  - OLD Prompt 4 → NEW Prompt 6: Integrate_Inbox
  - OLD Prompt 5 → NEW Prompt 7: Compile
  - OLD Prompt 6 → NEW Prompt 8: Consistency
  - OLD Prompt 7 → NEW Prompt 9: Export
  - OLD Prompt 8 → NEW Prompt 10: Dashboard
  - OLD Prompt 9 → NEW Prompt 12: Git_Operations
  - OLD Prompt 10 → NEW Prompt 5: Scan_For_User_Edits (repositioned for workflow logic)
  - Prompt 11: Style_Manager (unchanged)
- **Prompt 3: Change_by_Chg** - Clarified as automated _chg file execution only
  - No interactive elements (moved to Prompt 4)
  - References Prompt 4 for conversational editing
- **Prompt 8: Consistency Checker** - Enhanced with visual and citation status reporting
  - Reports on figures/ directories (📝 vs 🖼️ distribution)
  - Reports on Bibliography files (⏳/✓/❌ citation status)
  - Recommends when to run Prompts 14 and 15
  - Identifies chapters lacking visuals or citations
- **Compatibility Classifications** - Updated for 15-prompt structure
  - CLI-ONLY: Prompts 7, 9, 12, 13, 14, 15 (6 prompts)
  - DESKTOP-FRIENDLY: Prompts 2, 3, 4, 5, 6, 10 (6 prompts)
  - HYBRID: configure.md, Prompts 1, 11 (2 prompts + config)
  - DESKTOP-READY: Prompt 8 (1 prompt - 100% no CLI)
- **Documentation** - All 7 core documentation files updated
  - README.md: 11→15 prompts, updated compatibility tables
  - CLAUDE.md: Updated prompt listings and workflow examples
  - system-instructions.md: Updated CLI-ONLY lists, compatibility info
  - PREPARE_RELEASE.md: Updated for 15-prompt verification
  - Process/Prompts/QUICK_REFERENCE.md: Complete overhaul for dual workflows
  - Process/Prompts/README.md: Added new prompt descriptions
  - Process/AI-Assisted_Nonfiction_Authoring_Process.md: 1541 lines updated

### Technical
- **Development in 2 phases:**
  - Phase 1: Core Refactor (13-prompt structure) - Tagged v0.11.0-phase1
  - Phase 2: Content Enhancement (15-prompt structure) - Tagged v0.11.0-phase2
- **Total commits:** 25 (13 Phase 1 + 12 Phase 2)
- **Branch:** v_0.11.0 (merged to main for release)
- **Total modules:** 16 (added Modules 15-16)
- **All cross-references updated** across prompts and documentation

---

## [0.10.3] - 2025-11-20

### Fixed
- **CRITICAL:** `.nonfiction-migrations.json` was missing from v0.10.2 release package
  - Users upgrading from 0.10.1 to 0.10.2 had no migration rules available
  - Migration system could not function without this file
  - Fixed: `.github/workflows/release.yml` now explicitly copies migrations file to release
  - Added verification step to `PREPARE_RELEASE.md` to prevent recurrence

### Changed
- **Release workflow** (`.github/workflows/release.yml`)
  - Added explicit copy step for `.nonfiction-migrations.json`
  - Enhanced installation instructions with dual-path (Claude Code + Claude Desktop)
  - Added IMPORTANT note about system-instructions.md setup for Claude Desktop users
- **Release preparation** (`PREPARE_RELEASE.md`)
  - Added CRITICAL verification: migrations file must be in release zip
  - Enhanced Step 8 with dual-path installation verification checklist

### Technical
- All users should upgrade from 0.10.2 to 0.10.3 to get working migration system
- v0.10.2 migration (README.md → FW_README.md) will now work correctly

---

## [0.10.2] - 2025-11-20

### Added
- **Automated Migration System** for framework upgrades
  - `.nonfiction-migrations.json` with migration rules and change types
  - Multi-version migration support with sequential application (e.g., 0.10.0 → 0.11.1 applies all intermediate migrations)
  - Six change types: `rename`, `delete`, `gitignore_add`, `gitignore_remove`, `add_to_config`, `update_content`
  - Applied migrations tracked in `.nonfiction-manifest.json` to prevent re-execution
  - Step 4.5 in configure.md for automated migration execution
  - Interactive user prompts: apply/skip/abort with retry logic
  - Automatic generation of `MANUAL_MIGRATION_STEPS.md` for failed changes
  - First migration (0.10.0 → 0.10.1): README.md → FW_README.md, .gitignore updates

- **Date Confirmation Protocol** for accurate date usage
  - Session startup date verification in CLAUDE.md
  - User confirms date at start: "Today's date is YYYY-MM-DD. Is this correct?"
  - `CONFIRMED_DATE` passed to all spawned agents
  - Prevents incorrect dates in chapter creation and file generation
  - Updated Prompts 1, 2, 5, 7 with date reminder sections

- **Mandatory Anti-Hallucination Enforcement**
  - "FIRST ACTION - MANDATORY" requirement in Prompts 1, 2, 3, 4
  - Claude must use Read tool to read `Process/Anti-Hallucination_Guidelines.md` before ANY actions
  - Agent instructions to read guidelines before proceeding
  - Ensures ASK FIRST protocol is applied consistently

- **Prompt 9 (Git Operations) Enhancements**
  - Detailed answer examples for all 7 git operations
  - 8 full dialogue example interactions showing Q&A flow
  - Verbose mode preference with opt-out system: `prompt_9_verbose: true/false` in Project_Config.md
  - User can answer "never ask again" to disable detailed explanations
  - Comprehensive user guidance for commit messages, tags, branches, etc.

### Changed
- **Migration file tracking**
  - `.nonfiction-migrations.json` tracked in framework repository (not in .gitignore)
  - User projects exclude `.nonfiction-migrations.json` (added to gitignore_template)
- **Release preparation process**
  - PREPARE_RELEASE.md Step 4.5: Verify migration configuration
  - Prompt_99_Build_Release.md Step 2: Verify and include migrations in build
- **manifest_template.json**: Added `appliedMigrations: []` array
- **Project_Config.md template**: Added `prompt_9_verbose: true` setting (Prompt 1 creates it)

### Technical
- Migration system fully integrated into configure.md, PREPARE_RELEASE.md, and Prompt_99_Build_Release.md
- Version ordering logic for sequential migration application
- .gitignore properly configured: migrations tracked in framework, excluded from user projects
- Comprehensive documentation with single-version and multi-version migration examples

---

## [0.10.1] - 2025-11-19

### Added
- **Hierarchical Style System**: Three-level cascading style inheritance
  - Book-level style (global default in Style_Guide.md)
  - Chapter-level overrides (optional Chapter_XX_style.md files)
  - Section-level overrides (HTML comment markers in content)
  - Cascading inheritance: Book → Chapter → Section
- **NEW Prompt 11: Style Manager** (HYBRID compatibility)
  - Add/remove chapter-level style overrides
  - Scan and track section-level overrides
  - Validate override registry consistency
  - View style distribution across book
  - Analyze style transitions for smoothness
  - Change book-level style with impact analysis
- **Style Override Registry**: `Manuscript/Style/Style_Overrides.md`
  - Central tracking of all overrides (chapter and section)
  - Style distribution analysis with 30% threshold monitoring
  - Style transition map (chapter-to-chapter, section-to-section)
  - Documented transition strategies for smooth reader experience
  - Auto-maintained by Prompts 2, 3, 11
- **New Templates**:
  - `Process/Templates/Chapter_Style_Template.md` - Chapter-level override template
  - `Process/Templates/Style_Overrides_Template.md` - Central registry template
  - `Process/Testing/Hierarchical_Style_Testing_Checklist.md` - Manual testing guide

### Changed
- **Process/_COMMON/10_Style_Consistency_Protocol.md**: Updated for hierarchical system
  - Added style resolution algorithm (section → chapter → book)
  - Added transition detection (chapter-level and section-level)
  - Added severity assessment (Low/Medium/High)
  - Added override threshold warnings (30% guideline)
  - Added validation error messages for all failure modes
  - Expanded from ~300 lines to ~820 lines
- **Prompt 1 (Initialize)**: Now creates Style_Overrides.md during initialization
  - Always created (even if no overrides yet)
  - Documents hierarchical style system to users
  - Updated workflow steps (15 → 17 steps)
- **Prompt 2 (Add Chapter)**: Added chapter-level style override option
  - Question 7: "Does this chapter need a different style?"
  - Creates Chapter_XX_style.md if override selected
  - Updates Style_Overrides.md registry automatically
  - Impact report includes style override information
- **Prompt 3 (Modify File)**: Hierarchical style resolution for consistency checks
  - Step 8 now resolves active style using cascading algorithm
  - Checks section override markers first
  - Checks chapter override file second
  - Falls back to book-level style
  - Reports active style source and inheritance chain
  - Updated Style Consistency Check section with resolution examples
- **Prompt 6 (Consistency)**: Comprehensive hierarchical style analysis
  - Scans for all three levels of style configuration
  - Builds style distribution map
  - Detects chapter-to-chapter transitions
  - Detects section-level transitions within chapters
  - Assigns transition severity levels
  - Checks for documented transition strategies
  - Monitors 30% override threshold
  - Updated example report to show hierarchical analysis
- **Prompt 8 (Dashboard)**: Added style distribution section
  - Shows book-level style
  - Lists chapter override count and percentage
  - Lists section override count
  - Displays threshold status (below/at/above 30%)
  - Shows transition counts
  - Highlights undocumented transitions
  - Lists chapters with overrides and rationales

### Technical
- **Token Footprint Analysis**: Estimated hierarchical system adds ~6,000 tokens
  - Updated module: +650 tokens
  - New Prompt 11: +3,250 tokens
  - Prompt updates (1,2,3,6,8): +1,300 tokens
  - New templates: +780 tokens
  - Total framework (v0.10.1): ~71,000 tokens
  - Per-prompt range: 7,000-12,000 tokens (before user content)
- **Section Override Marker Syntax**: Simplified HTML comment format
  - Start: `<!-- STYLE_OVERRIDE: StyleName -->`
  - End: `<!-- END_STYLE_OVERRIDE -->`
  - Validation: No nesting, must be properly closed, style must exist
- **30% Threshold Guideline**: Warning when chapter overrides exceed 30%
  - Indicates book-level style may not be appropriate
  - Suggests re-evaluating book-level choice
  - Encourages consistent majority style usage

### Documentation
- **Comprehensive updates** across all documentation files:
  - CLAUDE.md: Added hierarchical style system overview
  - INSTALLATION.md: Added style override capabilities section
  - Process/AI-Assisted_Nonfiction_Authoring_Process.md: Detailed style hierarchy
  - Process/Prompts/README.md: Added Prompt 11 documentation
  - Process/Prompts/QUICK_REFERENCE.md: Added hierarchical style workflows
  - Proposal/HIERARCHICAL_STYLE_SYSTEM.md: Complete system design proposal

### Notes
- **No Backward Compatibility Required**: Framework still in testing phase
- **Testing Strategy**: Manual testing checklist with 8 test categories, 40+ test scenarios
- **Design Rationale**: Allows consistent book-level style with targeted overrides for special chapters (technical appendices, narrative case studies) and sections (code examples, interviews, anecdotes)

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
