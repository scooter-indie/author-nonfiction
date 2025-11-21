# Execute Prompt 99: Build Production Release

**INTERNAL USE ONLY - Framework Maintainers**

**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`

---

## What This Does

I will create a production release of the nonfiction authoring framework for distribution to book authors. This prompt:

1. Extracts version information from the current framework
2. Creates a clean production build (no development files)
3. Copies author-focused documentation files
4. Packages everything into a versioned zip file
5. Creates a GitHub Release with zip asset

**This prompt is EXCLUDED from production builds.**

---

## Prerequisites

Before running this prompt, ensure:

1. **All changes committed and pushed** to main branch
2. **Version number updated** in `Process/AI-Assisted_Nonfiction_Authoring_Process.md`
3. **Version history documented** in `Process/AI-Assisted_Nonfiction_Authoring_Process_chg.md`
4. **GitHub CLI installed** (`gh` command available)
5. **GitHub authenticated** (`gh auth status` shows logged in)

---

## Build Process

### Step 1: Version Detection

I will:
1. Read version from `Process/AI-Assisted_Nonfiction_Authoring_Process.md` (line 3)
2. Read release date from same file (line 4)
3. Extract version history from `Process/AI-Assisted_Nonfiction_Authoring_Process_chg.md`
4. Confirm version with you before proceeding

### Step 2: Verify Migration Configuration

Before creating the build, I will verify the migration system:

1. **Check `.nonfiction-migrations.json` exists:**
   - Verify file is present in repository root
   - Read and validate JSON structure

2. **Validate migrations for this release:**
   - Check if there are migrations from previous version to current version
   - Verify all migrations have required fields: `id`, `fromVersion`, `toVersion`, `date`, `description`, `changes`
   - Verify each change has: `type`, `reason`, `manualSteps`
   - Confirm all referenced files exist (e.g., files to rename, .gitignore patterns)

3. **Check migration change types:**
   - Verify only supported change types are used: `rename`, `delete`, `gitignore_add`, `gitignore_remove`, `add_to_config`, `update_content`
   - Warn if any unsupported types are present

4. **Confirm with user:**
   - If migrations exist for this release: "This release includes X migration(s). Have you tested them with configure.md?"
   - If no migrations: "This release has no migrations. Is this correct?"

**This step ensures migrations are properly configured before distribution.**

### Step 3: Create Build Directory

I will:
1. Create temporary build directory: `build/nonfiction-v{VERSION}/`
2. Copy framework files to build directory (see inclusion list below)
3. **Copy `.nonfiction-migrations.json` to build root** (migration rules)
4. Verify no `_chg.md` files are included
5. Verify no development files are included

### Step 4: Generate Production Files

I will create:

**`.config/manifest.json`** template (for user projects):
```json
{
  "framework": "AI-Assisted Nonfiction Authoring",
  "version": "{VERSION}",
  "release_date": "{DATE}",
  "release_url": "https://github.com/scooter-indie/author-nonfiction/releases/tag/v{VERSION}"
}
```

**Files copied from repository root:**
- `README.md` (already author-focused)
- `INSTALLATION.md` (installation guide)
- `CHANGELOG.md` (version history)
- `CLAUDE.md` (framework context for Claude Code)
- `configure.md` (configuration script)
- `system-instructions.md` (Claude Desktop integration)

**`.gitignore`** (from Process/Templates/gitignore_template):
- Copy `Process/Templates/gitignore_template` to `.gitignore`
- This excludes framework files from user git tracking

### Step 5: Create Production Zip

I will:
1. Create `nonfiction-v{VERSION}.zip` containing the build directory contents
2. Calculate SHA256 checksum
3. Verify zip integrity by listing contents

### Step 6: Extract Release Notes

I will:
1. Read latest version entry from `CHANGELOG.md`
2. Format as GitHub release notes
3. Include:
   - Version highlights
   - Major changes
   - Breaking changes (if any)
   - Link to full changelog

### Step 7: Create Git Tag

I will:
1. Create annotated git tag: `v{VERSION}`
2. Tag message: Version number and brief description
3. Push tag to remote

### Step 8: Create GitHub Release

I will execute:
```bash
gh release create v{VERSION} \
  --title "Nonfiction Framework v{VERSION}" \
  --notes "$(cat release-notes.md)" \
  nonfiction-v{VERSION}.zip
```

This creates a GitHub Release with:
- Tag: `v{VERSION}`
- Title: "Nonfiction Framework v{VERSION}"
- Release notes from CHANGELOG.md
- Asset: zip file (contains configure.md, README.md, INSTALLATION.md, etc.)

### Step 9: Verification

I will:
1. Verify release appears at https://github.com/scooter-indie/author-nonfiction/releases
2. Verify zip asset is attached
3. Verify download link works
4. Clean up temporary build directory

### Step 10: Report

I will provide:
- Release URL
- Asset download URLs
- Checksum for verification
- Next steps for announcement

---

## Files Included in Production Zip

### Root Level
- `scripts/` (bash automation scripts - v0.12.3+)
  - `init.sh` (fast initialization script)
  - `README.md`
- `README.md` (author-focused, from repo root)
- `INSTALLATION.md` (from repo root)
- `CHANGELOG.md` (from repo root)
- `CLAUDE.md` (from repo root)
- `configure.md` (from repo root)
- `system-instructions.md` (from repo root)
- `.gitignore` (from Process/Templates/gitignore_template)

### .claude/
- `agents/book-writing-assistant.md`

### Process/
- `AI-Assisted_Nonfiction_Authoring_Process.md` (NO _chg file)
- `Anti-Hallucination_Guidelines.md` (NO _chg file)
- `Style_Examples.md`

### Process/Prompts/
- `Prompt_1_Initialize.md`
- `Prompt_2_Add_Chapter.md`
- `Prompt_3_Modify_File.md`
- `Prompt_4_Integrate_Inbox.md`
- `Prompt_5_Compile.md`
- `Prompt_6_Consistency.md`
- `Prompt_7_Export.md`
- `Prompt_8_Dashboard.md`
- `Prompt_9_Git.md`
- `Prompt_10_Update_Change_Tracking.md`
- `QUICK_REFERENCE.md`
- **EXCLUDE:** `README.md` (developer-focused)
- **EXCLUDE:** `Prompt_99_Build_Release.md` (this file)

### Process/Templates/
- `Style_Guide_Template.md`
- `Custom_Styles_Template.md`
- All other templates

---

## Files Excluded from Production Zip

**Development/Internal:**
- All `*_chg.md` files
- `Proposal/` directory
- `Process/Prompts/README.md` (developer-focused)
- `Process/Prompts/Prompt_99_Build_Release.md` (this file)
- `README_FRAMEWORK.md` (framework developer README)
- `.claude/settings.local.json`
- `build/` directory
- `.git/` directory (users initialize their own git repo via configure.md)

---

## Error Handling

If any step fails:
1. I will report the error
2. I will NOT create the GitHub Release
3. I will NOT delete the build directory (for inspection)
4. You can fix the issue and re-run

Common issues:
- **Version not found:** Update version in Process document first
- **Git not clean:** Commit or stash changes first
- **gh not authenticated:** Run `gh auth login`
- **Tag already exists:** Delete tag or increment version

---

## Post-Release Tasks

After successful release:

1. **Announce release** (if applicable)
2. **Update documentation** if distribution process changed
3. **Test installation** on clean directory to verify
4. **Monitor issues** for user feedback

---

## Ready to Begin?

**I will now:**
1. Detect current version
2. Ask you to confirm version and proceed
3. Execute all build steps
4. Create GitHub Release
5. Provide verification report

**Do you want to proceed with building the production release?**

---

*This prompt is for framework maintainers only. It is excluded from production distributions.*
