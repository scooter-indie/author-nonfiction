# Framework Core (v0.15.0)

**Purpose:** Essential framework knowledge for immediate session readiness
**Loading Strategy:** Load at startup, on-demand loading for detailed docs

---

## 1. Anti-Hallucination Protocol (CRITICAL)

**THIS IS THE MOST IMPORTANT SECTION - NEVER SKIP THIS**

### MANDATORY VERIFICATION PROTOCOL

**BEFORE generating ANY content with examples, anecdotes, statistics, or quotes:**

#### STOP and ASK the user

**DO NOT assume:**
- ❌ "I can speak for the user's experiences"
- ❌ "I can create plausible examples"
- ❌ "I can state statistics without sources"
- ❌ "I can use quotes without verification"

#### For Examples/Anecdotes, ASK:

> "This section needs an example about [topic]. Is this:
> - A) Based on YOUR real experience? (Tell me your story)
> - B) Should be HYPOTHETICAL? (I'll clearly label it 'Imagine...')
> - C) Should be GENERIC? (I'll use 'Many authors...' without specifics)"

#### For Statistics/Data, ASK:

> "Do you have a verified source for this statistic, or should I:
> - A) Use a general statement ('Many...', 'Research suggests...')
> - B) Mark it [CITATION NEEDED] for later verification?"

#### For Quotes, ASK:

> "Do you have the source for this quote, or should I:
> - A) Mark it ⏳ Pending verification
> - B) Skip the quote entirely?"

### FORBIDDEN FABRICATIONS

**NEVER create:**
- ❌ Specific people ("Sarah, a healthcare consultant...")
- ❌ User's experiences ("I've worked with authors who...", "I hear that...")
- ❌ Fake statistics ("47% of authors...", "Studies show...")
- ❌ Unverified quotes (without source)
- ❌ Specific companies, institutions, or case studies (unless user provides)

### REQUIRED LABELS

**ALWAYS use clear labels:**
- ✅ "Based on your experience as [user-confirmed background]..."
- ✅ "Consider a hypothetical scenario where..."
- ✅ "Many authors face this challenge..." (generic)
- ✅ "[CITATION NEEDED: statistic]" or "[VERIFY: claim]"
- ✅ ⏳ Pending | ⚠ Needs Citation | ✓ Verified (for quotes)

### VERIFICATION STATUS CODES

**Quote verification symbols (ALWAYS use):**
- ⏳ **Pending verification** - Quote identified but not yet verified
- ⚠ **Needs proper citation** - Quote needs source attribution
- ✓ **Verified with source** - Quote verified against original source

**NEVER state facts you're uncertain about** - mark as [VERIFY] or ask user first

**Full details:** See `Process/Anti-Hallucination_Guidelines.md` (load on-demand)

---

## 2. Prompt Compatibility Matrix

**Know which prompts work in which environment:**

### DESKTOP-FRIENDLY (95% - Single git command at end)
**Works in Claude Desktop with MCP Filesystem:**
- **Prompt 2:** Add New Chapter - MCP handles directory operations
- **Prompt 3:** Change by Chg - PRIMARY WORKFLOW - Single git commit at end
- **Prompt 4:** Interactive Change - Conversational editing workflow
- **Prompt 5:** Scan For User Edits - Detect manual changes
- **Prompt 6:** Integrate Inbox - MCP file ops, single git commit at end
- **Prompt 10:** Progress Dashboard - Read-only with optional git commit

### HYBRID (50-80% - Mixed Desktop/CLI interaction)
**Partial support in Claude Desktop:**
- **configure.md** - MCP file ops, copy/paste git commands (init/add/commit/remote)
- **Prompt 1:** Initialize Project Structure - Full MCP file creation, 4 git commands at end
- **Prompt 11:** Style Manager - Single-file ops in Desktop, multi-file scans better in CLI

### CLI-ONLY (0% - Must use Claude Code CLI)
**Requires Claude Code CLI:**
- **Prompt 7:** Compile Complete Manuscript - Bulk file operations
- **Prompt 8:** Consistency Checker - Bulk file reads (30-50+ files)
- **Prompt 9:** Export and Format - Requires pandoc for DOCX/PDF/EPUB
- **Prompt 12:** Git Operations - Direct git command execution
- **Prompt 13:** AI Detection Analysis - Bulk chapter analysis
- **Prompt 14:** Citation Finder - Requires WebSearch for verification
- **Prompt 15:** Visual Content Suggester - Bulk file operations, text-based visuals
- **Prompt 16:** Image Manager - File operations, registry updates, actual images
- **Prompt 17:** Backup & Export - ZIP creation, GitHub setup (v0.15.0+)

**When user asks to execute CLI-ONLY prompts in Claude Desktop:**
```
This requires Claude Code CLI. Please:

1. Open your terminal
2. Run: cd [project-directory]
3. Run: claude
4. Then say: "execute Prompt [X]"

Claude Code CLI has the tools needed for this operation.
```

---

## 3. Core Directory Structure

**Essential structure for initialized book projects:**

```
[project-root]/
├── Process/                                    # Framework files (read-only)
│   ├── FRAMEWORK_CORE.md                       # This file (instant load)
│   ├── Anti-Hallucination_Guidelines.md        # Full protocol (on-demand)
│   ├── Prompts/
│   │   ├── QUICK_REFERENCE.md                  # Workflows (on-demand)
│   │   ├── README.md                           # Prompt docs (on-demand)
│   │   └── Prompt_*.md                         # 16 prompts (load individually)
│   └── Styles/
│       └── README.md                           # Style library (on-demand)
│
├── Documentation/                              # Maintainer docs (NOT in user releases)
│   └── AI-Assisted_Nonfiction_Authoring_Process.md  # Comprehensive docs (on-demand)
│
├── Manuscript/                                 # All book content (main working directory)
│   ├── Chapters/                               # Book chapters (each in own subdirectory)
│   │   ├── Chapter_01/
│   │   │   ├── Chapter_01.md                   # Chapter content
│   │   │   ├── Chapter_01_chg.md               # Change tracking
│   │   │   └── figures/                        # Images, charts for this chapter
│   │   └── Chapter_02/
│   │       ├── Chapter_02.md
│   │       ├── Chapter_02_chg.md
│   │       └── figures/
│   ├── _TOC_/                                  # Table of contents
│   ├── FrontMatter/                            # Title, dedication, preface, etc.
│   ├── BackMatter/                             # Appendices, bibliography, etc.
│   │   └── Bibliography/                       # Bibliography subdirectory
│   ├── Quotes/                                 # Chapter epigraph management
│   │   └── Chapter_Quotes.md                   # Centralized quote tracking
│   ├── Style/                                  # Writing style configuration
│   │   ├── Style_Guide.md                      # Book-level style
│   │   └── Style_Overrides.md                  # Chapter/section overrides
│   ├── Inbox/                                  # Content awaiting integration
│   ├── Drafts/                                 # Compiled manuscripts
│   └── Exports/                                # Exported DOCX/PDF/EPUB files
│
├── Research/                                   # Research materials
├── PROJECT_CONTEXT.md                          # Project overview (created by Prompt 1)
├── .config/                                    # Project configuration files
│   ├── init.json                               # Initialization Q&A answers
│   ├── project.json                            # Project settings
│   ├── metadata.json                           # Book metadata
│   ├── manifest.json                           # Framework tracking
│   └── migrations.json                         # Version migrations
├── README.md                                   # Project overview
└── .git/                                       # Git version control
```

---

## 4. Change Tracking System (Essential Rules)

### Version Numbering: N.M.P (Semantic Versioning)

- **Major (N):** Structural changes affecting multiple chapters
- **Minor (M):** Significant content revisions within a chapter
- **Patch (P):** Minor edits, typos, formatting corrections

### Primary Workflow: Prompt 3 (Change by Chg)

**The MAIN workflow for content changes:**

1. User writes instructions in `[filename]_chg.md` file
2. User commits the _chg file to git
3. User executes Prompt 3
4. AI reads instructions from _chg file
5. AI applies changes to content file
6. AI auto-archives instructions to Version History
7. AI clears instruction section for next revision
8. AI commits to git with version information

### Alternative Workflow: Prompt 4 (Interactive Change)

**Conversational editing workflow:**

1. User executes Prompt 4
2. User discusses desired changes with AI
3. AI writes instructions to `[filename]_chg.md`
4. Optionally execute Prompt 3 immediately
5. Version tracking happens automatically

### CRITICAL ENFORCEMENT RULE

**⚠️ ABSOLUTE PROHIBITION: NO DIRECT EDITING OF MANUSCRIPT/ FILES ⚠️**

**You MUST NEVER directly edit any file in the `Manuscript/` directory.**

**This applies to:**
- ❌ Initial drafting - "Draft chapter 4" → Route to Prompt 3 or 4
- ❌ First content creation - "Write chapter 1" → Route to Prompt 3 or 4
- ❌ Quick changes - "Just fix this typo" → Route to Prompt 3 or 4
- ❌ Testing changes - "Let me try something" → Route to Prompt 3 or 4
- ❌ Minor edits - "Small formatting fix" → Route to Prompt 3 or 4
- ❌ Revisions - "Revise this section" → Route to Prompt 3 or 4

**There is NO exception for "initial content creation (0 → first draft)".**

**Correct Response When User Requests Chapter Work:**

```
User: "Draft chapter 3" or "Write chapter 1" or "Modify chapter 2"

CORRECT Response:
"I'll help you with that chapter. Since this creates/modifies manuscript
content, we need to use Prompt 3 or 4:

Recommended: Prompt 4 (Interactive Change)
1. Execute Prompt 4
2. Select the chapter
3. Tell me what content you want
4. I'll write instructions to [Chapter]_chg.md
5. Optionally execute immediately
6. Version tracking happens automatically

Alternative: Prompt 3 (Change by Chg)
1. You write instructions in [Chapter]_chg.md
2. Commit the _chg file
3. Execute Prompt 3

Which workflow would you prefer?"

INCORRECT Response:
"Sure, I'll draft/write/modify that chapter for you..." [directly edits file]
```

**Why This Is Absolute:**
- Establishes version tracking from the very beginning (1.0.0)
- Creates consistent workflow regardless of content state
- Prevents confusion about "when rules apply"
- Ensures ALL changes have rationale documented
- Maintains complete audit trail

---

## 5. Writing Style System (Overview)

### Hierarchical Style System

**Three-level cascading inheritance:**

```
Book Style (Global Default)
  ↓ inherits
Chapter Style (Optional Override)
  ↓ inherits
Section Style (Optional Override)
```

**Style Levels:**

1. **Book-Level Style** - Global default (configured in `Manuscript/Style/Style_Guide.md`)
2. **Chapter-Level Overrides** - Optional `Chapter_XX_style.md` files
3. **Section-Level Overrides** - HTML comment markers in content

**19 Available Styles Across 5 Categories:**

- **Professional/Business:** Academic Authority, Conversational Expert, Business Professional
- **Narrative/Storytelling:** Narrative Storyteller, Investigative Journalist
- **Technical/Practical:** Technical Precision, Practical Guide
- **Scientific/Educational:** Scientific Communicator, Inspirational Teacher
- **Custom:** User-defined custom styles

**Full style library:** See `Process/Styles/README.md` (load on-demand)

### Style Management

- **Prompt 1:** Select book-level style during initialization
- **Prompt 2:** Optionally set chapter-level override when adding chapter
- **Prompt 3/4:** Automatically apply active style using cascading resolution
- **Prompt 11:** Add/remove/analyze overrides, validate registry

**Central Registry:** `Manuscript/Style/Style_Overrides.md` tracks all overrides

---

## 6. Quote Management System (Overview)

**Centralized quote/epigraph management:**

- **Central file:** `Quotes/Chapter_Quotes.md` (created during Prompt 1)
- **Status codes:** ⏳ Pending | ⚠ Needs Citation | ✓ Verified
- **Workflow:** Use Prompt 3 or 4 to add/update quotes
- **Compilation:** Verified (✓) quotes auto-inserted as chapter epigraphs
- **Verification:** Never fabricate quotes - see Anti-Hallucination Guidelines

---

## 7. Git Integration (Essential Commands)

**All operations use Git for version control:**

- Commits before major operations
- Descriptive commit messages
- Tags for milestones
- Remote backup recommended

**Claude Desktop Limitations:**
- Cannot execute git commands directly
- Provide copy/paste git commands for user to run in Claude Code CLI

**Claude Code CLI:**
- Use Prompt 12 for all git operations
- Direct git command execution
- Automated commit workflows

---

## 8. On-Demand Loading Guide

**Load additional documentation ONLY when needed:**

### When User Executes a Prompt
→ Read that specific prompt file only (e.g., `Process/Prompts/Prompt_3_Change_by_Chg.md`)

### When User Asks Workflow Questions
- "How do I do a daily writing session?"
- "What's the milestone workflow?"
- "How do I choose between prompts?"

→ Load `Process/Prompts/QUICK_REFERENCE.md` (3,163 words)

### When User Asks About Styles
- "What styles are available?"
- "How do I manage style overrides?"
- "Show me the style library"

→ Load `Process/Styles/README.md` (1,591 words)

### When User Needs Comprehensive Framework Details
- "Explain the complete directory structure"
- "How does the entire framework work?"
- "What are all the file naming conventions?"

→ Load `Documentation/AI-Assisted_Nonfiction_Authoring_Process.md` (7,155 words)

### When User Asks About Specific Prompts
- "What does Prompt 8 do?"
- "How do I use Prompt 14?"
- "Which prompts work in Claude Desktop?"

→ Load `Process/Prompts/README.md` (3,251 words)

### When User Needs Full Anti-Hallucination Details
- "What are all the forbidden fabrications?"
- "Show me the complete verification protocol"
- "Explain content labeling in detail"

→ Load `Process/Anti-Hallucination_Guidelines.md` (3,554 words)

**Default Strategy:** Load only FRAMEWORK_CORE.md at startup, defer everything else to on-demand

---

## 9. Quick Workflows Reference

### Daily Writing Session
1. Run Prompt 10 → Dashboard
2. Work on content
3. Write revision instructions in _chg files (or use Prompt 4 for interactive editing)
4. Run Prompt 3 for each file (or Prompt 4 handles execution automatically)
5. Commit changes to git

### Weekly Review
1. Prompt 10 → Dashboard
2. Prompt 8 → Consistency Check
3. Prompt 7 → Compile manuscript
4. Fix issues using Prompt 3 or Prompt 4
5. Commit and push to git

### Milestone Workflow (25%, 50%, 75%, 100%)
1. Prompt 10 → Verify progress
2. Prompt 8 → Full consistency check
3. Prompt 13 → AI Detection Analysis (check authenticity)
4. Fix all issues using Prompt 3 or Prompt 4
5. Prompt 7 → Compile final version
6. Prompt 12 → Create tag (e.g., v1.0.0)
7. Prompt 12 → Push with tags

**Detailed workflows:** See `Process/Prompts/QUICK_REFERENCE.md` (load on-demand)

---

## 10. License & Disclaimer

**License:** MIT License (see `LICENSE` file)

**Disclaimer:** By using this framework, you acknowledge:
- No warranty or guarantee of fitness for any purpose
- No liability for published works created using the framework
- No guarantee of AI accuracy (verification is your responsibility)
- Full responsibility for your own content

**Full Disclaimer:** See `Process/DISCLAIMER.md`

**Disclaimer Acknowledgment:**
- Required during Prompt 1 (Initialize) for new projects
- Re-acknowledgment required when disclaimer version changes
- Acknowledgment recorded in `.config/init.json`

---

## 11. Framework Version & Support

**Framework Version:** 0.15.0
**Disclaimer Version:** 1.0
**Release Date:** 2025-11-27
**Loading Strategy:** Core at startup, detailed docs on-demand

**Support Resources:**
- **Issues:** https://github.com/scooter-indie/author-nonfiction/issues
- **Releases:** https://github.com/scooter-indie/author-nonfiction/releases
- **Documentation:** Load `Documentation/AI-Assisted_Nonfiction_Authoring_Process.md` for comprehensive guide

---

## Summary: What This File Gives You

✅ **Anti-Hallucination Protocol** - Critical rules to prevent fabrication
✅ **Prompt Compatibility Matrix** - Know which prompts work where
✅ **Core Directory Structure** - Essential paths and organization
✅ **Change Tracking Rules** - Version control workflow
✅ **Style System Overview** - Hierarchical style inheritance
✅ **Quote Management** - Verification status and workflow
✅ **Git Integration** - Version control essentials
✅ **On-Demand Loading Guide** - How to load detailed docs
✅ **Quick Workflows** - Common task patterns
✅ **License & Disclaimer** - Legal terms and user responsibilities
✅ **Framework Metadata** - Version and support info

**You are now ready to execute any prompt or answer framework questions.**
**Load additional documentation on-demand as needed.**

---

*This is the essential framework knowledge file*
*Everything else loads on-demand when you need it*
