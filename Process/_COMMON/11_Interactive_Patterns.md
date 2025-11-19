# Interactive Patterns

**Framework Version:** 0.10.0
**Module:** Question/Answer and User Interaction Templates
**Purpose:** Standardized interactive workflows

---

## Sequential Question Template

**Use for:** Linear information gathering

```markdown
**Questions I'll ask:**

1. {Question 1}
2. {Question 2}
3. {Question 3}
...

**Then I'll:**

{Workflow steps}
```

**Example:**
```markdown
**Questions I'll ask:**

1. What is the working title of your book?
2. What is your name (author)?
3. What is the target total word count?
4. Who is the target audience?

**Then I'll:**

1. Create project structure
2. Generate configuration files
3. Initialize git repository
```

---

## Branching Decision Template

**Use for:** Conditional paths based on user choice

```markdown
**Initial Question:** {Question}

**If Option A:**
- {Sub-question A1}
- {Sub-question A2}

**If Option B:**
- {Sub-question B1}
- {Sub-question B2}

**Then I'll:**

{Common workflow steps}
{Option-specific steps}
```

**Example:**
```markdown
**Initial Question:** Do you want to add interactively or from Inbox content?

**If Interactive:**
- What is the chapter title?
- Where should it be positioned?
- What is the estimated word count?

**If From Inbox:**
- Which file in Manuscript/Inbox/ contains the chapter content?
- Where should it be positioned?
- Should I use the content as-is or create a placeholder?

**Then I'll:**

1. Create safety commit
2. [Option-specific integration]
3. Update TOC and cross-references
4. Commit changes
```

---

## Menu Selection Template

**Use for:** Multiple choice selection

```markdown
**Select an option:**

1. **{Option 1}** - {Description}
2. **{Option 2}** - {Description}
3. **{Option 3}** - {Description}
4. **{Option 4}** - {Description}

Which would you like? ({number or name})
```

**Example:**
```markdown
**Which git operation would you like to perform?**

1. **Commit Current Changes** - Save your current work
2. **Create Tag** - Mark a milestone
3. **View History** - See recent commits
4. **Push to Remote** - Backup to GitHub/GitLab

Which would you like? (1-4 or operation name)
```

---

## Confirmation Pattern

**Use for:** Verifying before action

```markdown
**I will perform the following actions:**

- {Action 1}
- {Action 2}
- {Action 3}

**This operation is {reversible | irreversible}.**

{Warning or note if applicable}

**Proceed? (Yes/No)**
```

**Example:**
```markdown
**I will perform the following actions:**

- Renumber Chapter_04 → Chapter_05
- Renumber Chapter_05 → Chapter_06
- Insert new chapter as Chapter_04
- Update all cross-references
- Update TOC

**This operation is reversible** (via git).

**Note:** This will modify 8 files. A safety commit will be created first.

**Proceed? (Yes/No)**
```

---

## Verification Pattern

**Use for:** Content verification (anti-hallucination)

```markdown
I'd like to {action}. Would you like me to:

A) **{Option A}** - {Description}
   → {What this means}

B) **{Option B}** - {Description}
   → {What this means}

C) **{Option C}** - {Description}
   → {What this means}

D) **{Option D}** - {Description}
   → {What this means}

Which would you prefer? (A/B/C/D)
```

**Example:**
```markdown
I'd like to add an example here. Would you like me to:

A) **Use a REAL example from your experience**
   → Please describe what happened

B) **Create a HYPOTHETICAL example** (clearly labeled)
   → I'll mark it as "For example, imagine..."

C) **Use a GENERIC scenario**
   → "Many professionals find that..."

D) **Leave a PLACEHOLDER**
   → [ADD EXAMPLE: Describe your experience with this technique]

Which would you prefer? (A/B/C/D)
```

---

## Progressive Disclosure Pattern

**Use for:** Complex multi-step workflows

```markdown
**Step 1: {Name}**

{Questions for step 1}

[User answers]

---

**Step 2: {Name}**

Based on your answers:
{Context from step 1}

{Questions for step 2}

[User answers]

---

**Step 3: {Name}**

{Final questions}

---

**Summary**

I will now:
{All actions based on all answers}

Proceed? (Yes/No/Revise)
```

---

## Error Recovery Pattern

**Use for:** Handling errors gracefully

```markdown
❌ {Error occurred}

**What happened:**
{Explanation}

**Options:**

1. **{Recovery Option 1}** - {Description}
2. **{Recovery Option 2}** - {Description}
3. **{Recovery Option 3}** - {Description}

What would you like to do? (1/2/3)
```

**Example:**
```markdown
❌ File not found

**What happened:**
The file Manuscript/Chapters/Chapter_05/Chapter_05.md does not exist.

**Options:**

1. **Create it now** - I'll create a new Chapter 5
2. **Use different file** - Specify the correct path
3. **Cancel operation** - Stop and investigate

What would you like to do? (1/2/3)
```

---

## Customization Pattern

**Use for:** Default vs. custom settings

```markdown
**Use default settings?**

Default: {description of defaults}

- {Default 1}
- {Default 2}
- {Default 3}

**Or customize?**

If you choose to customize, I'll ask about:
- {Customizable option 1}
- {Customizable option 2}
- {Customizable option 3}

Which would you prefer? (Default/Customize)
```

---

## Batch Operation Pattern

**Use for:** Operating on multiple items

```markdown
**Items to process:** {count}

For each item, I'll ask:
{Question template}

Or, use the same action for all?
- {Option 1}: Apply to all
- {Option 2}: Ask for each
- {Option 3}: Use smart defaults

Which approach? (1/2/3)
```

---

## Routing Response Pattern

**Use for:** Redirecting to appropriate prompt

```markdown
I cannot {action} directly. This should go through {Prompt X} ({Prompt Name}).

**Here's how:**

1. {Step 1}
2. {Step 2}
3. {Step 3}

**This ensures:**
✅ {Benefit 1}
✅ {Benefit 2}
✅ {Benefit 3}

Would you like me to guide you through {Prompt Name}?
```

---

## Status Update Pattern

**Use for:** Progress during long operations

```markdown
{Operation name}... ({percent}%)

✅ {Completed step 1}
✅ {Completed step 2}
🔄 {Current step}
⏳ {Pending step 1}
⏳ {Pending step 2}

Estimated time remaining: {duration}
```

---

## Multi-Select Pattern

**Use for:** Selecting multiple options

```markdown
**Select all that apply** (separate with commas or spaces):

- [ ] {Option 1}
- [ ] {Option 2}
- [ ] {Option 3}
- [ ] {Option 4}
- [ ] {Option 5}

Enter selections: (e.g., "1, 3, 5" or "Option1, Option3")
```

---

## Range Input Pattern

**Use for:** Numeric or date ranges

```markdown
**{Question}**

Range: {min} to {max}
Recommended: {recommended}

Current: {current}

Enter {unit}: ___
```

**Example:**
```markdown
**What is the target total word count?**

Range: 10,000 to 200,000
Recommended: 50,000-75,000 for typical nonfiction

Enter word count: ___
```

---

**Module Version:** 0.10.0
**Last Updated:** 2025-11-19
**Status:** Active
