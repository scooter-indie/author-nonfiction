# Enforcement Rules Refactor - Consolidation Proposal

**Proposal Date:** 2025-11-23
**Framework Version:** 0.13.0
**Status:** Proposed for Implementation
**Purpose:** Consolidate ENFORCEMENT_RULES.md and Module 14 to eliminate redundancy

---

## Executive Summary

**Current State:** We have TWO files covering enforcement rules:
1. **Root: `ENFORCEMENT_RULES.md`** (711 lines) - Complete comprehensive rulebook
2. **Module 14: `Process/_COMMON/14_Enforcement_Rules_Module.md`** (506 lines) - Integration templates

**Problem:** ~40% content overlap, duplication of enforcement guidance, maintenance burden

**Proposed Solution:** **Consolidate Module 14 INTO ENFORCEMENT_RULES.md** (eliminate Module 14)

**Benefits:**
- ✅ Single source of truth
- ✅ Eliminates ~200 lines of duplication
- ✅ Root-level visibility for policy document
- ✅ Complete reference in one place
- ✅ Easier to maintain

**Impact:** Update ~30 files that reference Module 14

---

## Refactor Plan

### Problem Analysis

**Current Duplication:**

| Content | ENFORCEMENT_RULES.md | Module 14 | Overlap |
|---------|---------------------|-----------|---------|
| RULE 1 Statement | ✓ Detailed (lines 16-178) | ✓ Summary (lines 18-32) | 60% |
| RULE 2 Statement | ✓ Detailed (lines 181-449) | ✓ Summary (lines 34-43) | 50% |
| Standard Enforcement Notice | ✓ (lines 454-465) | ✓ (lines 46-56) | 100% |
| Routing Templates | ✓ (lines 336-412) | ✓ (lines 117-188) | 80% |
| Validation Protocols | ✓ (lines 143-178, 426-449) | ✓ (lines 191-238) | 70% |
| _chg Update Protocol | ✓ (lines 69-82) | ✓ (lines 240-289) | 90% |
| Prompt-Specific Enforcement | ✓ (lines 96-142) | ✓ (lines 291-382) | 50% |
| Testing & Compliance | ✓ (lines 525-571) | ✓ (lines 384-457) | 60% |

**Estimated Duplication:** ~200-250 lines (~40% of Module 14)

**Maintenance Issues:**
- Changes must be made in TWO places
- Risk of version drift between files
- Confusion about which file is authoritative
- Prompts reference both files (inconsistent)

---

### Proposed Solution: Consolidate into ENFORCEMENT_RULES.md

**Keep:** `ENFORCEMENT_RULES.md` at root (expand with Module 14 content)
**Delete:** `Process/_COMMON/14_Enforcement_Rules_Module.md` (eliminate redundancy)

**Why keep at root instead of moving to _COMMON/:**

1. **Policy vs Implementation**
   - ENFORCEMENT_RULES.md = Policy document (what rules exist and why)
   - Modules = Implementation guides (how to use in prompts)
   - Policy warrants root-level visibility

2. **Audience**
   - ENFORCEMENT_RULES.md: For users, AI, and maintainers
   - Modules: Primarily for prompt authors
   - Root location signals importance to all audiences

3. **Referenced Widely**
   - system-instructions.md references it (AI configuration)
   - 22 files reference ENFORCEMENT_RULES.md
   - Breaking all references would be disruptive

4. **Like PREPARE_RELEASE.md**
   - Both are operational tools at root
   - Both contain policy and procedure
   - Both actively used during operations

---

### New ENFORCEMENT_RULES.md Structure

**Proposed organization:**

```markdown
# Framework Enforcement Rules

## Part 1: Policy (The Rules)
  - Overview & Purpose
  - RULE 1: Automatic _chg File Updates
    - Statement, Scope, Enforcement, Exceptions, Implementation, Validation
  - RULE 2: Workflow Routing
    - Statement, Scope, Routing Table, Examples, Enforcement, Exceptions
  - Consequences of Violations
  - Recovery Procedures

## Part 2: Integration Guide (For Prompt Authors)
  - Standard Enforcement Notice (for all prompts)
  - Routing Response Templates (3 templates)
  - Validation Protocols (pre/during/post execution)
  - _chg File Update Protocol (standard format)
  - Prompt-Specific Enforcement (Prompts 1-16)
  - Compliance Checklist

## Part 3: Testing & Compliance
  - Self-Check Questions
  - Violation Detection
  - Testing Procedures (3 tests)
  - Recovery Procedures
  - Success Metrics
  - Examples of Correct/Incorrect Enforcement

## Part 4: Reference Tables
  - Routing Table (user request → correct prompt)
  - Prompt Enforcement Matrix (which prompts enforce which rules)
  - File Coverage (all files subject to rules)
  - Validation Checklist
```

**Estimated size:** ~850-900 lines (consolidating 711 + ~200 unique from Module 14)

---

### Implementation Checklist

#### Phase 1: Consolidate Content

- [ ] **Step 1:** Create backup of both files
  ```bash
  cp ENFORCEMENT_RULES.md ENFORCEMENT_RULES.md.backup
  cp Process/_COMMON/14_Enforcement_Rules_Module.md Process/_COMMON/14_Enforcement_Rules_Module.md.backup
  ```

- [ ] **Step 2:** Expand ENFORCEMENT_RULES.md with Module 14 content
  - [ ] Add "Part 2: Integration Guide" section
  - [ ] Merge Standard Enforcement Notice (currently duplicated)
  - [ ] Merge Routing Response Templates (consolidate 3 templates)
  - [ ] Merge Validation Protocols (consolidate pre/during/post)
  - [ ] Merge _chg Update Protocol (use Module 14's detailed version)
  - [ ] Merge Prompt-Specific Enforcement (consolidate both versions)
  - [ ] Merge Compliance Checklist
  - [ ] Add "Part 3: Testing & Compliance" section header
  - [ ] Add "Part 4: Reference Tables" section

- [ ] **Step 3:** Verify all unique content from Module 14 preserved
  - [ ] Standard enforcement notice templates
  - [ ] Routing response templates (Template 1, 2, 3)
  - [ ] Pre-commit validation format
  - [ ] Post-execution validation format
  - [ ] Auto-archive procedure
  - [ ] Testing procedures (Test 1, 2, 3)
  - [ ] Recovery procedures

- [ ] **Step 4:** Update version and metadata
  - [ ] Update version: 0.12.10 → 0.13.0
  - [ ] Add note: "Consolidated Module 14 content in v0.13.0"
  - [ ] Update last modified date

#### Phase 2: Update References (All Prompts)

**Files that reference Module 14:** (~30 files)

- [ ] **Prompt Files** (update references)
  - [ ] Process/Prompts/Prompt_1_Initialize.md
  - [ ] Process/Prompts/Prompt_2_Add_Chapter.md
  - [ ] Process/Prompts/Prompt_3_Change_by_Chg.md
  - [ ] Process/Prompts/Prompt_4_Interactive_Change.md
  - [ ] Process/Prompts/Prompt_5_Scan_For_User_Edits.md
  - [ ] Process/Prompts/Prompt_6_Integrate_Inbox.md
  - [ ] Process/Prompts/Prompt_7_Compile.md
  - [ ] Process/Prompts/Prompt_8_Consistency.md
  - [ ] Process/Prompts/Prompt_9_Export.md
  - [ ] Process/Prompts/Prompt_10_Dashboard.md
  - [ ] Process/Prompts/Prompt_11_Style_Manager.md
  - [ ] Process/Prompts/Prompt_12_Git_Operations.md
  - [ ] Process/Prompts/Prompt_13_AI_Detection_Analysis.md
  - [ ] Process/Prompts/Prompt_14_Citation_Finder.md

**Change in prompts:**
```markdown
OLD:
See: `Process/_COMMON/14_Enforcement_Rules_Module.md`

NEW:
See: `ENFORCEMENT_RULES.md` (Part 2: Integration Guide)
```

- [ ] **Module Files**
  - [ ] Process/_COMMON/01_Prompt_Structure_Template.md (references Module 14)
  - [ ] Process/_COMMON/README.md (lists Module 14, needs update)

**Change in _COMMON/README.md:**
```markdown
OLD:
| 14 | `14_Enforcement_Rules_Module.md` | Mandatory compliance rules integration |

NEW:
Note: Module 14 was consolidated into root-level ENFORCEMENT_RULES.md in v0.13.0
See: `ENFORCEMENT_RULES.md` for enforcement rules and integration guidance
```

- [ ] **system-instructions.md** (verify reference still works)
  - Currently references ENFORCEMENT_RULES.md ✓ (no change needed)

#### Phase 3: Delete Module 14

- [ ] **Step 1:** Verify all content migrated
  - [ ] Review consolidated ENFORCEMENT_RULES.md
  - [ ] Confirm all Module 14 sections present
  - [ ] Check no content lost

- [ ] **Step 2:** Delete Module 14
  ```bash
  git rm Process/_COMMON/14_Enforcement_Rules_Module.md
  ```

- [ ] **Step 3:** Update module numbering (optional)
  - Keep gap at 14 (note: "Module 14 deprecated, consolidated into ENFORCEMENT_RULES.md")
  - OR: Renumber modules 15-18 → 14-17 (more complex, not recommended)

**Recommendation:** Keep gap at 14 with deprecation note

#### Phase 4: Update Documentation

- [ ] **CHANGELOG.md** - Add entry:
  ```markdown
  ## [0.13.0] - 2025-11-23

  ### Changed
  - Consolidated Module 14 (Enforcement Rules Module) into root-level ENFORCEMENT_RULES.md
  - Eliminated ~200 lines of duplication between files
  - Updated all prompt references to point to consolidated ENFORCEMENT_RULES.md

  ### Removed
  - Process/_COMMON/14_Enforcement_Rules_Module.md (content merged into ENFORCEMENT_RULES.md)
  ```

- [ ] **Process/_COMMON/README.md** - Update module count
  ```markdown
  OLD: This directory contains 14 standardized modules...
  NEW: This directory contains 13 active modules (Module 14 deprecated in v0.13.0)...
  ```

- [ ] **FRAMEWORK_CORE.md** - Update reference (if any)

#### Phase 5: Validation

- [ ] **Test 1:** Verify all references updated
  ```bash
  grep -r "14_Enforcement_Rules_Module" --include="*.md" .
  # Should return empty (no matches)
  ```

- [ ] **Test 2:** Verify ENFORCEMENT_RULES.md completeness
  - [ ] Read through consolidated file
  - [ ] Confirm all 4 parts present
  - [ ] Check for broken internal links

- [ ] **Test 3:** Verify prompts still reference correctly
  ```bash
  grep -r "ENFORCEMENT_RULES.md" --include="*.md" Process/Prompts/
  # Should find references in all prompts
  ```

- [ ] **Test 4:** Verify _COMMON/README.md updated
  - [ ] Module 14 no longer listed as active
  - [ ] Deprecation note present
  - [ ] Reference to ENFORCEMENT_RULES.md included

---

### File-by-File Update Guide

#### Prompts (Change Reference Path)

**Current reference in prompts:**
```markdown
**CRITICAL ENFORCEMENT:**
- **RULE 1:** All file modifications MUST update corresponding _chg files
- **RULE 2:** All Manuscript/ changes must go through appropriate prompts

See: `Process/_COMMON/14_Enforcement_Rules_Module.md`
```

**Updated reference:**
```markdown
**CRITICAL ENFORCEMENT:**
- **RULE 1:** All file modifications MUST update corresponding _chg files
- **RULE 2:** All Manuscript/ changes must go through appropriate prompts

See: `ENFORCEMENT_RULES.md` (Part 2: Integration Guide)
```

**Apply to:**
- All 16 prompt files (Prompt_1 through Prompt_16)
- Process/_COMMON/01_Prompt_Structure_Template.md

---

#### _COMMON/README.md (Update Module List)

**Current (lines 24-31):**
```markdown
### Foundation Modules (01-03, 14)

| Module | File | Purpose |
|--------|------|---------|
| 01 | `01_Prompt_Structure_Template.md` | Master template for all prompts |
| 02 | `02_Desktop_Compatibility_Module.md` | Compatibility level definitions |
| 03 | `03_Anti_Hallucination_Protocols.md` | Three-level verification system |
| 14 | `14_Enforcement_Rules_Module.md` | Mandatory compliance rules integration |
```

**Updated:**
```markdown
### Foundation Modules (01-03)

| Module | File | Purpose |
|--------|------|---------|
| 01 | `01_Prompt_Structure_Template.md` | Master template for all prompts |
| 02 | `02_Desktop_Compatibility_Module.md` | Compatibility level definitions |
| 03 | `03_Anti_Hallucination_Protocols.md` | Three-level verification system |

**Note:** Module 14 (Enforcement Rules) was consolidated into root-level `ENFORCEMENT_RULES.md` in v0.13.0 to eliminate duplication. See `ENFORCEMENT_RULES.md` (Part 2: Integration Guide) for enforcement rules and prompt integration templates.
```

**Current (line 12):**
```markdown
This directory contains 14 standardized modules that provide shared functionality across all Execute Prompts.
```

**Updated:**
```markdown
This directory contains 13 active modules that provide shared functionality across all Execute Prompts. (Module 14 deprecated in v0.13.0 - consolidated into root-level ENFORCEMENT_RULES.md)
```

---

### Benefits of Consolidation

**Before (Current State):**
```
Root/
├── ENFORCEMENT_RULES.md (711 lines)
│   - Complete policy document
│   - Detailed rules and rationale
│   - Some templates and examples
│
Process/_COMMON/
└── 14_Enforcement_Rules_Module.md (506 lines)
    - Integration templates
    - Validation protocols
    - ~200 lines duplicate from ENFORCEMENT_RULES.md
```

**After (Proposed State):**
```
Root/
├── ENFORCEMENT_RULES.md (~900 lines)
│   - Part 1: Policy (The Rules)
│   - Part 2: Integration Guide (for prompt authors)
│   - Part 3: Testing & Compliance
│   - Part 4: Reference Tables
│   - Single source of truth
│
Process/_COMMON/
└── (Module 14 removed, gap noted in README)
```

**Metrics:**
- **Lines saved:** ~200 lines of duplication eliminated
- **Files reduced:** 2 → 1 (50% reduction)
- **Maintenance:** Update 1 file instead of 2
- **Clarity:** Single authoritative source
- **References:** ~30 files updated (one-time cost)

---

### Risks & Mitigations

#### Risk 1: Breaking References During Update

**Risk:** If update incomplete, some prompts point to deleted Module 14
**Impact:** High - prompts would reference missing file
**Mitigation:**
- Use grep to find ALL references before deleting Module 14
- Update all references BEFORE deleting file
- Test with grep after update
- Keep backup of Module 14 until validation complete

#### Risk 2: Content Loss During Consolidation

**Risk:** Unique content from Module 14 accidentally omitted
**Impact:** Medium - loss of integration guidance
**Mitigation:**
- Create detailed content map (which sections from each file)
- Review consolidated file section-by-section
- Keep backup files until validation complete
- Have second person review for completeness

#### Risk 3: ENFORCEMENT_RULES.md Becomes Too Long

**Risk:** Consolidated file becomes unwieldy (~900 lines)
**Impact:** Low - harder to navigate
**Mitigation:**
- Use clear part divisions (Part 1, 2, 3, 4)
- Add comprehensive Table of Contents
- Use markdown anchors for internal linking
- Still shorter than AI-Assisted Process (1,692 lines)

---

### Timeline

**Estimated Effort:**
- Phase 1 (Consolidate Content): 2-3 hours
- Phase 2 (Update References): 1-2 hours
- Phase 3 (Delete Module 14): 15 minutes
- Phase 4 (Update Documentation): 30 minutes
- Phase 5 (Validation): 1 hour

**Total:** 5-7 hours

**Recommended Approach:**
1. Do Phase 1 (consolidation) first, review thoroughly
2. Do Phases 2-5 in single session (avoid partial state)
3. Commit with descriptive message documenting consolidation

---

## Current Integration Analysis (For Reference)

### The Two Enforcement Rules

### RULE 1: Automatic _chg File Updates

**Statement:**
> WHENEVER the AI updates any file in the Manuscript/ directory, it MUST also update the corresponding _chg.md file.

**Scope:**
- All content files in Manuscript/Chapters/
- All files in Manuscript/FrontMatter/, BackMatter/
- Manuscript/_TOC_/TOC.md
- Manuscript/Quotes/Chapter_Quotes.md
- Manuscript/Style/ files

**No exceptions** - even for:
- Minor changes
- Formatting only
- Automated operations
- Testing

---

### RULE 2: Workflow Routing

**Statement:**
> ANY change requested that will act upon a file in the Manuscript/ directory MUST be routed through an appropriate Execute Prompt.

**Critical:** **NO direct editing is EVER allowed**, including:
- ❌ Initial drafting ("Draft chapter 4")
- ❌ First content creation ("Write chapter 1")
- ❌ Quick changes ("Just fix this typo")
- ❌ Testing ("Let me try something")
- ❌ Minor edits ("Small formatting fix")

**Always use:** Prompt 3 or Prompt 4 for ALL manuscript content modifications

---

## How Rules Are Invoked

### 1. Through Module 14 (Process/_COMMON/14_Enforcement_Rules_Module.md)

**Purpose:** Provides standardized templates and procedures for integrating enforcement rules

**What it provides:**
- Standard enforcement notice (included in all prompts)
- Routing response templates
- Validation protocols
- _chg file update protocol
- Prompt-specific enforcement instructions
- Testing and compliance checklists

**Integration method:**
- Prompts reference Module 14 for enforcement patterns
- Provides copy/paste templates for consistent enforcement
- Documents proper validation procedures

---

### 2. Through Individual Prompts (All 16 Prompts)

**22 files reference ENFORCEMENT_RULES.md** including:

#### File-Modifying Prompts (Enforce Rule 1):
1. **Prompt 1 (Initialize)** - Creates initial _chg files with Version 1.0.0
2. **Prompt 2 (Add Chapter)** - Creates chapter _chg file, updates TOC_chg.md, Chapter_Quotes_chg.md
3. **Prompt 3 (Change by Chg)** - PRIMARY EXAMPLE - Auto-archives to Version History
4. **Prompt 4 (Interactive Change)** - Writes instructions to _chg, optionally executes
5. **Prompt 5 (Scan For User Edits)** - Reconstructs missing _chg entries from git
6. **Prompt 6 (Integrate Inbox)** - Updates/creates _chg files for modified/new content
7. **Prompt 10 (Dashboard)** - May update PROJECT_CONTEXT.md (no _chg needed for this)
8. **Prompt 11 (Style Manager)** - Updates Style_Overrides.md and _chg file

#### Read-Only/Export Prompts (Explicit Exception):
- **Prompt 7 (Compile)** - Read-only, no _chg updates required
- **Prompt 8 (Consistency)** - Read-only analysis, no modifications
- **Prompt 9 (Export)** - Creates exports, doesn't modify source files
- **Prompt 12 (Git Operations)** - Version control only, no content modifications
- **Prompt 13 (AI Detection)** - Read-only analysis
- **Prompt 14 (Citation Finder)** - May modify content, updates _chg files
- **Prompt 15 (Visual Content)** - Creates visuals, updates _chg files
- **Prompt 16 (Image Manager)** - Manages images, updates _chg files

**How they invoke:**

Each prompt includes:

```markdown
**CRITICAL ENFORCEMENT:**
- **RULE 1:** All file modifications MUST update corresponding _chg files
- **RULE 2:** All Manuscript/ changes must go through appropriate prompts

See: `Process/ENFORCEMENT_RULES.md` for complete details
```

**Workflow integration:**
- Explicit _chg update steps in workflow
- Pre-commit validation (verify both files staged)
- Post-execution validation (confirm both files updated)
- Version increment based on change scope

---

### 3. Through system-instructions.md

**Location:** Lines referenced in ENFORCEMENT_RULES.md

**What it contains:**
```markdown
## CRITICAL ENFORCEMENT RULES

1. **RULE 1: Automatic _chg Updates**
   - WHENEVER I modify any file in Manuscript/, I MUST update its _chg.md file
   - Document version, date, changes, rationale
   - NO EXCEPTIONS

2. **RULE 2: Workflow Routing**
   - ALL Manuscript/ changes MUST go through appropriate Execute Prompts
   - I MUST NOT directly modify Manuscript/ files outside prompts
   - Route user requests to correct prompt (see routing table)

See: ENFORCEMENT_RULES.md for complete details
```

**How it invokes:**
- Configures AI behavior at the system level
- AI reads this at session startup (or should)
- Establishes mandatory compliance expectations
- Provides routing guidance

**Current status:**
- system-instructions.md DOES reference ENFORCEMENT_RULES.md
- Includes enforcement rules in **ABSOLUTE PROHIBITION section** (lines 259-310)
- Provides routing templates and examples

---

## Invocation Flow

### Scenario 1: User Executes Prompt 3 (Compliant Flow)

```
1. User: Opens Chapter_05_chg.md
2. User: Writes instructions in [INSTRUCTIONS FOR THIS REVISION]
3. User: Commits _chg file to git
4. User: Executes Prompt 3

5. AI: Reads ENFORCEMENT_RULES reference in Prompt 3
6. AI: Reads instructions from _chg file
7. AI: Applies modifications to Chapter_05.md
8. AI: Updates Chapter_05_chg.md with Version History entry ← RULE 1 ENFORCED
9. AI: Increments version: 1.2.3 → 1.3.0
10. AI: Validates both files ready for commit
11. AI: Provides git commit command for BOTH files
12. AI: Report confirms both files updated

Result: ✅ COMPLIANT - Rule 1 enforced automatically
```

---

### Scenario 2: User Asks to Modify Directly (Rule 2 Routing)

```
1. User: "Can you add a section about data validation to Chapter 3?"

2. AI: Detects Manuscript/ modification request outside prompt
3. AI: Reads RULE 2 from system-instructions.md or Module 14
4. AI: Applies routing template

5. AI Response:
   "I cannot modify Manuscript/ files directly. This change should
   go through Prompt 3 (Modify File).

   Here's how:
   1. Open: Manuscript/Chapters/Chapter_03/Chapter_03_chg.md
   2. Add your instructions in [INSTRUCTIONS FOR THIS REVISION]
   3. Commit the _chg file
   4. Execute Prompt 3

   This ensures proper change tracking, version history, and validation."

Result: ✅ COMPLIANT - Rule 2 enforced, user routed to correct prompt
```

---

### Scenario 3: User Asks to Draft Chapter (Common Case)

```
1. User: "Draft chapter 3" OR "Write chapter 1"

2. AI: Detects initial content creation request
3. AI: Reads RULE 2 with "NO exception for initial content" clause
4. AI: Routes to Prompt 3 or 4 (not direct editing)

5. AI Response:
   "I'll help you draft that chapter. Since this creates manuscript
   content, we need to use Prompt 3 or 4:

   Recommended: Prompt 4 (Interactive Change)
   1. Execute Prompt 4
   2. Select the chapter
   3. Tell me what content you want
   4. I'll write instructions to Chapter_03_chg.md
   5. Optionally execute immediately
   6. Version 1.0.0 is tracked from the start

   Which workflow would you prefer?"

Result: ✅ COMPLIANT - Even initial drafts use prompts, Rule 2 enforced
```

---

## Validation Mechanisms

### Pre-Execution Validation

**Before modifying files:**
1. Verify this is a legitimate prompt execution
2. Confirm user has followed correct routing
3. Identify which files will be modified
4. Prepare to update corresponding _chg files

### During Execution Validation

**While modifying files:**
1. Track all file modifications
2. Update corresponding _chg files immediately after content changes
3. Include all required metadata:
   - Version number (N.M.P)
   - Date (YYYY-MM-DD)
   - Type (Content Addition/Deletion/Structural Change/Refinement)
   - Scope (affected sections)
   - Priority (Low/Medium/High)
   - Rationale (why change was made)
   - Changes Made (detailed list)

### Post-Execution Validation

**After modifying files:**
1. Verify every modified Manuscript/ file has updated _chg file
2. Confirm both files ready for git commit
3. Generate report showing what was tracked
4. Provide git command including both files

**Example validation report:**
```
Validation checklist:
✅ Content file modified: Chapter_03.md
✅ _chg file updated: Chapter_03_chg.md
✅ Version entry added to Version History
✅ Version number incremented: 1.2.3 → 1.3.0
✅ Git commit includes both files
✅ Change type documented: Content Addition
```

---

## Testing Compliance

### Test 1: Rule 1 Compliance (File Pairing)

**Command:**
```bash
git status
```

**Expected result:**
```
modified:   Manuscript/Chapters/Chapter_03/Chapter_03.md
modified:   Manuscript/Chapters/Chapter_03/Chapter_03_chg.md
```

**PASS:** Both files modified together
**FAIL:** Only content file modified → VIOLATION

---

### Test 2: Rule 2 Compliance (Routing)

**Attempt:**
```
User: "Can you update Chapter 3 to add a new section?"
```

**Expected response:**
```
I cannot modify Manuscript/ files directly. This change should
go through Prompt 3 (Modify File).

Here's how:
[Routing instructions]
```

**PASS:** Redirects to appropriate prompt
**FAIL:** Attempts direct modification → VIOLATION

---

### Test 3: Git Commit Validation (Both Files)

**Command:**
```bash
git log -1 --name-only
```

**Expected result:**
```
commit [hash]
Author: [name]
Date: [date]

Update Chapter 3 with case studies v1.3.0

Manuscript/Chapters/Chapter_03/Chapter_03.md
Manuscript/Chapters/Chapter_03/Chapter_03_chg.md
```

**PASS:** Both files in commit
**FAIL:** Only one file in commit → VIOLATION

---

## Recovery Procedures

### If Rule 1 Violated (Missing _chg update)

**Symptoms:**
- Content file modified but _chg file not updated
- Git commit includes only content file
- No version entry in Version History

**Recovery:**

**Option A: Amend commit immediately**
```bash
# Update missing _chg file manually or with AI
# Then amend the commit:
git add Manuscript/Chapters/Chapter_03/Chapter_03_chg.md
git commit --amend --no-edit
```

**Option B: Run Prompt 5 (Scan For User Edits)**
```
Execute Prompt 5 (Scan For User Edits)
```
This scans git history and reconstructs missing _chg entries automatically.

---

### If Rule 2 Violated (Direct modification)

**Symptoms:**
- AI attempted to directly edit Manuscript/ file
- No prompt execution occurred
- User bypassed workflow

**Recovery:**
1. Undo any direct modifications made (git revert)
2. Respond with correct prompt routing
3. Guide user through appropriate prompt
4. Document the mistake to prevent repetition

---

## Integration Status by File

| File | Invokes Rules? | How Invoked |
|------|---------------|-------------|
| **ENFORCEMENT_RULES.md** | Defines | Source document |
| **Process/_COMMON/14_Enforcement_Rules_Module.md** | Templates | Provides integration patterns |
| **system-instructions.md** | ✅ Yes | AI behavior configuration |
| **Prompt 1** | ✅ Yes | Creates initial _chg files |
| **Prompt 2** | ✅ Yes | Updates multiple _chg files |
| **Prompt 3** | ✅ Yes | PRIMARY EXAMPLE - auto-archive |
| **Prompt 4** | ✅ Yes | Writes instructions, executes |
| **Prompt 5** | ✅ Yes | Reconstructs missing entries |
| **Prompt 6** | ✅ Yes | Integrates with _chg updates |
| **Prompt 7** | ✅ Exception | Read-only, explicitly notes no _chg |
| **Prompt 8** | ✅ Exception | Read-only, explicitly notes no _chg |
| **Prompt 9** | ✅ Exception | Export only, explicitly notes no _chg |
| **Prompt 10** | ✅ Yes | Updates PROJECT_CONTEXT (no _chg) |
| **Prompt 11** | ✅ Yes | Updates Style_Overrides and _chg |
| **Prompt 12** | ✅ Exception | Git only, explicitly notes no _chg |
| **Prompt 13** | ✅ Exception | Read-only analysis |
| **Prompt 14** | ✅ Yes | May modify, updates _chg |
| **Prompt 15** | ✅ Yes | Creates visuals, updates _chg |
| **Prompt 16** | ✅ Yes | Manages images, updates _chg |

---

## Key Insights

### 1. Enforcement is Multi-Layered

**Layer 1: Documentation** (ENFORCEMENT_RULES.md)
- Defines the rules authoritatively
- Explains rationale and scope
- Provides examples and templates

**Layer 2: Modularization** (Module 14)
- Standardizes integration across prompts
- Provides reusable templates
- Ensures consistency

**Layer 3: Implementation** (All 16 Prompts)
- Each prompt explicitly references rules
- Workflow steps integrate enforcement
- Validation built into execution

**Layer 4: AI Configuration** (system-instructions.md)
- Configures AI behavior at startup
- Establishes mandatory compliance
- Provides routing templates

### 2. No Loopholes

**Common attempts to bypass:**
- ❌ "It's just a small change" → Still requires prompts
- ❌ "This is the first draft" → Still requires prompts (Prompt 3 or 4)
- ❌ "I'm just testing" → Still requires prompts or manual editing + Prompt 5
- ❌ "Can we skip tracking?" → NO - absolutely required

**Enforcement is absolute** - no exceptions exist except read-only operations.

### 3. Self-Healing with Prompt 5

**If violations occur:**
- Prompt 5 (Scan For User Edits) reconstructs missing _chg entries
- Scans git history for manual edits
- Automatically generates Version History entries
- Syncs change tracking files

**This provides:**
- Recovery mechanism for accidental violations
- Safety net for manual edits (if user edits outside Claude)
- Audit trail reconstruction

---

## Relationship to v0.13.0 Changes

### ENFORCEMENT_RULES.md Status in v0.13.0

**Location:** Root level (stays where it is)
**Included in release:** YES (maintainer tool, like PREPARE_RELEASE.md)
**Referenced by:** All prompts, Module 14, system-instructions.md

**Not moving to Documentation/** because:
- Actively used by prompts (referenced at runtime)
- Part of operational framework (not just reference docs)
- Needs to be accessible to AI during execution
- Similar to configure.md and PREPARE_RELEASE.md (tools, not reference)

### Module 14 Status

**Location:** Process/_COMMON/14_Enforcement_Rules_Module.md
**Purpose:** Integration templates for prompts
**Status:** Part of modular system, stays in _COMMON/

**Relationship:**
- ENFORCEMENT_RULES.md = Complete rulebook (root level)
- Module 14 = Integration patterns for prompts (_COMMON/)
- system-instructions.md = AI configuration (root level)

All three work together to enforce rules at multiple levels.

---

## Recommendations

### 1. Keep Current Structure ✅

**Do NOT move:**
- ENFORCEMENT_RULES.md (operational tool, not reference docs)
- Module 14 (part of modular system)
- system-instructions.md (AI configuration)

**Why:** These are active operational components, not reference documentation.

### 2. Update for v0.13.0 References

**Update ENFORCEMENT_RULES.md:**
- [ ] Update version: 0.12.10 → 0.13.0
- [ ] Update references to session startup (mention FRAMEWORK_CORE.md)
- [ ] Verify all 16 prompts still referenced correctly

**Update Module 14:**
- [ ] Update version: 0.10.0 → 0.13.0
- [ ] Verify templates still accurate for v0.13.0 structure

### 3. Verify in FRAMEWORK_CORE.md

**Check:** Does FRAMEWORK_CORE.md mention enforcement rules?

**Current status:** FRAMEWORK_CORE.md Section 4 includes "Change Tracking System (Essential Rules)" but doesn't explicitly mention ENFORCEMENT_RULES.md.

**Recommendation:** Add reference in FRAMEWORK_CORE.md:

```markdown
## 4. Change Tracking System (Essential Rules)

**Critical:** ALL changes to Manuscript/ files are tracked via _chg files.

**Two mandatory enforcement rules:**
1. **RULE 1:** All file modifications MUST update corresponding _chg files
2. **RULE 2:** All Manuscript/ changes MUST go through appropriate prompts

**Complete details:** See `ENFORCEMENT_RULES.md` at root

**Why this is absolute:**
...
```

---

## Conclusion

**ENFORCEMENT_RULES.md is fully integrated and actively enforced throughout the framework.**

**Invocation happens through:**
1. ✅ Module 14 provides integration templates
2. ✅ All 16 prompts reference and implement rules
3. ✅ system-instructions.md configures AI behavior
4. ✅ Multi-layer validation ensures compliance

**No changes needed for v0.13.0** except:
- Version number updates
- Optional reference in FRAMEWORK_CORE.md for user visibility

**Status:** ✅ **Enforcement system is robust and complete**

---

**Document Version:** 1.0
**Date:** 2025-11-23
**Author:** Claude (Sonnet 4.5)
