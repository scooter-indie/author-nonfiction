# Execute Prompt 14: Citation Finder

**Version:** 0.14.3
**⚡ Token Efficient:** ~5,500 tokens (75% reduction from v0.14.0)
**CLI-ONLY:** Requires WebSearch tool and bulk file analysis

**FIRST ACTION - MANDATORY:**
Reference `Process/Prompts/Prompt_Essentials.md` (loaded once per session via /fw-init)

---

## Quick Start

Analyzes chapters to find statements needing citations, uses WebSearch to find real sources, and auto-inserts with ⏳ Pending status for user verification.

### Anti-Hallucination Level 3: NEVER FABRICATE

| Rule | Requirement |
|------|-------------|
| Sources | ONLY from WebSearch results |
| Status | ALWAYS ⏳ Pending until user verifies |
| Attribution | NEVER guess authors, DOIs, ISBNs |
| Verification | User MUST confirm access and accuracy |

---

## Workflow (6 Steps)

1. Ask scope and citation types
2. Acquire locks
3. Scan content for uncited claims
4. WebSearch for valid sources
5. Insert citations as ⏳ Pending
6. Commit and release locks

---

## Step 0: Lock Management

**Acquire locks:**
1. Generate instance ID: `CLI-[5-digit]`
2. Lock `Chapter_XX` (for each chapter)
3. Lock `BackMatter` (for bibliography updates)

See: Prompt_Essentials.md → Lock Management

---

## Step 1: Questions

**Ask user:**

1. **Scope:** Which chapters?
2. **Citation types to find:**
   - Statistical claims
   - Research findings
   - Expert quotes
   - Theoretical frameworks
   - All of the above

3. **Output preference:**
   - Auto-insert citations
   - Generate report only
   - Interactive (ask per citation)

---

## Step 2: Scan for Uncited Claims

**Scan content for:**

| Pattern | Example |
|---------|---------|
| Statistics | "73% of employees...", "Studies show..." |
| Research claims | "Research indicates...", "Data suggests..." |
| Expert attribution | "Experts agree...", "Leading researchers..." |
| Unattributed quotes | Quotation marks without source |
| Theoretical references | "According to theory...", "The model..." |

**Flag each as:**
```
UNCITED: [claim text]
Location: Chapter_XX.md:line
Type: [Statistic | Research | Quote | Theory]
Priority: [High | Medium | Low]
```

---

## Step 3: WebSearch for Sources

**For each uncited claim:**

1. Construct search query from claim keywords
2. Execute WebSearch
3. Evaluate results for:
   - Source credibility (academic, reputable publication)
   - Relevance to claim
   - Accessibility (open access preferred)
   - Recency (prefer recent publications)

4. Select best match or mark as ⚠️ No reliable source found

**CRITICAL:** Only use real sources from WebSearch results. NEVER fabricate.

---

## Step 4: Insert Citations

**Citation format:**
```markdown
[claim text] (Author, Year)⏳
```

**Bibliography entry format:**
```markdown
### ⏳ Pending Verification

- **Author(s):** [Names]
- **Year:** [Year]
- **Title:** "[Article/Book Title]"
- **Source:** [Journal/Publisher]
- **URL:** [if available]
- **Found via:** WebSearch on [date]
- **Supports claim in:** Chapter_XX.md:line
- **Verification status:** ⏳ User must confirm access and accuracy
```

---

## Step 5: Update Files

**Files modified:**
1. Chapter content (inline citations)
2. Chapter _chg file (version history)
3. `BackMatter/Bibliography/Chapter_XX_References.md`

**Status codes:**
- ⏳ Pending verification (default for new)
- ✓ Verified (user confirmed)
- ❌ Rejected (user rejected)

---

## Step 6: Commit & Release

```bash
git add Manuscript/Chapters/Chapter_XX/*
git add BackMatter/Bibliography/*
git commit -m "$(cat <<'EOF'
ADD: Citations for Chapter XX v[version]

- Added N citations for uncited claims
- All marked ⏳ Pending verification
- Sources found via WebSearch

🤖 Generated with Claude Code - Prompt 14

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

Release locks for all acquired resources.

---

## Verification Workflow

**User completes verification:**

1. Access source (click URL, check library)
2. Confirm source supports the claim
3. Update status: ⏳ → ✓ or ❌

**Update via Prompt 3 or 4:**
```
Change ⏳ Pending to ✓ Verified for [citation]
Add page number: p. 45
```

---

## Output Report

```markdown
## Citation Finder Report

**Chapters analyzed:** 1, 3, 5
**Claims scanned:** 45
**Citations added:** 12

### Summary by Chapter

| Chapter | Uncited | Found | Added | No Source |
|---------|---------|-------|-------|-----------|
| 1 | 15 | 12 | 12 | 3 |
| 3 | 20 | 18 | 18 | 2 |
| 5 | 10 | 8 | 8 | 2 |

### Citations Added (⏳ Pending)

1. **Chapter 1, line 45:** "73% of employees prefer hybrid work"
   - Source: Smith et al. (2023), Journal of Workplace Studies
   - URL: https://...

2. **Chapter 3, line 89:** "Remote work increases productivity"
   - Source: Johnson (2024), Harvard Business Review
   - URL: https://...

### No Reliable Source Found

1. **Chapter 1, line 123:** "Most managers struggle with..."
   - Recommendation: Rephrase as opinion or remove claim

### Next Steps

1. Verify N pending citations (access and accuracy)
2. Rephrase N claims with no sources
3. Run Prompt 8 to validate citation status
```

---

📖 **For detailed examples and troubleshooting:** See `Process/Prompts/Prompt_14_Reference.md`

---

**Version:** 0.14.3
**Last Updated:** 2025-11-24
**Token Efficiency:** 75% reduction

---

## Session Cleanup

Tell user: "✓ Prompt 14 Citation Finder complete.

To free up tokens, say: **'Clear Prompt 14 from context'**"
