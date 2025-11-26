# Proposal: Create gh-project-tools CLI Extension

**Issue:** #79
**Author:** Claude (AI-assisted)
**Date:** 2025-11-26
**Status:** Draft

---

## Executive Summary

Create a new GitHub CLI extension called **gh-project-tools** that provides enhanced project board management capabilities. The extension will be based on [yahsan2/gh-sub-issue](https://github.com/yahsan2/gh-sub-issue) (MIT licensed) with proper attribution, and will expand beyond sub-issue management to include project status updates and future enhancements.

The initial release will include:
```bash
# Existing sub-issue functionality (from gh-sub-issue)
gh project-tools sub add 79 80 --repo owner/repo
gh project-tools sub create 79 --title "Sub-task" --repo owner/repo
gh project-tools sub list 79 --repo owner/repo

# NEW: Status management
gh project-tools status 79 "In Progress" --repo owner/repo
gh project-tools status 79 --list
```

---

## Repository Strategy

### New Repository: gh-project-tools

Rather than forking and diverging from gh-sub-issue, we will create a fresh repository with a new identity that reflects the expanded scope.

**Repository:** `https://github.com/scooter-indie/gh-project-tools`

### Why a New Repo Instead of Fork?

| Approach | Pros | Cons |
|----------|------|------|
| **Fork gh-sub-issue** | Easy setup, GitHub lineage | Name implies sub-issues only, fork badge suggests tracking upstream |
| **New repo (chosen)** | Clean identity, name reflects scope, room to grow | Must copy code, manual upstream tracking |

### Attribution Requirements (MIT License)

The original gh-sub-issue is MIT licensed, which permits:
- ✅ Commercial use
- ✅ Modification
- ✅ Distribution
- ✅ Sublicensing

**Required:** Include original copyright notice in LICENSE file.

### LICENSE File

```
MIT License

Copyright (c) 2024 scooter-indie
Copyright (c) 2023 yahsan2 (original gh-sub-issue - https://github.com/yahsan2/gh-sub-issue)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

### README Attribution

The README will include an acknowledgment section:

```markdown
## Acknowledgments

This project is based on [gh-sub-issue](https://github.com/yahsan2/gh-sub-issue)
by [@yahsan2](https://github.com/yahsan2), which provided the foundation for
sub-issue management functionality. We extend our thanks for their excellent work.
```

### Future Expansion Possibilities

The gh-project-tools name allows for future commands:
- `gh project-tools status` - Project board status management (this proposal)
- `gh project-tools sub` - Sub-issue management (from gh-sub-issue)
- `gh project-tools field` - Custom field management (future)
- `gh project-tools move` - Move items between projects (future)
- `gh project-tools bulk` - Batch operations (future)

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

The gh-project-tools extension will include a `status` command that:

1. **Resolves issue to project item** - Query issue's project memberships
2. **Gets Status field metadata** - Find field ID and available options
3. **Executes status update** - Call `updateProjectV2ItemFieldValue` mutation

### Command Interface

```bash
# Set status for an issue
gh project-tools status <issue> <status-name> [flags]

# List available statuses for an issue's project
gh project-tools status <issue> --list [flags]

# Flags
--repo, -R     Repository in owner/repo format (default: current repo)
--project, -p  Project number (if issue is in multiple projects)
--format       Output format: table, json (default: table)
```

### Examples

```bash
# Set issue #79 to "In Progress"
gh project-tools status 79 "In Progress"

# Set status in specific repo
gh project-tools status 79 "Done" --repo scooter-indie/author-nonfiction

# List available statuses
gh project-tools status 79 --list
# Output:
# STATUS OPTIONS (Project: author-nonfiction)
# - Backlog
# - In Progress
# - In Review
# - Done

# JSON output for scripting
gh project-tools status 79 --list --format json
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
gh-project-tools/
├── main.go                 # Entry point
├── go.mod                  # Module definition
├── go.sum                  # Dependencies
├── LICENSE                 # MIT with attribution
├── README.md               # Documentation
├── .goreleaser.yml         # Release config
├── cmd/
│   ├── root.go             # Root command (gh project-tools)
│   ├── sub.go              # Sub-issue parent command (gh project-tools sub)
│   ├── sub_add.go          # from gh-sub-issue
│   ├── sub_create.go       # from gh-sub-issue
│   ├── sub_list.go         # from gh-sub-issue
│   ├── sub_remove.go       # from gh-sub-issue
│   ├── status.go           # NEW - status command
│   └── status_test.go      # NEW - status tests
└── internal/
    ├── github/             # GitHub API helpers
    │   ├── client.go       # GraphQL client
    │   ├── issues.go       # Issue operations
    │   └── projects.go     # Project operations
    └── output/             # Output formatting
        ├── table.go
        └── json.go
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
  gh project-tools status 79 "In Progress"

  # List available status options
  gh project-tools status 79 --list

  # Set status in a specific repository
  gh project-tools status 79 "Done" -R owner/repo`,
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

### Phase 0: Repository Setup

1. **Create new repo** `scooter-indie/gh-project-tools`
2. **Copy source from gh-sub-issue** - Bring over core Go files
3. **Update LICENSE** - Add dual copyright with yahsan2 attribution
4. **Restructure commands** - Move sub-issue commands under `sub` parent
5. **Update module name** - Change go.mod to `github.com/scooter-indie/gh-project-tools`
6. **Update README** - New name, expanded scope, acknowledgments section
7. **Verify builds** - Ensure `go build` works with restructured code

### Phase 1: Status Command (MVP)

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

1. **Complete README.md** - Full command documentation
2. **Configure goreleaser** - Multi-platform builds
3. **Create initial release** - Tag v0.1.0 and publish
4. **Install extension** - `gh extension install scooter-indie/gh-project-tools`
5. **Update gh-workflow.md** - Use new command in author-nonfiction
6. **Delete old fork** - Remove scooter-indie/gh-sub-issue if no longer needed

---

## Integration with gh-workflow

After implementation, update `.claude/commands/gh-workflow.md`:

### Before (current workaround)
```bash
gh issue comment [issue-number] --repo scooter-indie/author-nonfiction \
  --body "🔧 **Status: In Progress**"
```

### After (with gh-project-tools)
```bash
gh project-tools status [issue-number] "In Progress" --repo scooter-indie/author-nonfiction
```

This provides:
- Actual project board updates
- No comment noise
- Queryable status via `--list`
- Scriptable automation

### Sub-issue commands also available
```bash
# Link sub-issues (replaces gh sub-issue add)
gh project-tools sub add [parent] [child] --repo scooter-indie/author-nonfiction
```

---

## Acceptance Criteria

### Must Have (Phase 0 - Repo Setup)

- [ ] New repo `scooter-indie/gh-project-tools` created
- [ ] LICENSE includes yahsan2 attribution
- [ ] README includes acknowledgments section
- [ ] Sub-issue commands work under `gh project-tools sub *`
- [ ] `go build` succeeds

### Must Have (Phase 1 - Status Command)

- [ ] `gh project-tools status <issue> <status>` updates project board status
- [ ] `gh project-tools status <issue> --list` shows available statuses
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
| Phase 0: Repo Setup | 1-2 hours |
| Phase 1: Status MVP | 2-3 hours |
| Phase 2: Polish | 1-2 hours |
| Phase 3: Docs & Release | 1 hour |
| **Total** | **5-8 hours** |

---

## References

- [GitHub GraphQL Mutations](https://docs.github.com/en/graphql/reference/mutations)
- [Using the API to manage Projects](https://docs.github.com/en/issues/planning-and-tracking-with-projects/automating-your-project/using-the-api-to-manage-projects)
- [Original gh-sub-issue by yahsan2](https://github.com/yahsan2/gh-sub-issue) - Foundation for sub-issue functionality
- [GitHub CLI Extension Guide](https://docs.github.com/en/github-cli/github-cli/creating-github-cli-extensions)
- [MIT License](https://opensource.org/licenses/MIT) - Permissive license allowing derivative works

---

*Proposal created for issue #79 - gh-workflow uses invalid --add-project-status flag*
