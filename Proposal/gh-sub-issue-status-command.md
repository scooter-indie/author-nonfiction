# Proposal: Add Status Command to gh-sub-issue Extension

**Issue:** #79
**Author:** Claude (AI-assisted)
**Date:** 2025-11-26
**Status:** Draft

---

## Executive Summary

Extend the [gh-sub-issue](https://github.com/scooter-indie/gh-sub-issue) GitHub CLI extension to include a `status` command that updates project board status for issues. This addresses the limitation that `gh issue edit` doesn't support project status updates, requiring complex GraphQL API calls that are impractical for inline workflow commands.

The new command would allow:
```bash
gh sub-issue status 79 "In Progress" --repo owner/repo
```

---

## Problem Statement

### Current Limitation

The GitHub CLI's `gh issue edit` command doesn't support project board status updates:

```bash
# This fails - flag doesn't exist
gh issue edit 79 --add-project-status "In Progress"
# Error: unknown flag: --add-project-status
```

### Why This Matters

Project boards are essential for workflow management. Without CLI support:
- Automation scripts can't update issue status
- CI/CD pipelines can't reflect work state
- The `/gh-workflow` command in author-nonfiction can't track status programmatically

### Current Workaround

Status is tracked via issue comments (e.g., "🔧 **Status: In Progress**"), but this:
- Doesn't update the actual project board
- Requires manual board updates
- Creates noise in issue history

### Existing Solution Complexity

The `gh project item-edit` command exists but requires multiple IDs:
```bash
gh project item-edit --id ITEM_ID --project-id PROJECT_ID \
  --field-id FIELD_ID --single-select-option-id OPTION_ID
```

Getting these IDs requires multiple GraphQL queries - too complex for inline use.

---

## Technical Design

### Architecture

Extend gh-sub-issue with a new `status` subcommand that:

1. **Resolves issue to project item** - Query issue's project memberships
2. **Gets Status field metadata** - Find field ID and available options
3. **Executes status update** - Call `updateProjectV2ItemFieldValue` mutation

### Command Interface

```bash
# Set status for an issue
gh sub-issue status <issue> <status-name> [flags]

# List available statuses for an issue's project
gh sub-issue status <issue> --list [flags]

# Flags
--repo, -R     Repository in owner/repo format (default: current repo)
--project, -p  Project number (if issue is in multiple projects)
--format       Output format: table, json (default: table)
```

### Examples

```bash
# Set issue #79 to "In Progress"
gh sub-issue status 79 "In Progress"

# Set status in specific repo
gh sub-issue status 79 "Done" --repo scooter-indie/author-nonfiction

# List available statuses
gh sub-issue status 79 --list
# Output:
# STATUS OPTIONS (Project: author-nonfiction)
# - Backlog
# - In Progress
# - In Review
# - Done

# JSON output for scripting
gh sub-issue status 79 --list --format json
```

### GraphQL Queries

#### 1. Get Issue's Project Items and Status Field

```graphql
query GetIssueProjectItems($owner: String!, $repo: String!, $number: Int!) {
  repository(owner: $owner, name: $repo) {
    issue(number: $number) {
      id
      title
      projectItems(first: 10) {
        nodes {
          id
          project {
            id
            number
            title
            field(name: "Status") {
              ... on ProjectV2SingleSelectField {
                id
                name
                options {
                  id
                  name
                }
              }
            }
          }
        }
      }
    }
  }
}
```

#### 2. Update Status Field Value

```graphql
mutation UpdateProjectItemStatus(
  $projectId: ID!
  $itemId: ID!
  $fieldId: ID!
  $optionId: String!
) {
  updateProjectV2ItemFieldValue(
    input: {
      projectId: $projectId
      itemId: $itemId
      fieldId: $fieldId
      value: { singleSelectOptionId: $optionId }
    }
  ) {
    projectV2Item {
      id
    }
  }
}
```

### Go Implementation Structure

```
cmd/
├── add.go          # existing
├── create.go       # existing
├── list.go         # existing
├── remove.go       # existing
├── root.go         # existing
├── status.go       # NEW - status command implementation
└── status_test.go  # NEW - status command tests
```

### Key Functions in status.go

```go
package cmd

import (
    "fmt"
    "github.com/spf13/cobra"
)

var statusCmd = &cobra.Command{
    Use:   "status <issue> [status-name]",
    Short: "Get or set project board status for an issue",
    Long: `Get or set the project board status for a GitHub issue.

Examples:
  # Set issue #79 to "In Progress"
  gh sub-issue status 79 "In Progress"

  # List available status options
  gh sub-issue status 79 --list

  # Set status in a specific repository
  gh sub-issue status 79 "Done" -R owner/repo`,
    RunE: runStatus,
}

func init() {
    rootCmd.AddCommand(statusCmd)
    statusCmd.Flags().BoolP("list", "l", false, "List available status options")
    statusCmd.Flags().StringP("repo", "R", "", "Repository in owner/repo format")
    statusCmd.Flags().IntP("project", "p", 0, "Project number (if multiple)")
    statusCmd.Flags().StringP("format", "f", "table", "Output format: table, json")
}

func runStatus(cmd *cobra.Command, args []string) error {
    // 1. Parse arguments
    // 2. Resolve issue reference
    // 3. Query project items
    // 4. If --list, display options and return
    // 5. Find matching status option
    // 6. Execute mutation
    // 7. Display result
}

func getIssueProjectItems(owner, repo string, number int) (*ProjectItemsResponse, error) {
    // Execute GraphQL query to get project items
}

func updateItemStatus(projectId, itemId, fieldId, optionId string) error {
    // Execute GraphQL mutation to update status
}
```

### Error Handling

| Scenario | Error Message |
|----------|---------------|
| Issue not in any project | `Error: Issue #79 is not part of any project` |
| Issue in multiple projects (no --project flag) | `Error: Issue #79 is in multiple projects. Use --project to specify: [list]` |
| Invalid status name | `Error: "Invalid" is not a valid status. Available: Backlog, In Progress, In Review, Done` |
| No permission | `Error: You don't have permission to update this project` |
| Status field not found | `Error: Project "name" doesn't have a Status field` |

---

## Implementation Plan

### Phase 1: Core Implementation (MVP)

1. **Add status.go** with basic structure
2. **Implement getIssueProjectItems()** - Query issue's project memberships
3. **Implement --list flag** - Display available status options
4. **Implement updateItemStatus()** - Execute the mutation
5. **Add status_test.go** - Unit tests with mocked responses

### Phase 2: Polish & Edge Cases

1. **Handle multiple projects** - Add --project flag support
2. **Add JSON output** - For scripting and automation
3. **Improve error messages** - Clear, actionable errors
4. **Add integration tests** - Test against real GitHub API

### Phase 3: Documentation & Release

1. **Update README.md** - Add status command documentation
2. **Update goreleaser config** - Ensure proper build
3. **Create release** - Tag and publish new version
4. **Update gh-workflow.md** - Use new command in author-nonfiction

---

## Integration with gh-workflow

After implementation, update `.claude/commands/gh-workflow.md`:

### Before (current workaround)
```bash
gh issue comment [issue-number] --repo scooter-indie/author-nonfiction \
  --body "🔧 **Status: In Progress**"
```

### After (with new command)
```bash
gh sub-issue status [issue-number] "In Progress" --repo scooter-indie/author-nonfiction
```

This provides:
- Actual project board updates
- No comment noise
- Queryable status via `--list`
- Scriptable automation

---

## Acceptance Criteria

### Must Have

- [ ] `gh sub-issue status <issue> <status>` updates project board status
- [ ] `gh sub-issue status <issue> --list` shows available statuses
- [ ] Works with issue numbers and URLs
- [ ] Clear error messages for common failures
- [ ] Unit tests with >80% coverage

### Should Have

- [ ] `--project` flag for issues in multiple projects
- [ ] `--format json` output option
- [ ] `--repo` flag for cross-repo operations

### Nice to Have

- [ ] Fuzzy matching for status names (e.g., "progress" matches "In Progress")
- [ ] Batch status updates for multiple issues
- [ ] Status history query

---

## Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| GitHub API changes | High | Pin to stable GraphQL schema version |
| Rate limiting | Medium | Cache project metadata, batch queries |
| Permission complexity | Medium | Clear error messages, document required scopes |
| Multiple projects | Low | Require explicit --project flag |

---

## Dependencies

- **Go 1.21+** - Language runtime
- **github.com/cli/go-gh** - GitHub CLI extension framework
- **github.com/spf13/cobra** - CLI framework (already used)
- **GitHub token scope** - `project` scope required (`gh auth refresh -s project`)

---

## Timeline Estimate

| Phase | Effort |
|-------|--------|
| Phase 1: MVP | 2-3 hours |
| Phase 2: Polish | 1-2 hours |
| Phase 3: Docs & Release | 1 hour |
| **Total** | **4-6 hours** |

---

## References

- [GitHub GraphQL Mutations](https://docs.github.com/en/graphql/reference/mutations)
- [Using the API to manage Projects](https://docs.github.com/en/issues/planning-and-tracking-with-projects/automating-your-project/using-the-api-to-manage-projects)
- [gh-sub-issue source](https://github.com/scooter-indie/gh-sub-issue)
- [GitHub CLI Extension Guide](https://docs.github.com/en/github-cli/github-cli/creating-github-cli-extensions)

---

*Proposal created for issue #79 - gh-workflow uses invalid --add-project-status flag*
