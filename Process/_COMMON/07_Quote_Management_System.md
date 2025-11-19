# Quote Management System

**Framework Version:** 0.10.0
**Module:** Centralized Quote/Epigraph Management
**Purpose:** Standardized quote tracking and verification

---

## Overview

Centralized system for managing chapter epigraphs with verification status tracking. Prevents fabricated quotes and ensures proper citations.

---

## Status Code System

**Three verification levels:**

| Code | Status | Meaning |
|------|--------|---------|
| ⏳ | Pending verification | Initial entry, user will provide citation |
| ⚠ | Needs proper citation | Quote exists but citation incomplete/unverified |
| ✓ | Verified with source | Full citation provided and confirmed |

---

## Quote Entry Format

**Standard format in `Manuscript/Quotes/Chapter_Quotes.md`:**

```markdown
## Chapter {XX}: {Chapter Title}

**Quote:** "{Quote text verbatim}"
**Author:** {Author full name}
**Source:** {Book/article/speech title}
**Year:** {YYYY}
**Page:** {Page number or N/A}
**Bibliography:** {Full citation in configured style}
**Status:** {⏳ Pending | ⚠ Needs Citation | ✓ Verified}

---
```

---

## Required Fields

### Quote
- Exact text (NEVER fabricated)
- Enclosed in quotes
- Preserves original punctuation

### Author
- Full name
- NEVER guessed or approximated

### Source
- Complete title
- Type (book, article, speech, etc.)

### Year
- Publication/delivery year
- YYYY format

### Page
- Specific page number if from book
- "N/A" if not applicable (speech, etc.)

### Bibliography
- Full citation in project's style (APA, Chicago, MLA, etc.)
- Complete and properly formatted

### Status
- Current verification level
- Progresses: ⏳ → ⚠ → ✓

---

## Verification Progression

### Stage 1: Initial Entry (⏳ Pending)

**When created:**
- During initialization (Prompt 1)
- When new chapter added (Prompt 2)
- Placeholder quote

**Required:**
- Chapter number
- Status: ⏳ Pending
- Placeholder text: "[Quote TBD]" or "[No epigraph]"

**Example:**
```markdown
## Chapter 05: Methodology

**Quote:** "[Quote TBD - Add verified quote or mark as 'No epigraph']"
**Author:** [TBD]
**Source:** [TBD]
**Year:** [TBD]
**Page:** [TBD]
**Bibliography:** [TBD]
**Status:** ⏳ Pending verification

---
```

### Stage 2: Citation Needed (⚠ Needs Citation)

**When set:**
- Quote text provided but citation incomplete
- Source uncertain
- Attribution questionable

**Required:**
- Quote text (user-provided)
- Partial citation info
- Status: ⚠ Needs Citation

**Example:**
```markdown
## Chapter 05: Methodology

**Quote:** "Research is formalized curiosity. It is poking and prying with a purpose."
**Author:** Zora Neale Hurston
**Source:** [VERIFY: Dust Tracks on a Road?]
**Year:** [Verify: 1942?]
**Page:** [NEEDED]
**Bibliography:** [INCOMPLETE - Verify source and add full citation]
**Status:** ⚠ Needs Citation

---
```

### Stage 3: Verified (✓ Verified)

**When set:**
- Full citation provided
- Source confirmed
- User verified accuracy

**Required:**
- All fields complete
- Full bibliography entry
- Status: ✓ Verified

**Example:**
```markdown
## Chapter 05: Methodology

**Quote:** "Research is formalized curiosity. It is poking and prying with a purpose."
**Author:** Zora Neale Hurston
**Source:** *Dust Tracks on a Road: An Autobiography*
**Year:** 1942
**Page:** 143
**Bibliography:** Hurston, Zora Neale. *Dust Tracks on a Road: An Autobiography*. J.B. Lippincott, 1942, p. 143.
**Status:** ✓ Verified

---
```

---

## Epigraph Insertion Format

**When compiling (Prompt 5), verified quotes (✓) are auto-inserted as chapter epigraphs:**

```markdown
# Chapter 5: Methodology

> "Research is formalized curiosity. It is poking and prying with a purpose."
>
> — Zora Neale Hurston, *Dust Tracks on a Road* (1942)

[Chapter content begins...]
```

**Rules:**
- ONLY ✓ Verified quotes are inserted
- ⚠ and ⏳ quotes are skipped (not included in compilation)
- Format: Blockquote with attribution line

---

## Operations

### Add New Quote (Prompt 3)

```markdown
1. User adds quote request to chapter _chg file
2. AI asks for verification:
   - "Do you have the full citation?"
   - If yes → Add with ✓ Verified
   - If partial → Add with ⚠ Needs Citation
   - If no → Add with ⏳ Pending
3. Update Chapter_Quotes.md
4. Update Chapter_Quotes_chg.md with entry:
   ```
   ### Version {N.M.P} - {DATE} - Quote added for Chapter {XX}

   **Type:** Content Addition
   **Scope:** Chapter {XX} epigraph
   **Status:** {Status}
   ```
```

### Update Quote Status (Prompt 3)

```markdown
1. User provides updated citation info
2. AI updates status progression:
   - ⏳ → ⚠ (partial info provided)
   - ⏳ → ✓ (full citation provided)
   - ⚠ → ✓ (citation completed)
3. Update Chapter_Quotes.md
4. Update Chapter_Quotes_chg.md
```

### Validate Quotes (Prompt 6)

```markdown
Check all quote entries:
- All chapters have entry (or "No epigraph" marker)
- All quotes have required fields
- All ✓ quotes have complete bibliographies
- No fabricated quotes detected

Report:
- Total quotes: {count}
- Verified (✓): {count} ({percent}%)
- Needs Citation (⚠): {count} ({percent}%)
- Pending (⏳): {count} ({percent}%)
- Missing entries: {count}
```

---

## Anti-Hallucination Integration

**NEVER fabricate:**
- Quotes
- Attributions
- Sources
- Citations

**ALWAYS ask user:**
- "Do you have the exact quote?"
- "Can you provide the source?"
- "Do you have the full citation?"

**Use appropriate status:**
- User has full info → ✓ Verified
- User has partial info → ⚠ Needs Citation
- User will add later → ⏳ Pending

---

## Metrics Calculation

**For Prompt 8 (Dashboard):**

```markdown
Quote/Epigraph Status:
- Total chapters: {X}
- Chapters with epigraphs: {Y} ({percent}%)
  - ✓ Verified: {A} ({percent}% of total)
  - ⚠ Needs Citation: {B} ({percent}% of total)
  - ⏳ Pending: {C} ({percent}% of total)
- Chapters without epigraphs: {Z} ({percent}%)

Next steps:
- {count} quotes need citations
- {count} quotes pending user input
```

---

## Special Cases

### No Epigraph for Chapter

**If user doesn't want quote:**

```markdown
## Chapter {XX}: {Title}

**No epigraph for this chapter**

---
```

### Multiple Quotes

**If chapter has multiple relevant quotes:**

Only one epigraph per chapter supported. User should choose the best one.

Alternative: Include additional quotes within chapter content (not as epigraph).

---

**Module Version:** 0.10.0
**Last Updated:** 2025-11-19
**Status:** Active
**See Also:** `03_Anti_Hallucination_Protocols.md`
