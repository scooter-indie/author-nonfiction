# Prompt 16: Image Manager

**Version:** 0.16.1
**⚡ Token Efficient:** ~6,500 tokens (74% reduction from v0.14.0)
**CLI-ONLY:** Requires Claude Code CLI for file operations

**FIRST ACTION - MANDATORY:**
Reference `Process/Prompts/Prompt_Essentials.md` (loaded once per session via /fw-init)

---

## Quick Start

Manage professional images (photos, screenshots, charts) in your manuscript. Works with Prompt 15 for complete visual asset management.

**Visual System:**
- **Location:** `Manuscript/images/` (flat directory)
- **Naming:** `fig-XX-YY-description.ext`
- **Registry:** `Image_Registry.md` (single or split mode)
- **Status:** 🖼️ Professional image

---

## Five Modes

| Mode | Purpose | Use When |
|------|---------|----------|
| 1 | Add Image | Adding new image to chapter |
| 2 | Upgrade | Replacing 📝 text-based with 🖼️ image |
| 3 | Scan | Registering existing untracked images |
| 4 | Validate | Checking references and files |
| 5 | Split | Splitting large registry (300+ entries) |

---

## Step 0: Registry Type Detection (ALL MODES)

**Detect before any operation:**

1. Read first 15 lines of `Image_Registry.md`
2. Search for "Registry Type: Split"

| If Found | Mode | Operations |
|----------|------|------------|
| Yes | SPLIT | Read chapter registries, update master index |
| No | SINGLE | Read/write single registry file |

**Threshold Monitoring (Single Mode):**
- 200-299 entries: ⚠️ Warning
- 300-399 entries: 🔴 Recommend split
- 400+ entries: ❌ Strongly recommend split

---

## Step 1: Lock Management

**Acquire locks:**
1. Create `.locks/locks.json` if needed
2. Generate instance ID: `CLI-[5-digit]`
3. Lock `ImageRegistry` resource
4. Lock `Chapter_XX` (for target chapter)

See: Prompt_Essentials.md → Lock Management

---

## Mode 1: Add Image

**User provides:**
1. Source image file path
2. Target chapter number
3. Location in chapter (after paragraph X, section Y)
4. Image type (Photo, Screenshot, Chart, Diagram, Infographic)
5. Alt text and caption

**Steps:**
1. Detect registry mode
2. Read appropriate registry
3. Determine next figure number: `fig-XX-YY`
4. Copy file to `Manuscript/images/` with proper name
5. Add registry entry with metadata
6. Insert reference in chapter: `![Alt](../images/fig-XX-YY-desc.ext)`
7. Update chapter _chg file
8. Update registry stats (+ master index if split)
9. Commit changes

---

## Mode 2: Upgrade Text-Based

**User provides:**
1. Figure number to upgrade (e.g., fig-03-02)
2. New image file path

**Steps:**
1. Locate figure in registry
2. Archive old `.md` file
3. Copy new image with same base name
4. Update registry: 📝 → 🖼️, add size/dimensions
5. Update chapter reference
6. Commit changes

---

## Mode 3: Scan and Register

**Steps:**
1. Scan `Manuscript/images/` for unregistered files
2. Search chapters for image references
3. Present findings for confirmation
4. Register confirmed images
5. Update statistics
6. Commit changes

---

## Mode 4: Validate

**Steps:**
1. Read all chapter files
2. Extract image references
3. Check each file exists
4. Cross-check with registry
5. Report discrepancies:
   - Missing files
   - Broken references
   - Unregistered images
   - Missing alt text
6. Suggest fixes

---

## Mode 5: Split Registry

**Trigger:** Manual request or 300+ entries

**Steps:**
1. Count entries (`grep -c "^### "`)
2. Parse entries by chapter from filename
3. Create `Image_Registry_Chapter_XX.md` for each
4. Create master index with distribution table
5. Archive original as `Image_Registry_LEGACY_DATE.md`
6. Validate (sum matches original)
7. Commit changes

📖 **For split algorithm details:** See `Process/_COMMON/19_Image_Registry_Splitting_Module.md`

---

## Registry Entry Format

```markdown
### fig-XX-YY-description
- **Figure:** X.Y
- **Title:** Figure title
- **Type:** [Photo | Screenshot | Chart | Diagram | Infographic]
- **Status:** 🖼️ Professional image (FORMAT)
- **File:** `images/fig-XX-YY-description.ext`
- **Size:** [KB/MB] ([width]x[height]px)
- **Referenced in:** Chapter_XX.md:line
- **Alt Text:** "Description"
- **Caption:** "Figure X.Y: Caption"
- **Created:** YYYY-MM-DD by Prompt 16
```

---

## Naming Convention

**Format:** `fig-XX-YY-description.ext`

- `XX` = Chapter number (01-99)
- `YY` = Figure number within chapter (01-99)
- `description` = kebab-case description (3-5 words)
- `ext` = Original extension (jpg, png, svg)

**Examples:**
- ✅ `fig-03-02-survey-results.png`
- ✅ `fig-07-01-data-collection.jpg`
- ❌ `Figure 3.2 Survey Results.png` (spaces)
- ❌ `fig_03_02_survey.png` (underscores)

---

## Git Commit

```bash
git add Manuscript/images/[files] Manuscript/images/Image_Registry.md
git add Manuscript/Chapters/Chapter_XX/Chapter_XX.md
git add Manuscript/Chapters/Chapter_XX/Chapter_XX_chg.md
git commit -m "$(cat <<'EOF'
[MODE]: [Description] v[version]

[Details]

🤖 Generated with Claude Code - Prompt 16

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

---

## Release Locks & Report

1. Remove lock entries from `.locks/locks.json`
2. Display: `✓ Locks released: ImageRegistry, Chapter_XX`
3. Show operation summary

---

## Integration

| Prompt | Relationship |
|--------|--------------|
| Prompt 15 | Creates 📝 text-based → Prompt 16 upgrades to 🖼️ |
| Prompt 8 | Validates image references |
| Prompt 9 | Exports with images embedded |

---

📖 **For detailed examples and troubleshooting:** See `Process/Prompts/Prompt_16_Reference.md`

📖 **For split registry details:** See `Process/_COMMON/19_Image_Registry_Splitting_Module.md`

---

**Version:** 0.16.1
**Last Updated:** 2025-11-24
**Token Efficiency:** 74% reduction

---

## Session Cleanup

Tell user: "✓ Prompt 16 Image Manager complete.

To free up tokens, say: **'Clear Prompt 16 from context'**"
