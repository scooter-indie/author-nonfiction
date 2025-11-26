# Proposal: Create gh-project-tools CLI Extension

**Issue:** #79
**Author:** Claude (AI-assisted)
**Date:** 2025-11-26
**Status:** Draft

---

## Executive Summary

Create a new GitHub CLI extension called **gh-project-tools** that combines the capabilities of two excellent extensions by [@yahsan2](https://github.com/yahsan2):

- **[gh-sub-issue](https://github.com/yahsan2/gh-sub-issue)** - Sub-issue/hierarchy management
- **[gh-pm](https://github.com/yahsan2/gh-pm)** - Project board management

Both are MIT licensed, allowing us to merge them into a unified tool with a consistent interface and room for future enhancements.

```bash
# Sub-issue management (from gh-sub-issue)
gh project-tools sub add 79 80
gh project-tools sub create 79 --title "Sub-task"
gh project-tools sub list 79
gh project-tools sub remove 79 80

# Project management (from gh-pm)
gh project-tools list
gh project-tools create --title "New issue"
gh project-tools view 79
gh project-tools move 79 --status in_progress
gh project-tools split 79
gh project-tools intake
gh project-tools triage
gh project-tools init
```

---

## Source Repositories

### gh-sub-issue (v0.5.1)

**Repository:** https://github.com/yahsan2/gh-sub-issue
**License:** MIT
**Purpose:** Manage sub-issues (child issues) with hierarchical task structures

| Command | Description |
|---------|-------------|
| `add` | Link existing issues as sub-issues to a parent |
| `create` | Create new issues directly connected to a parent |
| `list` | Display all sub-issues attached to a parent |
| `remove` | Unlink sub-issues from parent (without deletion) |

### gh-pm (v0.6.7)

**Repository:** https://github.com/yahsan2/gh-pm
**License:** MIT
**Purpose:** Streamline project management from the command line

| Command | Description |
|---------|-------------|
| `init` | Initialize configuration with project detection |
| `list` | List issues in project with filtering |
| `create` | Create new issue with project metadata |
| `view` | View issue details with project information |
| `move` | Update issue status/priority fields |
| `split` | Decompose issues into sub-issues |
| `intake` | Find and add issues not in project |
| `triage` | Bulk process issues with configurable rules |

---

## Repository Strategy

### New Repository: gh-project-tools

Create a fresh repository that combines both tools under a unified interface.

**Repository:** `https://github.com/scooter-indie/gh-project-tools`

### Why Combine?

| Current State | Problem | Solution |
|---------------|---------|----------|
| Two separate extensions | Different install, different commands | Single unified tool |
| `gh sub-issue` + `gh pm` | Overlapping concerns (both deal with issues/projects) | Consistent interface |
| Separate maintenance | Track two upstreams | Single codebase |

### Attribution Requirements (MIT License)

Both source repositories use the MIT License, which permits:
- ✅ Commercial use
- ✅ Modification
- ✅ Distribution
- ✅ Sublicensing

**Required:** Include both original copyright notices in LICENSE file.

### LICENSE File

```
MIT License

Copyright (c) 2025 scooter-indie
Copyright (c) 2023-2024 yahsan2 (gh-sub-issue - https://github.com/yahsan2/gh-sub-issue)
Copyright (c) 2023-2024 yahsan2 (gh-pm - https://github.com/yahsan2/gh-pm)

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

```markdown
## Acknowledgments

This project combines and extends two excellent GitHub CLI extensions by
[@yahsan2](https://github.com/yahsan2):

- **[gh-sub-issue](https://github.com/yahsan2/gh-sub-issue)** - Foundation for
  sub-issue hierarchy management (`sub` commands)
- **[gh-pm](https://github.com/yahsan2/gh-pm)** - Foundation for project board
  management (`list`, `create`, `view`, `move`, `split`, `intake`, `triage`, `init`)

We extend our sincere thanks for their excellent work making GitHub project
management accessible from the command line.
```

---

## Combined Command Structure

### Command Hierarchy

```
gh project-tools
├── sub                    # Sub-issue management (from gh-sub-issue)
│   ├── add               # Link issues as sub-issues
│   ├── create            # Create new sub-issue
│   ├── list              # List sub-issues
│   └── remove            # Unlink sub-issues
├── list (ls)             # List project issues (from gh-pm)
├── create                # Create issue with project metadata (from gh-pm)
├── view                  # View issue details (from gh-pm)
├── move                  # Update status/priority (from gh-pm)
├── split                 # Decompose into sub-issues (from gh-pm)
├── intake                # Find issues not in project (from gh-pm)
├── triage                # Bulk process issues (from gh-pm)
└── init                  # Initialize configuration (from gh-pm)
```

### Usage Examples

```bash
# Initialize project configuration
gh project-tools init

# List issues in project
gh project-tools list
gh project-tools ls --status in_progress
gh project-tools list --priority p0,p1 --format json

# Create new issue
gh project-tools create --title "New feature" --status backlog --priority p1

# View issue details
gh project-tools view 79

# Update issue status/priority
gh project-tools move 79 --status in_progress
gh project-tools move 79 --status done --priority p0

# Sub-issue management
gh project-tools sub add 79 80 81        # Link 80, 81 as children of 79
gh project-tools sub create 79 --title "Sub-task"
gh project-tools sub list 79
gh project-tools sub remove 79 80

# Split issue into sub-issues
gh project-tools split 79

# Find issues not in project
gh project-tools intake

# Bulk triage
gh project-tools triage
```

---

## Go Implementation Structure

```
gh-project-tools/
├── main.go                     # Entry point
├── go.mod                      # github.com/scooter-indie/gh-project-tools
├── go.sum                      # Dependencies
├── LICENSE                     # MIT with dual attribution
├── README.md                   # Documentation with acknowledgments
├── .goreleaser.yml             # Release automation
├── .gh-pm.yml.example          # Example configuration
│
├── cmd/
│   ├── root.go                 # Root command (gh project-tools)
│   │
│   │   # Sub-issue commands (from gh-sub-issue)
│   ├── sub.go                  # Parent: gh project-tools sub
│   ├── sub_add.go              # gh project-tools sub add
│   ├── sub_add_test.go
│   ├── sub_create.go           # gh project-tools sub create
│   ├── sub_create_test.go
│   ├── sub_list.go             # gh project-tools sub list
│   ├── sub_list_test.go
│   ├── sub_remove.go           # gh project-tools sub remove
│   ├── sub_remove_test.go
│   │
│   │   # Project management commands (from gh-pm)
│   ├── init.go                 # gh project-tools init
│   ├── init_test.go
│   ├── list.go                 # gh project-tools list
│   ├── list_test.go
│   ├── create.go               # gh project-tools create
│   ├── create_test.go
│   ├── view.go                 # gh project-tools view
│   ├── view_test.go
│   ├── move.go                 # gh project-tools move
│   ├── move_test.go
│   ├── split.go                # gh project-tools split
│   ├── split_test.go
│   ├── intake.go               # gh project-tools intake
│   ├── intake_test.go
│   ├── triage.go               # gh project-tools triage
│   └── triage_test.go
│
└── internal/
    ├── config/                 # Configuration handling
    │   ├── config.go           # .gh-pm.yml parsing
    │   └── config_test.go
    ├── github/                 # GitHub API helpers
    │   ├── client.go           # GraphQL client
    │   ├── issues.go           # Issue operations
    │   ├── projects.go         # Project operations
    │   └── subissues.go        # Sub-issue operations
    └── output/                 # Output formatting
        ├── table.go
        ├── json.go
        └── csv.go
```

---

## Implementation Plan

### Phase 0: Repository Setup

1. **Create new repo** `scooter-indie/gh-project-tools`
2. **Initialize Go module** with proper module path
3. **Create LICENSE** with dual yahsan2 attribution
4. **Create README.md** with acknowledgments section
5. **Set up .goreleaser.yml** for multi-platform builds
6. **Create basic root.go** with version command

### Phase 1: Integrate gh-sub-issue

1. **Copy sub-issue source** from gh-sub-issue
2. **Restructure as `sub` subcommand** (sub add, sub create, sub list, sub remove)
3. **Update imports** to new module path
4. **Run tests** to verify functionality
5. **Update command help text** to reflect new structure

### Phase 2: Integrate gh-pm

1. **Copy gh-pm source** for core commands
2. **Integrate commands** (init, list, create, view, move, split, intake, triage)
3. **Merge shared code** (GraphQL client, output formatting)
4. **Update imports** to new module path
5. **Run tests** to verify functionality
6. **Ensure config file compatibility** (.gh-pm.yml format)

### Phase 3: Unify & Polish

1. **Consolidate shared code** in internal/ packages
2. **Ensure consistent error handling** across all commands
3. **Ensure consistent output formatting** (table, json, csv)
4. **Add integration tests** for combined workflows
5. **Update all help text** for consistency

### Phase 4: Documentation & Release

1. **Complete README.md** with full command documentation
2. **Add CHANGELOG.md** documenting the merge
3. **Configure GitHub Actions** for CI/CD
4. **Create initial release** v1.0.0
5. **Publish to GitHub** for `gh extension install`
6. **Update author-nonfiction gh-workflow.md** to use new tool

---

## Integration with gh-workflow

After implementation, update `.claude/commands/gh-workflow.md`:

### Current (two extensions)
```bash
gh pm move 79 --status in_progress
gh sub-issue add 79 80
```

### After (unified tool)
```bash
gh project-tools move 79 --status in_progress
gh project-tools sub add 79 80
```

**Benefits:**
- Single extension to install and maintain
- Consistent command interface
- Unified configuration

---

## Acceptance Criteria

### Must Have (Phase 0-1 - Setup & Sub-issues)

- [ ] New repo `scooter-indie/gh-project-tools` created
- [ ] LICENSE includes dual yahsan2 attribution
- [ ] README includes acknowledgments section
- [ ] `gh project-tools sub add` works
- [ ] `gh project-tools sub create` works
- [ ] `gh project-tools sub list` works
- [ ] `gh project-tools sub remove` works
- [ ] All sub-issue tests pass

### Must Have (Phase 2 - Project Management)

- [ ] `gh project-tools init` works
- [ ] `gh project-tools list` works
- [ ] `gh project-tools create` works
- [ ] `gh project-tools view` works
- [ ] `gh project-tools move` works
- [ ] `gh project-tools split` works
- [ ] `gh project-tools intake` works
- [ ] `gh project-tools triage` works
- [ ] Configuration file (.gh-pm.yml) compatible
- [ ] All gh-pm tests pass

### Must Have (Phase 3-4 - Polish & Release)

- [ ] Consistent error messages across all commands
- [ ] Consistent output formatting (table, json, csv)
- [ ] `go build` succeeds on Linux, macOS, Windows
- [ ] `gh extension install scooter-indie/gh-project-tools` works
- [ ] README documents all commands

### Should Have

- [ ] GitHub Actions CI/CD pipeline
- [ ] Integration tests for combined workflows
- [ ] Shell completions (bash, zsh, fish)

### Nice to Have

- [ ] Alias support (e.g., `ls` for `list`)
- [ ] Interactive mode for triage
- [ ] Dry-run mode for destructive operations

---

## Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| Code incompatibility | High | Test each phase thoroughly before moving on |
| Config format changes | Medium | Maintain .gh-pm.yml compatibility |
| GitHub API changes | Medium | Pin to stable GraphQL schema version |
| Upstream updates | Low | Document divergence, optionally backport fixes |

---

## Dependencies

- **Go 1.21+** - Language runtime
- **github.com/cli/go-gh/v2** - GitHub CLI extension framework
- **github.com/spf13/cobra** - CLI framework
- **github.com/spf13/viper** - Configuration management
- **gopkg.in/yaml.v3** - YAML parsing
- **GitHub token scopes** - `repo`, `project` (for project board access)

---

## Timeline Estimate

| Phase | Effort |
|-------|--------|
| Phase 0: Repository Setup | 1 hour |
| Phase 1: Integrate gh-sub-issue | 2-3 hours |
| Phase 2: Integrate gh-pm | 3-4 hours |
| Phase 3: Unify & Polish | 2-3 hours |
| Phase 4: Docs & Release | 1-2 hours |
| **Total** | **9-13 hours** |

---

## Future Enhancements

Once the merged tool is stable, potential future additions:

| Feature | Description |
|---------|-------------|
| `gh project-tools sync` | Sync issues across multiple projects |
| `gh project-tools archive` | Bulk archive completed issues |
| `gh project-tools report` | Generate project status reports |
| `gh project-tools migrate` | Migrate issues between projects |
| `gh project-tools template` | Apply issue templates |

---

## References

- [gh-sub-issue by yahsan2](https://github.com/yahsan2/gh-sub-issue) - Sub-issue management
- [gh-pm by yahsan2](https://github.com/yahsan2/gh-pm) - Project management
- [GitHub GraphQL API](https://docs.github.com/en/graphql)
- [GitHub CLI Extension Guide](https://docs.github.com/en/github-cli/github-cli/creating-github-cli-extensions)
- [MIT License](https://opensource.org/licenses/MIT)

---

*Proposal to combine gh-sub-issue and gh-pm into unified gh-project-tools extension*
