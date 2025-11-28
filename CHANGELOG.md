# Changelog

All notable changes to the AI-Assisted Nonfiction Authoring Framework will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [0.16.0] - 2025-11-28

### Added
- **Unified PROJECT_ROOT Architecture** - Complete re-architecture with single container (#109)
  - PROJECT_ROOT now contains FW_ROOT/, BOOKS_ROOT/, and .config/ as siblings
  - CONFIG_ROOT (.config/) is where Claude Code sessions start
  - Single .git repository at PROJECT_ROOT level
  - FW_ROOT/ gitignored (framework files excluded from user's git)

- **Bootstrap Scripts** - New configure.bat/sh at dist root (#115)
  - Users clone dist repo, run configure.bat/sh
  - Script launches Claude with configure.md
  - Auto-chains to start-authoring on `/exit`

- **New Templates for PROJECT_ROOT** (#110, #111)
  - `PROJECT_ROOT_gitignore_template` - Excludes FW_ROOT/
  - `CONFIG_ROOT_CLAUDE_template.md` - Claude instructions for .config/
  - `Archive_README_template.md` - README for BOOKS_ROOT/Archive/
  - `books-registry_template.json` - Multi-book registry
  - `fw-location_template.json` - FW_ROOT path configuration
  - `settings_template.json` - BOOKS_ROOT path and preferences
  - `.claude/` templates for CONFIG_ROOT (fw-init, switch-book, manage-book, book-writing-assistant)

- **New Slash Commands** (#112)
  - `/switch-book` - Switch between books in multi-book setup
  - `/manage-book` - Archive, restore, delete books

### Changed
- **Installation Method** - Now clone-based instead of zip download (#115, #116)
  - Users clone dist repo to Downloads
  - Run configure.bat/sh to set up PROJECT_ROOT
  - Framework cloned/copied into FW_ROOT/

- **Session Startup** (#113)
  - Claude starts in .config/ (CONFIG_ROOT)
  - /fw-init reads fw-location.json to find FW_ROOT
  - Automatic framework update checking from VERSION file

- **Documentation** - Updated for PROJECT_ROOT architecture (#116, #118)
  - README.md: New Quick Start with clone-based installation
  - Claude_Desktop_Setup.md: Single MCP entry for PROJECT_ROOT
  - Multi-Book_Setup_Guide.md: Updated architecture diagram and setup
  - deploy-dist.yml: New validation for v0.16.0 templates

### Technical
- Archived REARCH_PROPOSAL.md to Proposal/Implemented/
- Updated all version references to 0.16.0
- Added configure.bat/sh to deploy-dist.yml build

---

## [0.15.4] - 2025-11-28

### Removed
- **Legacy (single-book) mode** - Framework now exclusively supports multi-book architecture (#107)
  - Removed legacy mode from configure.md (Step 3)
  - Removed legacy mode detection from /fw-init
  - Updated all prompts to remove legacy mode sections
  - Scripts now require FW_ROOT parameter (no legacy fallback)
  - Added deprecation notice to migration guide

### Fixed
- **BOOKS_ROOT CLAUDE.md removal** - Removed incorrect CLAUDE.md copy to BOOKS_ROOT (#106)
  - configure.md no longer copies CLAUDE.md to BOOKS_ROOT
  - Removed BOOKS_ROOT_CLAUDE_template.md from templates
  - Updated deploy-dist.yml validation

### Technical
- Removed redundant release.yml workflow (releases created manually)
- Net reduction of ~546 lines across documentation and scripts

---

## [0.15.3] - 2025-11-28

### Fixed
- **CLAUDE.md not copied to FW_ROOT** - Fixed configure.md workflow (#105)
  - CLAUDE.md from FW_ROOT_CLAUDE_template.md was not being copied during BOOKS_ROOT setup
  - Start scripts now work correctly since they depend on FW_ROOT/CLAUDE.md existing

### Changed
- **Dist repo README** - Updated for v0.15.x architecture (#98)
  - Updated installation instructions for multi-book setup
  - Clarified FW_ROOT vs BOOKS_ROOT usage
  - Improved quick start guide

---

## [0.15.2] - 2025-11-27

### Added
- **FW_ROOT/.config/settings.json** - configure.md now creates settings file in FW_ROOT (#103)
  - Contains booksRoot path, version, and configured date
  - Enables /fw-init to discover BOOKS_ROOT when starting from FW_ROOT
- **Start scripts** - New scripts for launching Claude Code sessions (#104)
  - `start-authoring.bat/.sh` - Standard start with /fw-init reminder
  - `bp-start-authoring.bat/.sh` - Bypass permissions mode for trusted environments
  - Scripts cd to FW_ROOT and launch claude with `--append-system-prompt`
  - Templates in Process/Templates/, copied to FW_ROOT during configure

### Fixed
- **Windows path escape issue** - Changed `echo -e` to `printf` for path variables (#101)
  - Paths like `E:\Projects\nfauthor\anf` no longer corrupted by `\n` interpretation
- **Script banner versions** - Fixed banner display versions showing 0.15.0 instead of 0.15.1 (#100)
  - Updated init.sh, detect-tools.sh, generate-content.sh banners
- **PREPARE_RELEASE.md line numbers** - Updated CLAUDE.md line references after streamlining (#102)

### Changed
- **CLAUDE.md streamlined** - Reduced from ~648 to ~84 lines for dev repo
  - Removed user-facing documentation (moved to dist repo templates)
  - Added mandatory Anti-Hallucination Guidelines read at startup
  - Added GitHub workflow summary for maintainer visibility

### Technical
- Updated deploy-dist.yml validation for new start script templates
- Updated framework_files_manifest.json with start script templates

---

## [0.15.1] - 2025-11-27

### Fixed
- **CRITICAL: scripts/ directory missing from dist repo** (#99)
  - The scripts/ directory was incorrectly removed from v0.15.0 release
  - This broke Prompt 1 initialization which depends on init.sh, detect-tools.sh, generate-content.sh, and generate-usage-guide.sh
  - Fixed deploy-dist.yml to include scripts/ directory
  - Fixed INSTALLATION.md to show scripts/ in directory structure
  - Fixed CHANGELOG.md to remove erroneous "Removed scripts/" section
  - Fixed framework_files_manifest.json to include scripts/ section

### Technical
- **Release Type:** PATCH (critical bug fix)
- **Breaking Change:** No
- **Issue:** #99

---

## [0.15.0] - 2025-11-27

### Added
- **Multi-Book Architecture** - Complete re-architecture separating framework from book projects (#88)
  - FW_ROOT: Framework installation directory with VERSION file
  - BOOKS_ROOT: Separate directory for all user book projects
  - Support for managing multiple books from a single framework installation
- **VERSION file** - Semantic version tracking at framework root for update checking
- **New configuration files** in `.config/`:
  - `fw-location.json` - Points BOOKS_ROOT to FW_ROOT location
  - `books-registry.json` - Tracks all registered books with status
  - `settings.json` - User preferences and settings
- **New templates** in `Process/Templates/`:
  - `BOOKS_ROOT_CLAUDE_template.md` - CLAUDE.md for user book directories
  - `FW_ROOT_CLAUDE_template.md` - Minimal CLAUDE.md for framework root
  - `Archive_README_template.md` - For archived book subdirectories
  - `books-registry_template.json` - Registry template
  - `fw-location_template.json` - Framework location template
  - `settings_template.json` - Settings template
- **Migrations system** - `Process/migrations/` for version upgrades
  - `migrate-0.14.5-to-0.15.0.md` - Migration guide for existing users
- **Claude Desktop integration** - Enhanced support for Claude Desktop Projects
  - `Documentation/Claude_Desktop_Setup.md` - Complete MCP configuration guide
  - `Process/Templates/Claude_Desktop_System_Instructions.md` - Minimal system instructions
- **Update checking** - `/fw-init` now checks for framework updates via VERSION comparison
- **Prompt 17: Backup Export** - New prompt for backup and export operations

### Changed
- **configure.md** - Complete rewrite for v0.15.0 multi-book architecture
  - Mode detection: FW_ROOT vs BOOKS_ROOT vs Legacy
  - Update workflow for existing FW_ROOT installations
  - New book setup workflow from FW_ROOT
  - Reconfiguration workflow for BOOKS_ROOT
  - Legacy single-book mode preserved for backward compatibility
- **/fw-init command** - Updated for multi-book mode
  - Book selection when multiple books registered
  - Framework update notification
  - Mode detection (Multi-Book vs Legacy)
- **deploy-dist.yml** - Updated for v0.15.0 distribution
  - Creates VERSION file in dist
  - Uses FW_ROOT_CLAUDE_template.md for CLAUDE.md
  - Validates new required templates and scripts
- **release.yml** - Added VERSION file verification
- **INSTALLATION.md** - Updated directory structure (added VERSION, multi-book paths)

### Technical
- **Release Type:** MINOR (new features, backward compatible)
- **Breaking Change:** No - Legacy single-book mode fully supported
- **Migration Required:** Yes - Run `execute configure.md` after update
- **Parent Issue:** #88 (Re-Architecture Proposal)
- **Implementing Issues:** #90 (Phase 1), #95 (Phase 6), #96 (Phase 7), #97 (Phase 8)

---

## [0.14.5] - 2025-11-27

### Fixed
- **book-writing-assistant.md** - Fix YAML parsing error in agent frontmatter (#84)
  - Wrapped description in quotes and escaped inner quotes
  - Colons no longer interpreted as YAML mapping syntax

### Added
- **Version tracking** - Added framework version to `.claude/` files (#83)
  - `.claude/README.md` now includes version
  - `.claude/commands/fw-init.md` now includes version

### Technical
- **Release Type:** PATCH (bug fix, minor additions)
- **Breaking Change:** No

---

## [0.14.4] - 2025-11-27

### Fixed
- **deploy-dist.yml** - Exclude CONTRIBUTING.md from distribution repo (#82)
  - CONTRIBUTING.md is for framework contributors, not end users
- **deploy-dist.yml** - Use `shopt -s dotglob` for reliable dotfile copying (#81)
  - Ensures `.claude/` and other dotfiles are properly copied
- **configure.md** - Clarify push behavior and set origin as default remote (#80)
  - Users can now push to their own `origin` remote
  - Clear messaging about remote configuration

### Technical
- **Release Type:** PATCH (deployment fixes)
- **Breaking Change:** No

---

## [0.14.3] - 2025-11-26

### Added
- **MIT License** - Added LICENSE file at repository root (#35)
- **Framework Disclaimer** - Added `Process/DISCLAIMER.md` with comprehensive legal disclaimer (#35)
  - No warranty or guarantee of fitness
  - No liability for published works
  - No guarantee of AI accuracy
  - Users responsible for their own content
- **Contributor Agreement** - Added `CONTRIBUTING.md` with contributor guidelines (#35)
- **Disclaimer Acknowledgment** - New Step 3 in Prompt 1 (Initialize) (#35)
  - Users must type "I acknowledge the disclaimer" before project creation
  - Acknowledgment recorded in `.config/init.json`
  - Git commit serves as proof of acknowledgment
- **Disclaimer Versioning** - Separate version tracking for disclaimer (v1.0) (#35)
  - Re-acknowledgment required when disclaimer version changes
  - Migration system supports `disclaimer_reacknowledge` change type

### Changed
- **Prompt 1 workflow** - Now 9 steps (was 8) with disclaimer acknowledgment (#35)
- **CLAUDE.md** - Added Legal section with license and disclaimer info
- **FRAMEWORK_CORE.md** - Added Section 10: License & Disclaimer
- **README_AUTHORS_template.md** - Added Legal section with disclaimer link

### Technical
- **Release Type:** PATCH (legal/documentation additions)
- **Breaking Change:** No
- **New Files:** LICENSE, CONTRIBUTING.md, Process/DISCLAIMER.md
- **Disclaimer Version:** 1.0

---

## [0.14.2] - 2025-11-26

### Changed
- **gh-workflow command** - Enhanced GitHub workflow integration (#79)
  - Integrated `gh-pm` extension for project board status updates
  - Added "In Review" step between work completion and issue closing
  - Removed invalid `--add-project-status` flags
  - Updated proposal to combine `gh-sub-issue` and `gh-pm` into `gh-project-tools`

- **configure.md** - Added `/fw-init` reminder to completion messages (#76)
  - Users now see clear instructions to run `/fw-init` at start of future sessions
  - Helps prevent users from trying to execute prompts without framework loaded

- **deploy-dist.yml** - Changed to PR-based deployment workflow
  - More controlled deployment process for distribution repository

### Fixed
- **fw-init command** - Removed outdated token savings messaging (#77)
  - Cleaned up messaging that no longer applies to current architecture

- **dist repo remote** - Fixed remote configuration to disable push access (#75)
  - Users cannot accidentally push to upstream distribution repository

### Technical
- **Release Type:** PATCH (workflow improvements, bug fixes)
- **Breaking Change:** No
- **Files Updated:** gh-workflow.md, configure.md, deploy-dist.yml, fw-init.md

---

## [0.14.1] - 2025-11-26

### Fixed
- **deploy-dist.yml workflow** - Fixed gitignore for dist repo deployment
  - Dist repo now uses minimal gitignore (doesn't ignore framework files)
  - Removes maintainer-only commands (gh-workflow.md)
  - Creates proper README with version for dist repo

- **configure.md remote handling** (#75)
  - Detects when cloned from distribution repo
  - Automatically renames `origin` → `upstream`
  - Users get: `git pull upstream main` for framework updates
  - Users can add their own `origin` for book backup

---

## [0.14.0] - 2025-11-26

### Added
- **Distribution repository** - `author-nonfiction-dist` for simplified installation (#13)
  - Users can now `git clone` instead of downloading/extracting zip files
  - Easy updates via `git pull upstream main`
  - No more zip extraction errors
  - Version control built-in from the start

- **Automated deployment workflow** - `deploy-dist.yml` (#70)
  - Triggers on release publish
  - Pushes release files to distribution repo
  - Creates matching version tags
  - Runs alongside existing zip workflow during transition

- **Git clone as recommended installation** (#71)
  - Release notes now show clone as Option A (Recommended)
  - Zip download options remain available (Options B & C)
  - Benefits highlighted: easy updates, no extraction errors

- **PDF added to default export formats** (#65)
  - Prompt 9 now exports PDF by default alongside DOCX

### Fixed
- **DOCX export formatting** (#68)
  - Fixed issues with document formatting in Word exports

- **DOCX --toc field warning** (#67)
  - Removed --toc flag from DOCX export to avoid field code warnings

### Technical
- Added `gh sub-issue` extension documentation to gh-workflow command
- Various proposal documents for future features (#57, #13)

---

## [0.13.14] - 2025-11-26

### Added
- **Step 0: Verify Repository State** in PREPARE_RELEASE.md (#64)
  - Checks for uncommitted changes before starting release
  - Provides options: commit, stash, or abort if dirty
  - Optionally verifies remote sync status

### Fixed
- **Framework manifest sync** - Missing Image_Registry templates added (#63)
  - `Image_Registry_Master_template.md` now in manifest
  - `Image_Registry_Chapter_template.md` now in manifest
- **Framework manifest cleanup** - Removed 4 non-existent file entries
  - `14_Enforcement_Rules_Module.md` (never created)
  - `Prompt_13_Reference.md` (never created)
  - `Prompt_14_Reference.md` (never created)
  - `Prompt_15_Reference.md` (never created)

### Changed
- **PREPARE_RELEASE.md Step 4.6** - Now automated manifest sync (#63)
  - Scans filesystem for actual framework files
  - Compares against manifest entries
  - Adds files on disk but not in manifest
  - Removes manifest entries for deleted files
  - Prevents missing files in future releases

---

## [0.13.13] - 2025-11-25

### Added
- **reference.docx template** - Default Word styling template for DOCX exports (#44)
  - Generated from pandoc's default reference.docx
  - Copied to `Manuscript/Style/reference.docx` during initialization
  - Prompt 9 falls back to `Process/Templates/reference.docx` if project copy missing

- **Typst book template** - Professional PDF styling with `book-template.typ` (#45)
  - Page setup (US Letter, binding margins)
  - Typography (Linux Libertine, justified paragraphs)
  - Chapter/section heading styles with proper formatting
  - Header/footer with page numbers
  - Title page, copyright page, dedication page functions
  - Epigraph function for chapter quotes
  - Block quote and code block styling

- **Sequential versioning for drafts** - Auto-increment compile versions (#58)
  - New naming: `[Project-Name]-[format]-vNN.md` (e.g., `My-Book-publication-v03.md`)
  - Project name sanitized to URL-safe slug
  - Format types: basic, formatted, publication
  - Version auto-detected from existing files

- **Sequential versioning for exports** - Independent from draft versions (#58)
  - Export versions increment independently from compile versions
  - Flat directory structure: `Manuscript/Exports/My-Book-v01.epub`
  - All export formats share same version number

- **Export workflow integration** - Script output capture for automation (#60)
  - compile-manuscript.sh outputs parseable `OUTPUT_FILE: <path>` line
  - Prompt 9 captures filename via grep for use in export commands
  - Enables seamless draft→export workflow

- **Export tools installation section** - USAGE_GUIDE_template.md now includes pandoc/typst guidance

### Fixed
- **Table of Contents** - Now properly generated from chapter headings in compiled manuscript
- **gitignore template** - Added scripts/, .claude/commands/, CHANGELOG.md to excluded files
- **Release checklist** - Added AI-Assisted_Nonfiction_Authoring_Process.md to version verification

### Technical
- **Release Type:** MINOR (new features, workflow improvements)
- **Breaking Change:** No - existing projects work without modification
- **Files Updated:** compile-manuscript.sh (major rewrite), Prompt_7_Compile.md, Prompt_7_Reference.md, Prompt_9_Export.md, Prompt_9_Reference.md, init.sh, book-template.typ (new), reference.docx (new), USAGE_GUIDE_template.md, gitignore_template, PREPARE_RELEASE.md

---

## [0.13.12] - 2025-11-25

### Changed
- **PDF export simplified to Typst-only** - Removed LaTeX option from Prompt 9
  - Two-step process: pandoc→typ, then typst compile
  - Avoids `--pdf-engine=typst` font fallback errors
  - Cleaner, more reliable PDF generation

- **DOCX export improved** - Better page breaks and user guidance
  - Changed `---` to `\newpage` for proper page breaks in Word
  - Added note about "Update fields?" dialog (user can click No)

- **Style selection presentation** - Consistent two-step format in Prompt 1 Question 9
  - Step 1: Category selection (numbered 1-5)
  - Step 2: Style selection (numbered 1-N within category)
  - Fixed inconsistent formatting between Prompt_1_Initialize.md and Prompt_1_Reference.md

### Added
- **PREPARE_RELEASE.md git log instructions** - Added workflow for CHANGELOG generation
  - `git log --oneline <last-tag>..HEAD` to review commits
  - `git log --stat <last-tag>..HEAD` for detailed file changes
  - Helps identify all changes for release notes

- **/fw-init reminder after Prompt 1** - Session Cleanup now reminds users to run `/fw-init`
  - Critical for loading new project context after initialization
  - Prevents users from attempting to execute prompts without framework loaded

### Fixed
- **Compile script metadata leak** - Chapter metadata no longer appears in compiled output
  - Status, Word Count, Last Updated lines are now stripped
  - Clean manuscript compilation for export

- **Version string double-v bug** - Fixed `vv1.0.0` appearing in filenames
  - Added `VERSION="${VERSION#v}"` to strip leading "v" if present
  - Affects compile-manuscript.sh output filenames

- **detect-tools.sh silent skip** - No longer silently skips when manifest missing
  - Now returns cleanly, manifest created by configure.md Step 3

### Technical
- **Release Type:** PATCH (bug fixes, workflow improvements)
- **Breaking Change:** No
- **Files Updated:** Prompt_1_Initialize.md, Prompt_1_Reference.md, Prompt_9_Export.md, Prompt_9_Reference.md, compile-manuscript.sh, PREPARE_RELEASE.md, detect-tools.sh

---

## [0.13.11] - 2025-11-25

### Changed
- **Simplified copy blocks** - Removed ASCII box decorations from configure.md
  - Plain code blocks are sufficient and cleaner
  - Reduced file size by ~70 lines

- **Manifest creation flow** - configure.md now owns manifest creation
  - configure.md Step 2: No longer requires manifest (created in Step 3)
  - configure.md Step 3: Explicitly creates `.config/` directory before manifest
  - Prompt 1 Step 3: No longer creates manifest, adds prerequisite check
  - detect-tools.sh: Messages now say "run configure.md first"

### Fixed
- **Tool detection message** - No longer tells users to "run after Prompt 1"
  - Updated to "run configure.md first" since manifest is created there
  - Users never need to run detect-tools.sh manually

### Technical
- **Release Type:** PATCH (workflow improvement)
- **Breaking Change:** No
- **Files Updated:** configure.md, Prompt_1_Initialize.md, detect-tools.sh

---

## [0.13.10] - 2025-11-25

### Changed
- **configure.md dual-platform support** - Now works in both Claude Code CLI and Claude Desktop
  - Removed CLI-only restriction from v0.13.9
  - Added "Environment Support" section explaining both environments
  - All CLI commands have conditional paths: CLI executes directly, Desktop gets copy blocks
  - Copy blocks use visual box format for easy identification

- **Copy block pattern for Desktop users** - Every external tool operation provides copy blocks
  - Tool detection script (Step 0.5)
  - Git initialization (Step 5)
  - Remote repository setup (Step 6) for GitHub/GitLab
  - Export tool discovery (Step 7)
  - Git commit (Step 9) for new installs and updates
  - Error handling: uncommitted changes warning

- **No direct shell interaction** - Users never paste into bash/cmd/PowerShell
  - All commands route through Claude Code CLI
  - Removed "Open PowerShell and run" instructions
  - Copy blocks explicitly state "COPY THIS TO CLAUDE CODE CLI"

- **Standard package manager assumptions** - Tool installation uses platform defaults
  - Windows: winget for jq installation
  - macOS: brew for git/jq
  - Linux: apt for git/jq

### Technical
- **Release Type:** PATCH (dual-platform workflow improvement)
- **Breaking Change:** No
- **Files Updated:** configure.md, Implemented/Startup-Requirements.md
- **Implements:** Startup-Requirements.md (5 requirements)

---

## [0.13.9] - 2025-11-24

### Changed
- **configure.md requires Claude Code CLI** - Removed hybrid Desktop/CLI approach
  - configure.md now explicitly requires CLI mode (has multiple bash operations)
  - Desktop users are told to open Claude Code CLI at the start
  - Removed redundant "If in Claude Desktop" branching throughout
  - Cleaner, simpler document that works reliably in CLI

### Technical
- **Release Type:** PATCH (workflow simplification)
- **Breaking Change:** No
- **Files Updated:** configure.md

---

## [0.13.8] - 2025-11-24

### Changed
- **configure.md simplified for Desktop/CLI interaction** - Removed complex environment detection
  - Simple header: CLI runs commands directly, Desktop asks user to copy/paste to CLI
  - Step 0.5 now asks user to run detect-tools.sh in Claude Code CLI and share output
  - No more automatic environment detection that could fail
  - Works reliably in both Claude Code CLI and Claude Desktop

### Fixed
- **detect-tools.sh winget jq detection** - Script now finds jq installed via winget on Windows
  - winget installs to `%LOCALAPPDATA%\Microsoft\WinGet\Packages\jqlang.jq_*\jq.exe`
  - This path is not in Git Bash's PATH by default
  - Script now searches winget package directory for jq.exe
  - Converts Windows paths to Unix paths for Git Bash compatibility

### Technical
- **Release Type:** PATCH (Desktop/CLI workflow improvement)
- **Breaking Change:** No
- **Files Updated:** configure.md, scripts/detect-tools.sh

---

## [0.13.7] - 2025-11-24

### Added
- **Environment detection in configure.md** - Claude now detects whether it's in CLI or Desktop mode
  - Checks for "Claude Desktop Limitations" in system instructions → Desktop mode
  - Checks for Bash tool availability → CLI mode
  - Uses `[CLI]`, `[DESKTOP]`, `[BOTH]` tags throughout document for clear branching

### Changed
- **Step 0.5 restructured** - Separate paths for CLI and Desktop
  - `[CLI]` runs detect-tools.sh automatically
  - `[DESKTOP]` asks user to run version commands manually
  - Installation instructions shown only when tools are actually missing

### Technical
- **Release Type:** PATCH (improved environment detection)
- **Breaking Change:** No
- **Files Updated:** configure.md, CHANGELOG.md

---

## [0.13.6] - 2025-11-24

### Fixed
- **configure.md Step 0.5 imperative instruction** - Strengthened language to ensure detect-tools script runs automatically
  - Previous v0.13.5 fix still allowed Claude to skip to asking users
  - Now uses "ACTION: Run the detect-tools script NOW" with explicit "Do NOT ask the user" instruction

### Technical
- **Release Type:** PATCH (refinement of v0.13.5 fix)
- **Breaking Change:** No
- **Files Updated:** configure.md

---

## [0.13.5] - 2025-11-24

### Fixed
- **configure.md tool detection workflow** - Step 0.5 now runs detect-tools.sh script AUTOMATICALLY
  - Removed "If in Claude Code CLI" / "If in Claude Desktop" branching that caused wrong path selection
  - Changed to imperative "ACTION: Run the detect-tools script NOW" instruction
  - Added "IMPORTANT: Execute this command immediately. Do NOT ask the user if tools are installed"
  - Only shows installation instructions AFTER running script if tools are actually missing
  - Prevents unnecessary "Do you have both git and jq installed?" questions

- **detect-tools.sh jq detection** - Script now properly detects jq as a required tool
  - Added `detect_jq()` function with Windows compatibility (jq.exe)
  - Separates "Required tools" (git, jq) from "Optional tools" (pandoc, typst) in output
  - Shows red warning with installation instructions only for missing required tools
  - Updates manifest with jq availability status

### Technical
- **Release Type:** PATCH (bug fix for tool detection workflow)
- **Breaking Change:** No
- **Files Updated:** configure.md, scripts/detect-tools.sh

---

## [0.13.4] - 2025-11-24

### Fixed
- **configure.md CLI command clarity** - All bash command sections now explicitly direct users to Claude Code CLI
  - Step 6 (remote setup): Clear "If in Claude Code CLI" vs "If in Claude Desktop" branching
  - Step 7 (tool detection): Explicit instructions for both environments
  - Step 9 (git commit): Detailed user-facing instructions for Claude Desktop users
  - Error handling section (uncommitted changes): Simplified command display

- **Windows user experience improvements:**
  - detect-tools.sh now checks for `.exe` variants (pandoc.exe, typst.exe, jq.exe)
  - Added Windows path checks for Pandoc at `/c/Program Files/Pandoc/pandoc.exe`
  - Fixed carriage return (`\r`) in version output with `tr -d '\r'`
  - Windows-friendly tool installation instructions (no bash knowledge required)

### Technical
- **Release Type:** PATCH (UX improvements for Windows and Claude Desktop users)
- **Breaking Change:** No
- **Files Updated:** configure.md, detect-tools.sh

---

## [0.13.3] - 2025-11-24

### Added
- **Module 20: JSON Schema and Structure Standards** - Authoritative reference for all .config/ JSON files
  - Canonical schemas for init.json, project.json, metadata.json, manifest.json, migrations.json
  - Required vs optional field definitions
  - Field naming conventions (camelCase, exact names like `style` not `writingStyle`)
  - Validation rules (dates in YYYY-MM-DD, chapter arrays, style name matching)
  - Common error messages and fixes
  - Integration notes for scripts

### Fixed
- **init.json field name enforcement** - Scripts now strictly require `style` field (not `writingStyle`)
  - generate-content.sh validates exact field names per Module 20
  - Prompt_1_Reference.md references Module 20 for schema documentation

### Technical
- **Release Type:** PATCH (new module, stricter validation)
- **Breaking Change:** No (clarifies existing requirement)
- **New Module:** Process/_COMMON/20_JSON_Schema_Module.md
- **Files Updated:** generate-content.sh, Prompt_1_Reference.md, _COMMON/README.md, framework_files_manifest.json

---

## [0.13.2] - 2025-11-24

### Added
- **Date Confirmation in configure.md** - Step 0 now confirms today's date before any operations
  - Prevents incorrect dates in generated files when system date is wrong
  - User can confirm or provide correct date in YYYY-MM-DD format

- **jq Dependency Check** - Step 0.5 validates required tools before initialization
  - Checks for git (required) and jq (required for JSON processing)
  - Provides installation instructions for missing tools
  - Prevents cryptic errors during generate-content.sh execution

- **Date Confirmation in /fw-init** - Step 6 confirms date during session startup
  - Ensures CONFIRMED_DATE is set for all session operations
  - Added to initialization summary report

- **Target Completion Date Validation** - Prompt 1 now validates future dates
  - Date must be after CONFIRMED_DATE (today)
  - Prompts user to re-enter if date is in the past

### Fixed
- **configure.md User Decision Points** - All steps requiring user input now explicitly pause
  - Added `⏸️ STOP AND ASK USER` and `WAIT for user response` markers
  - Affected steps: 4.5 (migration retry), 4.7 (cleanup), 5 (git missing), 6 (remote setup), 7 (tool detection), 9 (commit)
  - Prevents steps from running together without waiting for user input

### Technical
- **Release Type:** PATCH (bug fixes and UX improvements)
- **Breaking Change:** No
- **Files Updated:** configure.md, fw-init.md, Prompt_1_Initialize.md, Prompt_1_Reference.md, all version-numbered files

---

## [0.13.1] - 2025-11-24

### Added
- **Token-Optimized Prompt Architecture** - Core + Reference file pattern for 65-75% token reduction
  - All 15 prompts optimized with consistent pattern
  - Core files contain essential workflow (~3,000-6,500 tokens)
  - Reference files contain detailed examples and troubleshooting (load on-demand)
  - Total framework token savings: ~150,000 tokens across all prompts

- **15 New Reference Files:**
  - `Prompt_1_Reference.md` - Q&A examples, config formats
  - `Prompt_2_Reference.md` - Chapter templates, renumbering logic
  - `Prompt_3_Reference.md` - _chg file structure, style resolution
  - `Prompt_5_Reference.md` - Change detection, version inference
  - `Prompt_6_Reference.md` - Integration examples, lock scenarios
  - `Prompt_7_Reference.md` - Compilation options, script details
  - `Prompt_8_Reference.md` - Analysis criteria, report examples
  - `Prompt_9_Reference.md` - Export commands, format options
  - `Prompt_10_Reference.md` - Dashboard examples, metrics calculations
  - `Prompt_11_Reference.md` - Style operations, transition analysis
  - `Prompt_12_Reference.md` - Git operation examples
  - `Prompt_13_Reference.md` - AI indicator details
  - `Prompt_14_Reference.md` - Citation examples
  - `Prompt_15_Reference.md` - Visual templates
  - `Prompt_16_Reference.md` - Image management details

- **Prompt_Essentials.md** - Shared essentials loaded once per session
  - Lock management protocol
  - Anti-hallucination rules
  - Git commit format templates
  - Style resolution algorithm
  - Date handling protocol
  - Semantic versioning guide
  - Change tracking format

### Changed
- **All 15 Prompts Optimized** - Reduced token footprint while maintaining functionality

  | Prompt | Old Size | New Size | Reduction |
  |--------|----------|----------|-----------|
  | Prompt 1 | ~500 lines | ~225 lines | 70% |
  | Prompt 2 | ~310 lines | ~200 lines | 65% |
  | Prompt 3 | ~520 lines | ~170 lines | 67% |
  | Prompt 5 | ~340 lines | ~155 lines | 65% |
  | Prompt 6 | ~400 lines | ~190 lines | 65% |
  | Prompt 7 | ~500 lines | ~130 lines | 75% |
  | Prompt 8 | ~477 lines | ~180 lines | 75% |
  | Prompt 9 | ~530 lines | ~160 lines | 70% |
  | Prompt 10 | ~378 lines | ~150 lines | 70% |
  | Prompt 11 | ~650 lines | ~200 lines | 70% |
  | Prompt 12 | ~530 lines | ~200 lines | 75% |
  | Prompt 13 | ~500 lines | ~205 lines | 75% |
  | Prompt 14 | ~600 lines | ~240 lines | 75% |
  | Prompt 15 | ~700 lines | ~256 lines | 75% |
  | Prompt 16 | ~850 lines | ~240 lines | 74% |

- **Session Cleanup Instructions** - All prompts now include:
  - Completion message with prompt name
  - Token reclamation instruction for users
  - Example: "Clear Prompt X from context"

### Technical
- Implemented from Proposal/OTHER_PROMPTS_OPTIMIZATION.md
- Three-phase implementation:
  - Phase 1: High-value prompts (3, 8, 13, 14, 15, 16)
  - Phase 2: Medium-value prompts (1, 6, 7, 9, 11)
  - Phase 3: Remaining prompts (2, 5, 10, 12)
- Backward compatible - no changes to workflow or functionality
- Reference files load on-demand, reducing typical session token usage by 60%+

---

## [0.13.0] - 2025-11-23

### Added
- **Modular Style Library (Phase 2)** - Complete integration of 19-style catalog system
  - Prompt 1: Category-based style selection with progressive disclosure (5 categories → 19 styles)
  - Prompt 11: Updated to use Style_Catalog.md for override management
  - Style_Guide.md now includes category metadata
  - 57% token reduction in style selection (280 lines vs 650 lines)
  - Category organization: Academic (4), Professional (2), Narrative (4), Personal (3), Cultural (6)

- **Concurrency Lock Management** - File-based locking for multi-instance safety
  - 10 prompts updated with lock management (Prompts 1, 2, 3, 4, 5, 6, 10, 14, 15, 16)
  - .locks/locks.json tracking with unique instance IDs
  - Resource-level locking (Chapter_XX, ProjectConfig, Image_Registry)
  - Conflict detection with retry/cancel/override options
  - Added .locks/ to gitignore_template

- **Documentation/ directory** - New maintainer documentation directory (NOT in user releases)
  - Documentation/README.md - Directory guide for maintainers
  - Documentation/Development/ - Future contributor guides
  - Documentation/Archive/ - Historical proposals
  - PREPARE_RELEASE.md stays at root (actively used)

### Changed
- **Phase 2: Documentation Consolidation** - Eliminated ~2,370 words of redundancy (~75% reduction)
  - AI-Assisted_Nonfiction_Authoring_Process.md: Reduced 16 prompt descriptions to 2-3 sentence summaries with reference to Prompts/README.md (~1,200 words saved)
  - Prompts/README.md: Replaced "Common Workflows" section with reference to QUICK_REFERENCE.md (~750 words saved)
  - QUICK_REFERENCE.md: Reduced hierarchical style system from 28 lines to 8 lines with reference to Styles/README.md (~120 words saved)
  - Prompts/README.md: Replaced detailed quote management with 15-line summary and reference (~150 words saved)
  - Updated "9 styles" → "19 styles (v2.0)" for accuracy
  - All unique content preserved, only redundancy removed

- **Phase 3: Documentation Migration** - Moved AI-Assisted Process to Documentation/
  - `Process/AI-Assisted_Nonfiction_Authoring_Process.md` → `Documentation/AI-Assisted_Nonfiction_Authoring_Process.md`
  - Updated all references across framework (CLAUDE.md, fw-init.md, system-instructions.md, FRAMEWORK_CORE.md, Prompts/README.md, QUICK_REFERENCE.md)
  - Documentation/ excluded from user release packages (maintainer-only content)
  - Users get FRAMEWORK_CORE.md (instant load) + on-demand docs from Process/

- **Phase 3.5: PREPARE_RELEASE.md Updates** - Comprehensive release preparation updates
  - Added FRAMEWORK_CORE.md to Critical Files list (#2)
  - Added .claude/commands/fw-init.md to Critical Files list (#8)
  - Removed AI-Assisted Process from Critical Files (moved to Documentation/)
  - PREPARE_RELEASE.md stays at root (noted explicitly)
  - Updated "Files That Should Contain Version Numbers" section with new organization
  - Added Step 4.7: Documentation/ Directory Exclusion note
  - Updated commit message template with new file list
  - Updated grep command examples to exclude Documentation/
  - Updated manifest example structure (v0.13.0, no Documentation/)

- **ENFORCEMENT_RULES.md** - Consolidated Module 14 (Enforcement Rules Module) into root-level document
  - Eliminated ~200 lines of duplication between files
  - Added Part 2 (Integration Guide) with all Module 14 templates and procedures
  - Added Part 3 (Testing & Compliance) with testing procedures and validation
  - Added Part 4 (Reference Tables) with enforcement matrix and file coverage
  - Single source of truth for enforcement rules and integration guidance
  - Updated all prompt references to point to consolidated location

- **Process/_COMMON/** - Module 14 deprecated
  - All Module 14 content merged into ENFORCEMENT_RULES.md
  - Process/_COMMON/README.md updated (13 active modules, Module 14 noted as deprecated)
  - Process/_COMMON/04_File_Operations_Library.md updated reference
  - Prompt 15 updated to reference ENFORCEMENT_RULES.md instead of Module 14

### Removed
- **Process/_COMMON/14_Enforcement_Rules_Module.md** - Content merged into ENFORCEMENT_RULES.md
  - All integration templates now in ENFORCEMENT_RULES.md Part 2
  - All testing procedures now in ENFORCEMENT_RULES.md Part 3
  - All reference tables now in ENFORCEMENT_RULES.md Part 4

### Technical
- Consolidation eliminates maintenance burden of keeping two files in sync
- ~200 lines of duplication removed
- Improved clarity with single authoritative source for enforcement rules
- Gap maintained at Module 14 position with deprecation note in _COMMON/README.md

---

## [0.12.10] - 2025-11-23

### Added
- **Session Initialization Command** - `/fw-init` for Claude Code CLI
  - Mandatory session startup command that loads all framework documentation
  - Loads ~20,000-30,000 tokens: system-instructions.md, Process/ files, style library
  - Activates Anti-Hallucination Protocol
  - Checks for PROJECT_CONTEXT.md
  - Provides verbose initialization report with version and available prompts
  - Solves initialization bypass problem (makes setup explicit and mandatory)
  - Added `.claude/commands/fw-init.md`
  - Updated CLAUDE.md: FIRST ACTION changed from reading files to running `/fw-init`
  - Note: Claude Desktop users continue using Session Startup Protocol in system-instructions.md

- **Lock Management Module** - Process/_COMMON/18_Lock_Management_Module.md
  - Resource-level locking for concurrent editing (Chapter_XX, StyleSystem, ImageRegistry, etc.)
  - Single JSON lock file (`.locks/locks.json`)
  - 15-minute stale lock timeout with override option
  - User choices: wait, cancel, or override stale locks
  - Clear all locks functionality for recovery
  - Works in both CLI and Desktop (Read/Write JSON)
  - Target: v0.13.0 for prompt integration (Prompts 1, 2, 3, 4, 5, 6, 11, 14, 15, 16)

- **Compilation Script** - Process/Scripts/compile-manuscript.sh
  - Efficient bash script for manuscript compilation
  - Handles both flat and subdirectory chapter structures
  - Reduces token usage and improves compilation speed
  - Added Process/Scripts/README.md documenting available scripts

### Changed
- **Prompt 7 (Compile)** - Now uses bash script for efficient compilation instead of manual assembly
- **CONCURRENCY.md** - Simplified to implementation checklist
  - Replaced complex branching/partitioning strategies with simple lock-based approach
  - References Lock Management Module as the solution
  - Lists all 10 prompts requiring lock implementation with checklists
  - Provides standard lock implementation pattern
  - Includes Prompt 10 dashboard integration for lock display
  - Status: Module complete, prompt updates pending (v0.13.0)

### Fixed
- **Prompt 14 (Citation Finder)** - Corrected self-references (was incorrectly labeled as Prompt 15)
- **Prompt 15 (Visual Content Suggester)** - Corrected self-references (was incorrectly labeled as Prompt 14)

### Proposed
- **Concurrent Editing Support** - Proposal/CONCURRENCY.md
  - Three solutions: Branch-based isolation, file-based partitioning, lock files
  - Recommended workflows for solo authors and co-authors
  - Conflict prevention and resolution strategies
  - Phased implementation plan (v0.13.0-v0.15.0)
  - Enhanced with image registry concurrency analysis

- **Image Registry Splitting** - Proposal/IMAGE_REGISTRY_SPLITTING.md
  - Automatic splitting at 300-image threshold for scalability
  - Chapter-based registry organization (Image_Registry_Chapter_XX.md)
  - Master index with overview and statistics
  - 89% token reduction for typical operations (5,000-12,500 vs 75,000+ tokens)
  - Backward compatible with single-registry mode
  - Scales to 1,000+ images comfortably
  - Impact analysis for Prompts 6, 8, 10, 15, 16
  - Target: v0.14.0

### Technical
- **Documentation updates** across multiple files for /fw-init integration:
  - .claude/README.md - Document fw-init command usage
  - INSTALLATION.md - Added mandatory fw-init step, updated directory structure
  - Process/Prompts/README.md - Added Session Initialization section
  - Process/Prompts/QUICK_REFERENCE.md - Added fw-init to all workflows
  - PREPARE_RELEASE.md - Added fw-init.md to verification checklist
- **Framework files manifest** - Updated with fw-init.md and new scripts
- **Scripts directory** - New Process/Scripts/ with documentation

---

## [0.12.9] - 2025-11-22

### Added
- **Modular Style Library (v2.0.0)** - Complete refactoring from monolithic to category-based organization
  - **Process/Styles/** directory with 5 category subdirectories
  - **19 writing styles** (up from 9) across categories: Academic (4), Professional (2), Narrative (4), Personal (3), Cultural (6)
  - **Style_Catalog.md** - Master index for browsing all styles (280 lines vs old 650 lines = 57% token reduction)
  - **README.md** - Comprehensive usage guide for the style library

- **10 New Writing Styles:**
  1. Historical Chronicler (Narrative) - Narrative history with scholarly rigor
  2. Philosophical Contemplative (Personal) - Ethics and existential inquiry
  3. Cultural Critic (Cultural) - Sharp social commentary and essays
  4. Satirical Humorist (Cultural) - Witty, ironic comedic truth-telling
  5. Activist Advocate (Cultural) - Social justice advocacy
  6. Lyrical Nature Writer (Cultural) - Poetic nature writing with ecological awareness
  7. Spiritual/Religious Writer (Cultural) - Faith exploration and contemplative writing
  8. Sports Writer (Cultural) - Athletic narratives and sports culture
  9. Confessional Memoir (Narrative) - Raw, unflinching personal honesty
  10. Medical/Health Narrative (Academic) - Clinical knowledge + patient experience

- **Individual Style Files** - Each style in separate ~100-line file with consistent template
  - Voice Characteristics, Tone, Pacing, Structure
  - Example passage (200-300 words)
  - DO/DON'T guidelines
  - Category and version metadata

- **Proposal Documentation**
  - Proposal/Implemented/STYLE_REFACTOR.md - Phase 1 complete proposal (structure and styles)
  - Proposal/STYLE_REFACTOR_PH2.md - Phase 2 proposal (prompt integration, complexity levels, future features)

### Changed
- **README.md** - Updated from "9 curated styles" to "19 curated styles across 5 categories"
- **Style organization** - Category-based browsing (Academic, Professional, Narrative, Personal, Cultural) vs alphabetical
- **Token efficiency** - Progressive disclosure: Catalog + selected style (280 lines) vs all styles (650 lines)

### Removed
- **Process/Style_Examples.md** - Replaced by modular Process/Styles/ directory structure

### Technical
- **Breaking change** - File paths changed from `Process/Style_Examples.md` to `Process/Styles/[Category]/[Style].md`
- **Git history preserved** - Individual style files easier to maintain and version
- **Scalability improved** - Can add 10+ more styles without structural changes
- **Phase 2 pending** - Prompt updates (1, 8, 11), documentation updates, complexity levels implementation

---

## [0.12.8] - 2025-11-21

### Added
- **Process/_COMMON/17_README_Management_Module.md** - Centralized module for managing root README.md
  - Defines complete structure (Title, Author, About, Project Info, Dashboard, Reports)
  - Report filename formats and link text rules
  - On-demand directory creation (Reports/ and Dashboard/)
  - Footer warnings (user-facing + AI directive)
  - Complete specification for automatic README.md generation

- **Manuscript/Reports/** directory organization
  - AI Detection reports: `ai-detection-chapter-XX-YYYY-MM-DD.md` or `ai-detection-YYYY-MM-DD.md`
  - Consistency reports: `consistency-chapter-XX-YYYY-MM-DD.md` or `consistency-YYYY-MM-DD.md`
  - Tables in README.md show 5 most recent reports, newest first
  - Descriptive link text: "[Chapter X Analysis]" or "[Full Book]"

- **Manuscript/Dashboard/** directory organization
  - Single Dashboard.md file (always overwrites)
  - Git safety: Prompt 10 asks to commit before overwriting existing dashboard
  - Dashboard link in README.md after first dashboard creation

- **Root README.md auto-generation**
  - Prompt 1 generates initial README.md with all metadata
  - About This Book from Q&A answers (purpose, targetAudience)
  - Project Information from metadata.json (excludes targetAudience, description, keywords; omits empty fields)
  - Auto-updated by Prompts 8, 10, 13 when creating reports/dashboard

### Changed
- **Prompt_1_Initialize.md** - Updated to v0.12.8
  - Added Step 4h: Generate README.md
  - Uses README Management Module for structure
  - Includes About This Book and Project Information sections
  - No Dashboard/Reports sections initially (added later by other prompts)

- **Prompt_8_Consistency.md** - Enhanced with report management
  - Added "Save Report and Update README.md" section
  - Creates Manuscript/Reports/ directory on demand
  - Saves consistency reports with dated filenames
  - Automatically regenerates README.md with updated Consistency table

- **Prompt_10_Dashboard.md** - Enhanced with dashboard management
  - Added "Save Dashboard and Update README.md" section
  - Creates Manuscript/Dashboard/ directory on demand
  - Asks user to commit before overwriting existing Dashboard.md
  - Automatically regenerates README.md with dashboard link

- **Prompt_13_AI_Detection_Analysis.md** - Enhanced with report management
  - Added "Save Report and Update README.md" section
  - Creates Manuscript/Reports/ directory on demand
  - Saves AI detection reports with dated filenames
  - Automatically regenerates README.md with updated AI Detection table

- **Process/Templates/framework_files_manifest.json** - Updated to v0.12.8
  - Added 17_README_Management_Module.md to Process/_COMMON list

### Fixed
- **CRITICAL: Direct editing loophole closed**
  - ENFORCEMENT_RULES.md updated with explicit prohibition on ALL direct editing
  - Added section: "CRITICAL: No Direct Editing Exception"
  - Explicitly prohibits direct editing for initial drafts and first content creation
  - Added routing table entries for "Draft chapter" and "Write chapter" requests
  - Closed debugging loophole (no direct editing even for testing)
  - Added Example 4 showing correct workflow for drafting chapters

- **system-instructions.md** - Added critical enforcement rules
  - New section: "⚠️ CRITICAL ENFORCEMENT RULES ⚠️"
  - Absolute prohibition on direct editing of Manuscript/ files
  - Template response for routing chapter work to Prompt 3 or 4
  - No exception for "initial content creation (0 → first draft)"

- **ENFORCEMENT_RULES.md** - Updated to v0.12.8
  - Removed loophole allowing direct editing for "initial drafts"
  - Updated routing table with "Draft chapter" and "Write chapter" examples
  - Updated Special Case 2 (debugging) to prevent direct editing workaround
  - Updated version history to reflect loophole closure

### Technical
- **Release Type:** MINOR (new features: README Management, Reports/Dashboard organization, stricter enforcement)
- **Breaking Change:** No (enhancement to existing workflows)
- **New Modules:** 1 (17_README_Management_Module.md)
- **Updated Prompts:** 4 (Prompts 1, 8, 10, 13)
- **Framework Files:** 11 modified (README.md, CLAUDE.md, system-instructions.md, ENFORCEMENT_RULES.md, 4 prompts, manifest, CHANGELOG, INSTALLATION)

**Why MINOR not PATCH:**
- New feature: README Management Module with automatic generation
- New feature: Structured Reports/ and Dashboard/ directories
- Enhanced feature: Stricter enforcement rules (prevents workflow violations)
- Multiple prompts enhanced with auto-update behavior

---

## [0.12.7] - 2025-11-21

### Fixed
- **configure.md Step 7** - Now instructs users to open Claude Code CLI
  - Previously asked users to run bash commands directly in terminal
  - Now tells users: "Open Claude Code CLI" and say "Run: bash scripts/detect-tools.sh"
  - Aligns with hybrid workflow (Claude Desktop can't reliably execute bash)
  - Consistent with other steps that require command execution

### Technical
- **Release Type:** PATCH (workflow instruction fix)
- **Breaking Change:** No
- **Issue:** configure.md Step 7 had incorrect instructions for Claude Desktop users

---

## [0.12.6] - 2025-11-21

### Added
- **scripts/generate-usage-guide.sh** - Bash script for USAGE_GUIDE.md generation
  - Takes 5 parameters (title, author, date, chapter count, style)
  - Replaces 6 separate sed commands with single script call
  - Handles special character escaping (/, &, \) safely
  - Validates parameters and template existence
  - Documented in scripts/README.md

- **Process/Templates/USAGE_GUIDE_template.md** - Template for user project quick start guide
  - Static content with {{PLACEHOLDER}} markers
  - Populated by generate-usage-guide.sh during Prompt 1
  - 5 placeholders: BOOK_TITLE, AUTHOR_NAME, INIT_DATE, CHAPTER_COUNT, STYLE_NAME

### Changed
- **Prompt_1_Initialize.md** - Optimization and realism improvements
  - Removed all time estimates (misleading "~5-10 seconds" claims)
  - Updated to use generate-usage-guide.sh script
  - Changed "10x faster" to "Faster initialization" (no specific timing)
  - Removed "Time elapsed" from completion report
  - Removed execution time comparison from footer

### Technical
- **Release Type:** PATCH (performance optimization + accurate expectations)
- **Breaking Change:** No
- **Performance:** Template-based USAGE_GUIDE.md generation (faster than AI)
- **User Experience:** Removed misleading time estimates for realistic expectations

---

## [0.12.5] - 2025-11-21

### Fixed
- **CRITICAL: Missing scripts/ directory in release packages**
  - **GitHub Actions workflow**: Added `cp -r scripts build/temp/` to release.yml
  - The scripts/ directory was missing from v0.12.3 and v0.12.4 release zip files
  - This caused configure.md Step 7 and Prompt 1 to fail (couldn't find detect-tools.sh)
  - Directory contains: init.sh, detect-tools.sh, README.md
  - Without scripts/, users could not use automated tool detection

### Changed
- **configure.md Step 7** - Added clarification note about git detection
  - Explains git was already verified in Step 2
  - Clarifies that detect-tools.sh re-confirms git and focuses on pandoc/typst
  - Script detects export tools needed for Prompt 9

### Technical
- **Release Type:** PATCH (critical bug fix - missing directory in release package)
- **Breaking Change:** No
- **Issue:** GitHub Actions workflow didn't copy scripts/ directory to release zip
- **Impact:** v0.12.3 and v0.12.4 releases were incomplete and non-functional for new installations

---

## [0.12.4] - 2025-11-21

### Fixed
- **Manifest consolidation** - Completed v0.12.1 migration to `.config/` directory
  - **configure.md**: All references now use `.config/manifest.json` (8 locations updated)
  - **gitignore_template**: Added legacy files section for `.nonfiction-manifest.json` and `.nonfiction-migrations.json`
  - **INSTALLATION.md**: Updated file structure diagram (removed root manifest, added scripts/)
  - **.claude/README.md**: Updated manifest reference to `.config/manifest.json`
  - **README_AUTHORS_template.md**: Updated structure (16 prompts, .config/ directory, framework files distinction)
  - Migration support: configure.md now automatically migrates from legacy locations
  - Legacy files properly marked and can be gitignored after migration

### Technical
- **Release Type:** PATCH (bug fix - incomplete migration from v0.12.1)
- **Breaking Change:** No (backward compatible with automatic migration)
- **Issue:** v0.12.1 planned manifest consolidation but configure.md still referenced old location

---

## [0.12.3] - 2025-11-21

### Changed
- **configure.md** - Now uses `detect-tools.sh` script for automatic tool detection
  - Replaced manual Q&A with automated bash script execution
  - Runs `bash scripts/detect-tools.sh .config/manifest.json`
  - Automatic detection of git, pandoc, and typst with version numbers
  - Color-coded output with installation instructions
  - Updates `.config/manifest.json` with tool availability
  - Consistent detection logic between Prompt 1 and configure.md

### Technical
- **Release Type:** PATCH (configuration workflow improvement)
- **Breaking Change:** No (internal workflow change only)

---

## [0.12.2] - 2025-11-21

### Changed
- **Prompt 1 (Initialize)** - Reverted to v0.12.0 question structure and ordering
  - Questions restored: working title, author, word count, audience, purpose, completion date, TOC file, chapters, style
  - User preference: More comprehensive metadata collection during initialization
  - Updated `init.json` and `metadata.json` templates to support additional fields
- **Initialization Flow** - Optimized .config creation process
  - Claude now creates ALL 5 JSON files in Step 2b (init, project, metadata, manifest, migrations)
  - Bash script no longer copies empty .config templates
  - Eliminated redundant file operations (copy empty → immediately overwrite)
  - Cleaner separation: Claude handles configuration, bash handles structure

### Technical
- **Release Type:** PATCH (workflow optimization, user preference)
- **Performance:** Same ~5-10 second initialization time maintained
- **Breaking Change:** No (internal workflow change only)

---

## [0.12.1] - 2025-11-21

### Added
- **Fast Initialization System** - 10x faster project setup (~5-10 seconds vs ~30-60 seconds)
  - Bash script `scripts/init.sh` for automated structure creation
  - Validates preconditions, creates directories, copies templates
  - Verbose progress output with color-coded status
  - Smart merge on re-initialization (preserves user content)
- **Centralized Configuration** - All JSON configs in `.config/` directory
  - `init.json` - Initialization metadata from Q&A
  - `project.json` - Project settings (replaces Project_Config.md)
  - `metadata.json` - Book metadata (replaces Project_Metadata.md)
  - `manifest.json` - Framework tracking (replaces .nonfiction-manifest.json)
  - `migrations.json` - Version migrations (moved from root)
- **Hybrid Workflow** - Desktop Q&A → CLI execution
  - Interactive questions in Claude Desktop create config
  - Fast execution in Claude Code CLI with bash script
  - Environment detection (checks for existing config)

### Changed
- **Prompt 1 (Initialize)** - Complete rewrite for hybrid workflow
  - 5 core questions + 5 optional metadata questions
  - Writes `.config/init.json` with user answers
  - Desktop: Creates config and instructs user to switch to CLI
  - CLI: Reads config, runs bash script, completes AI tasks
  - 10x performance improvement
- **All Prompts** - Updated to read `.config/*.json` instead of .md files
  - Prompt 2, 7, 9, 12, 99 reference new config structure
  - README.md and QUICK_REFERENCE.md updated
- **Directory Structure** - New `scripts/` directory for automation

### Removed
- **Removed from user projects** (breaking change for v0.13.0):
  - `Project_Config.md` → `.config/project.json`
  - `Project_Metadata.md` → `.config/metadata.json`
  - `.nonfiction-manifest.json` → `.config/manifest.json`
  - `.nonfiction-migrations.json` → `.config/migrations.json`

### Technical
- **Release Type:** PATCH (performance improvement, internal refactor)
- **Breaking Change:** Yes (config file migration)
- **No Migration Needed:** Not yet in production use
- **Execution Time:** ~5-10 seconds (v0.12.1) vs ~30-60 seconds (v0.12.0)
- **Files Added:** 8 files (scripts/, .config templates)
- **Files Updated:** 14 prompts and documentation files

---

## [0.12.0] - 2025-11-21

### Added
- **Unified Visual Asset System** - Centralized image management in single `Manuscript/images/` directory
  - Replaces per-chapter `Chapter_XX/figures/` subdirectories with flat structure
  - Single `Image_Registry.md` tracks all visual assets across entire book
  - Registry-based coordination between Prompt 15 and Prompt 16
  - Two-level status tracking: 📝 Text-based vs 🖼️ Professional images
  - Simplified Pandoc export: `--resource-path=Manuscript` eliminates path rewriting
  - Typora-friendly relative paths: `../images/` works in markdown editors
- **Prompt 16: Image Manager** - Professional image management with four operating modes
  - Mode 1: Add new professional image to chapter
  - Mode 2: Upgrade text-based visual (📝 → 🖼️)
  - Mode 3: Scan and register existing images
  - Mode 4: Validate all image references
  - Semi-automated workflow: Claude handles file operations, user controls placement
  - Registry-based figure numbering ensures sequential consistency
- **EPUB Templates** - Professional EPUB export support
  - `epub-style.css` - Default EPUB stylesheet with professional typography
  - `Copyright_template.md` - Standard copyright page template
  - `About_Author_template.md` - Author bio template
  - Enhanced Pandoc EPUB command with publisher/rights metadata
- **Module 15: Visual Asset Management Protocol** - Complete rewrite for unified system
  - 700-line comprehensive protocol governing both Prompt 15 and 16
  - Naming convention: `fig-XX-YY-description.ext` with hyphens
  - Registry format with upgrade priority tracking
  - Coordination protocol prevents duplicate figure numbering
  - Integration guide for all prompts

### Changed
- **Prompt Renumbering** - Swapped visual content prompts for better logical flow
  - Prompt 14: Citation Finder (was Prompt 15)
  - Prompt 15: Visual Content Suggester (was Prompt 14)
  - Prompt 16: Image Manager (NEW)
  - All prompt cross-references updated across 16+ files
- **Prompt 1 (Initialize)** - Updated for unified visual system
  - Creates `Manuscript/images/` directory instead of per-chapter `figures/`
  - Copies new templates: Image_Registry, Copyright, About_Author, epub-style.css
  - No per-chapter figures directories in new chapters
- **Prompt 2 (Add Chapter)** - Removed per-chapter figures directory creation
  - New chapters only contain markdown files
  - All images managed centrally via Prompt 15/16
- **Prompt 7 (Compile)** - Updated for unified image paths
  - Handles images from `Manuscript/images/`
  - Preserves relative `../images/` paths for compatibility
  - Includes Copyright and About_Author in compilation
- **Prompt 8 (Consistency)** - Registry-based visual validation
  - Reads unified `Image_Registry.md` instead of scanning per-chapter directories
  - Cross-references registry entries with chapter files
  - Registry health check (accuracy, orphaned files, missing metadata)
  - Validates image references (paths, alt text, captions)
- **Prompt 9 (Export)** - Enhanced EPUB generation with unified images
  - Pandoc: `--resource-path=Manuscript` (no complex path rewriting)
  - Simplified asset copying: `cp Manuscript/images/*`
  - Added publisher and rights metadata to EPUB
  - Cover image: `Manuscript/images/cover.jpg`
  - CSS: `Manuscript/Style/epub-style.css`
  - Updated pre-export checklist with Prompt 16 Mode 4 validation
- **Prompt 15 (Visual Content Suggester)** - Updated for unified directory
  - Creates text-based visuals in `Manuscript/images/` (not per-chapter)
  - Uses hyphenated naming: `fig-XX-YY-description.md`
  - References unified `Image_Registry.md`
  - Standard markdown image syntax with required alt text
  - Integration with Prompt 16 for upgrades

### Documentation
- **README.md** - Updated for v0.12.0 with 16 prompts
  - Added Visual Content Management feature
  - Updated directory structure (Manuscript/images/)
  - Swapped Prompt 14/15 descriptions, added Prompt 16
- **QUICK_REFERENCE.md** - Complete prompt workflow updates
  - New "Visual Content" section for Prompts 15 & 16
  - Updated milestone workflows with image validation steps
  - Updated CLI-ONLY list and prompt selection tree
- **Process/Prompts/README.md** - Comprehensive prompt guide updates
  - Swapped Prompt 14/15 detailed descriptions
  - Added Prompt 16 with four mode descriptions
  - Updated milestone and publication workflows
  - Added image management tips and integration notes
- **CLAUDE.md** - Session context document updates
  - Version 0.11.1 → 0.12.0
  - 15 → 16 Core Prompts
  - Updated prompt list and CLI-ONLY references
  - Added visual system notes
- **system-instructions.md** - Critical framework instructions
  - Updated CLI-ONLY list (added Prompt 16)
  - Updated prompt execution guidance
  - Swapped Prompt 14/15 descriptions
- **configure.md** - Configuration script updates
  - Version 0.11.1 → 0.12.0
  - Added migration_0.11.1_to_0.12.0 (documentation-only)
  - Updated example scenarios (15 → 16 prompts)

### Technical
- **Release Type:** MINOR (new features: Prompt 16, unified visual system)
- **Total Commits:** 20 implementation commits across 13 phases
- **Files Created:** 5 new files (4 templates + Prompt 16)
- **Files Updated:** 30+ prompt and documentation files
- **Breaking Change:** No - existing per-chapter figures/ directories still work
- **Migration:** Documentation-only (no structural changes to existing projects)

---

## [0.11.1] - 2025-11-20

### Fixed
- **Prompt 8 Compatibility Classification** - Corrected from DESKTOP-READY to CLI-ONLY
  - Consistency checking performs bulk file operations (30-50+ files)
  - Scans all chapters, figures/, bibliography files, and style configurations
  - MCP Filesystem in Claude Desktop is inefficient for bulk reads
  - Updated 5 files: Prompt_8_Consistency.md, system-instructions.md, CLAUDE.md, PREPARE_RELEASE.md, QUICK_REFERENCE.md
- **Framework README.md in Release Package** - Excluded GitHub repository README.md from release zip
  - Framework README.md is GitHub-only documentation (repo overview, download links)
  - Should not be included in release package (users don't need repo documentation)
  - Updated .github/workflows/release.yml to exclude README.md from copy step
- **User .gitignore Template** - Removed README.md from ignored files
  - User's README.md in their book project SHOULD be tracked by git
  - Dashboard (Prompt 10) writes project status to README.md
  - Updated Process/Templates/gitignore_template with clarifying comment
- **Dashboard Appendix Reporting** - Added explicit appendix tracking to Prompt 10
  - Dashboard now scans and reports on all appendices in BackMatter/
  - Added "Appendices complete: [N] / [total]" to summary statistics
  - Added Appendix Status Table (matching chapter table format)
  - Appendix word counts and completion percentages now tracked
  - Updated Process/Prompts/Prompt_10_Dashboard.md

### Technical
- **Release Type:** PATCH (bug fixes only, no new features)
- **Total Commits:** 4 bug fix commits
- **Files Updated:** 8 documentation files

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
