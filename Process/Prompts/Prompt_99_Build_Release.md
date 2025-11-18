# Execute Prompt 99: Build Production Release

**INTERNAL USE ONLY - Framework Maintainers**

**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`

---

## What This Does

I will create a production release of the nonfiction authoring framework for distribution to book authors. This prompt:

1. Extracts version information from the current framework
2. Creates a clean production build (no development files)
3. Generates author-focused documentation
4. Packages everything into a versioned zip file
5. Creates installer.md for distribution
6. Creates a GitHub Release with all assets

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

### Step 2: Create Build Directory

I will:
1. Create temporary build directory: `build/nonfiction-v{VERSION}/`
2. Copy framework files to build directory (see inclusion list below)
3. Verify no `_chg.md` files are included
4. Verify no development files are included

### Step 3: Generate Production Files

I will create:

**`.nonfiction-manifest.json`** at build root:
```json
{
  "framework": "AI-Assisted Nonfiction Authoring",
  "version": "{VERSION}",
  "release_date": "{DATE}",
  "release_url": "https://github.com/scooter-indie/author-nonfiction/releases/tag/v{VERSION}"
}
```

**`README.md`** (author-focused, ~100-150 lines):
- What this framework is
- Quick start: Run installer.md, then follow prompts
- Overview: 10 prompts for different tasks
- Next steps: Use Prompt 3 for daily revisions, Prompt 8 for progress
- Link to QUICK_REFERENCE.md for detailed workflows
- How to update framework (re-run installer.md)
- Support and issues link

**`.gitignore`** (book project template):
```
# Temporary files
*.tmp
*.bak
~*

# Editor files
.vscode/
.idea/
*.swp

# OS files
.DS_Store
Thumbs.db

# Build artifacts
build/
dist/

# Optional: Large compiled drafts
# Drafts/Full_Draft_*.md
```

### Step 4: Create Production Zip

I will:
1. Create `nonfiction-v{VERSION}.zip` containing the build directory contents
2. Calculate SHA256 checksum
3. Verify zip integrity by listing contents

### Step 5: Generate installer.md

I will create `installer.md` with embedded version number and logic:

```markdown
# Nonfiction Framework Installer

**Version:** {VERSION}
**Release Date:** {DATE}

## What This Does

I will install the AI-Assisted Nonfiction Authoring Framework into your book project.

**If this is a new project:** I'll set up git, push to remote, and launch initialization.
**If updating existing project:** I'll update the framework files and track changes in git.

---

## Prerequisites

- You have downloaded `nonfiction-v{VERSION}.zip` to your project directory
- For new projects: You have created an empty remote repository (GitHub/GitLab/Bitbucket)
- For updates: Your current work is committed to git

---

## Installation Process

[Installer prompts user, detects new vs. update mode, executes accordingly]
```

### Step 6: Extract Release Notes

I will:
1. Read latest version entry from `Process/AI-Assisted_Nonfiction_Authoring_Process_chg.md`
2. Format as GitHub release notes
3. Include:
   - Version highlights
   - Major changes
   - Breaking changes (if any)
   - Link to full version history

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
  nonfiction-v{VERSION}.zip \
  installer.md
```

This creates a GitHub Release with:
- Tag: `v{VERSION}`
- Title: "Nonfiction Framework v{VERSION}"
- Release notes from version history
- Assets: zip file and installer.md

### Step 9: Verification

I will:
1. Verify release appears at https://github.com/scooter-indie/author-nonfiction/releases
2. Verify both assets are attached
3. Verify download links work
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
- `.nonfiction-manifest.json` (version tracking)
- `README.md` (author-focused)
- `.gitignore` (book project template)

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

**Note:** Current `README.md` will be renamed to `README_FRAMEWORK.md` for framework developers. Production builds get new author-focused `README.md`.

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
