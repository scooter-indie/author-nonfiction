# Directory Restructure TODO - v0.9.0

**Status:** In Progress
**Started:** 2025-11-18
**Version:** 0.9.0 (Pre-release)

---

## Completed ✅

1. **Version Reset**
   - Deleted all v3.x.x tags (local and remote)
   - Deleted all v3.x.x GitHub releases
   - Updated version to 0.9.0 in all files
   - Kept framework _chg version history intact
   - Updated CHANGELOG.md with 0.9.0 structure documentation
   - Committed and pushed

---

## New Directory Structure

```
project-root/
├── Manuscript/           # NEW: All book content here
│   ├── Chapters/
│   │   ├── Chapter_01/   # Each chapter in subdirectory
│   │   │   ├── Chapter_01.md
│   │   │   ├── Chapter_01_chg.md
│   │   │   └── figures/  # Chapter-specific images
│   │   └── Chapter_02/
│   ├── FrontMatter/
│   ├── BackMatter/
│   │   └── Bibliography/ # Subdirectory of BackMatter
│   ├── Quotes/
│   ├── Style/
│   ├── _TOC_/           # Renamed from TOC/
│   ├── Inbox/
│   ├── Drafts/          # Moved from root
│   └── Exports/         # Moved from root
├── Process/             # Framework (unchanged location)
├── .claude/             # Configuration
├── Project_Config.md    # Stays at root
├── Project_Metadata.md  # Stays at root
└── [other config files]
```

---

## Remaining Work 🚧

### 1. Update All Prompts (Process/Prompts/) ✅

**Path changes needed:**

Old Path | New Path
---------|----------
`Chapters/Chapter_XX.md` | `Manuscript/Chapters/Chapter_XX/Chapter_XX.md`
`Chapters/Chapter_XX_chg.md` | `Manuscript/Chapters/Chapter_XX/Chapter_XX_chg.md`
`FrontMatter/` | `Manuscript/FrontMatter/`
`BackMatter/` | `Manuscript/BackMatter/`
`Quotes/` | `Manuscript/Quotes/`
`Style/` | `Manuscript/Style/`
`TOC/` | `Manuscript/_TOC_/`
`Inbox/` | `Manuscript/Inbox/`
`Drafts/` | `Manuscript/Drafts/`
`Exports/` | `Manuscript/Exports/`

**Files updated:**

- [x] Prompt_1_Initialize.md - Creates directory structure
- [x] Prompt_2_Add_Chapter.md - Adds chapters to Manuscript/Chapters/
- [x] Prompt_3_Modify_File.md - References chapter paths
- [x] Prompt_4_Integrate_Inbox.md - Uses Manuscript/Inbox/
- [x] Prompt_5_Compile.md - Reads from Manuscript/, writes to Manuscript/Drafts/
- [x] Prompt_6_Consistency.md - Scans all Manuscript/ directories
- [x] Prompt_7_Export.md - Reads from Manuscript/, writes to Manuscript/Exports/
- [x] Prompt_8_Dashboard.md - Reports on Manuscript/ structure
- [x] Prompt_9_Git.md - Updated path examples
- [x] Prompt_10_Update_Change_Tracking.md - Finds _chg files in new structure
- [x] QUICK_REFERENCE.md - Updated all path examples

### 2. Update Templates (Process/Templates/) ✅

- [x] README_AUTHORS_template.md - Updated directory structure documentation
- [x] Style_Guide_Template.md - No changes needed (content template)
- [x] Custom_Styles_Template.md - No changes needed (content template)
- [x] installer_template.md - Deleted (obsolete)
- [x] manifest_template.json - No changes needed
- [x] gitignore_template - No changes needed

### 3. Update Documentation ✅

- [x] system-instructions.md - Updated directory tree diagram
- [x] configure.md - Updated git tracking paths
- [ ] CLAUDE.md - Check if needs updates (v3.5.0 version already updated)
- [ ] README.md - Check if needs updates (already has new structure)
- [ ] Process/AI-Assisted_Nonfiction_Authoring_Process.md - Main process doc (TODO)

### 4. Update Book Writing Assistant ✅

- [x] .claude/agents/book-writing-assistant.md - Updated all path references

### 5. Testing

- [ ] Test Prompt 1 creates correct Manuscript/ structure
- [ ] Test Prompt 2 adds chapter in subdirectory
- [ ] Test Prompt 3 modifies files in new locations
- [ ] Test Prompt 5 compiles to Manuscript/Drafts/
- [ ] Test Prompt 6 finds files in new structure
- [ ] Test Prompt 7 exports to Manuscript/Exports/
- [ ] Test Prompt 8 dashboard with new structure
- [ ] Verify all glob patterns work with new paths

### 6. Release

- [ ] Commit all updates
- [ ] Create v0.9.0 tag
- [ ] Trigger GitHub Actions to build release
- [ ] Verify release zip has correct structure
- [ ] Test installation from zip
- [ ] Announce pre-release status

---

## Notes

- This is a **breaking change** from v3.x.x
- Using 0.9.0 to indicate pre-release before 1.0.0 stable
- Migration guide provided in CHANGELOG.md
- Each chapter now in own subdirectory to support figures/images
- Clearer separation between manuscript and framework

---

**Delete this file when restructure is complete**
