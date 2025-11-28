# Prompt 6 Reference Documentation

**Version:** 0.15.4
**Purpose:** Detailed integration examples, lock scenarios, and troubleshooting

---

## Overview

This reference provides detailed integration workflows, examples, and troubleshooting. Load when:
- First time using Prompt 6
- Integrating complex content
- Understanding lock management for inbox
- Troubleshooting integration issues

**For core workflow:** See `Prompt_6_Integrate_Inbox.md`

---

## Inbox Scan Example

### Sample Scan Output

```
📂 Inbox Scan Results

Found 5 files in Manuscript/Inbox/

1. draft-chapter-5.md (12,340 bytes)
   Type: Content (draft chapter)
   Suggested: New chapter or insert into existing

2. research-notes-remote-work.md (5,230 bytes)
   Type: Reference material
   Suggested: Research/Notes/

3. survey-results-chart.png (245 KB)
   Type: Asset (image)
   Suggested: Manuscript/images/

4. competitor-analysis.docx (89 KB)
   Type: Reference material
   Suggested: Research/References/

5. full-toc.md (2,100 bytes)
   Type: TOC file
   ❌ REJECTED: Use Prompt 2 to add chapters

Actionable items: 4
```

---

## Content Integration Examples

### New Chapter from Draft

**User choice:** "Create new chapter from draft-chapter-5.md"

**Actions:**
1. Read draft content
2. Trigger Prompt 2 workflow for chapter creation
3. Copy content into new chapter structure
4. Create `Chapter_05_chg.md` tracking file
5. Update TOC
6. Archive original

### Insert into Existing Chapter

**User choice:** "Insert into Chapter 3 after section 2"

**Actions:**
1. Read target chapter
2. Identify insertion point
3. Add content with proper formatting
4. Update `Chapter_03_chg.md`:
   ```markdown
   ### Version History

   #### v1.1.0 - [CONFIRMED_DATE]
   **Action:** Content inserted from Inbox
   **Source:** draft-section.md
   **Location:** After section 2
   **Author:** Inbox Integration
   ```
5. Archive original

---

## Reference Material Integration

### Research Notes

**Actions:**
1. Move to `Research/Notes/`
2. Rename with date prefix: `[DATE]-remote-work-notes.md`
3. Create index entry in `Research/README.md`

### Bibliography Source

**Actions:**
1. Move to `Research/Sources/`
2. Extract citation data
3. Add entry to `BackMatter/Bibliography/`
4. Link to relevant chapters

---

## Image Integration Examples

### Single Registry Mode

**Input:** `chapter-03-workflow.png`

**Detection:** Chapter 03 from filename

**Actions:**
1. Copy to `Manuscript/images/fig-03-01-workflow.png`
2. Add to `Image_Registry.md`:
   ```markdown
   ### fig-03-01-workflow
   - **Figure:** 3.1
   - **Title:** Workflow Diagram
   - **Type:** Diagram
   - **Status:** 🖼️ Professional image (PNG)
   - **File:** `images/fig-03-01-workflow.png`
   - **Referenced in:** Pending chapter reference
   - **Alt Text:** "Workflow diagram showing process steps"
   - **Created:** 2025-11-24 by Prompt 6
   ```
3. Notify user to add reference in Chapter 03

### Split Registry Mode

**Detection:** "Registry Type: Split" in `Image_Registry.md`

**Actions:**
1. Copy to `Manuscript/images/fig-03-01-workflow.png`
2. Add to `Image_Registry_Chapter_03.md`:
   ```markdown
   ### fig-03-01-workflow
   - **Figure:** 3.1
   [... same entry ...]
   ```
3. Update master `Image_Registry.md` stats:
   ```markdown
   | Chapter 03 | Image_Registry_Chapter_03.md | 5 → 6 | 2025-11-24 |
   ```

---

## Lock Management Scenarios

### Scenario 1: Target Chapter Available

```
✓ Lock acquired: Chapter_05
Proceeding with integration...
```

### Scenario 2: Target Chapter Locked

```
⚠️ Chapter_05 is currently locked by another instance.

Lock details:
- Resource: Chapter_05
- Locked at: 2025-11-24T14:30:00Z (5 minutes ago)
- Instance: CLI-12345

Options:
1. Choose different destination
2. Wait for lock to clear
3. Skip this inbox item
4. Cancel entire operation

Choose option (1-4):
```

### Scenario 3: Stale Lock

```
⚠️ Chapter_05 has a stale lock (older than 15 minutes).

Options:
1. Override stale lock and continue
2. Choose different destination
3. Skip this inbox item
4. Cancel entire operation

Choose option (1-4):
```

---

## Archive Structure

```
Manuscript/Inbox/
├── Processed_2025-11-24/
│   ├── draft-chapter-5.md
│   ├── research-notes.md
│   └── workflow-diagram.png
└── [new items...]
```

---

## TOC File Rejection

### Why TOC Files Are Rejected

After project initialization:
- TOC is AI-managed via Prompt 2
- Manual TOC updates can desync structure
- Use Prompt 2 for adding chapters

### What To Do Instead

If you have a TOC file:
1. Open it and note chapter titles
2. Use Prompt 2 to add each chapter
3. Delete the TOC file from Inbox

---

## Integration Report

After processing:

```
✅ Inbox Integration Complete

Processed: 4 files
Archived to: Manuscript/Inbox/Processed_2025-11-24/

Integration Summary:

| File | Destination | Action |
|------|-------------|--------|
| draft-chapter-5.md | Chapter_05 | Created new chapter |
| research-notes.md | Research/Notes/ | Moved |
| workflow.png | images/fig-03-01 | Registered |
| analysis.docx | Research/References/ | Moved |

Skipped: 1 file
| full-toc.md | Rejected (TOC file) |

Next Steps:
1. Review new Chapter 05 content
2. Add image reference in Chapter 03
3. Link research notes to relevant chapters
```

---

## Troubleshooting

### "Permission denied" on file move

**Cause:** File locked by another application

**Solution:**
1. Close any applications using the file
2. Retry integration

### "Inbox directory not found"

**Cause:** Inbox directory doesn't exist

**Solution:**
```bash
mkdir -p Manuscript/Inbox
```

### "Chapter detection failed"

**Cause:** Filename doesn't indicate chapter

**Solution:**
- Rename file with chapter prefix
- Or specify manually when prompted

### "Image format not supported"

**Cause:** Unsupported image format

**Supported:** PNG, JPG, JPEG, SVG, WebP, GIF

**Solution:**
- Convert to supported format
- Or manually move to Research/Assets/

### "Lock conflict" during integration

**Cause:** Another operation in progress

**Solution:**
1. Choose alternative destination
2. Wait for lock to clear
3. Skip item for now

---

## Related Prompts

| Prompt | Relationship |
|--------|--------------|
| Prompt 2 | Creates new chapters from inbox content |
| Prompt 3 | Inserts content into existing chapters |
| Prompt 16 | Manages images after integration |

---

**Version:** 0.15.4
**For Core Workflow:** See `Prompt_6_Integrate_Inbox.md`
