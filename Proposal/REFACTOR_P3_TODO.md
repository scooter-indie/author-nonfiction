# Prompt 3/4 Refactor TODO

**Created:** 2025-11-20
**Status:** Planning
**Target Version:** 0.11.0

**IMPORTANT:** All work in this document (including Prompt 13: AI_Detection_Analysis) will be completed in v0.11.0 release.

---

## Overview

Refactor the chapter modification workflow to separate automated (_chg file-driven) changes from interactive conversational editing.

---

## Goals

1. **Clarify Prompt 3's purpose:** Execute instructions from _chg files only
2. **Create interactive editing workflow:** New Prompt 4 for conversational editing
3. **Improve prompt organization:** Reorder prompts by workflow priority
4. **Add natural language triggers:** Support conversational prompt invocation in both Claude Code CLI and Claude Desktop

---

## Prompt Renumbering

### Complete New Structure

```
OLD                                    NEW
---                                    ---
Prompt 1: Initialize                → Prompt 1: Initialize (unchanged)
Prompt 2: Add Chapter               → Prompt 2: Add Chapter (unchanged)
Prompt 3: Modify File               → Prompt 3: Change_by_Chg
Prompt 4: Integrate Inbox           → Prompt 6: Integrate_Inbox
Prompt 5: Compile                   → Prompt 7: Compile
Prompt 6: Consistency               → Prompt 8: Consistency
Prompt 7: Export                    → Prompt 9: Export
Prompt 8: Dashboard                 → Prompt 10: Dashboard
Prompt 9: Git Operations            → Prompt 12: Git_Operations
Prompt 10: Update Change Tracking   → Prompt 5: Scan_For_User_Edits
Prompt 11: Style Manager            → Prompt 11: Style_Manager
(NEW)                               → Prompt 4: Interactive_Change
```

### File Renames Required

```
OLD FILENAME                                    NEW FILENAME
---                                             ---
Prompt_3_Modify_File.md                      → Prompt_3_Change_by_Chg.md
Prompt_4_Integrate_Inbox.md                  → Prompt_6_Integrate_Inbox.md
Prompt_5_Compile.md                          → Prompt_7_Compile.md
Prompt_6_Consistency.md                      → Prompt_8_Consistency.md
Prompt_7_Export.md                           → Prompt_9_Export.md
Prompt_8_Dashboard.md                        → Prompt_10_Dashboard.md
Prompt_9_Git.md                              → Prompt_12_Git_Operations.md
Prompt_10_Update_Change_Tracking.md          → Prompt_5_Scan_For_User_Edits.md
Prompt_11_Style_Manager.md                   → Prompt_11_Style_Manager.md (unchanged)
(NEW FILE)                                   → Prompt_4_Interactive_Change.md
```

---

## Detailed Changes

### 1. Prompt 3: Change_by_Chg (Renamed from Modify File)

**Purpose:** Execute instructions written in _chg files (automated, non-interactive)

**Changes Required:**
- Rename file: `Prompt_3_Modify_File.md` → `Prompt_3_Change_by_Chg.md`
- Update title in file header
- Clarify that this prompt ONLY reads from _chg files
- Remove any interactive questioning (that moves to Prompt 4)
- Update description: "This prompt executes change instructions from _chg files. For interactive editing, use Prompt 4."
- Keep all existing functionality for reading _chg, applying changes, archiving to version history

**Compatibility:**
- DESKTOP-FRIENDLY (unchanged)

---

### 2. Prompt 4: Interactive_Change (NEW)

**Purpose:** Conversational editing session that writes instructions to _chg files, then optionally applies them

**Workflow:**

1. **Ask:** "Which file do you want to edit?"
   - Show list of available files with _chg files
   - Chapters (Chapter_01, Chapter_02, etc.)
   - FrontMatter (Title_Page, Preface, Dedication, etc.)
   - BackMatter (Appendix_A, Bibliography, etc.)
   - Quotes (Chapter_Quotes)
   - Style (Style_Guide, Style_Overrides)
   - TOC (_TOC)

2. **Conversational editing:**
   - User describes changes in natural language
   - Claude asks clarifying questions
   - Build up a clear set of instructions through dialogue
   - User can refine, add more changes, or say "that's all"

3. **Write to _chg file:**
   - Format instructions clearly in the appropriate _chg file
   - Follow existing _chg file format conventions
   - Include version number, date, rationale

4. **Commit _chg file:**
   - Git commit the _chg file
   - Commit message: "Add change instructions for [filename]"

5. **Offer to apply:**
   - Ask: "Apply changes now? (yes/no)"
   - If yes: Execute Prompt 3 (Change_by_Chg) automatically
   - If no: Stop, inform user they can run Prompt 3 later

**File Coverage:**
- ALL files with _chg files, including TOC (even though TOC_chg is AI-managed)
- For TOC: Warn user that TOC is managed by Prompts 1 and 2, but allow override if user insists

**Anti-Hallucination:**
- Include FIRST ACTION - MANDATORY: Read Anti-Hallucination_Guidelines.md
- Include DATE CONFIRMATION protocol
- Include AGENT INSTRUCTIONS

**Compatibility:**
- DESKTOP-FRIENDLY (95% Desktop with single git commit)
- All file operations via MCP Filesystem
- Single git commit command provided as copy/paste at end
- Prompt 3 execution (if yes) happens via same session

**File to Create:**
- `Process/Prompts/Prompt_4_Interactive_Change.md`

---

### 3. Prompt 5: Scan_For_User_Edits (Renamed and moved from Prompt 10)

**Purpose:** Detect manual edits to files and sync _chg files

**Changes Required:**
- Rename file: `Prompt_10_Update_Change_Tracking.md` → `Prompt_5_Scan_For_User_Edits.md`
- Update title in file header
- Update prompt number references throughout
- Keep all existing functionality

**Rationale for Position:**
- Prompt 5 position makes sense: after interactive workflows (1-4), before batch operations (6+)
- Users run this when they've made manual edits outside of prompts

**Compatibility:**
- DESKTOP-FRIENDLY (unchanged)

---

### 4. Prompts 6-12: Renumber Only

**Changes Required:**
- Rename files (see table above)
- Update title in file header
- Update prompt number references throughout each file
- Update any cross-references to other prompts

**Files:**
- Prompt_6_Integrate_Inbox.md (was 4)
- Prompt_7_Compile.md (was 5)
- Prompt_8_Consistency.md (was 6)
- Prompt_9_Export.md (was 7)
- Prompt_10_Dashboard.md (was 8)
- Prompt_11_Style_Manager.md (was 11, number unchanged but verify)
- Prompt_12_Git_Operations.md (was 9)

---

## Natural Language Intent Recognition

### Implementation Strategy

Support natural language triggers in BOTH Claude Code CLI and Claude Desktop.

**Claude Code CLI Implementation:**
- Update `.claude/agents/book-writing-assistant.md`
- Add intent recognition section with example phrases
- Agent interprets user intent and launches appropriate prompt

**Claude Desktop Implementation:**
- Update `system-instructions.md`
- Add intent recognition section with example phrases
- Instructions guide Claude to read and execute appropriate prompt file

**Behavior:**
- If Claude is uncertain about intent, ask: "Did you mean Prompt X?"
- Provide a few examples per prompt, let Claude interpret variations naturally
- Don't require exact phrase matching

### Example Trigger Phrases (Per Prompt)

**Prompt 1 (Initialize):**
- "start a new book project"
- "initialize my book"
- "set up a new nonfiction book"

**Prompt 2 (Add Chapter):**
- "add a new chapter"
- "insert chapter 5"
- "create chapter after chapter 3"

**Prompt 3 (Change_by_Chg):**
- "execute prompt 3"
- "apply the changes in the _chg file"
- "run the change instructions"

**Prompt 4 (Interactive_Change):**
- "I want to modify chapter 4"
- "edit chapter 2"
- "change the preface"
- "update the introduction"
- "revise the conclusion"

**Prompt 5 (Scan_For_User_Edits):**
- "scan for my edits"
- "sync my manual changes"
- "update change tracking"
- "detect what I changed"

**Prompt 6 (Integrate_Inbox):**
- "integrate inbox content"
- "process the inbox"
- "import from inbox"

**Prompt 7 (Compile):**
- "compile the manuscript"
- "generate full draft"
- "create complete manuscript"

**Prompt 8 (Consistency):**
- "check consistency"
- "run consistency checker"
- "validate the manuscript"

**Prompt 9 (Export):**
- "export to Word"
- "create PDF"
- "export the manuscript"

**Prompt 10 (Dashboard):**
- "show progress"
- "display dashboard"
- "project status"

**Prompt 11 (Style_Manager):**
- "manage styles"
- "add style override"
- "check style distribution"

**Prompt 12 (Git_Operations):**
- "commit changes"
- "push to remote"
- "git status"
- "create a tag"

**Prompt 13 (AI_Detection_Analysis):**
- "check for AI text"
- "analyze chapter authenticity"
- "scan for AI-generated content"
- "does this sound like AI?"

---

## Documentation Updates Required

### 1. QUICK_REFERENCE.md
- Update all prompt numbers (1-13)
- Update prompt names
- Add note about Prompt 3 vs Prompt 4 distinction
- Add Prompt 13 (AI_Detection_Analysis)
- Add natural language trigger examples

### 2. README.md (root)
- Update "11 Core Prompts" section to "13 Core Prompts"
- Update prompt list with new numbers and names (include Prompt 13)
- Update compatibility table with new numbers

### 3. Process/Prompts/README.md
- Update complete prompt list (1-13)
- Update descriptions (include Prompt 13)
- Update compatibility classifications
- Add natural language trigger section

### 4. CLAUDE.md
- Update "11 Core Prompts" section to "13 Core Prompts"
- Update prompt descriptions (include Prompt 13)
- Update workflow examples with new numbers

### 5. system-instructions.md
- Update prompt list to include all 13 prompts (lines ~117-128)
- Update compatibility classifications (include Prompt 13 as CLI-ONLY)
- Add natural language intent recognition section
- Update workflow examples

### 6. INSTALLATION.md
- Update any references to prompt numbers
- Update examples

### 7. Process/AI-Assisted_Nonfiction_Authoring_Process.md
- Update complete prompt documentation
- Update workflow examples
- Update cross-references

### 8. All Other Prompts
- Update cross-references to other prompts
- Update "See also" sections
- Update workflow descriptions that reference other prompts

---

## Cross-Reference Updates

### Files That Reference Prompt Numbers

Search and update references in:
- All prompt files (Prompt_1 through Prompt_12)
- QUICK_REFERENCE.md
- README.md (multiple locations)
- CLAUDE.md (multiple locations)
- system-instructions.md (multiple locations)
- INSTALLATION.md
- PREPARE_RELEASE.md (if applicable)
- Process/AI-Assisted_Nonfiction_Authoring_Process.md
- Process/_COMMON/ files (if any reference prompts)
- .claude/agents/book-writing-assistant.md

### Search Patterns

```bash
# Find all references to specific prompts
grep -r "Prompt 3" --include="*.md" Process/ .claude/
grep -r "Prompt 4" --include="*.md" Process/ .claude/
grep -r "Prompt 5" --include="*.md" Process/ .claude/
# ... continue for all prompts

# Find references to old names
grep -r "Modify File" --include="*.md" Process/ .claude/
grep -r "Integrate Inbox" --include="*.md" Process/ .claude/
grep -r "Update Change Tracking" --include="*.md" Process/ .claude/
```

---

## Testing Plan

### 1. Test Prompt 3 (Change_by_Chg)
- Create test _chg file with instructions
- Execute Prompt 3
- Verify it reads _chg and applies changes correctly
- Verify no interactive prompts appear

### 2. Test Prompt 4 (Interactive_Change)
- Start conversational editing session
- Test with Chapter file
- Test with FrontMatter file
- Test with BackMatter file
- Test with Quotes file
- Test with Style file
- Verify _chg file written correctly
- Verify git commit happens
- Test "Apply changes now?" flow (yes and no paths)
- Verify Prompt 3 executes when "yes" chosen

### 3. Test Prompt 5 (Scan_For_User_Edits)
- Make manual edits to a chapter
- Execute Prompt 5
- Verify it detects changes
- Verify _chg file updated

### 4. Test All Renumbered Prompts (6-12)
- Execute each prompt
- Verify functionality unchanged
- Verify cross-references work correctly

### 5. Test Natural Language Triggers (All 13 Prompts)

**Claude Code CLI:**
- Test various natural language phrases for each prompt
- Verify intent recognition works
- Verify "Did you mean Prompt X?" confirmation appears when uncertain
- Test in book-writing-assistant agent

**Claude Desktop:**
- Test various natural language phrases for each prompt
- Verify intent recognition works via system-instructions.md
- Verify Claude reads and executes correct prompt file
- Test "Did you mean Prompt X?" confirmation

### 6. Test Documentation
- Verify all cross-references updated
- Verify QUICK_REFERENCE.md accurate
- Verify README.md accurate
- Verify compatibility tables correct

---

## Implementation Steps

### Phase 1: File Operations (No Logic Changes)

1. **Create new Prompt 4 stub:**
   - Create `Process/Prompts/Prompt_4_Interactive_Change.md`
   - Add header, compatibility markers, placeholder content

2. **Rename existing prompts:**
   ```bash
   # Backup first
   git add -A && git commit -m "Backup before prompt refactor"

   # Rename files (in order to avoid conflicts)
   git mv Process/Prompts/Prompt_11_Style_Manager.md Process/Prompts/Prompt_11_Style_Manager.md.tmp
   git mv Process/Prompts/Prompt_10_Update_Change_Tracking.md Process/Prompts/Prompt_5_Scan_For_User_Edits.md
   git mv Process/Prompts/Prompt_9_Git.md Process/Prompts/Prompt_12_Git_Operations.md
   git mv Process/Prompts/Prompt_8_Dashboard.md Process/Prompts/Prompt_10_Dashboard.md
   git mv Process/Prompts/Prompt_7_Export.md Process/Prompts/Prompt_9_Export.md
   git mv Process/Prompts/Prompt_6_Consistency.md Process/Prompts/Prompt_8_Consistency.md
   git mv Process/Prompts/Prompt_5_Compile.md Process/Prompts/Prompt_7_Compile.md
   git mv Process/Prompts/Prompt_4_Integrate_Inbox.md Process/Prompts/Prompt_6_Integrate_Inbox.md
   git mv Process/Prompts/Prompt_3_Modify_File.md Process/Prompts/Prompt_3_Change_by_Chg.md
   git mv Process/Prompts/Prompt_11_Style_Manager.md.tmp Process/Prompts/Prompt_11_Style_Manager.md

   git commit -m "Rename prompt files for refactor"
   ```

3. **Update file headers:**
   - Update title in each renamed file
   - Update prompt number in header
   - Commit changes

### Phase 2: Update Prompt Content

4. **Create Prompt 13 (AI_Detection_Analysis):**
   - Create `Process/Prompts/Prompt_13_AI_Detection_Analysis.md`
   - Implement complete workflow as specified in "Additional Prompt for v0.11.0" section
   - Include anti-hallucination and date confirmation protocols
   - Test thoroughly with sample chapters
   - Commit changes

5. **Update Prompt 3 (Change_by_Chg):**
   - Clarify purpose: _chg file execution only
   - Remove any interactive elements
   - Add reference to Prompt 4 for interactive editing
   - Commit changes

6. **Write Prompt 4 (Interactive_Change):**
   - Implement complete conversational workflow
   - Add file selection logic
   - Add conversational editing loop
   - Add _chg file writing logic
   - Add git commit logic
   - Add "Apply now?" prompt and Prompt 3 execution
   - Include anti-hallucination and date confirmation protocols
   - Test thoroughly
   - Commit changes

7. **Update Prompt 5 (Scan_For_User_Edits):**
   - Update any self-references to new number
   - Commit changes

8. **Update Prompts 6-12:**
   - Update self-references to new numbers
   - Update cross-references to other prompts
   - Commit each file separately

### Phase 3: Update Documentation

9. **Update QUICK_REFERENCE.md:**
   - Update all prompt numbers and names
   - Add Prompt 3 vs Prompt 4 distinction
   - Commit changes

10. **Update README.md:**
   - Update "12 Core Prompts" section
   - Update prompt list
   - Update compatibility table
   - Commit changes

11. **Update Process/Prompts/README.md:**
    - Update prompt list
    - Update descriptions
    - Update compatibility classifications
    - Commit changes

12. **Update CLAUDE.md:**
    - Update "12 Core Prompts" section
    - Update prompt descriptions
    - Update workflow examples
    - Commit changes

13. **Update system-instructions.md:**
    - Update prompt list
    - Update compatibility classifications
    - Update workflow examples
    - Commit changes

14. **Update other documentation:**
    - INSTALLATION.md
    - Process/AI-Assisted_Nonfiction_Authoring_Process.md
    - Any other files with prompt references
    - Commit changes

### Phase 4: Natural Language Intent Recognition

15. **Update book-writing-assistant.md:**
    - Add intent recognition section
    - Add example trigger phrases for all 12 prompts
    - Add "Did you mean Prompt X?" confirmation logic
    - Test in Claude Code CLI
    - Commit changes

16. **Update system-instructions.md:**
    - Add intent recognition section
    - Add example trigger phrases for all 12 prompts
    - Add "Did you mean Prompt X?" confirmation instructions
    - Test in Claude Desktop
    - Commit changes

### Phase 5: Testing and Validation

17. **Run complete test suite** (see Testing Plan above)
    - Include Prompt 13 (AI_Detection_Analysis) testing

18. **Fix any issues found**

19. **Update CHANGELOG.md** with refactor details
    - Include all 13 prompts
    - Highlight Prompt 4 (Interactive_Change) and Prompt 13 (AI_Detection_Analysis) as new features

20. **Create release** (v0.11.0)

---

## Rollback Plan

If issues are discovered after deployment:

1. **Immediate rollback:**
   ```bash
   git revert [commit-range]
   git push
   ```

2. **Or restore from backup commit:**
   ```bash
   git reset --hard [backup-commit]
   git push --force
   ```

3. **Tag old version as fallback:**
   ```bash
   git tag v0.10.3-stable
   git push --tags
   ```

---

## Migration Path for Existing Users

**Users on v0.10.x upgrading to v0.11.0:**

1. **Automatic migration via configure.md:**
   - Add migration rule to `.nonfiction-migrations.json`
   - Migration renames prompt files if user has custom copies
   - Updates any user documentation referencing old prompt numbers

2. **User notification:**
   - CHANGELOG.md explains the refactor
   - README.md highlights the change
   - Users learn about Prompt 3 vs Prompt 4 distinction

3. **Backward compatibility:**
   - Old muscle memory: "execute Prompt 3" still works (but now means _chg execution)
   - Natural language: "modify chapter 4" triggers new Prompt 4
   - All existing _chg files continue to work with Prompt 3

---

## Success Criteria

### Functionality
- ✅ Prompt 3 executes _chg instructions correctly
- ✅ Prompt 4 provides conversational editing experience
- ✅ Prompt 4 writes correct _chg file format
- ✅ Prompt 4 commits _chg file to git
- ✅ Prompt 4 offers to apply changes via Prompt 3
- ✅ Prompt 13 detects AI-generated text patterns accurately
- ✅ Prompt 13 provides actionable authenticity recommendations
- ✅ All renumbered prompts work correctly
- ✅ Natural language triggers work in both Claude Code CLI and Claude Desktop (all 13 prompts)

### Documentation
- ✅ All prompt numbers updated across all files (1-13)
- ✅ All prompt names updated
- ✅ All cross-references correct
- ✅ QUICK_REFERENCE.md accurate (13 prompts)
- ✅ README.md accurate (13 prompts)
- ✅ Compatibility tables accurate (includes Prompt 13 as CLI-ONLY)

### User Experience
- ✅ Clear distinction between Prompt 3 and Prompt 4
- ✅ Natural language invocation feels intuitive
- ✅ "Did you mean Prompt X?" confirmations work well
- ✅ Conversational editing in Prompt 4 is smooth
- ✅ Users understand when to use which prompt

---

## Timeline Estimate

- Phase 1 (File Operations): 1 hour
- Phase 2 (Update Content): 6-8 hours (includes Prompt 13 creation)
- Phase 3 (Documentation): 3-4 hours (13 prompts to document)
- Phase 4 (Intent Recognition): 2-3 hours (13 prompts to configure)
- Phase 5 (Testing): 3-4 hours (includes Prompt 13 testing)

**Total: 15-20 hours**

---

## Notes

- This is a MAJOR refactor affecting all prompts
- Adds 2 new prompts (Prompt 4: Interactive_Change, Prompt 13: AI_Detection_Analysis)
- Goes from 11 prompts to 13 prompts total
- Thorough testing required before release
- Will be released as v0.11.0 (minor version bump)
- May want beta testing period before full release
- Natural language intent recognition is experimental feature
- AI detection analysis is new quality control feature
- Monitor user feedback closely after release

---

## Additional Prompt for v0.11.0

### Prompt 13: AI_Detection_Analysis

**Purpose:** Analyze chapters for AI-generated text indicators and provide authenticity recommendations

**Rationale:**
- Authors need to ensure their content sounds authentic and human-written
- Common AI patterns can make text feel generic or artificial
- Dedicated analysis helps identify and fix these issues

**Workflow:**

1. **Ask:** "Which chapters to analyze?" (specific chapters or "all")

2. **Scan for AI text indicators:**
   - Repetitive phrasing patterns
   - Generic transitions ("Moreover", "Furthermore", "In conclusion", "It's worth noting")
   - Overly formal/stiff language
   - Lack of specific examples or personal anecdotes
   - Excessive hedging language ("might", "could", "possibly", "arguably")
   - Uniform sentence structure (lack of variety)
   - Missing personal voice/expertise markers
   - Overuse of lists and bullet points
   - Generic "best practices" language
   - Absence of conversational elements

3. **Generate detailed report:**
   - Rate each chapter on "human authenticity" scale (1-10)
   - Highlight specific passages that feel AI-generated
   - Provide examples of problematic patterns
   - Compare across chapters to identify inconsistencies

4. **Provide actionable recommendations:**
   - Suggest specific rewrites to make text more authentic
   - Recommend adding personal anecdotes or examples
   - Identify where voice/expertise should be stronger
   - Suggest varying sentence structure
   - Point out where hedging language weakens authority

5. **Output format:**
   - Summary report with overall authenticity scores
   - Per-chapter analysis with flagged sections
   - Rewriting suggestions with before/after examples
   - Priority ranking (critical, moderate, minor issues)

**Compatibility:**
- CLI-ONLY (requires bulk analysis across multiple files)
- Could have DESKTOP-FRIENDLY version for single-chapter analysis

**When to use:**
- After drafting chapters with AI assistance
- Before major milestones (25%, 50%, 75%, 100%)
- Before submission to editors or publishers
- When concerned about authenticity of specific sections

**Integration with existing prompts:**
- Can be run independently
- Recommendations can be applied via Prompt 4 (Interactive_Change)
- Results can inform revisions via Prompt 3 (Change_by_Chg)

**Target version:** v0.11.0 (included in same release as prompt refactor)

---

## Documentation Files Requiring Updates

**Research completed:** 2025-11-20

When implementing this refactor for v0.11.0, the following documentation files MUST be updated to reflect the new 13-prompt structure:

### Critical Updates (11→13 prompts, renumbered structure)

1. **CLAUDE.md** (lines 147-233)
   - Update section "11 Core Prompts" → "13 Core Prompts"
   - Add Prompt 4: Interactive_Change description
   - Renumber Prompts 4-9 → 6-12
   - Add Prompt 13: AI_Detection_Analysis description
   - Update "Quick Compatibility Reference" with new prompt numbers
   - Update CLI-ONLY list: Prompts 5,7,9 → 7,9,12

2. **system-instructions.md** (lines 42-66)
   - Update CLI-ONLY check: "Prompt 5" OR "Prompt 7" OR "Prompt 9" → "Prompt 7" OR "Prompt 9" OR "Prompt 12"
   - Update DESKTOP/HYBRID list: "Prompts 1, 2, 3, 4, 6, 8, 10, 11" → "Prompts 1, 2, 3, 4, 5, 6, 8, 10, 11"
   - Update HYBRID prompts: "Prompts 1, 4, 7" → "Prompts 1, 6, 9"

3. **PREPARE_RELEASE.md** (lines 37, 96-117, 331, 357)
   - Update all "11 prompts" → "13 prompts"
   - Update CLI-ONLY list: "Prompts 5, 7, 9" → "Prompts 7, 9, 12, 13"
   - Update DESKTOP-FRIENDLY list with renumbered prompts
   - Update HYBRID list: "Prompts 1, 11" → "Prompts 1, 6, 9, 11"
   - Update verification checklist for 13 prompts

4. **README.md** (lines 16, 82-89, 127-246)
   - Update "11 conversational prompts" → "13 conversational prompts"
   - Update "The 11 Core Prompts" → "The 13 Core Prompts"
   - Add Prompt 4 description (Interactive editing)
   - Renumber all prompts 4-11 → 6-13
   - Update workflow examples with new prompt numbers

5. **Process/Prompts/QUICK_REFERENCE.md** (lines 1-84)
   - Update compatibility tables with new prompt numbers
   - Update "At a Glance" table (11→13 rows)
   - Add Prompt 4: Interactive_Change
   - Renumber Prompts 4-11 → 6-13
   - Add Prompt 13: AI_Detection_Analysis
   - Update CLI-ONLY: Prompts 5,7,9 → 7,9,12,13

6. **Process/Prompts/README.md** (lines 15-32, 69-200+)
   - Update directory contents listing (add Prompt 4, Prompt 13, renumber)
   - Update "Available Prompts" section (13 prompts)
   - Renumber all prompt descriptions
   - Add new Prompt 4 and Prompt 13 descriptions

7. **Process/AI-Assisted_Nonfiction_Authoring_Process.md** (various lines)
   - Update all prompt number references throughout
   - Add documentation for Prompt 4 workflow
   - Add documentation for Prompt 13 analysis
   - Update cross-references to renumbered prompts

### Version References

All files currently reference:
- "11 prompts" or "11 Core Prompts"
- Prompt numbers 1-11
- CLI-ONLY: Prompts 5, 7, 9

After v0.11.0 implementation, all should reference:
- "13 prompts" or "13 Core Prompts"
- Prompt numbers 1-13
- CLI-ONLY: Prompts 7, 9, 12, 13
- DESKTOP-FRIENDLY: Prompts 2, 3, 4, 5, 8, 10
- HYBRID: Prompts 1, 6, 11
- DESKTOP-READY: Prompt 8

### Implementation Notes

- **Update documentation AFTER implementing prompt files** (not before)
- Use find/replace carefully - many prompt numbers appear in examples
- Test all cross-references after renumbering
- Update CHANGELOG.md with comprehensive v0.11.0 entry
- Consider adding migration for any config files referencing prompt numbers

---

**Status:** Ready for implementation
**Assigned to:** [To be determined]
**Target completion:** [To be determined]
