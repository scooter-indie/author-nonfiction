# Testing Infrastructure Proposal

**Version:** 0.1.0
**Created:** 2025-11-28
**Status:** Draft
**Scope:** Framework developers only (NOT deployed to -dist)

---

## Executive Summary

Restructure the framework's testing infrastructure by moving from `Process/Testing/` to a root-level `Testing/` directory with modular, feature-based test plans using a concise table-driven format.

---

## Problem Statement

The current testing location under `Process/Testing/` is:
1. Bundled with deployable content (requires exclusion in deploy workflow)
2. Uses a single monolithic checklist format
3. Lacks version tracking for test cases

---

## Proposed Changes

### 1. Directory Restructuring

**Remove:**
- `E:\Projects\author-nonfiction\Process\Testing\Hierarchical_Style_Testing_Checklist.md`
- `E:\Projects\author-nonfiction\Process\Testing\` directory

**Create:**
- `E:\Projects\author-nonfiction\Testing\` (root level)

### 2. Test Plan Structure

```
Testing/
├── README.md                    # Testing overview and instructions
├── 01_Initial_Configuration.md  # /fw-init, configure scripts
├── 02_Core_Prompts.md           # Prompts 1-9 functionality
├── 03_Style_System.md           # Writing styles, customization
├── 04_Quote_Management.md       # Quote tracking, verification
├── 05_Export_Pipeline.md        # Markdown, PDF, DOCX export
├── 06_Multi_Book.md             # Multi-book project support
├── 07_Migration.md              # Version migration paths
└── 08_Scripts.md                # Shell script functionality
```

### 3. Test Plan Format

Each test plan uses a concise table format with checkboxes:

```markdown
# Feature: [Name]

**Last Updated:** YYYY-MM-DD
**Covers Versions:** v0.X.X - v0.Y.Y

## Prerequisites
- [ ] Prerequisite 1
- [ ] Prerequisite 2

## Test Cases

| ID | Test Case | Steps | Expected | Version | Pass |
|----|-----------|-------|----------|---------|------|
| TC-01 | Description | 1. Step one<br>2. Step two | Expected result | v0.15.0 | [ ] |
| TC-02 | Description | 1. Step one | Expected result | v0.16.0 | [ ] |

## Notes
- Any additional context
```

### 4. Version Tracking

When `PREPARE_RELEASE.md` is executed:
1. Review commits since last release for testable changes
2. Add new test cases with the release version number
3. Mark deprecated test cases if features removed
4. Update "Covers Versions" range in affected test plans

---

## Implementation Steps

1. [ ] Create `Testing/` directory at repository root
2. [ ] Create `Testing/README.md` with testing instructions
3. [ ] Create individual test plan files (01-08)
4. [ ] Migrate relevant test cases from existing checklist
5. [ ] Remove `Process/Testing/` directory
6. [ ] Update `PREPARE_RELEASE.md` to include test plan review step
7. [ ] Update `.github/workflows/deploy-dist.yml` exclusions (if needed)
8. [ ] Update `CLAUDE.md` repository structure section

---

## Deployment Considerations

The `Testing/` directory must be excluded from the -dist repository:
- Verify `deploy-dist.yml` excludes `Testing/` from deployment
- This is developer-only content

---

## Acceptance Criteria

- [ ] `Testing/` directory exists at repository root
- [ ] `Process/Testing/` directory removed
- [ ] All feature areas have corresponding test plans
- [ ] Test plans use consistent table format
- [ ] Version numbers included in test case tracking
- [ ] `PREPARE_RELEASE.md` includes test plan update step
- [ ] Testing directory excluded from dist deployment

---

## Related Issues

- None yet (create issue when proposal approved)

---

**End of Proposal**
