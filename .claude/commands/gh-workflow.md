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

## Session Behavior

After running `/gh-workflow`, Claude will:

- Automatically detect findings vs enhancements from user language
- **Create issues immediately** when user reports finding or requests enhancement
- **Wait for explicit instruction** before working on any issue
- Reference issue numbers in commits
- Close issues with commit hashes when work is complete
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

Issues are created automatically. Work begins only when you say.
```

---

## Manual Overrides

- **Skip issue creation:** User says "don't create an issue for this"
- **Different label:** User specifies "label this as [label]"
- **Don't close:** User says "keep the issue open"

---

*This is a framework maintainer command - not included in user releases*
