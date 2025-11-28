# Prompt Essentials

**Version:** 0.15.4
**Purpose:** Core protocols and quick references for all prompts
**Load:** Once per session (loaded via /fw-init)

---

## Path Resolution (v0.15.0+)

**CRITICAL: All prompts must resolve paths correctly based on operating mode.**

### Multi-Book Mode

When `MODE=multi-book` (fw-location.json exists):

```
FW_ROOT         = Path from .config/fw-location.json
BOOKS_ROOT      = Current working directory
ACTIVE_BOOK     = ID from .config/books-registry.json
BOOK_PATH       = BOOKS_ROOT/[activeBook directory]
```

**Framework reads:**
- `[FW_ROOT]/Process/FRAMEWORK_CORE.md`
- `[FW_ROOT]/Process/Prompts/Prompt_X.md`
- `[FW_ROOT]/Process/Styles/[style].md`
- `[FW_ROOT]/Process/Templates/[template]`

**Book reads/writes:**
- `[BOOK_PATH]/Manuscript/...`
- `[BOOK_PATH]/Research/...`
- `[BOOK_PATH]/.config/...`
- `[BOOK_PATH]/PROJECT_CONTEXT.md`

### Path Resolution Helper

**At start of each prompt execution:**

```
1. Read BOOKS_ROOT/.config/fw-location.json → FW_ROOT
2. Read BOOKS_ROOT/.config/books-registry.json → activeBook
3. Set BOOK_PATH = BOOKS_ROOT/[activeBook directory]
4. Use FW_ROOT for framework file reads
5. Use BOOK_PATH for book content reads/writes
```

---

## Lock Management Quick Reference

### Lock File Location

`[BOOK_PATH]/.locks/locks.json`

**Initialize:**
- Create `.locks/` directory in BOOK_PATH: `mkdir -p [BOOK_PATH]/.locks`
- Create `.locks/locks.json`: `{"locks": []}`
- Generate instance ID: `CLI-[5-digit-random]` or `Desktop-[5-digit-random]`

**Acquire Lock:**
1. Read `[BOOK_PATH]/.locks/locks.json`
2. Check if resource is locked
3. If locked < 15 min: Offer wait/cancel
4. If locked >= 15 min: Offer override/cancel
5. Add lock entry with resource, timestamp, instance
6. Write updated JSON

**Release Lock:**
1. Read `[BOOK_PATH]/.locks/locks.json`
2. Remove lock where resource AND instance match
3. Write updated JSON
4. Confirm release

**Lock Entry Format:**
```json
{
  "resource": "Chapter_03",
  "timestamp": "2025-11-24T14:30:00Z",
  "instance": "CLI-12345"
}
```

**Full details:** `[FW_ROOT]/Process/_COMMON/18_Lock_Management_Module.md`

---

## Anti-Hallucination Quick Rules

**ASK before generating:**
- Examples, anecdotes, statistics, quotes
- Personal experiences (confirm REAL vs HYPOTHETICAL)

**NEVER fabricate:**
- Specific people, places, events
- Statistics, data, research findings
- Quotes or attributions

**Use labels:**
- `[PROVIDE REAL EXAMPLE - do not fabricate]`
- `[CITATION NEEDED: statistic about X]`
- `[VERIFY QUOTE from Author Name]`
- ⏳ Pending | ⚠ Needs Citation | ✓ Verified

**Full protocol:** `Process/Anti-Hallucination_Guidelines.md`

---

## Git Commit Format

**Standard format:**
```
git add [files] && git commit -m "[Brief description]

[Detailed changes if needed]

🤖 Generated with Claude Code

Co-Authored-By: Claude <noreply@anthropic.com>"
```

**For Claude Desktop:**
```
Run: git add [files] && git commit -m '[Brief description]

🤖 Generated with Claude Desktop

Co-Authored-By: Claude <noreply@anthropic.com>'
```

---

## Style Resolution (Hierarchical System)

**Resolution order:**
1. Section-level override (HTML markers in content)
2. Chapter-level override (`Chapter_XX_style.md`)
3. Book-level default (`Style_Guide.md`)

**Check for overrides:**
1. Look for HTML markers: `<!-- STYLE_OVERRIDE: StyleName -->`
2. Check for `Chapter_XX_style.md` file
3. Fall back to `Style_Guide.md`

**Full protocol:** `Process/_COMMON/10_Style_Consistency_Protocol.md`

---

## Date Handling

**ALWAYS use CONFIRMED_DATE from session startup**

**Protocol:**
1. At session start: User confirms date
2. Store as: `CONFIRMED_DATE=[YYYY-MM-DD]`
3. Use for ALL operations
4. Pass to agents: "Today's confirmed date is [CONFIRMED_DATE]"

**Never use raw `<env>` date without confirmation**

---

## Semantic Versioning

**Major (N.0.0):** Breaking changes, structural reorganization
**Minor (0.N.0):** New sections, significant revisions
**Patch (0.0.N):** Minor edits, typos, formatting

**In _chg files:**
- Estimate scope in **Rationale** section
- Prompt 3 determines actual version bump

---

## Change Tracking Format

**In `[filename]_chg.md`:**

```markdown
### [INSTRUCTIONS FOR THIS REVISION]

[Date: CONFIRMED_DATE]

**Changes requested:**
1. [Clear, actionable instruction]
   - [Details]
   - Placement: [Where]

**Priority:** [High/Medium/Low]
**Rationale:** [Why]
**Estimated scope:** [Major/Minor/Patch]
```

---

## CLI vs Desktop Compatibility

**Tools available in both:**
- File read/write/edit (MCP Filesystem in Desktop)
- Single file operations
- Git commands (copy/paste in Desktop)

**CLI-only tools:**
- Bash commands with pipes/complex operations
- WebSearch
- Bulk file operations (30+ files)
- System tools (pandoc, zip, etc.)

**When prompt says "CLI-ONLY":**
- Required tools not available in Desktop
- Use Claude Code CLI for execution

**When prompt says "DESKTOP-FRIENDLY":**
- Works 80-95% in Desktop
- May require copy/paste git commands at end
- File operations via MCP Filesystem

**When prompt says "HYBRID":**
- Some operations work in Desktop
- Complex operations require CLI
- Prompt will indicate when to switch

---

**Version:** 0.15.4
**Last Updated:** 2025-11-28
**Token Count:** ~2,000 tokens
**vs Full Modules:** ~10,000 tokens (80% reduction)
