# Execute Prompt 11: Style Manager

**Version:** 0.14.5
**⚡ Token Efficient:** ~5,000 tokens (70% reduction from v0.14.0)
**HYBRID:** Single-file ops in Desktop, multi-file scans better in CLI

**FIRST ACTION - MANDATORY:**
Reference `Process/Prompts/Prompt_Essentials.md` (loaded once per session via /fw-init)

---

## Quick Start

Manages the hierarchical style system (book → chapter → section). Handles adding/removing overrides, validating registry, and analyzing style distribution.

**Style Hierarchy:**
```
Book Style (Style_Guide.md)
  ↓ inherits
Chapter Style (Chapter_XX_style.md)
  ↓ inherits
Section Style (HTML markers in content)
```

---

## Workflow (7 Operations)

1. Add chapter override
2. Remove chapter override
3. Scan section overrides
4. Validate override registry
5. View style distribution
6. Analyze transitions
7. Change book-level style

---

## Step 0: Lock Management

**Acquire lock:**
1. Generate instance ID: `CLI-[5-digit]` or `Desktop-[5-digit]`
2. Lock `StyleSystem`

See: Prompt_Essentials.md → Lock Management

---

## Operation 1: Add Chapter Override

**Ask user:**
1. Which chapter?
2. Which style? (19 framework styles or custom)
3. Rationale?
4. Transition strategy notes?

**Then:**
1. Validate chapter exists
2. Create `Chapter_XX_style.md` in chapter directory
3. Update `Style_Overrides.md` registry
4. Check 30% threshold
5. Analyze new transitions
6. Commit changes

---

## Operation 2: Remove Chapter Override

**Ask user:**
1. Which chapter override to remove?

**Then:**
1. Delete `Chapter_XX_style.md`
2. Update registry
3. Recalculate percentage
4. Report eliminated transitions
5. Commit changes

---

## Operation 3: Scan Section Overrides

**Ask user:**
1. Scan all chapters or specific?

**Then:**
1. Scan for markers: `<!-- STYLE_OVERRIDE: StyleName -->`
2. Validate: matching close tags, valid styles, no nesting
3. Update registry with findings
4. Report issues

---

## Operation 4: Validate Registry

**Ask user:**
1. Auto-fix issues or report only?

**Checks:**
- Chapter_XX_style.md files exist
- Orphaned files not in registry
- Referenced styles exist
- Section markers valid

**Auto-fix options:**
- Add orphaned files to registry
- Remove missing files from registry

---

## Operation 5: View Style Distribution

**Shows:**
- Total chapters and override percentage
- Style usage table
- Override threshold status (30%)
- Style transition map

---

## Operation 6: Analyze Transitions

**Ask user:**
1. Chapter-level, section-level, or both?

**Assigns severity:**
- Low: Related styles, documented strategies
- Medium: Different styles, undocumented
- High: Opposing styles, frequent transitions

**Provides:**
- Transition recommendations
- Bridging content suggestions

---

## Operation 7: Change Book-Level Style

**Ask user:**
1. New style selection
2. Analyze impact first?

**Impact analysis:**
- Chapters affected vs. those with overrides
- New transitions created
- Transitions eliminated
- Style characteristic changes

**Requires confirmation before proceeding.**

---

## Registry Entry Format

```markdown
## Chapter Overrides

| Chapter | Style | Rationale | Created |
|---------|-------|-----------|---------|
| 03 | Technical Precision | Technical appendix | 2025-11-24 |
| 07 | Narrative Storyteller | Case study chapter | 2025-11-24 |

## Section Overrides

| Chapter | Lines | Style | Purpose |
|---------|-------|-------|---------|
| 02 | 145-230 | Technical Precision | Code example |
| 05 | 89-156 | Narrative Storyteller | User story |

## Distribution

Override percentage: 20% (2 of 10 chapters)
Threshold status: ✓ Below 30%
```

---

## Git Commit & Release

```bash
git add Manuscript/Style/ Manuscript/Chapters/Chapter_XX/
git commit -m "$(cat <<'EOF'
[Operation]: [Description] v[version]

[Details]

🤖 Generated with Claude Code - Prompt 11

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

Release `StyleSystem` lock.

---

## 30% Override Threshold

**Guideline:** If >30% of chapters have overrides, consider whether the book-level style is appropriate.

| Percentage | Status | Recommendation |
|------------|--------|----------------|
| 0-20% | ✓ Healthy | Normal variation |
| 21-30% | ⚠ Monitor | Review style choice |
| 31%+ | 🔴 High | Consider changing book-level style |

---

📖 **For detailed examples and reports:** See `Process/Prompts/Prompt_11_Reference.md`

📖 **For style catalog:** See `Process/Styles/Style_Catalog.md`

---

**Version:** 0.14.5
**Last Updated:** 2025-11-24
**Token Efficiency:** 70% reduction

---

## Session Cleanup

Tell user: "✓ Prompt 11 Style Manager complete.

To free up tokens, say: **'Clear Prompt 11 from context'**"
