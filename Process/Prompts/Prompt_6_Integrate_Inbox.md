# Execute Prompt 6: Integrate Inbox

**Version:** 0.14.3
**⚡ Token Efficient:** ~4,000 tokens (65% reduction from v0.14.0)
**DESKTOP-FRIENDLY:** Works 95% in Desktop (git via CLI)

**FIRST ACTION - MANDATORY:**
Reference `Process/Prompts/Prompt_Essentials.md` (loaded once per session via /fw-init)

---

## Quick Start

Processes files from `Manuscript/Inbox/` and integrates them into appropriate locations. Interactive workflow for each item.

**Rejects:** TOC files (use Prompt 2 for chapters)

---

## Workflow (5 Steps)

1. Scan Inbox directory
2. Identify file types
3. Interactive decisions per file
4. Execute integration
5. Archive processed files

---

## Step 0: Lock Management

**Acquire locks based on content:**
- After user decisions, lock target resources
- Possible: `Chapter_XX`, `FrontMatter`, `BackMatter`, `ImageRegistry`

See: Prompt_Essentials.md → Lock Management

---

## Step 1: Scan Inbox

**I'll list all files and analyze:**
- Content files (drafts, sections)
- Reference materials (research, sources)
- Assets (images, diagrams)

---

## Step 2: File Type Identification

**Content files:**
- Create new chapter (via Prompt 2)
- Insert into existing chapter (via Prompt 3)
- Add to front/back matter
- Move to Research/

**Reference materials:**
- Research/Sources/
- Research/Notes/
- Research/References/
- Extract bibliography entries

**Assets (images):**
- Move to `Manuscript/images/` with proper naming
- Registry Type Detection:
  - Single mode: Add to `Image_Registry.md`
  - Split mode: Add to `Image_Registry_Chapter_XX.md`
- Chapter Detection:
  - From filename pattern (`chapter-03-diagram.png`)
  - User specification
  - Ask if not determinable

---

## Step 3: Interactive Decisions

**For each file, I'll ask:**

1. **Where should this go?**
   - New chapter
   - Existing chapter (which?)
   - Research directory
   - Front/back matter

2. **How should it integrate?**
   - Replace existing
   - Insert at position
   - Append
   - Merge

3. **Priority level?**

---

## Step 4: Execute Integration

**Sequence:**
1. Commit current state (safety)
2. Acquire locks for targets
3. Perform integration
4. Update _chg files
5. Update cross-references
6. Commit changes

---

## Step 5: Archive

**Move processed files to:**
```
Manuscript/Inbox/Processed_[CONFIRMED_DATE]/
```

---

## Anti-Hallucination Note

**When integrating content with examples/anecdotes/statistics:**
- **ASK user** to verify before integration
- **Request sources** for statistics and quotes
- **Use labels**: REAL vs HYPOTHETICAL vs GENERIC vs [CITATION NEEDED]
- **Never assume** inbox content reflects user's real experiences

---

## Image Integration Details

**Naming convention:**
```
fig-XX-YY-description.ext
```
- XX = Chapter number
- YY = Figure number in chapter
- description = kebab-case (3-5 words)

**Chapter detection methods:**
1. Filename pattern: `chapter-03-*.png` → Chapter 03
2. User specifies: "Add to Chapter 5"
3. Ask if not determinable

**Registry update:**
```markdown
### fig-03-02-workflow-diagram
- **Figure:** 3.2
- **Title:** Workflow Diagram
- **Type:** Diagram
- **Status:** 🖼️ Professional image (PNG)
- **File:** `images/fig-03-02-workflow-diagram.png`
- **Created:** [CONFIRMED_DATE] by Prompt 6
```

---

## Git Commit & Release

```bash
git add Manuscript/
git commit -m "$(cat <<'EOF'
INTEGRATE: Inbox items processed v[version]

- [N] files integrated
- [Destinations]

🤖 Generated with Claude Code - Prompt 6

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

Release all acquired locks.

---

📖 **For detailed integration examples:** See `Process/Prompts/Prompt_6_Reference.md`

---

**Version:** 0.14.3
**Last Updated:** 2025-11-24
**Token Efficiency:** 65% reduction

---

## Session Cleanup

Tell user: "✓ Prompt 6 Integrate Inbox complete.

To free up tokens, say: **'Clear Prompt 6 from context'**"
