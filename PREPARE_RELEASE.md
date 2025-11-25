# Prepare Release

**Current Framework Version:** 0.13.11
**Last Updated:** 2025-11-25

---

## What This Does

This document guides Claude through preparing a new framework release by updating all version numbers across documentation files and verifying consistency.

**IMPORTANT:** This is a framework-only file. It should NOT be included in the release zip. It's used by maintainers in the development repository.

---

## Release Preparation Workflow

### Step 1: Determine New Version Number

Ask the user:
- "What is the new version number?" (e.g., 0.9.2, 0.10.0, 1.0.0)
- Validate format: Must be semantic versioning (MAJOR.MINOR.PATCH)

Store as: `NEW_VERSION`

### Step 2: Update Version References

Update the version number in these files:

**Critical Files (MUST update):**
1. `README.md` (root level)
   - Line ~3: `**Version X.X.X**`
   - Line ~30: Download link: `nonfiction-vX.X.X.zip`
   - Line ~41-47: Extract instructions: `nonfiction-vX.X.X.zip`
   - Line ~336: `**Framework Version**: X.X.X`
   - Line ~337: `**Release Date**: YYYY-MM-DD`
   - Review entire file for outdated prompt counts (should be "16 prompts" as of v0.12.1+)

2. `Process/FRAMEWORK_CORE.md` ← NEW
   - Line ~3: `**Framework Version:** X.X.X`
   - Line ~395: `**Framework Version:** X.X.X` (footer)
   - Line ~396: `**Release Date:** YYYY-MM-DD` (footer)
   - Line ~397: `**Token Efficiency:** [Note about token savings]`

3. `CLAUDE.md`
   - Line ~3: `**Framework Version:** X.X.X`
   - Line ~533: `**Framework Version:** X.X.X`
   - Line ~534: `**Last Updated:** YYYY-MM-DD`

4. `configure.md`
   - Line ~5: `**AI-Assisted Nonfiction Authoring Framework vX.X.X**`
   - Line ~418: `*Framework Version: X.X.X*`

5. `INSTALLATION.md`
   - All references to `vX.X.X` or `X.X.X`
   - Download links: `nonfiction-vX.X.X.zip`

6. `PREPARE_RELEASE.md` (this file) ← STAYS at root
   - Line ~3: `**Current Framework Version:** X.X.X`
   - Line ~4: `**Last Updated:** YYYY-MM-DD`
   - Line ~end: `**Framework Version:** X.X.X` (footer)
   - Line ~end-1: `**Last Updated:** YYYY-MM-DD` (footer)

   **Self-Update:** This file updates its own version numbers as part of the release process.

7. `system-instructions.md`
   - Line ~3: `**Framework Version:** X.X.X`
   - Line ~552: `**Framework Version:** X.X.X` (footer)
   - Line ~553: `**Last Updated:** YYYY-MM-DD` (footer)

8. `.claude/commands/fw-init.md` ← NEW
   - Line ~7: Version note in improvement message
   - Line ~95: Framework version in completion report
   - Line ~96: Token savings note
   - Line ~140: Version note in "Notes" section

**Shell Scripts (Must update version headers):**
9. `scripts/init.sh`
   - Line ~5: `# Version: X.X.X`
   - Line ~227: Version in banner: `Nonfiction Framework Initialization Script vX.X.X`

10. `scripts/detect-tools.sh`
   - Line ~5: `# Version: X.X.X`
   - Line ~166: Version in banner: `Tool Detection Script vX.X.X`

11. `scripts/generate-usage-guide.sh`
   - Line ~5: `# Version: X.X.X`

12. `scripts/generate-content.sh` ← NEW in v0.14.0
   - Line ~3: `# Version: X.X.X`
   - Line ~232: Version in banner: `Batch Content Generator vX.X.X`

13. `Process/Scripts/compile-manuscript.sh`
   - No version number currently (add if needed)

**CHANGELOG.md:**
- Add new version entry at top with today's date
- Follow this format:

```markdown
## [X.X.X] - YYYY-MM-DD

### Added
- [New features]

### Changed
- [Changes to existing functionality]

### Fixed
- [Bug fixes]

### Technical
- [Technical improvements]

---
```

### Step 3: Review Critical Files for Content Updates

**IMPORTANT:** Before proceeding to version verification, manually review these files for outdated content:

**3A. Review README.md:**
- Check all prompt counts (should be "16 prompts" as of v0.12.1+)
- Verify download links match new version
- Check "The 16 Core Prompts" section - should list all 16 prompts
- Verify "What's Included" section lists current features
- Check "Writing Style System" description is current
- Verify footer version and date

**3B. Review CHANGELOG.md:**
- Verify new version entry added at top
- Check that all major changes are documented
- Ensure version entry format is consistent
- Verify date is correct (YYYY-MM-DD)
- Check that Added/Changed/Fixed/Technical sections are complete

**3C. Review system-instructions.md:**
- Verify compatibility classifications are correct (as of v0.12.1+):
  - CLI-ONLY: Prompts 7, 8, 9, 12, 13, 14, 15, 16
  - DESKTOP-FRIENDLY: Prompts 2, 3, 4, 5, 6, 10
  - HYBRID: configure.md, Prompts 1, 11
- Check all 16 prompts are listed (lines ~117-133)
- Verify critical section (lines ~42-66) has correct CLI-ONLY prompts (7, 8, 9, 12, 13, 14, 15, 16)
- Check version numbers in header and footer

### Step 4: Verify All Updates

Run this grep command to find any remaining old version references:

```bash
grep -r "OLD_VERSION" --include="*.md" --include="*.json" --include="*.sh" . | grep -v ".git" | grep -v "node_modules" | grep -v "CHANGELOG.md"
```

**Note:** CHANGELOG.md will contain old versions in history - that's expected.

If any unexpected references found, update them.

### Step 4.5: Verify Migration Configuration

**Check that migrations configuration exists and is properly configured:**

1. **Verify file exists:**
   ```bash
   ls -la .nonfiction-migrations.json
   ls -la Process/Templates/.config/migrations.json
   ```

2. **Check migration entries are up to date:**
   - Read `.nonfiction-migrations.json` (root - for framework development)
   - Template at `Process/Templates/.config/migrations.json` copied to user projects
   - Verify the latest migration entry matches the new version
   - If releasing 0.10.1, there should be a migration from 0.10.0 → 0.10.1
   - If no changes need migrations this release, that's fine (not every release requires migrations)

3. **Validate migration structure:**
   - Each migration must have: `id`, `fromVersion`, `toVersion`, `date`, `description`, `changes`
   - Each change must have: `type`, `reason`, `manualSteps`
   - Verify all referenced files in migrations actually exist (e.g., README.md for rename operations)

4. **Check .gitignore configuration:**
   ```bash
   # Framework .gitignore should NOT exclude migrations file
   grep ".nonfiction-migrations.json" .gitignore
   # (Should return no results - file should be tracked in framework repo)

   # User project .gitignore template SHOULD exclude .config directory
   grep ".config/" Process/Templates/gitignore_template
   # (Should find it - .config/ is a framework-managed directory)
   ```
   - Framework: `.nonfiction-migrations.json` tracked at root for development
   - User projects: `.config/migrations.json` copied from template, excluded in .gitignore

**If migrations are needed for this release:**
- Ensure they're documented in `.nonfiction-migrations.json` BEFORE tagging
- Test the migration with `configure.md` on a test project
- Verify all change types work correctly
- Confirm manual steps are clear and accurate

**CRITICAL: Verify config templates will be included in release:**
- Check that `.github/workflows/release.yml` copies `Process/Templates/.config/` to build
- `.config/migrations.json` template MUST be included in release zip
- All 5 .config templates must be present (init, project, metadata, manifest, migrations)

### Step 4.6: Generate Framework Files Manifest

**Generate the framework files manifest for this release:**

The manifest lists all framework files that should exist in a clean installation. This enables configure.md to clean up outdated files during updates.

1. **Generate current file listing:**
   ```bash
   # List all framework files
   find Process -type f | sort > /tmp/process_files.txt
   ls -1 INSTALLATION.md CLAUDE.md configure.md system-instructions.md .gitignore .nonfiction-migrations.json 2>/dev/null > /tmp/root_files.txt
   find .claude -type f | sort > /tmp/claude_files.txt
   find scripts -type f | sort > /tmp/scripts_files.txt
   ```

2. **Update `Process/Templates/framework_files_manifest.json`:**
   - Open `Process/Templates/framework_files_manifest.json`
   - Update `"version"` to match `NEW_VERSION`
   - Update `"generatedDate"` to today's date (YYYY-MM-DD)
   - Verify all files listed in manifest still exist
   - Add any new files created in this release
   - Remove any files that were deleted in this release

3. **Validate manifest structure:**
   ```bash
   # Check JSON is valid
   cat Process/Templates/framework_files_manifest.json | jq .
   ```

4. **Verify completeness:**
   - Compare manifest against actual files
   - Ensure all `.md` files in Process/ are listed
   - Ensure all prompts (Prompt_1 through Prompt_16, Prompt_99) are listed
   - Ensure all modules (_COMMON/01-17) are listed
   - Ensure all templates are listed

**IMPORTANT: Step 4.7 - Documentation/ Directory Exclusion**

The `Documentation/` directory contains maintainer documentation and is NOT included in user release packages:
- Documentation/ is excluded in `.github/workflows/release.yml` build step
- Only Process/, scripts/, .claude/, and root config files are included in releases
- PREPARE_RELEASE.md stays at root (actively used for every release)
- Users get FRAMEWORK_CORE.md (instant load) + on-demand docs from Process/
   - Ensure .claude/ files are listed (README.md, hooks.json)
   - Ensure .claude/agents/ are listed (book-writing-assistant.md)
   - Ensure .claude/commands/ are listed (fw-init.md)

**Example manifest structure:**
```json
{
  "version": "0.13.3",
  "generatedDate": "2025-11-23",
  "files": {
    "root": ["INSTALLATION.md", "CLAUDE.md", ...],
    "Process": ["FRAMEWORK_CORE.md", "Anti-Hallucination_Guidelines.md", ...],
    "Process/Prompts": ["Prompt_1_Initialize.md", "README.md", "QUICK_REFERENCE.md", ...],
    "Process/_COMMON": ["01_Prompt_Structure_Template.md", ...],
    "Process/Templates": ["Chapter_Style_Template.md", ...],
    "Process/Styles": ["README.md", "Style_Catalog.md", ...],
    ".claude": ["README.md", "hooks.json"],
    ".claude/agents": ["book-writing-assistant.md"],
    ".claude/commands": ["fw-init.md"]
  }
}
```

**Note:** Documentation/ directory is NOT in manifest - it's excluded from user releases

**Why this matters:**
- During framework updates, configure.md will:
  1. Read this manifest to know what files SHOULD exist
  2. Compare against what files DO exist in user's Process/ directory
  3. Remove files NOT in manifest (outdated from previous versions)
  4. Preserve user content (Manuscript/, etc. - never touched)
- Prevents accumulation of obsolete framework files
- Keeps installation clean and up-to-date

**Commit the updated manifest:**
```bash
git add Process/Templates/framework_files_manifest.json
# (Will be committed with other version updates in Step 5)
```

### Step 5: Commit Version Updates

```bash
git add -A
git commit -m "Update all documentation to version X.X.X

UPDATED:
- README.md (root level)
- Process/FRAMEWORK_CORE.md
- CLAUDE.md
- configure.md
- INSTALLATION.md
- PREPARE_RELEASE.md
- system-instructions.md
- .claude/commands/fw-init.md
- Documentation/AI-Assisted_Nonfiction_Authoring_Process.md
- CHANGELOG.md
- scripts/init.sh
- scripts/detect-tools.sh
- scripts/generate-usage-guide.sh
- scripts/generate-content.sh

Prepared for vX.X.X release.

🤖 Generated with Claude Code

Co-Authored-By: Claude <noreply@anthropic.com>"

git push
```

### Step 6: Create and Push Tag

```bash
# Delete existing tag if it exists (for re-releases)
git tag -d vX.X.X 2>/dev/null
git push origin :refs/tags/vX.X.X 2>/dev/null

# Create annotated tag with release notes
git tag -a vX.X.X -m "Release vX.X.X: [Brief Description]

[Detailed release notes - copy from CHANGELOG.md]
"

# Push tag (triggers GitHub Actions workflow)
git push --tags
```

### Step 7: Monitor GitHub Actions

```bash
# Wait for workflow to start
sleep 15

# Watch workflow execution
gh run list --limit 1

# If successful, verify release
gh release view vX.X.X
```

### Step 8: Verify Release Assets

Check that the release includes:
- ✅ Release page created on GitHub
- ✅ `nonfiction-vX.X.X.zip` artifact
- ✅ SHA256 checksum
- ✅ Changelog from CHANGELOG.md
- ✅ Installation instructions (dual-path for Claude Code + Claude Desktop)
  - ✅ Option A: Claude Code CLI (recommended)
  - ✅ Option B: Claude Desktop with system-instructions.md setup
  - ✅ IMPORTANT note about Custom Instructions BEFORE configure.md

---

## Files That Should Contain Version Numbers

This list helps verify all version references are updated:

### Framework Documentation (User-Facing)
- `README.md` - Root level readme (header, footer, download links, prompt counts)
- `Process/FRAMEWORK_CORE.md` - Header and footer version and date ← NEW
- `CLAUDE.md` - Header and footer version and date
- `configure.md` - Header and footer version
- `INSTALLATION.md` - All download links and references
- `system-instructions.md` - Header and footer version, token efficiency note
- `.claude/commands/fw-init.md` - Version notes throughout ← NEW

### Shell Scripts (Framework Automation)
- `scripts/init.sh` - Header version comment and banner display
- `scripts/detect-tools.sh` - Header version comment and banner display
- `scripts/generate-usage-guide.sh` - Header version comment
- `scripts/generate-content.sh` - Header version comment and banner display (NEW v0.14.0)

### Maintainer Tools (Root Level - Actively Used)
- `PREPARE_RELEASE.md` - This file's header and footer version and date (stays at root)

### Maintainer Documentation (NOT in user releases)
- `Documentation/AI-Assisted_Nonfiction_Authoring_Process.md` - Header version and date

### Generated During Installation (v0.12.1+)
- `.config/init.json` - Created by Prompt 1 Q&A session
- `.config/project.json` - Created by Prompt 1 (replaces Project_Config.md)
- `.config/metadata.json` - Created by Prompt 1 (replaces Project_Metadata.md)
- `.config/manifest.json` - Created by configure.md (replaces .nonfiction-manifest.json)
- `.config/migrations.json` - Copied from template during initialization

### Release Artifacts
- `CHANGELOG.md` - New version entry added
- Git tag - `vX.X.X`
- GitHub Release - Title and assets
- ZIP filename - `nonfiction-vX.X.X.zip`

---

## Version Numbering Guidelines

Follow semantic versioning (https://semver.org/):

**MAJOR version (X.0.0):**
- Breaking changes requiring migration
- Incompatible API changes
- Major structural reorganization

**MINOR version (0.X.0):**
- New features (backwards compatible)
- Significant enhancements
- New prompts or major prompt changes

**PATCH version (0.0.X):**
- Bug fixes
- Documentation improvements
- Small enhancements
- Performance improvements

---

## Pre-Release Checklist

Before creating a release, verify:

- [ ] All prompts tested and working
- [ ] **README.md reviewed** for prompt counts, version numbers, download links
- [ ] **CHANGELOG.md reviewed** for complete, accurate release notes
- [ ] **system-instructions.md reviewed** for correct compatibility classifications
- [ ] **`.nonfiction-migrations.json` verified** with correct migrations for this release
- [ ] **Migration testing completed** if migrations are included in this release
- [ ] All version numbers updated consistently across 11 files (8 docs + 3 shell scripts)
- [ ] **Shell scripts verified** (init.sh, detect-tools.sh, generate-usage-guide.sh)
- [ ] No uncommitted changes in repository
- [ ] GitHub Actions workflow is functioning
- [ ] Previous release (if any) completed successfully

---

## Rollback Procedure

If a release needs to be rolled back:

1. **Delete bad release:**
   ```bash
   gh release delete vX.X.X -y
   git push origin :refs/tags/vX.X.X
   git tag -d vX.X.X
   ```

2. **Fix issues in code**

3. **Re-run this PREPARE_RELEASE.md workflow**

---

## Example: Releasing v0.11.0

**User:** "Prepare release 0.11.0"

**Claude:**
1. Updates version to 0.11.0 in all 8 documentation files and 3 shell scripts listed in Step 2
2. Updates dates to today's date
3. **Reviews README.md** for prompt counts ("16 prompts" as of v0.12.1), download links, features
4. **Reviews CHANGELOG.md** entry for 0.11.0 completeness
5. **Reviews system-instructions.md** for correct compatibility classifications (CLI-ONLY: 7,8,9,12,13,14,15,16 as of v0.12.1+)
6. Runs grep to verify no 0.10.3 references remain (except CHANGELOG history)
7. Commits with message: "Update all documentation to version 0.11.0"
8. Creates tag v0.11.0 with release notes from CHANGELOG.md
9. Pushes tag
10. Monitors GitHub Actions
11. Verifies release created successfully with nonfiction-v0.11.0.zip

---

## Quick Command Reference

**Check current version in files:**
```bash
grep -h "Version:" README.md Process/FRAMEWORK_CORE.md CLAUDE.md configure.md PREPARE_RELEASE.md system-instructions.md Documentation/AI-Assisted_Nonfiction_Authoring_Process.md scripts/*.sh | head -12
```

**Find all version references:**
```bash
grep -r "0\.10\.0" --include="*.md" --include="*.sh" . | grep -v ".git" | grep -v "CHANGELOG.md" | grep -v "Documentation/"
```

**Review critical files for content:**
```bash
# Check README.md for outdated prompt counts (should be 16 as of v0.12.1)
grep -n "[0-9][0-9].*[Pp]rompts" README.md

# Check system-instructions.md for compatibility
grep -n "CLI-ONLY\|DESKTOP-FRIENDLY\|HYBRID\|DESKTOP-READY" system-instructions.md
```

**List recent releases:**
```bash
gh release list --limit 5
```

**View specific release:**
```bash
gh release view vX.X.X
```

**Check workflow status:**
```bash
gh run list --limit 3
```

---

**Framework Version:** 0.13.11
**Last Updated:** 2025-11-25

*This file is for framework maintainers only - not included in release packages*
