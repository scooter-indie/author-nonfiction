# Concurrent Editing Support

**Proposal ID:** CONCURRENCY
**Version:** 1.0.0
**Status:** DRAFT
**Created:** 2025-11-22
**Target Version:** 0.13.0

---

## Problem Statement

Users may want to run multiple Claude Code CLI instances simultaneously to work on different parts of their book project:

**Example scenarios:**
- Instance A: Writing Chapter 3
- Instance B: Revising Chapter 7
- Instance C: Running consistency check on full manuscript
- Instance D: Adding citations to Chapter 5

**Current Risk:**
Without coordination, multiple instances can create conflicts:
- Git merge conflicts when both commit changes
- Overwriting each other's file changes
- Inconsistent state in tracking files
- Lost work from instance collisions

---

## Goals

1. **Enable safe concurrent editing** across multiple Claude Code instances
2. **Prevent data loss** from file conflicts
3. **Minimize merge conflicts** through smart partitioning
4. **Provide clear workflows** for concurrent work patterns
5. **Maintain git integrity** with proper commit coordination

---

## Proposed Solutions

### Solution 1: Branch-Based Isolation (Recommended)

**Concept:** Each concurrent work session uses its own git branch

**Workflow:**

```bash
# Instance A - Working on Chapter 3
git checkout -b work/chapter-03
# Execute Prompt 3 or 4 to modify Chapter 3
# Commits go to work/chapter-03 branch

# Instance B - Working on Chapter 7
git checkout -b work/chapter-07
# Execute Prompt 3 or 4 to modify Chapter 7
# Commits go to work/chapter-07 branch

# When ready to integrate:
git checkout main
git merge work/chapter-03
git merge work/chapter-07
git push
```

**Advantages:**
- ✅ Complete isolation - no conflicts during work
- ✅ Easy rollback - can discard branch if needed
- ✅ Clear history - see exactly what changed in each session
- ✅ Standard git workflow - familiar to developers

**Disadvantages:**
- ⚠️ Requires merge step when done
- ⚠️ Need to remember which branch you're on
- ⚠️ May create merge conflicts if same files edited (though rare with chapter-based work)

**Best for:**
- Writing/editing different chapters
- Long work sessions (1+ hour)
- Experimental changes you might discard
- Users comfortable with git branching

---

### Solution 2: File-Based Partitioning (Simple)

**Concept:** Assign different chapters/sections to different instances, stay on same branch

**Coordination Rules:**

```
Instance A: Only touches Chapter_01, Chapter_02, Chapter_03
Instance B: Only touches Chapter_07, Chapter_08
Instance C: Only touches FrontMatter/, BackMatter/
```

**Workflow:**

1. **Before starting work:**
   ```bash
   git pull  # Get latest changes from other instances
   ```

2. **During work:**
   - Stick to assigned chapters
   - Commit frequently
   - Push immediately after commit

3. **After each commit:**
   ```bash
   git push  # Share your changes immediately
   ```

4. **Before each new task:**
   ```bash
   git pull  # Get changes from other instances
   ```

**Advantages:**
- ✅ Simple - no branching needed
- ✅ Immediate sharing via push/pull
- ✅ No merge conflicts if partitions respected

**Disadvantages:**
- ⚠️ Requires discipline (don't touch other instance's files)
- ⚠️ Risk of conflicts if both edit same shared files (Style/, Quotes/, .config/)
- ⚠️ Need frequent push/pull coordination

**Best for:**
- Short work sessions (< 30 min)
- Clear chapter boundaries
- Users less comfortable with git branching
- When working on completely separate chapters

---

### Solution 3: Lock Files (Semi-Automated)

**Concept:** Use lock files to signal which chapters are being edited

**Implementation:**

Create `.locks/` directory with lock files:

```
.locks/
├── chapter-03.lock    # Contains: "Instance A - Started 2025-11-22 10:30"
├── chapter-07.lock    # Contains: "Instance B - Started 2025-11-22 10:32"
└── README.md          # Explains lock file usage
```

**Workflow:**

```bash
# Instance A - Before working on Chapter 3
echo "Instance A - $(date)" > .locks/chapter-03.lock
git add .locks/chapter-03.lock
git commit -m "LOCK: Chapter 03 (Instance A)"
git push

# Work on Chapter 3...

# Instance A - After finishing Chapter 3
rm .locks/chapter-03.lock
git add .locks/chapter-03.lock
git commit -m "UNLOCK: Chapter 03 (Instance A)"
git push
```

**Prompt Integration:**
- Prompt 3/4 could check for lock files before modifying chapters
- Prompt 3/4 could auto-create/remove lock files
- Warning if attempting to edit locked chapter

**Advantages:**
- ✅ Visual indication of what's being edited
- ✅ Prevents accidental conflicts
- ✅ Works on same branch
- ✅ Can be automated in prompts

**Disadvantages:**
- ⚠️ Requires remembering to lock/unlock
- ⚠️ Lock files themselves can conflict if not pushed immediately
- ⚠️ Adds overhead to workflow

**Best for:**
- Teams with multiple people working on same book
- Long-running sessions with unclear boundaries
- When combined with file-based partitioning

---

## Recommended Workflows

### Workflow A: Solo Author, Multiple Tasks

**Scenario:** One author, multiple Claude Code instances for different tasks

**Strategy:** Branch-based isolation

```bash
# Terminal 1: Writing new content
git checkout -b writing/chapter-05
# Execute Prompt 3 or 4

# Terminal 2: Checking consistency
git checkout main
# Execute Prompt 8

# Terminal 3: Adding citations
git checkout -b enhance/citations-chapter-03
# Execute Prompt 14

# When ready to integrate:
git checkout main
git merge writing/chapter-05
git merge enhance/citations-chapter-03
git push
```

**Why:** Complete isolation, no coordination needed, clean history

---

### Workflow B: Co-Authors, Different Chapters

**Scenario:** Two authors working on different chapters of same book

**Strategy:** File-based partitioning + frequent push/pull

```bash
# Author A's instance (owns Chapters 1-5)
git pull                          # Get latest
# Work on Chapters 1-5 only
git push                          # Share immediately

# Author B's instance (owns Chapters 6-10)
git pull                          # Get latest
# Work on Chapters 6-10 only
git push                          # Share immediately
```

**Coordination file:** `.concurrency-plan.md`
```markdown
# Concurrency Plan

## Author A
- Chapters: 1, 2, 3, 4, 5
- FrontMatter: Copyright, Dedication
- Availability: Mon-Wed 9am-12pm

## Author B
- Chapters: 6, 7, 8, 9, 10
- BackMatter: Appendices, Glossary
- Availability: Thu-Fri 2pm-5pm

## Shared Resources (coordinate before editing)
- Style/Style_Guide.md
- Quotes/Chapter_Quotes.md
- .config/*.json
```

**Why:** Clear boundaries, minimal conflicts, real-time sharing

---

### Workflow C: Intensive Editing Session

**Scenario:** Single author doing heavy revision across multiple chapters simultaneously

**Strategy:** Lock files + branch-based isolation

```bash
# Terminal 1: Major revision of Chapter 3
git checkout -b revision/chapter-03
echo "Terminal 1 - Chapter 03 revision" > .locks/chapter-03.lock
git add .locks/ && git commit -m "LOCK: Chapter 03" && git push
# Execute Prompt 4 (interactive changes)

# Terminal 2: Major revision of Chapter 7
git checkout -b revision/chapter-07
echo "Terminal 2 - Chapter 07 revision" > .locks/chapter-07.lock
git add .locks/ && git commit -m "LOCK: Chapter 07" && git push
# Execute Prompt 4 (interactive changes)

# When both done:
git checkout main
git merge revision/chapter-03
git merge revision/chapter-07
rm .locks/*.lock
git add .locks/ && git commit -m "UNLOCK: Completed revisions" && git push
```

**Why:** Maximum safety, clear ownership, prevents self-conflicts

---

## Image Registry Concurrency

### The Problem

The image registry is a **high-conflict file** when multiple instances add images:

**Scenario:**
```
Instance A: Adds diagram to Chapter 3
  → Writes to Manuscript/images/Image_Registry.md

Instance B: Adds screenshot to Chapter 7
  → Writes to Manuscript/images/Image_Registry.md

CONFLICT: Both instances modified same file simultaneously
```

### The Solution: Registry Splitting

**See:** `Proposal/IMAGE_REGISTRY_SPLITTING.md` for complete details

**Split registry architecture:**
```
Manuscript/images/
├── Image_Registry.md                    # Master index (read-only for instances)
├── Image_Registry_Chapter_01.md         # Instance A writes here
├── Image_Registry_Chapter_03.md         # Instance A writes here
├── Image_Registry_Chapter_07.md         # Instance B writes here
└── Image_Registry_Chapter_10.md         # Instance B writes here
```

**How it prevents conflicts:**
- Instance A working on Chapter 3 → Writes to `Image_Registry_Chapter_03.md`
- Instance B working on Chapter 7 → Writes to `Image_Registry_Chapter_07.md`
- **No conflict** because they write to different files
- Master registry updated separately (or generated from chapter registries)

**Concurrency benefits:**
- ✅ Zero conflicts when adding images to different chapters
- ✅ Each instance has isolated registry file
- ✅ Can work on same chapter's images if using branches (each branch has own registry state)
- ✅ 89% token reduction (see IMAGE_REGISTRY_SPLITTING.md)

**Recommendation:**
- If using concurrent editing, **implement split registries first** (v0.14.0)
- Single registry mode becomes a concurrency bottleneck for image-heavy books

**Integration with concurrency workflows:**

```bash
# Branch-based workflow with split registries
git checkout -b enhance/add-diagrams-chapter-03
# Prompt 16 or 15 adds images to Image_Registry_Chapter_03.md
# No conflict with main branch or other feature branches
git checkout main
git merge enhance/add-diagrams-chapter-03  # Clean merge!

# File-based partitioning with split registries
# Instance A: Chapters 1-5 → Writes to Image_Registry_Chapter_01-05.md
# Instance B: Chapters 6-10 → Writes to Image_Registry_Chapter_06-10.md
# No coordination needed, no conflicts
```

---

## Conflict Detection and Resolution

### Files Most Likely to Conflict

**High conflict risk:**
- `Manuscript/Style/Style_Guide.md` - Global style settings
- `Manuscript/Quotes/Chapter_Quotes.md` - All chapter quotes
- `.config/metadata.json` - Project metadata
- `.config/project.json` - Project settings
- `README.md` - Auto-generated from reports

**Medium conflict risk:**
- `Manuscript/Style/Style_Overrides.md` - If multiple chapters get overrides
- **`Manuscript/images/Image_Registry.md`** - **HIGH RISK if both instances add images simultaneously**
  - Single registry file = all instances write to same file
  - **SOLUTION:** Implement chapter-based registry splitting (see `Proposal/IMAGE_REGISTRY_SPLITTING.md`)
  - Split registries eliminate this conflict entirely

**Low conflict risk:**
- `Manuscript/Chapters/Chapter_XX/Chapter_XX.md` - Each chapter independent
- `Manuscript/Chapters/Chapter_XX/Chapter_XX_chg.md` - Each chapter independent
- `Manuscript/FrontMatter/*.md` - Usually edited separately
- `Manuscript/BackMatter/*.md` - Usually edited separately
- **`Manuscript/images/Image_Registry_Chapter_XX.md`** - If using split registries (no conflicts!)

### Conflict Prevention Rules

**Rule 1: One instance per chapter**
- Never have two instances working on the same chapter simultaneously

**Rule 2: Coordinate shared file edits**
- Before editing Style_Guide.md, check if other instance needs it
- Before editing Chapter_Quotes.md, use git pull first

**Rule 3: Commit frequently**
- Small, frequent commits reduce conflict window
- Push immediately after commit if using file-based partitioning

**Rule 4: Pull before starting new work**
- Always `git pull` before executing a new prompt
- Ensures you have latest changes from other instances

### Merge Conflict Resolution

If conflicts occur:

```bash
# Attempt merge
git merge work/chapter-03
# CONFLICT in Manuscript/Style/Style_Guide.md

# Option 1: Manual resolution
git status                        # See conflicted files
# Edit files, resolve conflict markers (<<<<<<, ======, >>>>>>)
git add Manuscript/Style/Style_Guide.md
git commit -m "Merge: Resolved Style_Guide conflicts"

# Option 2: Take one side completely
git checkout --ours Manuscript/Style/Style_Guide.md    # Keep main branch version
# OR
git checkout --theirs Manuscript/Style/Style_Guide.md  # Keep feature branch version
git add Manuscript/Style/Style_Guide.md
git commit -m "Merge: Accepted branch version of Style_Guide"

# Option 3: Abort merge and try different approach
git merge --abort
# Coordinate with other instance, try again later
```

---

## Prompt Modifications for Concurrency

### Prompt 3 & 4: Change by Chg / Interactive Change

**Enhancement:** Check for locks before modifying

```markdown
## Step 0: Concurrency Check (if .locks/ exists)

1. Check for lock files:
   ```bash
   ls .locks/chapter-*.lock 2>/dev/null
   ```

2. If lock exists for current chapter:
   ```
   ⚠️ Chapter XX is currently locked by another instance:
   [Contents of .locks/chapter-XX.lock]

   Options:
   1. Wait for lock to be released
   2. Override lock (may cause conflicts)
   3. Cancel operation

   Choose option:
   ```

3. If no lock, optionally create one:
   ```
   Create lock file for Chapter XX? (prevents other instances from editing)
   [Y/n]
   ```
```

### Prompt 8: Consistency Checker

**Enhancement:** Read-only mode, no locking needed

```markdown
## Concurrency Handling

Consistency Checker is READ-ONLY and safe to run concurrently with other instances.
No locking required.

⚠️ Note: If other instances are making changes during this check, results may be outdated.
Consider running Prompt 8 when other instances are idle for most accurate results.
```

### Prompt 10: Progress Dashboard

**Enhancement:** Show concurrent activity

```markdown
## Dashboard: Concurrent Activity

**Active Locks:**
- Chapter 03: Instance A (started 2025-11-22 10:30)
- Chapter 07: Instance B (started 2025-11-22 10:45)

**Recent Commits (last 1 hour):**
- 10:32 - AUTO: Apply changes to Chapter_03.md (Instance A)
- 10:47 - AUTO: Apply changes to Chapter_07.md (Instance B)

**Branch Status:**
- Current branch: main
- Other branches: work/chapter-03, work/chapter-07, enhance/citations
```

### Prompt 12: Git Operations

**Enhancement:** Add concurrency-aware commands

```markdown
## New Concurrency Commands

1. **Create work branch:** Creates isolated branch for current work
2. **List active branches:** Shows all work branches and their status
3. **Merge work branch:** Safely merges completed work back to main
4. **Check locks:** Shows current lock status
5. **Create/release lock:** Manually manage chapter locks
6. **Sync with remote:** Pull latest, push current (for file-based partitioning)
```

---

## Implementation Plan

### Phase 1: Documentation (v0.13.0)

- [ ] Add this proposal to `Proposal/` directory
- [ ] Add concurrency section to `Process/AI-Assisted_Nonfiction_Authoring_Process.md`
- [ ] Create `Process/Concurrency_Guide.md` with workflows
- [ ] Update `CLAUDE.md` with concurrency notes
- [ ] Add concurrency workflows to `Process/Prompts/QUICK_REFERENCE.md`

### Phase 2: Git Branch Workflows (v0.13.0)

- [ ] Update Prompt 12 with branch management commands
- [ ] Add branch creation templates (`work/chapter-XX`, `enhance/TYPE`, `fix/ISSUE`)
- [ ] Document merge procedures
- [ ] Create conflict resolution guide

### Phase 3: Lock File System + Registry Splitting (v0.14.0)

**Lock Files:**
- [ ] Create `.locks/` directory structure
- [ ] Create `Process/Scripts/lock-chapter.sh` and `unlock-chapter.sh`
- [ ] Update Prompts 3 & 4 to check for locks
- [ ] Add lock status to Prompt 10 dashboard
- [ ] Create lock management commands in Prompt 12

**Image Registry Splitting (Critical for Concurrency):**
- [ ] Implement `Proposal/IMAGE_REGISTRY_SPLITTING.md`
- [ ] Split single registry into chapter-based registries
- [ ] Update Prompts 6, 8, 10, 15, 16 for split registry support
- [ ] **Benefit:** Eliminates image registry conflicts in concurrent editing

### Phase 4: Enhanced Coordination (v0.15.0)

- [ ] Create `.concurrency-plan.md` template
- [ ] Add concurrent activity tracking to Prompt 10
- [ ] Create `Process/Scripts/check-conflicts.sh` (pre-merge conflict detection)
- [ ] Add "safe to merge" checks before branch merges
- [ ] Create automated conflict resolution strategies

---

## User Education

### Quick Start: Concurrent Editing

**Beginner approach (no branching):**

1. **Assign chapters to instances:**
   - Instance A: Chapters 1-5
   - Instance B: Chapters 6-10

2. **Before each session:**
   ```bash
   git pull
   ```

3. **After each change:**
   ```bash
   git push
   ```

4. **Rule:** Never edit the same chapter in two instances

**Advanced approach (branching):**

1. **Create work branch:**
   ```bash
   git checkout -b work/chapter-03
   ```

2. **Do your work, make commits**

3. **When done:**
   ```bash
   git checkout main
   git merge work/chapter-03
   git push
   ```

---

## Alternative Approaches Considered

### 1. File Locking via Filesystem

**Concept:** Use OS-level file locks

**Rejected because:**
- Not portable across Windows/Mac/Linux
- Doesn't work over network drives
- Can leave stale locks if instance crashes
- Git doesn't integrate with filesystem locks

### 2. Centralized Coordination Server

**Concept:** Run a local server that coordinates lock acquisition

**Rejected because:**
- Adds complexity (server setup, maintenance)
- Requires network connectivity
- Overkill for solo authors
- Goes against framework's simplicity principle

### 3. Automatic Conflict Resolution in Prompts

**Concept:** Have prompts auto-detect and resolve merge conflicts

**Rejected because:**
- Dangerous - could silently discard user content
- Merge conflicts require human judgment
- Better to prevent conflicts than auto-resolve

### 4. Distributed Lock Files (One Per Chapter)

**Concept:** Individual lock files instead of centralized directory

**Considered for future:** May implement as enhancement to Solution 3

---

## Risks and Mitigations

### Risk 1: Users forget which instance is editing what

**Mitigation:**
- Prompt 10 shows active locks and recent commits
- Branch names self-document purpose (`work/chapter-03`)
- Terminal window titles can show current chapter

### Risk 2: Merge conflicts in shared files

**Mitigation:**
- Document high-risk files clearly
- Encourage communication if co-authoring
- Provide clear conflict resolution guide
- Make shared files smaller (e.g., split Image_Registry per chapter)

### Risk 3: Lost work from improper merging

**Mitigation:**
- Git never loses committed work (can always recover)
- Teach `git reflog` for recovery
- Recommend frequent commits
- Provide tested merge procedures

### Risk 4: Complexity overwhelms users

**Mitigation:**
- Provide simple "beginner" workflow (file-based partitioning)
- Make branching optional (advanced users only)
- Clear documentation with examples
- Lock files optional (only if needed)

---

## Success Metrics

**Phase 1 (Documentation):**
- ✅ Users understand concurrency risks
- ✅ Users can choose appropriate workflow for their use case

**Phase 2 (Branch Workflows):**
- ✅ Users successfully merge branches without data loss
- ✅ < 5% of users report merge conflicts

**Phase 3 (Lock Files):**
- ✅ Lock file system prevents > 90% of concurrent edits on same chapter
- ✅ Users can see what other instances are doing

**Phase 4 (Enhanced Coordination):**
- ✅ Co-authors successfully collaborate on same book
- ✅ Conflict resolution time < 5 minutes average

---

## Recommendations

### For Solo Authors (Most Common)

**Use Branch-Based Isolation:**
- Simple, safe, standard git workflow
- No risk of conflicts between your own instances
- Easy to discard experimental work
- Clean history of what changed

**Example:**
```bash
# Terminal 1
git checkout -b writing/chapter-03
# Work on Chapter 3

# Terminal 2
git checkout -b enhance/add-citations
# Work on citations

# When done
git checkout main
git merge writing/chapter-03
git merge enhance/add-citations
```

### For Co-Authors (Less Common)

**Use File-Based Partitioning + Communication:**
- Create `.concurrency-plan.md` documenting who owns what
- Use frequent push/pull
- Communicate before editing shared files
- Consider lock files for long sessions

### For Advanced Users

**Combine strategies:**
- Use branches for isolation
- Use lock files for visibility
- Use file-based partitioning rules
- Script common operations

---

## Open Questions

1. **Should lock files be mandatory or optional?**
   - Leaning toward: Optional, enabled per-user preference

2. **Should prompts auto-create branches?**
   - Leaning toward: No, users should manage branches explicitly

3. **How to handle Prompt 8 (Consistency) conflicts?**
   - Leaning toward: Read-only, safe to run concurrently, may have stale results

4. **Should we detect remote vs. local concurrent instances differently?**
   - Leaning toward: No distinction, same rules apply

---

## Conclusion

**Recommended Implementation:**

1. **v0.13.0:** Documentation + Git branch workflows (Solutions 1 & 2)
   - Low effort, high value
   - Uses standard git features
   - Covers 90% of use cases

2. **v0.14.0:** Lock file system (Solution 3)
   - Adds visibility for advanced users
   - Optional feature, doesn't complicate simple workflows

3. **v0.15.0:** Enhanced coordination features
   - Activity tracking in Dashboard
   - Conflict prevention tools
   - Co-authoring support

**Key Principle:**
Make concurrent editing **safe by default** through clear documentation and workflow guidance, with **optional tools** for advanced use cases.

---

**Status:** Ready for review and feedback
**Next Steps:**
1. Review proposal
2. Gather user feedback on workflows
3. Prioritize solutions for v0.13.0
4. Begin documentation phase

---

**Framework Version:** 0.12.9
**Proposal Version:** 1.0.0
**Last Updated:** 2025-11-22
