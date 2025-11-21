# AI-Assisted Nonfiction Book Authoring Framework

**Version 0.12.5**

A complete system for writing professional nonfiction books with AI assistance using Claude Code.

---

## What Is This?

This is a **production-ready framework** for authoring nonfiction books with AI assistance. It provides structured workflows, version control integration, and intelligent prompts that help you write, organize, revise, and publish high-quality nonfiction content.

### Key Features

- 📝 **Structured Authoring Process** with change tracking and version history
- 🤖 **AI Assistance** through 16 conversational prompts
- 🎨 **Professional Writing Styles** - 9 curated styles plus custom style support
- 🖼️ **Visual Content Management** - Unified image system with text-based placeholders and professional images
- 📚 **Quote Management** with web search and verification system
- 🔍 **Quality Control** - Consistency checking and validation
- 📦 **Git Version Control** - Complete change tracking and backup
- 🚀 **Export Formats** - DOCX, PDF, EPUB for publication
- ✨ **Anti-Hallucination Guidelines** - Ensures AI accuracy and factual integrity

---

## Quick Start

### 1. Download the Framework

Download `nonfiction-v0.12.5.zip` from:

**GitHub Releases**: https://github.com/scooter-indie/author-nonfiction/releases/latest

Save it to your book project directory (e.g., `E:\Projects\my-book`).

### 2. Extract the Framework

Extract the zip file to your project directory:

**Windows**:
- Right-click `nonfiction-v0.12.5.zip` → "Extract All..."
- Choose your project directory as the destination

**macOS/Linux**:
```bash
cd /path/to/my-book
unzip nonfiction-v0.12.5.zip
```

### 3. Run Configuration

Start Claude in your project directory and execute:

```bash
cd E:\Projects\my-book
claude
```

Then execute the configuration:
```
execute configure.md
```

The configuration will:
- Set up git repository (if needed)
- Connect to remote repository (optional)
- Verify installation
- Guide you to start writing

### 4. Initialize Your Book

After configuration, execute:

```
Execute Prompt 1
```

This will ask you about your book and create the complete project structure.

### 5. Start Writing!

Use the framework's 16 prompts to write and manage your book:
- **Prompt 3**: Change by Chg (automated workflow from _chg files)
- **Prompt 4**: Interactive Change (conversational editing)
- **Prompt 8**: Check consistency
- **Prompt 10**: View progress dashboard
- **Prompt 7**: Compile full manuscript
- And more...

**See**: `Process/Prompts/QUICK_REFERENCE.md` for complete workflow guide

---

## Installation Guide

For detailed installation instructions including updates and troubleshooting, see:

**INSTALLATION.md** (included in the zip file)

---

## What's Included

After extraction, your project contains:

### Framework Files
- `Process/` - Framework documentation, prompts, templates
- `INSTALLATION.md` - Installation and update guide
- `CLAUDE.md` - Framework context for Claude Code
- `configure.md` - Configuration script
- `system-instructions.md` - For Claude Desktop integration
- `CHANGELOG.md` - Version history
- `.claude/agents/book-writing-assistant.md` - AI writing assistant

### Your Book (Created by Prompt 1)
- `Manuscript/Chapters/` - Your chapter files
- `Manuscript/_TOC_/` - Table of contents
- `Manuscript/FrontMatter/` - Copyright, preface, introduction, etc.
- `Manuscript/BackMatter/` - Appendices, bibliography, About Author, etc.
- `Manuscript/Quotes/` - Quote and epigraph management
- `Manuscript/Style/` - Writing style configuration and EPUB CSS
- `Manuscript/images/` - All visual assets (unified directory, v0.12.1+)
- `Manuscript/Drafts/` - Compiled manuscripts
- `Manuscript/Exports/` - Published formats
- `Project_Config.md` - Book metadata

---

## The 16 Core Prompts

Execute these prompts in Claude Code to manage your book:

### Prompt 1: Initialize Project
Create your book project structure with chapters, metadata, and configuration.

### Prompt 2: Add New Chapter
Insert a new chapter and automatically renumber existing chapters.

### Prompt 3: Change by Chg
**AUTOMATED WORKFLOW** - Execute instructions from _chg files with automatic archiving.

### Prompt 4: Interactive Change
**CONVERSATIONAL WORKFLOW** - Discuss changes interactively, AI writes instructions to _chg files.

### Prompt 5: Scan For User Edits
Detect manual edits and synchronize _chg files with version history.

### Prompt 6: Integrate Inbox Content
Process content from your Inbox/ directory into the book.

### Prompt 7: Compile Manuscript
Generate a single file containing your entire manuscript.

### Prompt 8: Consistency Checker
Check for terminology, timeline, and style consistency across all content.

### Prompt 9: Export and Format
Export to DOCX, PDF, EPUB, or LaTeX for publication.

### Prompt 10: Progress Dashboard
View comprehensive project metrics, word counts, and recommendations.

### Prompt 11: Style Manager
Manage hierarchical style system with book/chapter/section overrides.

### Prompt 12: Git Operations
Commit, tag, branch, push, and manage version control.

### Prompt 13: AI Detection Analysis
Analyze chapters for AI-generated text indicators and ensure authentic voice.

### Prompt 14: Citation Finder
Find and insert citations with WebSearch verification for factual accuracy.

### Prompt 15: Visual Content Suggester
Analyze chapters and create text-based visuals (tables, diagrams, flowcharts) in Manuscript/images/.

### Prompt 16: Image Manager
Add professional images, upgrade text-based visuals, scan existing images, and validate image references.

**Full Documentation**: `Process/Prompts/QUICK_REFERENCE.md`

---

## Writing Style System

The framework includes 9 professionally curated writing styles:

1. **Academic Authority** - Scholarly, research-based
2. **Conversational Expert** - Business/professional, accessible
3. **Narrative Storyteller** - Memoir-adjacent, first-person
4. **Business Professional** - Management/leadership focused
5. **Technical Precision** - Technical guides, systematic
6. **Investigative Journalist** - Evidence-based revelation
7. **Practical Guide** - How-to, step-by-step
8. **Inspirational Teacher** - Personal development, motivational
9. **Scientific Communicator** - Popular science, wonder with rigor

**Select your style during Prompt 1**, or create custom styles tailored to your voice.

**Style Library**: `Process/Style_Examples.md`

---

## How It Works

### Change Tracking System

Every content file has a corresponding `_chg.md` file for two workflows:

**Prompt 3 (Automated):**
1. **Write instructions** in the `_chg.md` file
2. **Commit to git**
3. **Execute Prompt 3**
4. **AI reads instructions** and modifies content
5. **AI archives instructions** to version history
6. **AI commits changes** to git

**Prompt 4 (Interactive):**
1. **Discuss changes** conversationally with AI
2. **AI writes instructions** to _chg.md file
3. **Optionally execute** Prompt 3 automatically

All changes are tracked with rationale, version numbers, and git history.

### Git Integration

All operations use git for version control:
- Automatic commits before major operations
- Descriptive commit messages with version info
- Tags for milestones (25%, 50%, 75%, 100%)
- Remote backup support (GitHub, GitLab, etc.)

### Anti-Hallucination Guidelines

**Critical rules** to prevent AI fabrication:
- Never fabricate quotes, statistics, or citations
- Mark uncertain content clearly
- Verify facts before stating them
- Use proper quote verification status (⏳/⚠/✓)
- Never guess attributions

**See**: `Process/Anti-Hallucination_Guidelines.md`

---

## Common Workflows

### Daily Writing Session
1. Start Claude Code → `configure.md` runs automatically (if configured)
2. Review dashboard: `Execute Prompt 10`
3. Write revision instructions in `_chg.md` files OR use interactive editing
4. Execute `Prompt 3` for each file (or use `Prompt 4` for interactive)
5. Commit and push: `Execute Prompt 12`

### Weekly Review
1. Check progress: `Prompt 10`
2. Run consistency check: `Prompt 8`
3. Compile manuscript: `Prompt 7`
4. Fix issues: `Prompt 3` or `Prompt 4`
5. Commit and push: `Prompt 12`

### Milestone Workflow
1. Verify progress: `Prompt 10`
2. Full consistency check: `Prompt 8`
3. AI detection analysis: `Prompt 13`
4. Fix all issues: `Prompt 3` or `Prompt 4`
5. Compile final version: `Prompt 7`
6. Create version tag: `Prompt 12`
7. Push with tags: `Prompt 12`

---

## Updating the Framework

To update to a newer framework version:

1. **Commit all your work**: `git commit -am "Save work before update"`
2. **Create backup** of your entire project directory
3. **Download new version**: `nonfiction-vX.X.X.zip`
4. **Extract with overwrite** to your project directory
5. **Run configuration**: `execute configure.md`
6. **Review changelog** displayed by configure script
7. **Check consistency**: `Execute Prompt 8`

Your book content is preserved - only framework files update.

---

## Optional: Claude Desktop Integration

You can use this framework with both Claude Code and Claude Desktop:

1. **Copy system instructions**:
   - Open `system-instructions.md` from your project
   - Copy entire contents

2. **Create Claude Desktop project**:
   - Open Claude Desktop
   - Create new project for your book
   - Paste system instructions into project settings

3. **Use both interfaces**:
   - **Claude Code**: File operations, git, automation
   - **Claude Desktop**: Conversational writing, brainstorming

---

## Documentation

### Essential Reading
- `INSTALLATION.md` - Installation and update guide
- `Process/Prompts/QUICK_REFERENCE.md` - Workflow quick reference
- `Process/Anti-Hallucination_Guidelines.md` - Critical accuracy rules

### Comprehensive Guides
- `Process/AI-Assisted_Nonfiction_Authoring_Process.md` - Complete framework documentation
- `Process/Style_Examples.md` - Writing style library with examples
- `CHANGELOG.md` - Version history and release notes

### Templates
- `Process/Templates/Style_Guide_Template.md` - Style configuration
- `Process/Templates/Custom_Styles_Template.md` - Custom style creation
- `Process/Templates/README_AUTHORS_template.md` - Author documentation

---

## Requirements

### Essential
- **Claude** (Claude Code CLI) - Download from https://claude.com/claude-code
  - Launch with `claude` command in your project directory

### Recommended
- **Git** - Version control (https://git-scm.com/)
  - Windows: `winget install Git.Git`
  - macOS: `brew install git`
  - Linux: `sudo apt install git`

### Optional
- **Claude Desktop** - For conversational interface (https://claude.ai/)
- **Pandoc** - For DOCX/PDF export (https://pandoc.org/)
- **LaTeX** - For advanced PDF formatting (https://www.latex-project.org/)

---

## Support

- **Issues/Bugs**: https://github.com/scooter-indie/author-nonfiction/issues
- **Releases**: https://github.com/scooter-indie/author-nonfiction/releases
- **Discussions**: https://github.com/scooter-indie/author-nonfiction/discussions

---

## License

This framework is released under the MIT License. See LICENSE file for details.

---

## About

**Framework Version**: 0.12.5
**Release Date**: 2025-11-21
**Repository**: https://github.com/scooter-indie/author-nonfiction

Created to empower authors to write professional nonfiction books with AI assistance while maintaining complete creative control and ensuring factual accuracy.

---

**Ready to write your book? Download the framework and get started!**

https://github.com/scooter-indie/author-nonfiction/releases/latest
