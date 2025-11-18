# Nonfiction Framework Installer

**Version:** {{VERSION}}
**Release Date:** {{RELEASE_DATE}}

**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`

---

## What This Does

I will install or update the AI-Assisted Nonfiction Authoring Framework in your project.

**New Installation:**
- Extract framework files
- Initialize git repository
- Connect to your remote repository
- Push initial framework
- Launch Prompt 1 (Initialize) to set up your book project
- Clean up installer files

**Update Installation:**
- Detect existing installation via `.nonfiction-manifest.json`
- Extract updated framework files (replaces old Process/ directory)
- Update manifest with new version
- Commit framework update to git
- Show changelog of what changed
- Clean up installer files

---

## Prerequisites

### For New Projects:
- You have created an **empty** remote git repository (GitHub, GitLab, or Bitbucket)
- You have the remote repository URL ready (e.g., `https://github.com/username/my-book.git`)
- You have downloaded `nonfiction-v{{VERSION}}.zip` to your project directory
- You have downloaded this `installer.md` file to the same directory

### For Updates:
- Your current work is committed to git (run `git status` to verify)
- You have downloaded `nonfiction-v{{VERSION}}.zip` to your project root
- You have downloaded this `installer.md` file to the same directory

---

## Installation Mode Detection

I will:

1. **Check for `.nonfiction-manifest.json`**
   - If found → **Update Mode**
   - If not found → **New Installation Mode**

2. **Execute appropriate workflow**

---

## New Installation Workflow

### Step 1: Verify Prerequisites

I will check:
- `nonfiction-v{{VERSION}}.zip` exists in current directory
- Current directory is suitable for a book project
- Git is available (`git --version`)

### Step 2: Extract Framework

I will:
1. Unzip `nonfiction-v{{VERSION}}.zip`
2. Extract all contents to current directory
3. Verify `.nonfiction-manifest.json` was created
4. Verify `Process/` directory exists
5. Verify `.claude/agents/book-writing-assistant.md` exists

### Step 3: Initialize Git Repository

I will:
1. Run `git init`
2. Create initial `.gitignore` (if not already present from zip)
3. Run `git add .`
4. Create initial commit: "Initialize nonfiction framework v{{VERSION}}"

### Step 4: Connect to Remote Repository

I will ask you:
- **"What is your remote repository URL?"**
  - Example: `https://github.com/username/my-book.git`
  - Example: `git@github.com:username/my-book.git`

Then I will:
1. Run `git remote add origin [your-url]`
2. Run `git push -u origin main`
3. Verify push succeeded

### Step 5: Clean Up Installer Files

I will:
1. Delete `nonfiction-v{{VERSION}}.zip`
2. Delete `installer.md` (this file)
3. Commit the cleanup: "Clean up installer files"
4. Push to remote

### Step 6: Launch Prompt 1 (Initialize)

I will:
1. Read `Process/Prompts/Prompt_1_Initialize.md`
2. Execute it automatically
3. This will ask you questions about your book:
   - Working title
   - Author name
   - Target word count
   - Target audience
   - Book purpose/thesis
   - Target completion date
   - Table of contents (from file or interactive)
   - Writing style selection

4. Create your complete book project structure:
   - `Project_Config.md`
   - `Project_Metadata.md`
   - `TOC/TOC.md`
   - `Chapters/` with placeholders
   - `FrontMatter/`
   - `BackMatter/`
   - `Quotes/`
   - `Style/Style_Guide.md`
   - And all corresponding `_chg.md` files

5. Commit everything and push to remote

### Step 7: Installation Complete

I will provide:
- Confirmation that framework v{{VERSION}} is installed
- Confirmation that your book project is initialized
- Next steps: Start writing with Prompt 3 (Modify File)
- Link to `Process/Prompts/QUICK_REFERENCE.md`

---

## Update Installation Workflow

### Step 1: Detect Current Version

I will:
1. Read `.nonfiction-manifest.json`
2. Extract current framework version
3. Compare with new version: {{VERSION}}
4. Confirm you want to proceed with update

### Step 2: Verify Git Status

I will:
1. Run `git status`
2. Check for uncommitted changes
3. If found, ask you to commit or stash first
4. If clean, proceed

### Step 3: Show Changelog

I will:
1. Fetch release notes from GitHub (if available)
2. Or read from `Process/AI-Assisted_Nonfiction_Authoring_Process_chg.md` in new zip
3. Display what's changed between your version and {{VERSION}}
4. Ask you to confirm update

### Step 4: Backup Current Framework (Git)

I will:
1. Create git commit of current state (if any uncommitted changes to Process/)
2. Git will track all changes when we extract new files

### Step 5: Extract Updated Framework

I will:
1. Unzip `nonfiction-v{{VERSION}}.zip`
2. Extract to current directory (overwrites old `Process/` directory)
3. Verify extraction succeeded
4. Verify new `.nonfiction-manifest.json` has correct version

### Step 6: Commit Update

I will:
1. Run `git status` to show what changed
2. Run `git add .nonfiction-manifest.json Process/ .claude/`
3. Create commit: "Update framework from v[old] to v{{VERSION}}"
4. Show commit summary

### Step 7: Review Changes

I will:
1. Show `git diff HEAD~1` for Process/ directory
2. Highlight major changes
3. Ask if you want to push now or review further

### Step 8: Clean Up Installer Files

I will:
1. Delete `nonfiction-v{{VERSION}}.zip`
2. Delete `installer.md` (this file)
3. Commit cleanup (if you chose to proceed)
4. Push to remote (if you confirmed)

### Step 9: Update Complete

I will provide:
- Confirmation of framework update
- Summary of what changed
- Recommendation: Run Prompt 6 (Consistency) to check for any issues
- Link to updated documentation

---

## Error Handling

### Common Errors and Solutions

**Error: `nonfiction-v{{VERSION}}.zip` not found**
- Solution: Download the zip file to the current directory

**Error: Git not installed**
- Solution: Install git from https://git-scm.com/

**Error: Remote repository not empty**
- Solution: Use a truly empty repository, or clone it first then run installer

**Error: Remote push failed (authentication)**
- Solution: Set up SSH key or use personal access token
- See: https://docs.github.com/en/authentication

**Error: Uncommitted changes during update**
- Solution: Commit your work first with `git commit -am "Save work before update"`

**Error: Unzip failed**
- Solution: Verify zip file is not corrupted, re-download if needed

---

## Post-Installation

### For New Installations:

**You now have:**
- Complete framework installed (Process/ directory)
- Book project initialized (Chapters/, TOC/, etc.)
- Git repository connected to remote
- All changes committed and pushed

**Next steps:**
1. Review `README.md` for overview
2. Read `Process/Prompts/QUICK_REFERENCE.md` for workflows
3. Start writing with Prompt 3 (Modify File)
4. Check progress weekly with Prompt 8 (Dashboard)

### For Updates:

**You now have:**
- Updated framework (Process/ directory v{{VERSION}})
- All book content preserved
- Changes tracked in git
- Ready to continue writing

**Next steps:**
1. Review what changed in the framework
2. Run Prompt 6 (Consistency) to check your book
3. Read updated `Process/Prompts/QUICK_REFERENCE.md` for new features
4. Continue your writing workflow

---

## Support

- **Documentation:** `Process/AI-Assisted_Nonfiction_Authoring_Process.md`
- **Quick Reference:** `Process/Prompts/QUICK_REFERENCE.md`
- **Issues/Bugs:** https://github.com/scooter-indie/author-nonfiction/issues
- **Releases:** https://github.com/scooter-indie/author-nonfiction/releases

---

## Ready to Install?

**I will now:**
1. Detect installation mode (new vs. update)
2. Execute the appropriate workflow
3. Ask necessary questions
4. Complete installation
5. Provide confirmation and next steps

**Shall I proceed with installation?**

---

*This installer is generated by Prompt 99: Build Release*
*Framework Version: {{VERSION}} | Release Date: {{RELEASE_DATE}}*
