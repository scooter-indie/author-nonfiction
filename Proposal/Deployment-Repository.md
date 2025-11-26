# Deployment Repository

**Proposal Date:** 2025-11-26
**Framework Version:** 0.13.14
**Status:** Draft
**GitHub Issue:** #13
**Priority:** Distribution Enhancement

---

## Executive Summary

**Problem:** Users currently must download zip files from GitHub releases, extract them manually (error-prone), and cannot easily track upstream updates. The development repository contains maintainer-only files that would confuse users if they cloned it directly.

**Solution:** Create a separate read-only deployment repository (`author-nonfiction-dist`) that:
- Contains only user-facing framework files (no dev artifacts)
- Is the **sole distribution method** - no more zip files
- Allows users to `git clone` directly
- Enables tracking upstream updates via `git pull`
- Is auto-updated by GitHub Actions when releases are published

**Outcome:** Simpler installation, easier updates, cleaner separation between development and distribution, reduced maintenance (no zip workflow).

---

## Current State

### How Users Get the Framework Today

1. Go to GitHub Releases page
2. Download `nonfiction-vX.Y.Z.zip`
3. Extract to project directory (error-prone - must extract to correct location)
4. Run `configure.md`

### Problems

| Issue | Impact |
|-------|--------|
| **Zip extraction errors** | Users extract to wrong location, create nested directories |
| **No update tracking** | Users must manually check for new releases |
| **Dev files visible** | Development repo has Proposal/, Documentation/, _chg.md files that confuse users |
| **Zip download required** | Cannot use `git clone` for familiar workflow |
| **No delta updates** | Must re-download entire zip for any update |

---

## Proposed Solution

### Create `author-nonfiction-dist` Repository

A separate GitHub repository containing **only** the files included in release zips:

```
scooter-indie/author-nonfiction-dist/
├── .claude/
│   ├── agents/
│   │   └── book-writing-assistant.md
│   └── commands/
│       └── fw-init.md
├── Process/
│   ├── FRAMEWORK_CORE.md
│   ├── Anti-Hallucination_Guidelines.md
│   ├── Prompts/
│   │   ├── QUICK_REFERENCE.md
│   │   ├── Prompt_1_Initialize.md
│   │   ├── Prompt_2_Add_Chapter.md
│   │   └── ... (all prompts EXCEPT Prompt_99)
│   ├── Styles/
│   │   └── ... (all styles)
│   └── Templates/
│       └── ... (all templates)
├── scripts/
│   └── ... (automation scripts)
├── configure.md
├── system-instructions.md
├── INSTALLATION.md
├── CHANGELOG.md
├── CLAUDE.md
├── .gitignore
└── .nonfiction-migrations.json
```

### What's EXCLUDED from Deployment Repo

| Excluded | Reason |
|----------|--------|
| `Documentation/` | Maintainer documentation, not needed by users |
| `Proposal/` | Internal proposals |
| `Implemented/` | Completed proposals archive |
| `PREPARE_RELEASE.md` | Maintainer release checklist |
| `ENFORCEMENT_RULES.md` | Internal rules |
| `*_chg.md` files | Change tracking (development workflow) |
| `Prompt_99_Build_Release.md` | Maintainer-only prompt |
| `Process/Prompts/README.md` | Dev documentation |
| `.github/workflows/` | CI/CD (users don't need this) |
| `.claude/settings.local.json` | Local settings |
| `README.md` (GitHub) | Dev repo README (different from user README) |

---

## User Experience

### New Installation Flow (Clone)

```bash
# Option 1: Clone to new project
git clone https://github.com/scooter-indie/author-nonfiction-dist.git my-book
cd my-book
claude
# Say: execute configure.md

# Option 2: Clone specific version
git clone --branch v0.13.14 https://github.com/scooter-indie/author-nonfiction-dist.git my-book
```

### Update Flow (Pull)

```bash
# Before updating
git stash  # Save any local changes to framework files (rare)

# Update framework
git pull upstream main

# Or update to specific version
git fetch upstream --tags
git checkout v0.13.14

# After updating
git stash pop  # Restore local changes if any
```

---

## Technical Implementation

### 1. Create Deployment Repository

**One-time setup:**

```bash
# Create new repo on GitHub: scooter-indie/author-nonfiction-dist
# Settings:
#   - Public repository
#   - No wiki, no issues (point to main repo)
#   - Description: "AI-Assisted Nonfiction Authoring Framework - Distribution"
```

### 2. Create New Deployment Workflow (Phased Approach)

**Strategy:** Keep existing `release.yml` during transition, add new `deploy-dist.yml` workflow.

#### Phase 1: Add `deploy-dist.yml` (runs alongside existing workflow)

**File:** `.github/workflows/deploy-dist.yml` (NEW)

```yaml
name: Deploy to Distribution Repo

on:
  release:
    types: [published]

permissions:
  contents: read

jobs:
  deploy-dist:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Extract version
        id: version
        run: |
          VERSION=${GITHUB_REF#refs/tags/v}
          echo "version=$VERSION" >> $GITHUB_OUTPUT

      - name: Build release files
        run: |
          mkdir -p build/temp

          # Copy framework directories
          cp -r Process .claude scripts build/temp/

          # Copy root files
          cp INSTALLATION.md CHANGELOG.md CLAUDE.md configure.md system-instructions.md build/temp/
          cp .nonfiction-migrations.json build/temp/
          cp Process/Templates/gitignore_template build/temp/.gitignore

          # Remove dev-only files
          cd build/temp
          find . -name "*_chg.md" -delete
          rm -f Process/Prompts/Prompt_99_Build_Release.md
          rm -f Process/Prompts/README.md
          rm -rf Proposal/

      - name: Push to deployment repo
        env:
          DEPLOY_TOKEN: ${{ secrets.DEPLOY_REPO_TOKEN }}
        run: |
          git clone https://x-access-token:${DEPLOY_TOKEN}@github.com/scooter-indie/author-nonfiction-dist.git deploy-repo

          cd deploy-repo
          # Remove all files except .git
          find . -maxdepth 1 ! -name '.git' ! -name '.' -exec rm -rf {} +

          # Copy release files
          cp -r ../build/temp/* .

          # Commit and push
          git config user.name "GitHub Actions"
          git config user.email "actions@github.com"
          git add -A
          git commit -m "Release v${{ steps.version.outputs.version }}" || echo "No changes"
          git tag "v${{ steps.version.outputs.version }}"
          git push origin main --tags

      - name: Summary
        run: |
          echo "✅ Deployed v${{ steps.version.outputs.version }} to distribution repo"
          echo "📦 Clone: git clone https://github.com/scooter-indie/author-nonfiction-dist.git"
```

**Trigger:** Runs when a GitHub Release is published (after `release.yml` completes)

#### Phase 2: Update `release.yml` (after dist workflow is validated)

Modify existing workflow to update release notes with clone instructions:

**File:** `.github/workflows/release.yml` (MODIFY - add to release notes)

```yaml
      # In the "Generate release notes" step, add:
      echo "" >> release-notes-temp.md
      echo "### Option C: Git Clone (Recommended)" >> release-notes-temp.md
      echo "" >> release-notes-temp.md
      echo "\`\`\`bash" >> release-notes-temp.md
      echo "git clone https://github.com/scooter-indie/author-nonfiction-dist.git my-book" >> release-notes-temp.md
      echo "cd my-book" >> release-notes-temp.md
      echo "claude" >> release-notes-temp.md
      echo "# Say: execute configure.md" >> release-notes-temp.md
      echo "\`\`\`" >> release-notes-temp.md
```

#### Phase 3: Remove zip from `release.yml` (once clone is proven)

After sufficient validation (e.g., 2-3 releases), update `release.yml`:
- Remove zip creation steps
- Remove checksum calculation
- Remove zip upload to release
- Keep only release notes pointing to clone instructions

**Final `release.yml`:**

```yaml
name: Release Framework

on:
  push:
    tags:
      - 'v*.*.*'

permissions:
  contents: write

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Extract version
        id: version
        run: |
          VERSION=${GITHUB_REF#refs/tags/v}
          echo "version=$VERSION" >> $GITHUB_OUTPUT

      - name: Verify version matches files
        run: |
          VERSION=${{ steps.version.outputs.version }}
          FILE_VERSION=$(grep -m 1 "^\*\*Version:\*\*" Documentation/AI-Assisted_Nonfiction_Authoring_Process.md | sed 's/.*Version:\*\* //')
          if [ "$VERSION" != "$FILE_VERSION" ]; then
            echo "ERROR: Version mismatch! Tag: $VERSION, File: $FILE_VERSION"
            exit 1
          fi

      - name: Generate release notes
        run: |
          VERSION=${{ steps.version.outputs.version }}
          sed -n "/## \[$VERSION\]/,/^## \[/p" CHANGELOG.md | sed '$ d' > release-notes-temp.md

          cat >> release-notes-temp.md <<EOF

---

## 📥 Installation

\`\`\`bash
git clone https://github.com/scooter-indie/author-nonfiction-dist.git my-book
cd my-book
claude
# Say: execute configure.md
\`\`\`

See [CHANGELOG.md](https://github.com/scooter-indie/author-nonfiction-dist/blob/main/CHANGELOG.md) for details.

**Support:** https://github.com/${{ github.repository }}/issues
EOF

      - name: Create GitHub Release
        uses: softprops/action-gh-release@v2
        with:
          tag_name: v${{ steps.version.outputs.version }}
          name: Nonfiction Framework v${{ steps.version.outputs.version }}
          body_path: release-notes-temp.md
          draft: false
          prerelease: false

  # Trigger deployment to dist repo
  deploy:
    needs: release
    uses: ./.github/workflows/deploy-dist.yml
```

**Phased Transition Timeline:**

| Phase | Action | When |
|-------|--------|------|
| Phase 1 | Add `deploy-dist.yml`, keep zip workflow | Immediate |
| Phase 2 | Add clone option to release notes | Next release |
| Phase 3 | Remove zip from workflow | After 2-3 successful releases |

**Benefits of phased approach:**
- Can test dist deployment without breaking existing workflow
- Users can use either method during transition
- Easy rollback if issues discovered
- Gradual migration reduces risk

### 3. Repository Configuration

**Deployment repo settings:**

| Setting | Value | Reason |
|---------|-------|--------|
| **Issues** | Disabled | Point to main repo |
| **Wiki** | Disabled | Point to main repo |
| **Discussions** | Disabled | Point to main repo |
| **Projects** | Disabled | Point to main repo |
| **Actions** | Disabled | Updates come from main repo |

**README.md for deployment repo:**

```markdown
# AI-Assisted Nonfiction Authoring Framework

**This is the distribution repository.** Clone this repo to start using the framework.

## Quick Start

\`\`\`bash
git clone https://github.com/scooter-indie/author-nonfiction-dist.git my-book
cd my-book
claude
# Say: execute configure.md
\`\`\`

## Documentation & Support

- **Full Documentation:** [Main Repository](https://github.com/scooter-indie/author-nonfiction)
- **Issues & Bugs:** [Report Issues](https://github.com/scooter-indie/author-nonfiction/issues)
- **Releases:** [Release Notes](https://github.com/scooter-indie/author-nonfiction/releases)

## Updates

To update the framework:

\`\`\`bash
git pull origin main
\`\`\`

---

**Version:** 0.13.14 | [Changelog](CHANGELOG.md)
```

### 4. Secrets Required

| Secret | Purpose |
|--------|---------|
| `DEPLOY_REPO_TOKEN` | Personal Access Token with `repo` scope to push to deployment repo |

---

## Manifest Updates

The manifest template should be updated to reference both repos:

**File:** `Process/Templates/manifest_template.json`

```json
{
  "framework": "AI-Assisted Nonfiction Authoring",
  "frameworkVersion": "{{VERSION}}",
  "installedVersion": null,
  "installedDate": null,
  "releaseDate": "{{RELEASE_DATE}}",
  "releaseUrl": "https://github.com/scooter-indie/author-nonfiction/releases/tag/v{{VERSION}}",
  "distributionRepo": "https://github.com/scooter-indie/author-nonfiction-dist",
  "sourceRepo": "https://github.com/scooter-indie/author-nonfiction",
  "updateHistory": [],
  "appliedMigrations": []
}
```

---

## Documentation Updates

### INSTALLATION.md - Complete Rewrite

The installation guide becomes much simpler with clone-only distribution:

```markdown
# Installation Guide

## Quick Start

\`\`\`bash
git clone https://github.com/scooter-indie/author-nonfiction-dist.git my-book
cd my-book
claude
# Say: execute configure.md
\`\`\`

## Prerequisites

1. **Git** - Download from [git-scm.com](https://git-scm.com/)
2. **Claude Code CLI** - Download from [Claude Code](https://claude.com/claude-code)
   - Or **Claude Desktop** with MCP Filesystem configured

## Installation Steps

### Step 1: Clone the Framework

\`\`\`bash
git clone https://github.com/scooter-indie/author-nonfiction-dist.git my-book
\`\`\`

Replace `my-book` with your desired project folder name.

### Step 2: Run Configuration

**Claude Code CLI:**
\`\`\`bash
cd my-book
claude
# Say: execute configure.md
\`\`\`

**Claude Desktop:**
1. Configure MCP Filesystem with access to your project directory
2. In chat: `execute "[full-path]/configure.md"`

### Step 3: Initialize Your Book

After configuration completes:
- Say: `execute Prompt 1`
- Follow the interactive setup

## Updating the Framework

\`\`\`bash
cd my-book
git pull upstream main
\`\`\`

## Specific Version

To use a specific version:
\`\`\`bash
git clone --branch v0.13.14 https://github.com/scooter-indie/author-nonfiction-dist.git my-book
\`\`\`
```

**Removed:** All zip extraction instructions, troubleshooting for extraction errors.

### PREPARE_RELEASE.md Changes

The maintainer release checklist needs significant updates:

**Step 7: Monitor GitHub Actions** - Update to check dist repo push:
```bash
# Watch workflow execution
gh run list --limit 1

# If successful, verify dist repo updated
gh api repos/scooter-indie/author-nonfiction-dist/commits/main --jq '.sha[:7]'

# Verify tag created in dist repo
gh api repos/scooter-indie/author-nonfiction-dist/tags --jq '.[0].name'
```

**Step 8: Verify Release Assets** - Replace zip verification:
```markdown
Check that the release includes:
- ✅ Release page created on GitHub (dev repo)
- ✅ Dist repo updated with new files
- ✅ Version tag created in dist repo
- ✅ Changelog updated in dist repo
- ✅ Release notes point to clone instructions

Verify dist repo:
```bash
# Check dist repo has correct version
curl -s https://raw.githubusercontent.com/scooter-indie/author-nonfiction-dist/main/CLAUDE.md | grep "Framework Version"

# Verify file count is reasonable
gh api repos/scooter-indie/author-nonfiction-dist/git/trees/main?recursive=1 --jq '.tree | length'
```
```

**Remove these sections entirely:**
- SHA256 checksum references
- `nonfiction-vX.X.X.zip` filename references
- Zip download link updates in README.md
- Zip extraction instructions in INSTALLATION.md

**Update Rollback Procedure:**
```bash
# Delete bad release from dev repo
gh release delete vX.X.X -y
git push origin :refs/tags/vX.X.X
git tag -d vX.X.X

# Revert dist repo to previous version
cd /tmp
git clone https://github.com/scooter-indie/author-nonfiction-dist.git
cd author-nonfiction-dist
git revert HEAD --no-edit
git push origin main
git tag -d vX.X.X
git push origin :refs/tags/vX.X.X
```

**Simplification gains:**
- Remove ~50 lines of zip-related instructions
- Simpler verification (check dist repo, not zip contents)
- Faster release process (no zip creation/upload)

### CLAUDE.md Changes

Update support section to reference both repos:

```markdown
## Support

- **Distribution Repo (clone this):** https://github.com/scooter-indie/author-nonfiction-dist
- **Development Repo:** https://github.com/scooter-indie/author-nonfiction
- **Issues/Bugs:** https://github.com/scooter-indie/author-nonfiction/issues
- **Releases:** https://github.com/scooter-indie/author-nonfiction/releases
```

---

## Version Tagging Strategy

Both repositories will have matching version tags:

| Event | Main Repo | Dist Repo |
|-------|-----------|-----------|
| Release v0.13.14 | Tag `v0.13.14` | Tag `v0.13.14` |
| Release v0.14.0 | Tag `v0.14.0` | Tag `v0.14.0` |

Users can checkout specific versions:

```bash
git checkout v0.13.14
```

---

## Update Notification

### How Users Know Updates Are Available

**Option A: Check on `/fw-init` (Recommended)**

Add version check to the `/fw-init` command:

```bash
# In fw-init, after loading FRAMEWORK_CORE.md:

# Skip update check on development system (has Proposal/ directory)
if [ -d "Proposal" ]; then
  # Development system - don't check for updates
  :
else
  # User installation - check for updates
  git fetch upstream --tags --quiet 2>/dev/null

  LOCAL_VERSION=$(grep "frameworkVersion" .config/manifest.json | grep -oP '\d+\.\d+\.\d+')
  REMOTE_VERSION=$(git describe --tags --abbrev=0 upstream/main 2>/dev/null | sed 's/^v//')

  if [ "$LOCAL_VERSION" != "$REMOTE_VERSION" ]; then
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "⬆️  Framework Update Available: v$REMOTE_VERSION"
    echo "   Your version: v$LOCAL_VERSION"
    echo ""
    echo "   To update: git pull upstream main"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  fi
fi
```

**Development system detection:** The `Proposal/` directory only exists in the development repository, not in user installations (it's excluded from the dist repo). This allows `/fw-init` to skip update checks when running on the dev system.

**Pros:**
- Automatic check at every session start
- Non-blocking (just shows message)
- User decides when to update

**Cons:**
- Requires network access
- Small delay on startup (~1-2 seconds)

**Option B: Manual Check Command**

Add a slash command `/check-updates`:

```
/check-updates

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Framework Version Check
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Installed: v0.13.14
Latest:    v0.14.0

Update available! Run: git pull upstream main
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Pros:**
- No startup delay
- User controls when to check

**Cons:**
- Users must remember to check

**Option C: GitHub Watch Notifications**

Instruct users to "Watch" the dist repo for releases:

1. Go to https://github.com/scooter-indie/author-nonfiction-dist
2. Click "Watch" → "Custom" → Check "Releases"
3. Receive email when new version is published

**Pros:**
- No framework changes needed
- Works even when not using the framework

**Cons:**
- Requires GitHub account
- Easy to miss among other notifications

**Option D: Claude Desktop via system-instructions.md**

Add version check instructions to `system-instructions.md`:

```markdown
## Session Startup - Version Check

At the start of each session, after loading PROJECT_CONTEXT.md:

1. Read `.config/manifest.json` to get `frameworkVersion`
2. Fetch the latest version from:
   https://raw.githubusercontent.com/scooter-indie/author-nonfiction-dist/main/.config/manifest.json
3. Compare versions
4. If update available, show:

   ⬆️  Framework Update Available!
   Your version: v0.13.14
   Latest: v0.14.0

   To update, run in your terminal:
   ```
   cd [project-path]
   git pull upstream main
   ```
```

**Pros:**
- Works in Claude Desktop (no bash required)
- Uses existing MCP Filesystem + WebFetch
- Consistent experience across CLI and Desktop

**Cons:**
- Requires WebFetch tool availability
- Adds ~2-3 seconds to session start
- User must copy/paste git command to terminal

### Recommendation

**Implement all four methods:**
- **Option A:** `/fw-init` check (Claude Code CLI - automatic)
- **Option B:** `/check-updates` command (Claude Code CLI - manual)
- **Option C:** GitHub Watch (external - optional)
- **Option D:** `system-instructions.md` check (Claude Desktop - automatic)

### Update Banner Example

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Framework Initialization Complete (v0.13.14)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⬆️  UPDATE AVAILABLE: v0.14.0 (you have v0.13.14)
    To update: git pull upstream main
    Changelog: https://github.com/.../CHANGELOG.md

Framework Version: 0.13.14
...rest of init output...
```

---

## User Considerations

### Git Remote After Clone

When users clone the dist repo, `origin` points to the dist repo:

```bash
$ git remote -v
origin  https://github.com/scooter-indie/author-nonfiction-dist.git (fetch)
origin  https://github.com/scooter-indie/author-nonfiction-dist.git (push)
```

**configure.md should:**
1. Rename `origin` to `upstream` (framework updates)
2. Ask user to add their own `origin` for their book project (optional)

```bash
# In configure.md
git remote rename origin upstream
# User can later add: git remote add origin https://github.com/user/my-book.git
```

### Tracking Framework vs Book Content

After clone, users work in the same directory for both framework and book content:

```
my-book/
├── Process/          # Framework (tracked in upstream)
├── Manuscript/       # User content (created by Prompt 1)
├── .git/             # Single git repo
└── ...
```

**Option A: Single repo (simpler)**
- User's book and framework in same repo
- `git pull upstream main` for framework updates
- User pushes their book to their own `origin`

**Option B: Git submodule (cleaner separation)**
- Framework as submodule
- More complex, probably overkill

**Recommendation:** Option A (single repo) for simplicity.

---

## Alternative Approaches Considered

### 1. Keep Zip Distribution (Current State)

**Approach:** Continue distributing via zip files from GitHub Releases.

**Pros:**
- Already implemented
- Works without git knowledge

**Cons:**
- Extraction errors are common (wrong directory, nested folders)
- No update tracking
- Must re-download entire framework for any update
- More complex release workflow (zip creation, checksums)

**Decision:** Eliminated in favor of clone-only distribution.

### 2. GitHub Template Repository

**Approach:** Make dist repo a "template" that users can "Use this template" to create their own repo.

**Pros:**
- One-click creation on GitHub
- Clean new repo with no upstream connection

**Cons:**
- No easy way to pull framework updates
- Breaks the update workflow
- GitHub-specific (no CLI support)

**Decision:** Not recommended as primary method.

### 3. npm/pip Package

**Approach:** Distribute as npm or pip package.

**Pros:**
- Standard package manager workflow
- Easy updates (`npm update`)

**Cons:**
- Not a code package - it's a file structure
- Overkill for this use case
- Adds dependency on npm/pip

**Decision:** Not recommended.

### 4. Keep Single Repo with Branches

**Approach:** Use `main` for development, `release` branch for distribution.

**Pros:**
- Single repo to manage
- No cross-repo sync needed

**Cons:**
- Users might clone wrong branch
- Confusing for users seeing dev files in main
- Branch management overhead

**Decision:** Separate repo is cleaner.

---

## Implementation Checklist

**IMPORTANT:** When user approves this proposal, Claude Code performs all implementation work directly. User only needs to:
1. Approve the proposal
2. Provide GitHub PAT when prompted (for cross-repo push)
3. Confirm any destructive operations

Claude Code will execute all file edits, git commands, and GitHub CLI operations.

### Phase 1: Repository Setup

**Claude Code executes:**
```bash
# Create dist repo
gh repo create scooter-indie/author-nonfiction-dist --public \
  --description "AI-Assisted Nonfiction Authoring Framework - Distribution"

# Configure repo settings
gh repo edit scooter-indie/author-nonfiction-dist \
  --enable-issues=false \
  --enable-wiki=false \
  --enable-discussions=false
```

**User action required:**
```
Claude: "I need a Personal Access Token with 'repo' scope to push to the dist repo.

        1. Go to: https://github.com/settings/tokens/new
        2. Name: 'nonfiction-dist-deploy'
        3. Scope: Check 'repo' (full control)
        4. Generate and paste the token here (I won't store it)"

User: [pastes token]

Claude: [adds secret to repo]
gh secret set DEPLOY_REPO_TOKEN --body "[token]"
```

- [ ] Create `author-nonfiction-dist` repository on GitHub
- [ ] Configure repository settings (disable issues, wiki, etc.)
- [ ] Create initial README.md for dist repo
- [ ] Generate Personal Access Token for deployment
- [ ] Add `DEPLOY_REPO_TOKEN` secret to main repo

### Phase 2: Add Deployment Workflow (Phased - keeps existing zip workflow)

**GitHub Issue:** #70

**Claude Code executes:**
- Create new `.github/workflows/deploy-dist.yml` file
- No changes to existing `release.yml` yet
- No user action required

- [ ] Create `.github/workflows/deploy-dist.yml` (new workflow)
- [ ] Workflow triggers on `release: [published]` event
- [ ] Test deployment with next release (zip + dist both created)
- [ ] Verify dist repo receives correct files

### Phase 2b: Update Release Notes (after dist workflow validated)

**GitHub Issue:** #71

**Claude Code executes:**
- Modify `.github/workflows/release.yml` to add clone option to release notes
- Keep zip creation for now

- [ ] Add "Option C: Git Clone" to release notes template
- [ ] Position clone as recommended option

### Phase 2c: Remove Zip Workflow (after 2-3 successful releases)

**GitHub Issue:** #72

**Claude Code executes:**
- Modify `.github/workflows/release.yml` to remove zip steps
- No user action required

- [ ] Remove zip creation steps from `release.yml`
- [ ] Remove checksum calculation
- [ ] Remove zip upload to release
- [ ] Update release notes to show clone-only instructions
- [ ] Optionally: call `deploy-dist.yml` from `release.yml` as reusable workflow

### Phase 3: Documentation Updates

**Claude Code executes:**
- Edit all files directly using Edit tool
- No user action required

- [ ] Rewrite `INSTALLATION.md` (remove all zip instructions)
- [ ] Update `CLAUDE.md` with dist repo as primary link
- [ ] Update `configure.md` to handle remote rename (origin → upstream)
- [ ] Update manifest template with new fields
- [ ] Update release notes template
- [ ] Update `PREPARE_RELEASE.md`:
  - [ ] Remove zip verification steps
  - [ ] Remove checksum references
  - [ ] Add dist repo verification commands
  - [ ] Update rollback procedure for dist repo
  - [ ] Remove zip filename references from version update list
- [ ] Update `README.md` (dev repo) - change download instructions to clone

### Phase 3b: Update Notification

**Claude Code executes:**
- Edit `.claude/commands/fw-init.md` directly
- Create `.claude/commands/check-updates.md`
- Edit `system-instructions.md` directly
- No user action required

- [ ] Add version check to `/fw-init` (git fetch + compare)
- [ ] Create `/check-updates` slash command
- [ ] Add version check to `system-instructions.md` (MCP + WebFetch)
- [ ] Document GitHub Watch option in INSTALLATION.md

### Phase 4: Testing

**Claude Code executes:**
- Run test commands via Bash tool
- Report results to user
- User confirms tests pass

```bash
# Test clone
cd /tmp && git clone https://github.com/scooter-indie/author-nonfiction-dist.git test-clone

# Verify files
ls test-clone/Process/Prompts/ | wc -l  # Should be ~30+ files

# Verify no dev files
ls test-clone/Documentation 2>&1  # Should fail (not exist)
ls test-clone/Proposal 2>&1       # Should fail (not exist)

# Test version check
cd test-clone && git fetch upstream --tags
```

- [ ] Test fresh clone installation
- [ ] Test `git pull upstream main` update workflow
- [ ] Test version checkout (`git checkout v0.13.14`)
- [ ] Verify dist repo has correct files (no dev files)
- [ ] Verify remote rename works in configure.md
- [ ] Test update notification in `/fw-init` (when update available)
- [ ] Test `/check-updates` command
- [ ] Test Claude Desktop version check (system-instructions.md)

### Phase 5: Release

**Claude Code executes:**
- Update repo descriptions via `gh repo edit`
- Commit all changes
- User confirms ready to release

- [ ] Announce clone-only distribution in release notes
- [ ] Update GitHub repo descriptions
- [ ] Archive/remove old zip releases (optional)

---

## Open Questions

1. **Remote naming:** Should `configure.md` automatically rename `origin` to `upstream`?
   - **Recommendation: Yes** - Clear separation (upstream = framework, origin = user's repo)
   - Users expect to push their book to their own repo

2. **Shallow clones:** Should we recommend `--depth 1` for smaller downloads?
   - Pro: Faster initial clone (~50% smaller)
   - Con: Can't easily checkout older versions
   - **Recommendation:** Don't recommend by default, mention as option for slow connections

3. **Branch protection:** Should dist repo main branch be protected?
   - **Recommendation: Yes** - Prevents accidental pushes, only Actions can push

4. **Old releases:** Should we keep old zip releases or archive them?
   - Users can still get old versions via `git checkout v0.x.x`
   - **Recommendation:** Keep for historical reference, mark as "deprecated"

---

## Success Metrics

| Metric | Target |
|--------|--------|
| Installation success rate | 95%+ (vs ~70% with zip extraction) |
| Support tickets for installation | Reduced by 90% |
| Time to first prompt execution | Under 5 minutes |
| Framework update adoption | 80%+ on latest within 30 days |

---

## Conclusion

Eliminating zip distribution in favor of a dedicated deployment repository provides:

1. **Simpler installation** - `git clone` is one command, no extraction errors
2. **Easy updates** - `git pull upstream main` gets latest framework
3. **Version control** - Users can checkout any version, see history
4. **Clear separation** - Dev repo for maintainers, dist repo for users
5. **Reduced maintenance** - No zip creation, no checksum management
6. **Better UX** - Familiar git workflow for developers

The implementation simplifies the release workflow while providing a better experience for users.

---

**Proposal Version:** 1.8
**Author:** Claude (Opus 4.5)
**Changes:**
- v1.1 - Eliminated zip workflow entirely per user feedback
- v1.2 - Added Update Notification section (fw-init check, /check-updates command)
- v1.3 - Added Claude Desktop update check via system-instructions.md (WebFetch)
- v1.4 - Added PREPARE_RELEASE.md update requirements
- v1.5 - Clarified Claude Code performs all implementation (user only approves + provides PAT)
- v1.6 - Skip update check on development system (detect via Proposal/ directory)
- v1.7 - Phased workflow approach: new `deploy-dist.yml` runs alongside existing `release.yml`, gradual transition over 2-3 releases
- v1.8 - Created sub-issues for workflow phases (#70, #71, #72)
