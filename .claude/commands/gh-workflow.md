# GitHub Workflow Integration

**Framework-only command for maintainers**

This command configures Claude to automatically manage GitHub issues during development sessions.

---

## Project Configuration

**GitHub Project Board:** https://github.com/users/scooter-indie/projects/9/views/1
**Repository:** scooter-indie/author-nonfiction

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

**Step 3: Commit and close (AFTER WORK COMPLETE)**

```bash
git commit -m "Fix: [description] (#[issue-number])

[details]

Fixes #[issue-number]

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

```bash
gh issue close [issue-number] --repo scooter-indie/author-nonfiction \
  --comment "Fixed in commit [commit-hash]

  [brief summary of changes]"
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

**Step 3: Commit and close (AFTER WORK COMPLETE)**

```bash
git commit -m "[description] (#[issue-number])

[details]

Fixes #[issue-number]

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

```bash
gh issue close [issue-number] --repo scooter-indie/author-nonfiction \
  --comment "Implemented in commit [commit-hash]

  [brief summary of changes]"
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

**Step 3: Move proposal and close (AFTER IMPLEMENTATION COMPLETE)**

1. Move proposal to Implemented:
```bash
git mv Proposal/[Feature-Name].md Proposal/Implemented/[Feature-Name].md
```

2. Commit implementation with proposal move:
```bash
git commit -m "[description] (#[issue-number])

[details]

Fixes #[issue-number]

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

3. Close the issue:
```bash
gh issue close [issue-number] --repo scooter-indie/author-nonfiction \
  --comment "Implemented in commit [commit-hash]

  Proposal moved to Proposal/Implemented/[Feature-Name].md"
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

## Session Behavior

After running `/gh-workflow`, Claude will:

- Automatically detect findings vs enhancements vs proposals from user language
- **Create issues immediately** when user reports finding or requests enhancement
- **Create proposals** in Proposal/ directory when requested
- **Wait for explicit instruction** before working on any issue or implementing proposals
- Reference issue numbers in commits
- Close issues with commit hashes when work is complete
- **Move implemented proposals** to Proposal/Implemented/
- **Link sub-issues** to parent using `gh sub-issue add` extension
- **Ask about epic label** when creating sub-issues for a parent issue
- Link all work to the project board

**Confirmation message after activation:**
```
GitHub Workflow Activated
━━━━━━━━━━━━━━━━━━━━━━━━━━
Project: scooter-indie/author-nonfiction
Board:   https://github.com/users/scooter-indie/projects/9/views/1

Workflows enabled:
• Finding → Create issue (label: finding) → [WAIT] → Work when told → Commit → Close
• Enhancement → Create issue (label: enhancement) → [WAIT] → Work when told → Commit → Close
• Proposal → Create doc + issue → Commit → [WAIT] → Implement when told → Move to Implemented/ → Close
• Sub-Issue → Create sub-issues → Link to parent (gh sub-issue) → Ask about epic label → Update parent if yes

Issues are created automatically. Work begins only when you say.
```

---

## Manual Overrides

- **Skip issue creation:** User says "don't create an issue for this"
- **Different label:** User specifies "label this as [label]"
- **Don't close:** User says "keep the issue open"

---

*This is a framework maintainer command - not included in user releases*
