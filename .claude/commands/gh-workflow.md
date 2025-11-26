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

## Session Behavior

After running `/gh-workflow`, Claude will:

- Automatically detect findings vs enhancements vs proposals from user language
- **Create issues immediately** when user reports finding or requests enhancement
- **Create proposals** in Proposal/ directory when requested
- **Wait for explicit instruction** before working on any issue or implementing proposals
- Reference issue numbers in commits
- Close issues with commit hashes when work is complete
- **Move implemented proposals** to Proposal/Implemented/
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

Issues are created automatically. Work begins only when you say.
```

---

## Manual Overrides

- **Skip issue creation:** User says "don't create an issue for this"
- **Different label:** User specifies "label this as [label]"
- **Don't close:** User says "keep the issue open"

---

*This is a framework maintainer command - not included in user releases*
