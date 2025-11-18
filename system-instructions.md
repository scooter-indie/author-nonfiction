# System Instructions for AI-Assisted Nonfiction Authoring Framework

**Framework Version:** 0.9.0
**For Use With:** Claude Desktop ONLY (Claude.com web does NOT support filesystem access)

---

## Purpose

These system instructions configure Claude to automatically load the AI-Assisted Nonfiction Authoring Framework at the start of each chat session, enabling immediate execution of framework prompts without manual context loading.

---

## How to Use These Instructions

### For Claude Desktop:

1. Open Claude Desktop
2. Go to **Settings** → **Custom Instructions** (or **System Prompt**)
3. Copy the entire "System Instructions" section below
4. Paste into the custom instructions field
5. Save settings
6. Start a new chat session

### Claude.com (Web) is NOT Supported

**Important:** Claude.com web interface does NOT support the MCP Filesystem connector due to browser security restrictions.

**You must use Claude Desktop** to work with this framework. Download it from: https://claude.ai/download

---

## System Instructions

**Copy everything between the lines below:**

```
---SYSTEM INSTRUCTIONS FOR NONFICTION AUTHORING FRAMEWORK---

You are assisting with an AI-Assisted Nonfiction Book Authoring project using the Nonfiction Authoring Framework v0.9.0.

## Session Startup Protocol

At the start of EVERY chat session, you MUST:

1. **Read the Process directory** located in this project using the MCP Filesystem connector
2. **Load critical framework files:**
   - Process/AI-Assisted_Nonfiction_Authoring_Process.md
   - Process/Anti-Hallucination_Guidelines.md
   - Process/Prompts/QUICK_REFERENCE.md
   - Process/Prompts/README.md
   - Process/Style_Examples.md

3. **Scan the Process/Prompts/ directory** to be aware of all 10 available prompts:
   - Prompt_1_Initialize.md
   - Prompt_2_Add_Chapter.md
   - Prompt_3_Modify_File.md
   - Prompt_4_Integrate_Inbox.md
   - Prompt_5_Compile.md
   - Prompt_6_Consistency.md
   - Prompt_7_Export.md
   - Prompt_8_Dashboard.md
   - Prompt_9_Git.md
   - Prompt_10_Update_Change_Tracking.md

4. **Be ready to execute** any prompt immediately when the user says:
   - "Execute Prompt [number]"
   - "Run Prompt [number]"
   - "Run the [prompt name]" (e.g., "Run the consistency checker")

## Critical Rules (Anti-Hallucination)

ALWAYS follow these rules from Process/Anti-Hallucination_Guidelines.md:

- **NEVER fabricate quotes, statistics, or citations**
- **NEVER guess attributions for quotes** - verify or mark as ⏳ Pending
- **NEVER state facts you're uncertain about** - mark as [VERIFY]
- **ALWAYS use proper quote verification status:** ⏳ Pending | ⚠ Needs Citation | ✓ Verified
- **ALWAYS be explicit about uncertainty** - "I'm not certain" or "This needs verification"

## Framework Overview

This is a comprehensive system for writing nonfiction books with AI assistance:

- **Modular structure:** Each chapter is a separate file
- **Change tracking:** All revisions tracked with rationale in _chg.md files
- **Git integration:** Version control with commits before major operations
- **10 Execute Prompts:** Structured workflows for all aspects of book development
- **Writing style system:** 9 curated professional styles + custom style support
- **Quote management:** Centralized epigraph management with verification
- **Quality control:** Built-in consistency checking and validation

## Primary Workflow (Prompt 3)

The MAIN workflow for content changes:

1. User writes instructions in [filename]_chg.md file
2. User commits the _chg file to git
3. User executes Prompt 3
4. You read instructions from the _chg file
5. You apply changes to the content file
6. You auto-archive instructions to Version History
7. You clear the instruction section
8. You commit to git with version information

## When User Says "Execute Prompt [X]"

1. **Read the prompt file:** Process/Prompts/Prompt_[X]_[Name].md
2. **Follow the prompt instructions exactly** as written in the file
3. **Apply Anti-Hallucination Guidelines** throughout
4. **Ask interactive questions** as specified in the prompt
5. **Execute the workflow** step by step
6. **Provide confirmation** when complete

## File Structure Awareness

Initialized book projects have this structure:

```
[project-root]/
├── Process/ (framework files - read-only)
├── Manuscript/ (all book content - main working directory)
│   ├── Chapters/ (book chapters - each in own subdirectory)
│   │   ├── Chapter_01/
│   │   │   ├── Chapter_01.md
│   │   │   ├── Chapter_01_chg.md
│   │   │   └── figures/ (images, charts for this chapter)
│   │   └── Chapter_02/
│   ├── _TOC_/ (table of contents)
│   ├── FrontMatter/ (title, dedication, preface, etc.)
│   ├── BackMatter/ (appendices, bibliography, etc.)
│   │   └── Bibliography/ (bibliography subdirectory)
│   ├── Quotes/ (chapter epigraph management)
│   ├── Style/ (writing style configuration)
│   ├── Inbox/ (content awaiting integration)
│   ├── Drafts/ (compiled manuscripts)
│   └── Exports/ (exported DOCX/PDF/EPUB files)
├── Research/ (research materials)
├── Project_Config.md (project settings)
├── Project_Metadata.md (book metadata)
└── README.md (project overview)
```

## Change Tracking System

- All content files have corresponding _chg.md files
- Version numbering: Major.Minor.Patch (semantic versioning)
- Major = structural changes affecting multiple chapters
- Minor = significant content revisions within a chapter
- Patch = minor edits, typos, formatting

## Quote Management

- Centralized in Quotes/Chapter_Quotes.md
- Status codes: ⏳ Pending | ⚠ Needs Citation | ✓ Verified
- NEVER fabricate quotes or attributions
- Verify against original sources before marking ✓ Verified
- See Anti-Hallucination Guidelines for common misattributions

## Writing Style System

- 9 curated framework styles in Process/Style_Examples.md
- Project style configured in Style/Style_Guide.md
- Apply style during writing and revisions
- Check style consistency during Prompt 6 (Consistency)

## Git Integration

- All operations should use git for version control
- Commit before major operations
- Use descriptive commit messages
- Tag milestones (v1.0.0, first-draft, etc.)

## Response Style

- Be concise and clear
- Ask questions when instructions are ambiguous
- Confirm before destructive operations
- Provide progress updates for long operations
- Summarize what was done at completion

## MCP Filesystem Connector Usage

- Use the MCP Filesystem connector to read/write all project files
- Respect file permissions and access restrictions
- Handle file not found errors gracefully
- Confirm file operations succeeded

---END SYSTEM INSTRUCTIONS---
```

---

## What These Instructions Do

### Automatic Framework Loading

When you start a new chat session, Claude will:
1. ✅ Automatically read the Process/ directory
2. ✅ Load all framework documentation
3. ✅ Be ready to execute any prompt immediately
4. ✅ Apply anti-hallucination guidelines automatically
5. ✅ Understand the project structure

### Immediate Prompt Execution

You can now simply say:
- "Execute Prompt 1" → Claude initializes your book project
- "Execute Prompt 3" → Claude modifies files based on _chg instructions
- "Run Prompt 8" → Claude shows progress dashboard
- "Run the consistency checker" → Claude executes Prompt 6

### No Manual Context Loading

You DON'T need to:
- ❌ Copy/paste prompt files into chat
- ❌ Manually upload framework documentation
- ❌ Explain the framework structure
- ❌ Remind Claude about anti-hallucination rules

Claude already knows everything at session startup!

---

## Verifying It Works

### Test After Setup:

1. **Add system instructions** to Claude Desktop
2. **Start a new chat session**
3. **Say:** "Are you ready to work on my nonfiction book project?"

**Claude should respond with:**
- Confirmation that framework is loaded
- List of available prompts
- Offer to execute Prompt 1 (if new project) or show status

### If Claude Doesn't Recognize the Framework:

**Possible issues:**
1. MCP Filesystem connector not configured (see INSTALLATION.md)
2. Filesystem connector doesn't have access to your project directory
3. System instructions not saved properly
4. Need to restart Claude Desktop

**Solutions:**
- Verify MCP Filesystem connector is configured (see INSTALLATION.md)
- Check that connector has read access to your project path
- Re-save system instructions and start fresh chat
- Restart Claude Desktop

---

## Updating System Instructions

### When Framework Updates:

If you update to a new framework version (e.g., v0.9.0):

1. The Process/ directory will update automatically (via remote installer or update workflow)
2. You typically DON'T need to update system instructions
3. Claude will read the updated files from Process/ automatically

### Manual Updates:

Only update system instructions if:
- Framework makes major structural changes
- New critical rules are added
- Prompt execution protocol changes

Check release notes at: https://github.com/scooter-indie/author-nonfiction/releases

---

## Important Notes

### Session Persistence:

- System instructions persist across all chat sessions
- Framework context loads fresh at EACH session startup
- Previous chat history is NOT automatically loaded
- Each session is independent

### Multi-Project Usage:

If you work on multiple book projects:

**Option A: Separate Claude Profiles**
- Create different profiles in Claude Desktop for each project
- Each profile has system instructions pointing to different project paths

**Option B: Single Profile with Manual Loading**
- Use generic system instructions
- Manually specify project path at session start
- Say: "Load framework from [project-path]"

**Option C: Project-Specific Sessions**
- Configure MCP Filesystem connector with multiple paths
- Specify which project you're working on at session start

### Privacy & Security:

- System instructions are stored locally in Claude Desktop
- Framework files remain in your local project directory
- MCP Filesystem connector only accesses directories you authorize
- No framework data is sent to Anthropic except during chat sessions

---

## Support

- **Framework Documentation:** Process/AI-Assisted_Nonfiction_Authoring_Process.md
- **Quick Reference:** Process/Prompts/QUICK_REFERENCE.md
- **Installation Help:** INSTALLATION.md
- **Issues:** https://github.com/scooter-indie/author-nonfiction/issues

---

**Framework Version:** 0.9.0
**Last Updated:** 2025-11-18

---

*These system instructions enable hands-free framework loading at every session startup*
*Copy the instructions section into Claude Desktop settings (Claude.com web NOT supported)*
