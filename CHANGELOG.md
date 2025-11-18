# Changelog

All notable changes to the AI-Assisted Nonfiction Authoring Framework will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
