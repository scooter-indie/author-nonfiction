# .config Directory

**Framework Version:** 0.12.1+

This directory contains all JSON configuration files for your book project.

---

## Files

### init.json
Initialization data from Prompt 1 Q&A session.
- Book metadata (title, author, publisher, etc.)
- Chapter structure
- Selected writing style
- Created by Prompt 1 during initialization

### project.json
Project configuration and settings.
- `initialized`: Framework initialization status
- `settings.prompt_9_verbose`: Export detail level (true/false)
- Framework version tracking
- Replaces: `Project_Config.md` (removed in v0.12.1)

### metadata.json
Comprehensive project metadata.
- Book information (title, author, ISBN, genre, etc.)
- Version history
- Important dates
- Project statistics
- Replaces: `Project_Metadata.md` (removed in v0.12.1)

### manifest.json
Framework installation tracking.
- Framework version
- Installation date and method
- Available export tools (git, pandoc, typst)
- Replaces: `.nonfiction-manifest.json` (moved in v0.12.1)

### migrations.json
Framework migration configuration.
- Migration history
- Version upgrade paths
- Automated migration rules
- Replaces: `.nonfiction-migrations.json` (moved in v0.12.1)

---

## Usage

**DO NOT edit these files manually** unless you know what you're doing.

These files are managed by the framework prompts:
- Prompt 1 creates and initializes all config files
- Other prompts read/update as needed

---

## Migration from v0.12.1

If upgrading from v0.12.1:
- Old `.md` config files are converted to JSON
- Old root-level JSON files moved to `.config/`
- No manual action required

---

*This directory structure introduced in v0.12.1*
