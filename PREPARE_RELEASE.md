# Prepare Release

**Current Framework Version:** 0.10.1
**Last Updated:** 2025-11-19

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
   - Review entire file for outdated prompt counts ("10 prompts" vs "11 prompts")

2. `Process/AI-Assisted_Nonfiction_Authoring_Process.md`
   - Line ~3: `**Version:** X.X.X`
   - Line ~4: `**Last Updated:** YYYY-MM-DD`

3. `CLAUDE.md`
   - Line ~3: `**Framework Version:** X.X.X`
   - Line ~322: `**Framework Version:** X.X.X`
   - Line ~323: `**Last Updated:** YYYY-MM-DD`

4. `configure.md`
   - Line ~5: `**AI-Assisted Nonfiction Authoring Framework vX.X.X**`
   - Line ~418: `*Framework Version: X.X.X*`

5. `INSTALLATION.md`
   - All references to `vX.X.X` or `X.X.X`
   - Download links: `nonfiction-vX.X.X.zip`

6. `PREPARE_RELEASE.md` (this file)
   - Line ~3: `**Current Framework Version:** X.X.X`
   - Line ~4: `**Last Updated:** YYYY-MM-DD`
   - Line ~end: `**Framework Version:** X.X.X` (footer)
   - Line ~end-1: `**Last Updated:** YYYY-MM-DD` (footer)

   **Self-Update:** This file updates its own version numbers as part of the release process.

7. `system-instructions.md`
   - Line ~3: `**Framework Version:** X.X.X`
   - Line ~487: `**Framework Version:** X.X.X` (footer)
   - Line ~488: `**Last Updated:** YYYY-MM-DD` (footer)

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
- Check all prompt counts (should be "11 prompts", not "10 prompts")
- Verify download links match new version
- Check "The 10 Core Prompts" section - should list all 11 prompts
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
- Verify compatibility classifications are correct:
  - CLI-ONLY: Prompts 5, 7, 9
  - DESKTOP-FRIENDLY: Prompts 2, 3, 4, 8, 10
  - HYBRID: configure.md, Prompts 1, 11
  - DESKTOP-READY: Prompt 6
- Check all 11 prompts are listed (lines ~117-128)
- Verify critical section (lines ~42-62) has correct CLI-ONLY prompts
- Check version numbers in header and footer

### Step 4: Verify All Updates

Run this grep command to find any remaining old version references:

```bash
grep -r "OLD_VERSION" --include="*.md" --include="*.json" . | grep -v ".git" | grep -v "node_modules" | grep -v "CHANGELOG.md"
```

**Note:** CHANGELOG.md will contain old versions in history - that's expected.

If any unexpected references found, update them.

### Step 4.5: Verify Migration Configuration

**Check that `.nonfiction-migrations.json` exists and is properly configured:**

1. **Verify file exists:**
   ```bash
   ls -la .nonfiction-migrations.json
   ```

2. **Check migration entries are up to date:**
   - Read `.nonfiction-migrations.json`
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

   # User project .gitignore template SHOULD exclude migrations file
   grep ".nonfiction-migrations.json" Process/Templates/gitignore_template
   # (Should find it - file should NOT be tracked in user projects)
   ```
   - Framework: `.nonfiction-migrations.json` should be tracked (versioned with framework)
   - User projects: `.nonfiction-migrations.json` should be in .gitignore (it's a framework file)

**If migrations are needed for this release:**
- Ensure they're documented in `.nonfiction-migrations.json` BEFORE tagging
- Test the migration with `configure.md` on a test project
- Verify all change types work correctly
- Confirm manual steps are clear and accurate

### Step 5: Commit Version Updates

```bash
git add -A
git commit -m "Update all documentation to version X.X.X

UPDATED:
- README.md (root level)
- Process/AI-Assisted_Nonfiction_Authoring_Process.md
- CLAUDE.md
- configure.md
- INSTALLATION.md
- PREPARE_RELEASE.md
- system-instructions.md
- CHANGELOG.md

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
- ✅ Installation instructions

---

## Files That Should Contain Version Numbers

This list helps verify all version references are updated:

### Framework Documentation
- `README.md` - Root level readme (header, footer, download links, prompt counts)
- `Process/AI-Assisted_Nonfiction_Authoring_Process.md` - Header version and date
- `CLAUDE.md` - Header and footer version and date
- `configure.md` - Header and footer version
- `INSTALLATION.md` - All download links and references
- `PREPARE_RELEASE.md` - This file's header and footer version and date
- `system-instructions.md` - Header and footer version, compatibility classifications

### Generated During Installation
- `.nonfiction-manifest.json` - Created by configure.md (frameworkVersion field)

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
- [ ] All version numbers updated consistently across 8 files
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

## Example: Releasing v0.10.1

**User:** "Prepare release 0.10.1"

**Claude:**
1. Updates version to 0.10.1 in all 8 files listed in Step 2
2. Updates dates to today's date
3. **Reviews README.md** for prompt counts ("11 prompts" not "10"), download links, features
4. **Reviews CHANGELOG.md** entry for 0.10.1 completeness
5. **Reviews system-instructions.md** for correct compatibility classifications (CLI-ONLY: 5,7,9)
6. Runs grep to verify no 0.10.0 references remain (except CHANGELOG history)
7. Commits with message: "Update all documentation to version 0.10.1"
8. Creates tag v0.10.1 with release notes from CHANGELOG.md
9. Pushes tag
10. Monitors GitHub Actions
11. Verifies release created successfully with nonfiction-v0.10.1.zip

---

## Quick Command Reference

**Check current version in files:**
```bash
grep -h "Version:" README.md Process/AI-Assisted_Nonfiction_Authoring_Process.md CLAUDE.md configure.md PREPARE_RELEASE.md system-instructions.md | head -8
```

**Find all version references:**
```bash
grep -r "0\.10\.0" --include="*.md" . | grep -v ".git" | grep -v "CHANGELOG.md"
```

**Review critical files for content:**
```bash
# Check README.md for "10 prompts" vs "11 prompts"
grep -n "10.*[Pp]rompts" README.md

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

**Framework Version:** 0.10.1
**Last Updated:** 2025-11-19

*This file is for framework maintainers only - not included in release packages*
