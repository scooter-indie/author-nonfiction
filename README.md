# AI-Assisted Nonfiction Book Authoring Framework

**Version:** 3.5.0
**A Complete System for Writing Professional Nonfiction Books with AI Assistance**

---

## What Is This?

This is a **production-ready framework** for authoring nonfiction books using AI assistance with Claude Code. It provides structured workflows, version control integration, and intelligent prompts that help you write, organize, revise, and publish high-quality nonfiction content.

Think of it as a **complete writing environment** that combines:
- 📝 Structured authoring process with change tracking
- 🤖 AI assistance through conversational prompts
- 🎨 Professional writing style system (9 curated styles)
- 📚 Quote/epigraph management with verification
- 🔍 Quality control and consistency checking
- 📦 Git-based version control
- 🚀 Export to publication formats (DOCX, PDF, EPUB)

---

## For Book Authors

**Ready to start writing your book?**

### Download and Install

1. **Visit Releases:** https://github.com/scooter-indie/author-nonfiction/releases
2. **Download:**
   - `nonfiction-v3.5.0.zip` (latest version)
   - `installer.md`
3. **Install:**
   - Place both files in your project directory
   - Open `installer.md` in Claude Code
   - Follow the prompts to set up your book project
4. **Start Writing:**
   - The installer will guide you through initialization
   - You'll configure your book details, structure, and writing style
   - Then you can start writing immediately

### What You Get

**10 Conversational Prompts:**
- **Prompt 1: Initialize** - Set up new book project
- **Prompt 2: Add Chapter** - Create new chapters
- **Prompt 3: Modify File** - Your daily revision tool
- **Prompt 4: Integrate Inbox** - Process drafted content
- **Prompt 5: Compile** - Generate full manuscript
- **Prompt 6: Consistency** - Find issues and errors
- **Prompt 7: Export** - Create DOCX/PDF/EPUB
- **Prompt 8: Dashboard** - Track your progress
- **Prompt 9: Git** - Version control operations
- **Prompt 10: Update Change Tracking** - Sync change files

**9 Professional Writing Styles:**
- Academic Authority
- Conversational Expert
- Narrative Storyteller
- Business Professional
- Technical Precision
- Investigative Journalist
- Practical Guide
- Inspirational Teacher
- Scientific Communicator

**Complete Support System:**
- Change tracking with version history
- Quote management with verification
- Git version control with auto-commits
- Anti-hallucination guidelines
- Style consistency checking
- Book-writing-assistant AI agent

### Documentation

Once installed, you'll have access to:
- **Quick Reference:** `Process/Prompts/QUICK_REFERENCE.md` - Common workflows
- **Complete Guide:** `Process/AI-Assisted_Nonfiction_Authoring_Process.md` - Full documentation
- **Style Library:** `Process/Style_Examples.md` - All writing styles
- **Author README:** `README.md` - Your getting started guide

---

## For Framework Developers

**Want to contribute or customize the framework?**

### Repository Structure

```
author-nonfiction/
├── README.md                           # This file
├── README_FRAMEWORK.md                 # Framework developer guide
├── .gitignore                          # Git ignore patterns
│
├── .claude/
│   └── agents/
│       └── book-writing-assistant.md   # AI writing assistant
│
├── Process/
│   ├── AI-Assisted_Nonfiction_Authoring_Process.md
│   ├── AI-Assisted_Nonfiction_Authoring_Process_chg.md
│   ├── Anti-Hallucination_Guidelines.md
│   ├── Anti-Hallucination_Guidelines_chg.md
│   ├── Style_Examples.md               # 9 curated writing styles
│   │
│   ├── Prompts/
│   │   ├── Prompt_1_Initialize.md through Prompt_10_*.md
│   │   ├── Prompt_99_Build_Release.md  # Build production releases
│   │   ├── QUICK_REFERENCE.md
│   │   └── README.md (developer-focused)
│   │
│   └── Templates/
│       ├── installer_template.md
│       ├── README_AUTHORS_template.md
│       ├── manifest_template.json
│       ├── gitignore_template
│       ├── Style_Guide_Template.md
│       └── Custom_Styles_Template.md
│
└── Proposal/
    ├── Deployment-Proposal.md
    ├── Final_Style_System_Implementation.md
    ├── Proposed Approach Style and Tone Menu System.md
    └── Recommended_Style_and_Tone_Approach.md
```

### Development Workflow

**Making Changes:**
1. Clone this repository
2. Make changes to framework files
3. Update version in `Process/AI-Assisted_Nonfiction_Authoring_Process.md`
4. Document changes in `Process/AI-Assisted_Nonfiction_Authoring_Process_chg.md`
5. Commit and push to main branch

**Creating a Release:**
1. Ensure all changes are committed and pushed
2. Run `Process/Prompts/Prompt_99_Build_Release.md` in Claude Code
3. This will:
   - Create production zip (excludes `_chg` files, `Proposal/`, etc.)
   - Generate `installer.md` with embedded version
   - Create `README.md` for book authors
   - Create `.nonfiction-manifest.json`
   - Tag the release in git
   - Publish GitHub Release with assets

**Testing:**
1. Download the release assets from GitHub
2. Test installation in a clean directory
3. Verify all prompts work correctly
4. Check documentation accuracy

### Key Principles

**For Authors:**
- Simple download and install (no git clone)
- Conversational prompts (no complex syntax)
- Auto-commit to git (safety by default)
- Change tracking with rationale
- Style-aware AI assistance

**For Developers:**
- Use `_chg.md` files for framework development
- Excluded from production builds
- Semantic versioning (Major.Minor.Patch)
- Comprehensive version history
- Clear separation: framework vs. book content

### Contributing

**Areas for Contribution:**
- Additional curated writing styles
- New prompt features
- Documentation improvements
- Bug fixes
- Template enhancements

**Process:**
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit pull request with clear description

### File Naming Conventions

**Framework Development:**
- `*_chg.md` - Change tracking files (excluded from production)
- `*_template.md` - Templates for generated files
- `Prompt_N_*.md` - Execute prompts (1-10 for users, 99 for build)

**Production Distribution:**
- No `_chg.md` files
- `README.md` is author-focused
- `README_FRAMEWORK.md` for developers (not in production)

---

## Features at a Glance

### Change Tracking System
- Every content file has a `_chg.md` companion
- Version history with semantic versioning
- Rewrite instructions for AI execution
- Automatic archiving of completed changes
- Full audit trail

### Writing Style System
- 9 professionally curated styles
- Framework-level library + project-level configuration
- Automatic style consistency checking
- Custom style creation and mixing
- Style drift detection with gentle suggestions

### Quote Management
- Web search for quotations
- Verification and attribution tracking
- Status tracking (⏳ Pending, ⚠ Needs Citation, ✓ Verified)
- Auto-insertion into compiled manuscripts
- Book-writing-assistant agent integration

### Git Integration
- All prompts auto-commit with descriptive messages
- Tag milestones (first-draft, revised-draft, etc.)
- Branch for experiments
- Push to remote for cloud backup
- Full rollback capability

### Quality Control
- Terminology consistency checking
- Cross-reference validation
- Style alignment analysis
- Fact consistency verification
- Broken reference detection

### Compilation & Export
- Generate full manuscript drafts
- Export to DOCX, PDF, EPUB
- Include/exclude placeholders
- Auto-generate table of contents
- Insert verified quotes as epigraphs

---

## Version History

**Current Version:** 3.5.0 (November 17, 2025)

- **v3.5.0:** Writing Style System with 9 curated styles and complete integration
- **v3.4.0:** Quote management enhancements and automatic change tracking sync
- **v3.3.0:** Refactored process document to eliminate duplication
- **v3.2.0:** Quote management system with verification tracking
- **v3.1.0:** Execute-only prompts with _chg file workflow
- **v3.0.0:** Git-based version control, TOC import from Inbox

See `Process/AI-Assisted_Nonfiction_Authoring_Process_chg.md` for detailed changelog.

---

## Support

**For Book Authors:**
- **Installation Help:** See `installer.md` (included in release)
- **Usage Questions:** See `QUICK_REFERENCE.md` (after installation)
- **Issues/Bugs:** https://github.com/scooter-indie/author-nonfiction/issues

**For Framework Developers:**
- **Developer Guide:** `README_FRAMEWORK.md`
- **Process Documentation:** `Process/AI-Assisted_Nonfiction_Authoring_Process.md`
- **Anti-Hallucination Rules:** `Process/Anti-Hallucination_Guidelines.md`
- **Build Process:** `Process/Prompts/Prompt_99_Build_Release.md`

---

## License

This framework is designed to be downloaded and used for authoring nonfiction books. Use it freely for your book projects.

---

## Quick Links

- **Latest Release:** https://github.com/scooter-indie/author-nonfiction/releases/latest
- **All Releases:** https://github.com/scooter-indie/author-nonfiction/releases
- **Issues:** https://github.com/scooter-indie/author-nonfiction/issues
- **Framework Repository:** https://github.com/scooter-indie/author-nonfiction

---

**Ready to write your book?** [Download the latest release](https://github.com/scooter-indie/author-nonfiction/releases/latest) and start today!
