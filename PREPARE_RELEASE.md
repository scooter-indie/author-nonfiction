# Prepare Release

**Current Framework Version:** 0.9.1
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
1. `Process/AI-Assisted_Nonfiction_Authoring_Process.md`
   - Line ~3: `**Version:** X.X.X`
   - Line ~4: `**Last Updated:** YYYY-MM-DD`

2. `CLAUDE.md`
   - Line ~3: `**Framework Version:** X.X.X`
   - Line ~322: `**Framework Version:** X.X.X`
   - Line ~323: `**Last Updated:** YYYY-MM-DD`

3. `configure.md`
   - Line ~5: `**AI-Assisted Nonfiction Authoring Framework vX.X.X**`
   - Line ~389: `*Framework Version: X.X.X*`

4. `INSTALLATION.md`
   - All references to `vX.X.X` or `X.X.X`
   - Download links: `nonfiction-vX.X.X.zip`

5. `PREPARE_RELEASE.md` (this file)
   - Line ~3: `**Current Framework Version:** X.X.X`
   - Line ~4: `**Last Updated:** YYYY-MM-DD`
   - Line ~end: `**Framework Version:** X.X.X` (footer)
   - Line ~end-1: `**Last Updated:** YYYY-MM-DD` (footer)

   **Self-Update:** This file updates its own version numbers as part of the release process.

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

### Step 3: Verify All Updates

Run this grep command to find any remaining old version references:

```bash
grep -r "OLD_VERSION" --include="*.md" --include="*.json" . | grep -v ".git" | grep -v "node_modules" | grep -v "CHANGELOG.md"
```

**Note:** CHANGELOG.md will contain old versions in history - that's expected.

If any unexpected references found, update them.

### Step 4: Commit Version Updates

```bash
git add -A
git commit -m "Update all documentation to version X.X.X

UPDATED:
- Process/AI-Assisted_Nonfiction_Authoring_Process.md
- CLAUDE.md
- configure.md
- INSTALLATION.md
- PREPARE_RELEASE.md
- CHANGELOG.md

Prepared for vX.X.X release.

🤖 Generated with Claude Code

Co-Authored-By: Claude <noreply@anthropic.com>"

git push
```

### Step 5: Create and Push Tag

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

### Step 6: Monitor GitHub Actions

```bash
# Wait for workflow to start
sleep 15

# Watch workflow execution
gh run list --limit 1

# If successful, verify release
gh release view vX.X.X
```

### Step 7: Verify Release Assets

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
- `Process/AI-Assisted_Nonfiction_Authoring_Process.md` - Header version and date
- `CLAUDE.md` - Header and footer version and date
- `configure.md` - Header and footer version
- `INSTALLATION.md` - All download links and references
- `PREPARE_RELEASE.md` - This file's header version and date

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
- [ ] Documentation reviewed for accuracy
- [ ] CHANGELOG.md updated with all changes
- [ ] All version numbers updated consistently
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

## Example: Releasing v0.10.0

**User:** "Prepare release 0.10.0"

**Claude:**
1. Updates version to 0.10.0 in all files listed in Step 2
2. Updates dates to today's date
3. Adds CHANGELOG.md entry for 0.10.0
4. Runs grep to verify no 0.9.1 references remain (except CHANGELOG history)
5. Commits with message: "Update all documentation to version 0.10.0"
6. Creates tag v0.10.0 with release notes
7. Pushes tag
8. Monitors GitHub Actions
9. Verifies release created successfully

---

## Quick Command Reference

**Check current version in files:**
```bash
grep -h "Version:" Process/AI-Assisted_Nonfiction_Authoring_Process.md CLAUDE.md configure.md PREPARE_RELEASE.md | head -5
```

**Find all version references:**
```bash
grep -r "0\.9\.1" --include="*.md" . | grep -v ".git" | grep -v "CHANGELOG.md"
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

**Framework Version:** 0.9.1
**Last Updated:** 2025-11-19

*This file is for framework maintainers only - not included in release packages*
