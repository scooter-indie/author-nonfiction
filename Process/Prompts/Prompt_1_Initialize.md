# Execute Prompt 1: Initialize Project Structure

**DESKTOP-FRIENDLY:** Works in Claude Desktop with MCP Filesystem (git via Claude Code CLI)

**BEFORE PROCEEDING:** Read and apply `Process/Anti-Hallucination_Guidelines.md`

**Claude Desktop Compatibility:**
- ✅ All interactive questions work in Desktop
- ✅ All file creation via MCP Filesystem
- ✅ Git operations via Claude Code CLI (copy/paste 4 commands at end)
- 📋 Works 95% in Desktop

---

## What This Does

I will help you create a new nonfiction book project from scratch, including:
- Complete directory structure with Manuscript/ parent directory
- Git repository initialization
- Configuration files
- Table of contents
- Chapter placeholders in subdirectories with change tracking files
- Chapter quote (epigraph) management system
- Front and back matter placeholders

---

## How This Works

I'll ask you a series of questions to gather the information needed to set up your project. You can provide a path to an existing TOC file, or I'll help you create one interactively.

**Questions I'll ask:**

1. What is the working title of your book?
2. What is your name (author)?
3. What is the target total word count?
4. Who is the target audience?
5. What is the book's purpose or main thesis?
6. What is your target completion date?
7. Do you have an existing TOC file? (If yes, provide path)
8. If no TOC file: How many chapters and what are their topics/titles?
9. Writing style selection (interactive - see below)

**Then I'll:**

1. Parse existing TOC (if provided) or create from your input
2. Create complete directory structure with Manuscript/ parent directory:
   - Manuscript/Chapters/ (empty, ready for chapters)
   - Manuscript/FrontMatter/
   - Manuscript/BackMatter/ (with Bibliography/ subdirectory)
   - Manuscript/Quotes/
   - Manuscript/Style/
   - Manuscript/_TOC_/
   - Manuscript/Inbox/
   - Manuscript/Drafts/
   - Manuscript/Exports/
3. Initialize git repository (via Claude Code CLI if in Desktop)
4. Generate configuration files (Project_Config.md with `initialized: false`, Project_Metadata.md, USAGE_GUIDE.md) at root
5. Configure writing style (interactive style selection)
6. Create Manuscript/_TOC_/TOC.md and Manuscript/_TOC_/TOC_chg.md (with all chapter entries)
7. Create Manuscript/Quotes/Chapter_Quotes.md (with placeholder entries for all chapters)
8. Create Manuscript/Quotes/Chapter_Quotes_chg.md for tracking quote changes
9. Create front matter and back matter placeholders in Manuscript/FrontMatter/ and Manuscript/BackMatter/
10. Create Manuscript/BackMatter/Bibliography/ directory with placeholder files
11. **Generate PROJECT_CONTEXT.md** at project root for Claude Desktop session resumption
12. Commit everything to git with appropriate messages (via Claude Code CLI if in Desktop)
13. Tag as v1.0.0 (via Claude Code CLI if in Desktop)
14. **Set `initialized: true` in Project_Config.md** (marks successful completion)
15. Provide confirmation report with instructions to upload PROJECT_CONTEXT.md in Claude Desktop

**Note:** Chapter files are NOT created during initialization. Use **Prompt 2 (Add New Chapter)** to create each chapter on-demand. This keeps initialization fast (~5-10 seconds instead of ~30+ seconds).

---

## Writing Style Configuration

**This step helps you choose or define the writing style for your book.**

After gathering basic project information, I'll guide you through selecting a writing style:

### Step 1: Understand Your Audience

Based on your target audience answer, I'll show you 3-4 relevant framework styles from Process/Style_Examples.md:

- **Academic researchers** → Academic Authority, Scientific Communicator
- **Professional practitioners** → Conversational Expert, Business Professional
- **General public** → Narrative Storyteller, Practical Guide, Inspirational Teacher
- **Technical specialists** → Technical Precision
- **Mixed audience** → Multiple options presented

### Step 2: Review Style Examples

For each relevant style, I'll show you:
- Description (what it sounds like, who it's for)
- Example passage (150-200 words demonstrating the style)
- Key characteristics (voice, tone, pacing)

### Step 3: Make Your Choice

You can:

**Option A: Choose a framework style**
- Select one of the presented styles
- I'll use it as-is from Process/Style_Examples.md

**Option B: Customize a framework style**
- Start with a framework style
- Tell me what to adjust (e.g., "more formal" or "shorter paragraphs")
- I'll create a customized version in your Style/Style_Guide.md

**Option C: Mix multiple styles**
- Combine voice from one style, tone from another
- I'll help you create a unified custom style

**Option D: Define your own**
- Describe your desired style in your own words
- Optionally paste a sample paragraph you admire
- I'll help formalize it into a style guide

**Option E: Skip for now**
- I'll set up a neutral default style
- You can configure it later by editing Manuscript/Style/Style_Guide.md

### Step 4: Confirm with Example

Once you've chosen, I'll:
1. Show you a sample paragraph written in your selected style
2. Ask if it feels right
3. Make adjustments if needed
4. Create Manuscript/Style/Style_Guide.md with your configuration

### What Gets Created

**Manuscript/Style/Style_Guide.md** - Your active style configuration containing:
- Selected style name and source
- Complete style characteristics
- DO/DON'T guidelines
- Example passage for reference
- Notes on how prompts will use this style

**Manuscript/Style/Custom_Styles.md** (only if you create a custom style):
- Your custom style definition
- Can be reused in other projects
- Can be modified over time

---

## Verification System

**To check if initialization completed successfully:**

After running Prompt 1, you can verify completion by checking:

```
Project_Config.md contains:
initialized: true
```

**If Prompt 1 was interrupted or failed:**
- `initialized` will still be `false`
- You can ask Claude to "verify Prompt 1 completion"
- Claude will check what's missing and complete the initialization

**Verification command:** Say "verify initialization" or "check if Prompt 1 completed"

Claude will:
1. Read Project_Config.md to check `initialized` flag
2. Verify all required files/directories exist
3. Report what's complete and what's missing
4. Offer to complete any missing steps

---

## Next Steps After Initialization

Once Prompt 1 completes successfully (`initialized: true`):

1. **For Claude Desktop users:**
   - **IMPORTANT:** A file called `PROJECT_CONTEXT.md` has been created in your project root
   - When starting a new Claude Desktop session:
     - Upload `PROJECT_CONTEXT.md` to the chat
     - Paste the System Instructions (see Process/Prompts/README.md)
     - Claude will have complete context about your book project
   - This enables seamless session resumption without re-explaining your project

2. **Add your first chapter:**
   - Execute **Prompt 2 (Add New Chapter)**
   - This creates Chapter_01 with placeholder and change tracking files
   - Repeat for each chapter you want to create

3. **Start writing:**
   - Use **Prompt 3 (Modify File)** to write content in your chapters
   - This is your primary daily workflow

4. **Check progress:**
   - Use **Prompt 8 (Dashboard)** to see project status

**Note:** You don't need to create all chapters upfront. Create them as you're ready to write them. This keeps the project nimble and fast.

---

## Ready to Begin?

Please answer the first question: **What is the working title of your book?**

---

*Reference: Process/AI-Assisted_Nonfiction_Authoring_Process.md (Prompt 1)*
