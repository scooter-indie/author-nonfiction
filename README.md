# AI-Assisted Nonfiction Book Authoring Process

**Version:** 3.3.0
**Purpose:** A comprehensive, systematic framework for authoring nonfiction books with AI assistance using Git version control

---

## Overview

This repository contains the **process framework** for AI-assisted nonfiction book authoring. It provides:

- 9 conversational Execute prompts for different authoring tasks
- Comprehensive directory structure and file naming conventions
- Change tracking system with auto-archive workflow
- Quote/epigraph management with verification tracking
- Anti-hallucination guidelines for AI assistants
- Git-based version control workflow
- Quality control and consistency checking

---

## Getting Started

### For Book Authors

**To start a new book using this process:**

1. **Clone this repository** to create your book project:
   ```bash
   git clone https://github.com/scooter-indie/author-nonfiction.git my-book-title
   cd my-book-title
   ```

2. **Remove the original remote** (disconnect from process framework repo):
   ```bash
   git remote remove origin
   ```

3. **Create your book's repository** on GitHub/GitLab/Bitbucket (private recommended)

4. **Add your book's remote**:
   ```bash
   git remote add origin https://github.com/YOUR-USERNAME/your-book-repo.git
   git push -u origin main --tags
   ```

5. **Initialize your book project**:
   - Open Claude Code
   - Copy `Process/Prompts/Prompt_1_Initialize.md`
   - Paste into Claude Code
   - Follow the interactive prompts

6. **Start writing!**
   - See `Process/Prompts/README.md` for workflow guides
   - See `Process/AI-Assisted_Nonfiction_Authoring_Process.md` for comprehensive documentation
   - See `Process/USAGE_GUIDE.md` (generated during initialization) for your project-specific guide

---

## Repository Structure

```
author-nonfiction/
├── README.md                           # This file
├── Process/                            # Process framework (kept in your book repo)
│   ├── AI-Assisted_Nonfiction_Authoring_Process.md
│   ├── Anti-Hallucination_Guidelines.md
│   ├── Prompts/
│   │   ├── README.md                  # Prompt usage guide
│   │   ├── QUICK_REFERENCE.md
│   │   ├── Prompt_1_Initialize.md     # Start here!
│   │   ├── Prompt_2_Add_Chapter.md
│   │   ├── Prompt_3_Modify_File.md
│   │   ├── Prompt_4_Integrate_Inbox.md
│   │   ├── Prompt_5_Compile.md
│   │   ├── Prompt_6_Consistency.md
│   │   ├── Prompt_7_Export.md
│   │   ├── Prompt_8_Dashboard.md
│   │   └── Prompt_9_Git.md
│   ├── Templates/
│   │   ├── Chapter_Quotes_Template.md
│   │   └── Chapter_Quotes_chg_Template.md
│   └── Archive/
│       └── Old_Prompts_2025-11-17/
│
└── [Your book content will be created here by Prompt 1]
    ├── Project_Config.md
    ├── Project_Metadata.md
    ├── USAGE_GUIDE.md
    ├── TOC/
    ├── Chapters/
    ├── FrontMatter/
    ├── BackMatter/
    ├── Quotes/
    ├── Assets/
    ├── Research/
    ├── Inbox/
    └── Drafts/
```

---

## Keeping Process Framework Up to Date

### Problem: Process Framework Updates

The `Process/` directory in your book repository is a **snapshot** of the process framework at the time you cloned it. If this framework repository (`scooter-indie/author-nonfiction`) receives updates (bug fixes, new features, improved prompts), you'll want to pull those updates into your book project.

### Solution: Update Process Files

**Method 1: Manual File Replacement (Recommended)**

1. **Check for updates** to the framework:
   ```bash
   # In a separate directory, clone the latest framework
   cd /tmp
   git clone https://github.com/scooter-indie/author-nonfiction.git framework-latest
   cd framework-latest
   git log --oneline -10  # Check recent changes
   ```

2. **Review what changed**:
   ```bash
   # Compare your Process/ directory with latest
   diff -r /path/to/your-book/Process /tmp/framework-latest/Process
   ```

3. **Selectively update files** you want:
   ```bash
   # Copy specific updated files to your book repo
   cp /tmp/framework-latest/Process/Prompts/Prompt_3_Modify_File.md \
      /path/to/your-book/Process/Prompts/

   # Or update entire Prompts directory
   cp -r /tmp/framework-latest/Process/Prompts/* \
      /path/to/your-book/Process/Prompts/
   ```

4. **Commit the updates** to your book repo:
   ```bash
   cd /path/to/your-book
   git add Process/
   git commit -m "Update process framework to v3.4.0 from upstream"
   git push
   ```

**Method 2: Git Remote Tracking (Advanced)**

If you want to track framework updates via git:

1. **Add framework repo as upstream remote**:
   ```bash
   cd /path/to/your-book
   git remote add upstream https://github.com/scooter-indie/author-nonfiction.git
   git fetch upstream
   ```

2. **Create a branch to test updates**:
   ```bash
   git checkout -b update-process-framework
   ```

3. **Selectively merge Process/ directory changes**:
   ```bash
   # Check out specific files from upstream
   git checkout upstream/main -- Process/Prompts/Prompt_3_Modify_File.md
   git checkout upstream/main -- Process/AI-Assisted_Nonfiction_Authoring_Process.md

   # Or merge entire Process directory (may have conflicts)
   git checkout upstream/main -- Process/
   ```

4. **Review and test** the changes with your book content

5. **Merge to main** if everything works:
   ```bash
   git checkout main
   git merge update-process-framework
   git push
   ```

**Method 3: Scripted Update (Future Enhancement)**

Future versions may include an update script:
```bash
./Process/Scripts/update-framework.sh
```

### What to Update vs. What to Keep

**Safe to update (won't affect your content):**
- `Process/Prompts/*.md` - Prompt files
- `Process/AI-Assisted_Nonfiction_Authoring_Process.md` - Process documentation
- `Process/Anti-Hallucination_Guidelines.md` - Guidelines
- `Process/Templates/*.md` - Templates (your content uses instances, not templates)

**Be careful with:**
- `Process/Prompts/README.md` - May have your custom notes
- Any files you've customized for your specific workflow

**Never update (your book-specific files):**
- `Project_Config.md` - Your book's configuration
- `Project_Metadata.md` - Your book's metadata
- `USAGE_GUIDE.md` - Your book's usage guide
- Everything outside `Process/` - Your actual book content

### Checking Framework Version

**Your current framework version:**
```bash
head -n 5 Process/AI-Assisted_Nonfiction_Authoring_Process.md | grep "Version:"
```

**Latest framework version:**
```bash
curl -s https://raw.githubusercontent.com/scooter-indie/author-nonfiction/main/Process/AI-Assisted_Nonfiction_Authoring_Process.md | head -n 5 | grep "Version:"
```

**Framework changelog:**
- See version history at bottom of `Process/AI-Assisted_Nonfiction_Authoring_Process.md`
- See release tags: https://github.com/scooter-indie/author-nonfiction/tags

---

## Two-Repository Workflow

You'll end up with **two separate repositories**:

### 1. Framework Repository (this one)
- **URL:** `https://github.com/scooter-indie/author-nonfiction`
- **Purpose:** Process framework, prompts, templates, guidelines
- **Updates:** New features, bug fixes, prompt improvements
- **You:** Pull updates when available (optional)

### 2. Your Book Repository
- **URL:** `https://github.com/YOUR-USERNAME/your-book-repo` (your choice)
- **Purpose:** Your actual book content and project files
- **Updates:** Your writing, revisions, chapter additions
- **You:** Push your book content here regularly

**Relationship:**
```
Framework Repo                Your Book Repo
(upstream)                    (your work)
    │                             │
    │  Clone initially            │
    ├──────────────────────────►  │
    │                             │
    │  Periodic updates            │
    │  (Process/ files only)       │
    ├──────────────────────────►  │
    │                             │
                                  │  Daily writing
                                  │  (all content files)
                                  ├─────────────► GitHub/GitLab
```

---

## Best Practices

### For Book Authors

1. **Commit frequently** - After each writing session
2. **Push to remote daily** - Your book content is precious
3. **Check for framework updates monthly** - New features and improvements
4. **Use branches** for experimental reorganizations
5. **Tag milestones** (first-draft, revised-draft, final)
6. **Keep Process/ directory** - You need it to use the prompts
7. **Don't modify Process/ files** unless you know what you're doing
8. **Use Prompt 8 (Dashboard) weekly** - Track your progress

### For Framework Contributors

1. **Version all changes** using semantic versioning
2. **Document in changelog** (Version History section)
3. **Test with sample book project** before releasing
4. **Avoid breaking changes** to prompt interfaces
5. **Keep prompts conversational** - No complex templates
6. **Reference Anti-Hallucination Guidelines** in all prompts

---

## Support and Documentation

- **Process Documentation:** `Process/AI-Assisted_Nonfiction_Authoring_Process.md`
- **Prompt Guide:** `Process/Prompts/README.md`
- **Quick Reference:** `Process/Prompts/QUICK_REFERENCE.md`
- **Anti-Hallucination Rules:** `Process/Anti-Hallucination_Guidelines.md`
- **Issues/Bugs:** https://github.com/scooter-indie/author-nonfiction/issues

---

## License

This process framework is designed to be cloned and customized for individual book projects. Use it freely for your nonfiction book authoring.

The framework itself and all Process/ documentation files may be updated periodically. Your book content remains yours.

---

## Version History

See `Process/AI-Assisted_Nonfiction_Authoring_Process.md` for detailed version history.

**Current Version:** 3.3.0
- v3.3.0: Refactored process document to eliminate duplication
- v3.2.0: Added quote management system with verification tracking
- v3.1.0: Execute-only prompts with _chg file workflow
- v3.0.0: Git-based version control, TOC import from Inbox

---

**Ready to start your book?** Copy `Process/Prompts/Prompt_1_Initialize.md` into Claude Code and begin!
