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

**Automatic workflow:**

1. **Create GitHub issue** with label `finding`:
   ```bash
   gh issue create --repo scooter-indie/author-nonfiction \
     --title "Finding: [brief description]" \
     --label "finding" \
     --body "[detailed description of the finding]"
   ```

2. **Work the issue** - Implement the fix

3. **Commit with issue reference**:
   ```bash
   git commit -m "Fix: [description] (#[issue-number])

   [details]

   Fixes #[issue-number]

   🤖 Generated with [Claude Code](https://claude.com/claude-code)

   Co-Authored-By: Claude <noreply@anthropic.com>"
   ```

4. **Close issue with commit reference**:
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

**Automatic workflow:**

1. **Create GitHub issue** with label `enhancement`:
   ```bash
   gh issue create --repo scooter-indie/author-nonfiction \
     --title "Enhancement: [brief description]" \
     --label "enhancement" \
     --body "[detailed description of the enhancement]"
   ```

2. **Work the issue** - Implement the feature

3. **Commit with issue reference**:
   ```bash
   git commit -m "[description] (#[issue-number])

   [details]

   Fixes #[issue-number]

   🤖 Generated with [Claude Code](https://claude.com/claude-code)

   Co-Authored-By: Claude <noreply@anthropic.com>"
   ```

4. **Close issue with commit reference**:
   ```bash
   gh issue close [issue-number] --repo scooter-indie/author-nonfiction \
     --comment "Implemented in commit [commit-hash]

     [brief summary of changes]"
   ```

---

## Session Behavior

After running `/gh-workflow`, Claude will:

- Automatically detect findings vs enhancements from user language
- Create issues before starting work
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
• Finding → Issue (label: finding) → Fix → Commit → Close
• Enhancement → Issue (label: enhancement) → Implement → Commit → Close

Ready to track issues automatically.
```

---

## Manual Overrides

- **Skip issue creation:** User says "don't create an issue for this"
- **Different label:** User specifies "label this as [label]"
- **Don't close:** User says "keep the issue open"

---

*This is a framework maintainer command - not included in user releases*
