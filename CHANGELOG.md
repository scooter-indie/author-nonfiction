# Changelog

All notable changes to the AI-Assisted Nonfiction Authoring Framework will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [3.5.0] - 2025-11-18

### Added
- **New Installation Method**: Simplified single-method installation via manual download and unzip
- **configure.md**: New configuration script for setup automation
  - Automatic git repository initialization
  - Optional remote repository connection (GitHub/GitLab)
  - Support for both web UI and CLI (gh/gitlab) setup methods
  - Verification of framework files
  - Date confirmation workflow integration
- **INSTALLATION.md**: Comprehensive installation guide with safety warnings
- **CHANGELOG.md**: Version history tracking
- **Improved .gitignore**: Framework files now excluded from user git tracking
  - Only user content and configuration files tracked
  - Framework files (Process/, system-instructions.md, etc.) ignored

### Changed
- **Installation Process**: Now requires only download + unzip + configure
- **Git Tracking Strategy**: Framework files ignored, only user content tracked
- **Update Process**: Manual unzip with overwrite, then configure.md verification
- **Configuration Workflow**: Git setup and remote connection now handled by configure.md

### Removed
- **installer.md**: Replaced by simpler configure.md approach
- **remote-install.md**: Remote installation method discontinued
- **configuration.md**: Functionality merged into new configure.md

### Fixed
- Working directory detection issues (configure.md now uses pwd verification)
- Git tracking confusion between framework and user content

---

## [3.4.0] - 2025-11-17

### Added
- **Writing Style System**: 9 professionally curated writing styles
  - Academic Authority
  - Conversational Expert
  - Narrative Storyteller
  - Business Professional
  - Technical Precision
  - Investigative Journalist
  - Practical Guide
  - Inspirational Teacher
  - Scientific Communicator
- **Style Integration**:
  - Prompt 1 (Initialize): Interactive style selection during setup
  - Prompt 3 (Modify File): Automatic style consistency checking
  - Prompt 6 (Consistency): Chapter-by-chapter style alignment
  - Book-writing-assistant agent: Style-aware writing sessions
- **Style Extensibility**:
  - Framework-level style library (Process/Style_Examples.md)
  - Project-level configuration (Style/Style_Guide.md)
  - Custom style creation (Style/Custom_Styles.md)
- **Style Documentation**:
  - Complete voice, tone, pacing, and structure guidelines
  - DO/DON'T examples for each style
  - Sample passages (150-200 words) demonstrating each style

### Changed
- Enhanced QUICK_REFERENCE with style system workflows
- Improved documentation structure

### Fixed
- Simplified deployment with GitHub Releases

---

## [3.3.0] - 2025-11-10

### Added
- **Quote Management System**:
  - Centralized quote tracking in Quotes/Chapter_Quotes.md
  - Web search integration for quote verification
  - Status codes (⏳ Pending, ⚠ Needs Citation, ✓ Verified)
  - Automatic epigraph insertion during compilation
- **Automatic Change Tracking Synchronization** (Prompt 10):
  - Git diff analysis to detect manual edits
  - Automatic _chg file updates
  - Version history preservation

### Changed
- Anti-Hallucination Guidelines enhanced for quote verification
- Prompt 3 (Modify File) now includes quote management
- Prompt 5 (Compile) auto-inserts verified quotes as epigraphs

---

## [3.2.0] - 2025-11-03

### Added
- **Prompt 9: Git Operations**:
  - Commit, tag, branch, merge operations
  - View history and diffs
  - Push/pull to remote repositories
  - Status checks
- **Prompt 8: Progress Dashboard**:
  - Comprehensive project metrics
  - Word count tracking
  - Completion percentages
  - Recommendations for next actions

### Changed
- Improved git integration across all prompts
- Enhanced error handling for git operations

---

## [3.1.0] - 2025-10-27

### Added
- **Export System** (Prompt 7):
  - DOCX export via Pandoc
  - PDF export via LaTeX
  - EPUB export for e-readers
  - LaTeX export for advanced formatting
- **Consistency Checker** (Prompt 6):
  - Cross-chapter terminology tracking
  - Character/entity consistency
  - Timeline verification
  - Style drift detection

### Changed
- Enhanced Prompt 5 (Compile) with export preparation
- Improved validation reporting

---

## [3.0.0] - 2025-10-20

### Added
- **Complete Framework Release**:
  - 10 Execute Prompts for full authoring workflow
  - Git version control integration
  - Change tracking system with version history
  - Anti-Hallucination Guidelines
  - Modular file structure (chapters, front/back matter)
  - Inbox integration for content processing
  - Templates for all document types

### Changed
- Major restructure from prototype to production framework
- Comprehensive documentation in Process/ directory

---

## [2.x.x] - 2025-09-15 to 2025-10-19

### Development Versions
- Prototype iterations
- Testing of core concepts
- Workflow refinement

---

## [1.0.0] - 2025-09-01

### Added
- Initial concept and proof of concept
- Basic prompt structure
- Git integration experiments

---

**For detailed technical changes, see**: `Process/AI-Assisted_Nonfiction_Authoring_Process_chg.md`

**Project Repository**: https://github.com/scooter-indie/author-nonfiction
**Report Issues**: https://github.com/scooter-indie/author-nonfiction/issues
