# Framework Common Modules

**Framework Version:** 0.14.0
**Directory:** Process/_COMMON/
**Purpose:** Shared, reusable modules for all Execute Prompts

---

## Overview

This directory contains 18 active modules that provide shared functionality across all Execute Prompts. (Module 14 deprecated in v0.13.0 - consolidated into root-level ENFORCEMENT_RULES.md) These modules reduce duplication, ensure consistency, and serve as the single source of truth for common patterns.

**Benefits:**
- ✅ **DRY Principle:** Single source of truth eliminates 2,500+ lines of duplication
- ✅ **Consistency:** All prompts follow identical patterns
- ✅ **Maintainability:** Bug fixes apply to all prompts automatically
- ✅ **Clarity:** Prompts are more concise and easier to read
- ✅ **Enforcement:** Mandatory compliance rules integrated throughout

---

## Module Index

### Foundation Modules (01-03)

| Module | File | Purpose |
|--------|------|---------|
| 01 | `01_Prompt_Structure_Template.md` | Master template for all prompts |
| 02 | `02_Desktop_Compatibility_Module.md` | Compatibility level definitions |
| 03 | `03_Anti_Hallucination_Protocols.md` | Three-level verification system |

**Note:** Module 14 (Enforcement Rules) was consolidated into root-level `ENFORCEMENT_RULES.md` in v0.13.0 to eliminate duplication. See `ENFORCEMENT_RULES.md` (Part 2: Integration Guide) for enforcement rules and prompt integration templates.

### Core Operations (04-06)

| Module | File | Purpose |
|--------|------|---------|
| 04 | `04_File_Operations_Library.md` | Standardized file operations |
| 05 | `05_Git_Integration_Module.md` | Git commands and formats |
| 06 | `06_Validation_Protocols.md` | Safety checks and validation |

### Content Management (07-08, 10)

| Module | File | Purpose |
|--------|------|---------|
| 07 | `07_Quote_Management_System.md` | Quote tracking and verification |
| 08 | `08_Semantic_Versioning_Guide.md` | Version numbering rules |
| 10 | `10_Style_Consistency_Protocol.md` | Writing style validation |

### Reporting & Interaction (09, 11-13)

| Module | File | Purpose |
|--------|------|---------|
| 09 | `09_Report_Templates.md` | Statistics and report formats |
| 11 | `11_Interactive_Patterns.md` | Question/answer templates |
| 12 | `12_Workflow_Patterns.md` | Common workflow sequences |
| 13 | `13_PROJECT_CONTEXT_Protocol.md` | Context file management |

### Visual & Content Management (15-17)

| Module | File | Purpose |
|--------|------|---------|
| 15 | `15_Visual_Asset_Management_Protocol.md` | Visual assets, registry, status codes |
| 16 | `16_Citation_Management_Protocol.md` | Citation tracking and verification |
| 17 | `17_README_Management_Module.md` | README file management |

### Infrastructure (18-20)

| Module | File | Purpose |
|--------|------|---------|
| 18 | `18_Lock_Management_Module.md` | Concurrent editing locks |
| 19 | `19_Image_Registry_Splitting_Module.md` | Registry splitting for large collections |
| 20 | `20_JSON_Schema_Module.md` | JSON schema standards for .config/ files (NEW v0.13.3) |

---

## Quick Reference Guide

### How Modules Are Used

**Modules provide:**
1. **Templates** - Standardized formats (e.g., git commit messages)
2. **Protocols** - Step-by-step procedures (e.g., file operations)
3. **Guidelines** - Decision criteria (e.g., when to increment version)
4. **Patterns** - Reusable workflows (e.g., read-modify-archive)
5. **Reference Data** - Tables, checklists, examples

**Prompts reference modules by:**
- Following templates
- Implementing protocols
- Applying guidelines
- Using patterns
- Including reference data

---

## Module Usage Examples

### Example 1: Prompt 3 Uses Multiple Modules

**Prompt 3 (Modify File) references:**

- **Module 01:** Overall structure template
- **Module 02:** DESKTOP-FRIENDLY compatibility header
- **Module 03:** Anti-Hallucination Level 3 (comprehensive verification)
- **Module 04:** File operations (read _chg, write content, auto-archive)
- **Module 05:** Git commit format and commands
- **Module 08:** Semantic versioning for version increments
- **Module 10:** Style consistency checking
- **Module 11:** Interactive patterns (questions/confirmation)
- **Module 14:** Enforcement rules notice and validation

**Result:** Prompt 3 is concise yet complete by referencing these modules instead of duplicating content.

### Example 2: Git Commit Format (Module 05)

**Instead of this in EVERY prompt:**
```markdown
## Git Commit Format

When providing the git commit command at the end, format it like this:

[20+ lines of formatting instructions duplicated across 4 prompts]
```

**Now:**
```markdown
See: `05_Git_Integration_Module.md` for commit format templates
```

**Saves:** 80+ lines across 4 prompts = 320 lines total

### Example 3: Anti-Hallucination Protocols (Module 03)

**Instead of:**
- Prompt 1: 10 lines of brief note
- Prompt 3: 75 lines of comprehensive verification
- Prompts 4, 5: 7 lines of contextual note
- Prompts 6-10: 1 line reference

**Now:**
- Module 03 contains all three levels
- Each prompt references appropriate level
- Single source of truth for verification protocols

**Saves:** 150+ lines of duplication

---

## Enforcement Rules Integration

**CRITICAL:** All modules integrate the two mandatory enforcement rules:

### RULE 1: Automatic _chg File Updates

**Integrated in:**
- Module 01: Prompt structure includes enforcement notice
- Module 04: File operations mandate _chg updates
- Module 05: Git commits verify both files included
- ENFORCEMENT_RULES.md: Complete enforcement rule templates and validation (Part 2: Integration Guide)

**Result:** Impossible to violate Rule 1 when following module protocols

### RULE 2: Workflow Routing

**Integrated in:**
- Module 01: Standard structure includes routing validation
- Module 11: Routing response patterns
- ENFORCEMENT_RULES.md: Routing table and redirect templates (Part 2: Integration Guide)

**Result:** Clear routing guidance built into all prompts

---

## For Prompt Authors/Maintainers

### Creating a New Prompt

**Follow these steps:**

1. **Start with Module 01 (Structure Template)**
   - Copy the standard structure
   - Fill in variables for your prompt

2. **Choose compatibility level (Module 02)**
   - DESKTOP-READY (100%)
   - DESKTOP-FRIENDLY (95%)
   - CLI-ONLY

3. **Select anti-hallucination level (Module 03)**
   - Level 1: Reference only (read-only prompts)
   - Level 2: Contextual note (may generate content)
   - Level 3: Comprehensive (primary content generation)

4. **Add enforcement notice (ENFORCEMENT_RULES.md)**
   - Include CRITICAL ENFORCEMENT section
   - Add appropriate NOTE for _chg behavior
   - See Part 2: Integration Guide for templates

5. **Reference relevant operational modules**
   - File operations (Module 04) if modifying files
   - Git integration (Module 05) if committing
   - Validation (Module 06) for safety checks
   - Quote management (Module 07) if handling quotes
   - Versioning (Module 08) for version increments
   - Style checking (Module 10) if validating content

6. **Use appropriate patterns**
   - Report templates (Module 09) for output formatting
   - Interactive patterns (Module 11) for user interaction
   - Workflow patterns (Module 12) for common sequences
   - PROJECT_CONTEXT protocol (Module 13) if updating context

7. **Validate against enforcement rules (ENFORCEMENT_RULES.md)**
   - Verify _chg update steps included (if modifying files)
   - Include pre-commit validation (if using git)
   - Add routing responses (if users might try direct modification)
   - See Part 2: Integration Guide for compliance checklist

### Updating an Existing Prompt

**Checklist:**

- [ ] Enforcement notice added to header
- [ ] Anti-hallucination level appropriate
- [ ] File operation protocols followed (Module 04)
- [ ] Git commit format standardized (Module 05)
- [ ] Validation checks implemented (Module 06)
- [ ] Version increment logic correct (Module 08)
- [ ] Report formatting consistent (Module 09)
- [ ] Interactive patterns standardized (Module 11)
- [ ] Workflow sequences follow patterns (Module 12)
- [ ] Enforcement rules compliance verified (ENFORCEMENT_RULES.md)

---

## Module Maintenance

### Updating a Module

**When updating modules:**

1. **Consider impact:** Module changes affect ALL prompts that use it
2. **Test thoroughly:** Verify no regressions in dependent prompts
3. **Update version:** Increment module version number
4. **Document changes:** Update this README if structure changes
5. **Communicate:** If breaking changes, document migration path

### Version Control

**Each module has:**
- Version number (matches framework version: 0.10.0)
- Last updated date
- Status (Active/Deprecated/Draft)

### Dependencies

**Modules can reference other modules:**
- Module 04 references Module 08 (versioning)
- Module 04 references ENFORCEMENT_RULES.md (enforcement)
- Module 05 references ENFORCEMENT_RULES.md (enforcement validation)
- Module 03 references Module 07 (quote management)

**When updating, check dependencies.**

---

## Module Compliance Checklist

### For All Modules

- [ ] Header includes version, purpose, status
- [ ] Clear, concise documentation
- [ ] Examples provided where helpful
- [ ] Cross-references to related modules
- [ ] Version number matches framework version
- [ ] Last updated date current

### For Modules with Protocols

- [ ] Step-by-step procedures clear
- [ ] Error handling defined
- [ ] Success criteria specified
- [ ] Examples of correct usage

### For Modules with Templates

- [ ] Variables clearly marked (e.g., `{VARIABLE}`)
- [ ] Complete examples provided
- [ ] Edge cases addressed

### For Enforcement-Related Modules

- [ ] RULE 1 compliance ensured
- [ ] RULE 2 compliance ensured
- [ ] Validation procedures included
- [ ] Recovery procedures documented

---

## Testing Modules

### Manual Testing

**Test module changes by:**

1. **Update module:** Make changes to module file
2. **Select test prompt:** Choose prompt that uses the module
3. **Execute prompt:** Run complete workflow
4. **Verify behavior:** Ensure module changes work as expected
5. **Check side effects:** Verify no unintended impacts
6. **Test edge cases:** Try failure scenarios

### Validation Tests

**Key validation points:**

**Module 04 (File Operations):**
- Test: Modify file without _chg update → Should fail
- Test: Create file, verify _chg file created
- Test: Atomic operation failure → Both files rollback

**Module 05 (Git Integration):**
- Test: Commit with only content file → Should fail validation
- Test: Commit with both files → Should succeed
- Test: Commit message format → Should match template

**Module 06 (Validation):**
- Test: Missing file → Should detect and report
- Test: Broken cross-reference → Should find and flag
- Test: Out-of-sync _chg file → Should identify

**ENFORCEMENT_RULES.md (Enforcement):**
- Test: Direct modification attempt → Should redirect to prompt
- Test: Rule 1 violation → Should detect and fix
- Test: Rule 2 violation → Should route correctly

---

## Performance Impact

**Module-based architecture:**

**Benefits:**
- ✅ Faster prompt execution (less code to parse)
- ✅ Reduced token usage (shorter prompts)
- ✅ Clearer logic flow (separation of concerns)
- ✅ Easier debugging (isolated functionality)

**Tradeoffs:**
- ⚠️ Indirection (need to reference modules)
- ⚠️ Learning curve (understand module system)

**Net result:** Significant improvement in maintainability and consistency, minor indirection overhead.

---

## Lines Saved Analysis

**Total duplication eliminated: ~2,500-3,500 lines**

### By Module

| Module | Lines in Module | Used by Prompts | Lines Saved |
|--------|----------------|-----------------|-------------|
| 01 | ~150 | 10 | ~500-700 |
| 02 | ~120 | 10 | ~80-100 |
| 03 | ~450 | 10 | ~150-200 |
| 04 | ~350 | 7 | ~300-400 |
| 05 | ~200 | 4 | ~60-80 |
| 06 | ~150 | 9 | ~90-150 |
| 07 | ~200 | 6 | ~180-240 |
| 08 | ~150 | 6 | ~70-120 |
| 09 | ~250 | 6 | ~200-300 |
| 10 | ~150 | 2 | ~80-120 |
| 11 | ~200 | 10 | ~300-400 |
| 12 | ~180 | 10 | ~100-150 |
| 13 | ~150 | 3 | ~50-100 |

**Note:** Module 14 was consolidated into ENFORCEMENT_RULES.md in v0.13.0 (eliminated ~200 lines of duplication)

**Total modules: ~2,700 lines**
**Total eliminated: ~2,500-3,500 lines**
**Net savings: Break-even to +500 lines** (but MASSIVE consistency/maintainability gain)

---

## Success Criteria

**Module system is successful when:**

- ✅ All 10 prompts refactored to use modules
- ✅ No functionality lost or regression
- ✅ Enforcement rules integrated throughout
- ✅ Prompts are more concise and readable
- ✅ Bug fixes can be applied in one place
- ✅ New prompts can be created faster
- ✅ Consistent user experience across all prompts

---

## Future Enhancements

**Potential additions:**

1. **Module 15:** Advanced export templates (LaTeX, EPUB customization)
2. **Module 16:** Collaboration workflows (multi-author support)
3. **Module 17:** AI model selection and configuration
4. **Module 18:** Custom validation rules (user-defined checks)
5. **Module 19:** Advanced git workflows (rebasing, cherry-picking)
6. **Module 20:** Bibliography management (integration with Zotero, etc.)

---

## Related Documentation

- **Framework Guide:** `Process/AI-Assisted_Nonfiction_Authoring_Process.md`
- **Enforcement Rules:** `Process/ENFORCEMENT_RULES.md`
- **Anti-Hallucination Guidelines:** `Process/Anti-Hallucination_Guidelines.md`
- **Quick Reference:** `Process/Prompts/QUICK_REFERENCE.md`
- **Refactoring Analysis:** `REFACTOR_TODO.md`
- **Changelog:** `REFACTOR_CHANGELOG.md` (created during this refactoring)

---

## Support

**Questions or issues with modules:**
- Check module documentation first
- Review related modules for context
- Consult REFACTOR_CHANGELOG.md for recent changes
- See examples in refactored prompts
- Create issue on GitHub if needed

---

**Module System Version:** 0.10.0
**Created:** 2025-11-19
**Last Updated:** 2025-11-19
**Status:** Active

**Total Modules:** 18 active (Module 14 deprecated in v0.13.0)
**Total Prompts Using Modules:** 16
**Lines of Code Deduplicated:** ~2,500-3,500
**Maintenance Improvement:** ~60% reduction in update effort
**Consistency Improvement:** 100% (single source of truth)
