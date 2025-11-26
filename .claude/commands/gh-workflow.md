# GitHub Workflow Integration

**Framework-only command for maintainers**

This command configures Claude to automatically manage GitHub issues during development sessions.

---

## Project Configuration

**GitHub Project Board:** https://github.com/users/scooter-indie/projects/9/views/1
**Repository:** scooter-indie/author-nonfiction

---

## Prerequisites

The following GitHub CLI extensions must be installed:

```bash
gh extension install yahsan2/gh-pm        # Project status management
gh extension install yahsan2/gh-sub-issue # Sub-issue linking
```

**Configuration:** `.gh-pm.yml` in repo root configures project board status values.

**Status values:** `backlog`, `ready`, `in_progress`, `in_review`, `done`

---

## Workflow Instructions

When this command is executed, Claude should follow these workflows for the remainder of the session:

### 1. Finding Workflow (Bug Reports / Issues Discovered)

**Trigger phrases:**
- "I found an issue..."
- "There's a bug..."
- "This is broken..."
- "Something's wrong with..."
- Any report of unexpected behavior or missing functionality

**Step 1: Create issue (AUTOMATIC)**

When user reports a finding, immediately create the issue:
```bash
gh issue create --repo scooter-indie/author-nonfiction \
  --title "Finding: [brief description]" \
  --label "finding" \
  --body "[detailed description of the finding]"
```

Then report: "Created issue #[number]. Let me know when you want me to work on it."

**Step 2: Work the issue (ONLY WHEN USER SAYS)**

Wait for explicit instruction like:
- "work issue #[number]"
- "fix that"
- "do the work"
- "implement the fix"

Set project board status to In Progress:
```bash
gh pm move [issue-number] --status in_progress
```

**Step 3: Commit and set to In Review (AFTER WORK COMPLETE)**

```bash
git commit -m "Fix: [description] (#[issue-number])

[details]

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

```bash
gh pm move [issue-number] --status in_review
```

```bash
gh issue comment [issue-number] --repo scooter-indie/author-nonfiction \
  --body "Fixed in commit [commit-hash]

[brief summary of changes]"
```

Then report: "Issue #[number] ready for review. Say 'Done' to close it."

**Step 4: Close issue (ONLY WHEN USER SAYS "DONE")**

Wait for explicit instruction like:
- "done"
- "close it"
- "looks good"
- "approved"

```bash
gh pm move [issue-number] --status done
```

```bash
gh issue close [issue-number] --repo scooter-indie/author-nonfiction \
  --comment "Resolved and closed."
```

---

### 2. Enhancement Workflow (New Features / Proposals)

**Trigger phrases:**
- "I would like..."
- "Can you add..."
- "New feature..."
- "Enhancement..."
- "Proposal..."
- Any request for new functionality

**Step 1: Create issue (AUTOMATIC)**

When user requests an enhancement, immediately create the issue:
```bash
gh issue create --repo scooter-indie/author-nonfiction \
  --title "Enhancement: [brief description]" \
  --label "enhancement" \
  --body "[detailed description of the enhancement]"
```

Then report: "Created issue #[number]. Let me know when you want me to work on it."

**Step 2: Work the issue (ONLY WHEN USER SAYS)**

Wait for explicit instruction like:
- "work issue #[number]"
- "implement that"
- "do the work"
- "build it"

Set project board status to In Progress:
```bash
gh pm move [issue-number] --status in_progress
```

**Step 3: Commit and set to In Review (AFTER WORK COMPLETE)**

```bash
git commit -m "[description] (#[issue-number])

[details]

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

```bash
gh pm move [issue-number] --status in_review
```

```bash
gh issue comment [issue-number] --repo scooter-indie/author-nonfiction \
  --body "Implemented in commit [commit-hash]

[brief summary of changes]"
```

Then report: "Issue #[number] ready for review. Say 'Done' to close it."

**Step 4: Close issue (ONLY WHEN USER SAYS "DONE")**

Wait for explicit instruction like:
- "done"
- "close it"
- "looks good"
- "approved"

```bash
gh pm move [issue-number] --status done
```

```bash
gh issue close [issue-number] --repo scooter-indie/author-nonfiction \
  --comment "Resolved and closed."
```

---

### 3. Proposal Workflow (Design Documents)

**Trigger phrases:**
- "Create a proposal for..."
- "Write a proposal..."
- "Proposal for issue #[number]"
- "Design document for..."
- Any request for a detailed design/proposal document

**Step 1: Create proposal document (AUTOMATIC)**

When user requests a proposal:

1. Create `Proposal/[Feature-Name].md` with:
   - Executive Summary
   - Requirements/Problem Statement
   - Technical Design
   - Implementation Plan
   - Acceptance Criteria

2. Create issue if not already associated:
```bash
gh issue create --repo scooter-indie/author-nonfiction \
  --title "Enhancement: [brief description]" \
  --label "enhancement" \
  --body "## Summary\n[description]\n\n## Proposal\nSee Proposal/[Feature-Name].md"
```

3. Commit the proposal:
```bash
git add Proposal/[Feature-Name].md && git commit -m "Add proposal for [Feature-Name] (#[issue-number])

[brief description]

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

Then report: "Created proposal `Proposal/[Feature-Name].md` and issue #[number]. Let me know when you want me to implement it."

**Step 2: Implement (ONLY WHEN USER SAYS)**

Wait for explicit instruction like:
- "implement the proposal"
- "work issue #[number]"
- "build it"
- "do the work"

Set project board status to In Progress:
```bash
gh pm move [issue-number] --status in_progress
```

**Step 3: Move proposal and set to In Review (AFTER IMPLEMENTATION COMPLETE)**

1. Move proposal to Implemented:
```bash
git mv Proposal/[Feature-Name].md Proposal/Implemented/[Feature-Name].md
```

2. Commit implementation with proposal move:
```bash
git commit -m "[description] (#[issue-number])

[details]

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

3. Set status and comment:
```bash
gh pm move [issue-number] --status in_review
```

```bash
gh issue comment [issue-number] --repo scooter-indie/author-nonfiction \
  --body "Implemented in commit [commit-hash]

Proposal moved to Proposal/Implemented/[Feature-Name].md"
```

Then report: "Issue #[number] ready for review. Say 'Done' to close it."

**Step 4: Close issue (ONLY WHEN USER SAYS "DONE")**

Wait for explicit instruction like:
- "done"
- "close it"
- "looks good"
- "approved"

```bash
gh pm move [issue-number] --status done
```

```bash
gh issue close [issue-number] --repo scooter-indie/author-nonfiction \
  --comment "Resolved and closed."
```

---

### 4. Sub-Issue Workflow (Breaking Down Large Issues)

**Trigger phrases:**
- "Create sub-issues for..."
- "Break this into phases..."
- "Create phase issues for #[number]"
- Any request to create child/sub-issues for a parent issue

**Prerequisites:**
- `gh sub-issue` extension must be installed: `gh extension install yahsan2/gh-sub-issue`

**Step 1: Create sub-issues**

When user requests sub-issues, create them with reference to parent:
```bash
gh issue create --repo scooter-indie/author-nonfiction \
  --title "[Phase/Sub-task]: [brief description]" \
  --label "enhancement" \
  --body "## Summary
[description]

## Parent Issue
Part of #[parent-number]

## Requirements
[requirements]

## Depends On
[dependencies if any]"
```

**Step 2: Link sub-issues to parent (REQUIRED)**

After creating each sub-issue, link it to the parent using the `gh sub-issue` extension:
```bash
gh sub-issue add [parent-number] [sub-issue-number] --repo scooter-indie/author-nonfiction
```

This creates a proper parent-child relationship in GitHub (not just a text reference).

**Step 3: Ask about epic label**

After creating and linking sub-issues, ASK the user:

> "Sub-issues created. Should I label the parent issue #[number] as an 'epic'?
> This will:
> - Add the 'epic' label
> - Remove the 'story' label if present
>
> (yes/no)"

**Step 3: Apply epic label (IF USER SAYS YES)**

```bash
# Add epic label to parent
gh issue edit [parent-number] --repo scooter-indie/author-nonfiction --add-label "epic"

# Remove story label from parent if present
gh issue edit [parent-number] --repo scooter-indie/author-nonfiction --remove-label "story"

# Add story label to all sub-issues that don't have a label yet
gh issue edit [sub-1] --repo scooter-indie/author-nonfiction --add-label "story"
gh issue edit [sub-2] --repo scooter-indie/author-nonfiction --add-label "story"
# ... repeat for each sub-issue
```

**Note:** Only add "story" label to sub-issues that were created without a specific label (e.g., "finding", "bug"). If a sub-issue already has a meaningful label, keep it.

Then add a comment linking to sub-issues:
```bash
gh issue comment [parent-number] --repo scooter-indie/author-nonfiction \
  --body "## Sub-Issues Created

This epic has been broken into the following sub-issues:

- #[sub-1] - [description]
- #[sub-2] - [description]
- #[sub-3] - [description]

[additional context if any]"
```

---

### 5. Reopen Workflow (Reopening Closed Issues)

**Trigger phrases:**
- "reopen issue #[number]"
- "reopen #[number]"
- "open issue #[number] again"
- Any request to reopen a closed issue

**Action: Reopen and set status (AUTOMATIC)**

When user requests to reopen an issue:

```bash
gh issue reopen [issue-number] --repo scooter-indie/author-nonfiction
```

```bash
gh pm move [issue-number] --status in_progress
```

Then report: "Reopened issue #[number] and set status to In Progress."

---

## Session Behavior

After running `/gh-workflow`, Claude will:

- Automatically detect findings vs enhancements vs proposals from user language
- **Create issues immediately** when user reports finding or requests enhancement
- **Create proposals** in Proposal/ directory when requested
- **Wait for explicit instruction** before working on any issue or implementing proposals
- **Update project board status** via `gh pm move` (in_progress → in_review → done)
- Reference issue numbers in commits
- **Wait for user to say "Done"** before closing issues
- **Move implemented proposals** to Proposal/Implemented/
- **Link sub-issues** to parent using `gh sub-issue add` extension
- **Ask about epic label** when creating sub-issues for a parent issue
- **Reopen issues** and set status to in_progress

**Confirmation message after activation:**
```
GitHub Workflow Activated
━━━━━━━━━━━━━━━━━━━━━━━━━━
Project: scooter-indie/author-nonfiction
Board:   https://github.com/users/scooter-indie/projects/9/views/1

Extensions: gh-pm (status), gh-sub-issue (linking)

Workflows enabled:
• Finding → Create issue → [WAIT] → In Progress → Work → Commit → In Review → [WAIT for "Done"] → Done → Close
• Enhancement → Create issue → [WAIT] → In Progress → Work → Commit → In Review → [WAIT for "Done"] → Done → Close
• Proposal → Create doc + issue → [WAIT] → In Progress → Implement → Move to Implemented/ → In Review → [WAIT for "Done"] → Done → Close
• Sub-Issue → Create sub-issues → Link to parent (gh sub-issue) → Ask about epic label → Update parent if yes
• Reopen → Reopen issue → In Progress

Issues are created automatically. Work begins only when you say. Issues close only when you say "Done".
Project board status updates automatically via gh-pm.
```

---

## Manual Overrides

- **Skip issue creation:** User says "don't create an issue for this"
- **Different label:** User specifies "label this as [label]"
- **Don't close:** User says "keep the issue open"

---

*This is a framework maintainer command - not included in user releases*
