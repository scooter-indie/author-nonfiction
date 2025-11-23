# Concurrent Editing Implementation

**Proposal ID:** CONCURRENCY
**Version:** 2.0.0 (Simplified)
**Status:** IN PROGRESS
**Created:** 2025-11-22
**Target Version:** 0.13.0

---

## Problem Statement

Solo authors running multiple Claude Code CLI instances (or mix of CLI and Desktop) can create conflicts when editing the same book project simultaneously.

**Example:**
- Instance A: Working on Chapter 3
- Instance B: Working on Chapter 7
- Both commit changes → no conflict (different chapters)

**But:**
- Instance A: Working on Chapter 3
- Instance B: Also working on Chapter 3
- Both commit changes → **CONFLICT**

---

## Solution

**Lock Management Module:** `Process/_COMMON/18_Lock_Management_Module.md`

**Key Features:**
- Resource-level locking (Chapter_XX, StyleSystem, ImageRegistry, etc.)
- Single JSON lock file (`.locks/locks.json`)
- 15-minute stale lock timeout
- User choices when lock encountered: wait, cancel, or override (if stale)
- Clear all locks command for recovery
- Works in both CLI and Desktop

**Status:** ✅ Module created (v1.0.0)

---

## Implementation Checklist

### Infrastructure (✅ Complete)

- [x] Create lock management module documentation
- [x] Define resource names and lock file structure
- [x] Document lock operations (acquire, release, check, clear all)
- [ ] Add `.locks/` to `.gitignore` template
- [ ] Update `CLAUDE.md` to reference lock system

### Prompt Updates (❌ Not Started)

**10 prompts need lock implementation:**

#### Prompt 1: Initialize
- [ ] Read module: `Process/_COMMON/18_Lock_Management_Module.md`
- [ ] Add Step 0: Lock Management
- [ ] Acquire lock: `ProjectConfig`
- [ ] Release lock after initialization complete
- **Resources locked:** `ProjectConfig`

#### Prompt 2: Add Chapter
- [ ] Read module: `Process/_COMMON/18_Lock_Management_Module.md`
- [ ] Add Step 0: Lock Management
- [ ] Acquire locks: `Chapter_XX` (new chapter), `ProjectConfig`
- [ ] Release locks after chapter created
- **Resources locked:** `Chapter_XX`, `ProjectConfig`

#### Prompt 3: Change by Chg
- [ ] Read module: `Process/_COMMON/18_Lock_Management_Module.md`
- [ ] Add Step 0: Lock Management
- [ ] Determine which chapter(s) being modified
- [ ] Acquire lock: `Chapter_XX` for each chapter
- [ ] Release locks after changes applied
- **Resources locked:** `Chapter_XX` (one or more)

#### Prompt 4: Interactive Change
- [ ] Read module: `Process/_COMMON/18_Lock_Management_Module.md`
- [ ] Add Step 0: Lock Management
- [ ] Determine which chapter being modified
- [ ] Acquire lock: `Chapter_XX`
- [ ] Release lock after changes applied
- **Resources locked:** `Chapter_XX`

#### Prompt 5: Scan For User Edits
- [ ] Read module: `Process/_COMMON/18_Lock_Management_Module.md`
- [ ] Add Step 0: Lock Management
- [ ] Determine which chapters to scan
- [ ] Acquire lock: `Chapter_XX` for each chapter being updated
- [ ] Release locks after _chg files updated
- **Resources locked:** `Chapter_XX` (one or more)

#### Prompt 6: Integrate Inbox
- [ ] Read module: `Process/_COMMON/18_Lock_Management_Module.md`
- [ ] Add Step 0: Lock Management
- [ ] Analyze inbox content to determine resources needed
- [ ] Acquire locks based on content:
  - `Chapter_XX` if integrating into chapter
  - `FrontMatter` if integrating into front matter
  - `BackMatter` if integrating into back matter
  - `ImageRegistry` if adding images
- [ ] Release locks after integration complete
- **Resources locked:** Varies by content

#### Prompt 11: Style Manager
- [ ] Read module: `Process/_COMMON/18_Lock_Management_Module.md`
- [ ] Add Step 0: Lock Management
- [ ] Acquire lock: `StyleSystem`
- [ ] Release lock after style changes applied
- **Resources locked:** `StyleSystem`

#### Prompt 14: Citation Finder
- [ ] Read module: `Process/_COMMON/18_Lock_Management_Module.md`
- [ ] Add Step 0: Lock Management
- [ ] Determine which chapter receiving citations
- [ ] Acquire locks: `Chapter_XX`, `BackMatter` (if updating bibliography)
- [ ] Release locks after citations added
- **Resources locked:** `Chapter_XX`, `BackMatter`

#### Prompt 15: Visual Content Suggester
- [ ] Read module: `Process/_COMMON/18_Lock_Management_Module.md`
- [ ] Add Step 0: Lock Management
- [ ] Determine which chapter receiving visuals
- [ ] Acquire locks: `Chapter_XX`, `ImageRegistry`
- [ ] Release locks after visuals created
- **Resources locked:** `Chapter_XX`, `ImageRegistry`

#### Prompt 16: Image Manager
- [ ] Read module: `Process/_COMMON/18_Lock_Management_Module.md`
- [ ] Add Step 0: Lock Management
- [ ] Determine resources needed
- [ ] Acquire locks: `ImageRegistry`, optionally `Chapter_XX` (if inserting references)
- [ ] Release locks after image operations complete
- **Resources locked:** `ImageRegistry`, optionally `Chapter_XX`

### Dashboard Integration (❌ Not Started)

#### Prompt 10: Progress Dashboard
- [ ] Read module: `Process/_COMMON/18_Lock_Management_Module.md`
- [ ] Add section: "Active Locks"
- [ ] Display current locks with timestamps and instance IDs
- [ ] Identify stale locks (>15 minutes)
- [ ] Add command: "Clear All Locks"
- **No locks acquired** (read-only display)

### Documentation Updates (❌ Not Started)

- [ ] Update `Process/AI-Assisted_Nonfiction_Authoring_Process.md`
  - Add section on concurrent editing
  - Reference lock management module
- [ ] Update `Process/Prompts/QUICK_REFERENCE.md`
  - Add "Working with Multiple Instances" section
  - Explain lock system briefly
- [ ] Update `CLAUDE.md`
  - Add note about concurrent editing support
  - Reference lock module
- [ ] Update `.gitignore` template
  - Add `.locks/` directory

### Testing (❌ Not Started)

- [ ] Test two CLI instances editing different chapters (should succeed)
- [ ] Test two CLI instances editing same chapter (second should wait)
- [ ] Test stale lock override (>15 minutes)
- [ ] Test "Clear All Locks" functionality
- [ ] Test CLI + Desktop concurrency
- [ ] Test lock release on prompt failure/error

---

## Lock Implementation Pattern

Every prompt follows this standard pattern:

```markdown
# Execute Prompt X: [Prompt Name]

**BEFORE PROCEEDING:** Read `Process/_COMMON/18_Lock_Management_Module.md`

---

## Step 0: Lock Management

### Initialize Lock System

1. Check if `.locks/` directory exists
   - If not: Create `.locks/` directory

2. Check if `.locks/locks.json` exists
   - If not: Create with empty structure:
     ```json
     {
       "locks": []
     }
     ```

### Generate Instance ID

Create unique instance identifier for this session:
- Format: `CLI-[5-digit-random]` or `Desktop-[5-digit-random]`
- Example: `CLI-12345`, `Desktop-67890`
- Reuse same ID for all locks in this session

### Acquire Locks

**Resources needed for this prompt:**
- [List specific resources: Chapter_XX, StyleSystem, etc.]

**For each resource:**

1. Read `.locks/locks.json`

2. Check if resource is locked:
   - Search `locks` array for entry where `"resource": "[resource_name]"`

3. **If lock exists:**
   - Calculate age: `current_time - lock.timestamp`

   - **If age < 15 minutes:**
     ```
     ⚠️ [Resource] is currently locked by another instance.

     Lock details:
     - Resource: [resource]
     - Locked at: [timestamp] ([X] minutes ago)
     - Instance: [instance]

     Options:
     1. Wait for lock to clear (checks every 5 seconds)
     2. Cancel operation
     3. Override lock (not recommended)

     Choose option (1-3):
     ```

   - **If age >= 15 minutes:**
     ```
     ⚠️ [Resource] has a stale lock (older than 15 minutes).

     Lock details:
     - Resource: [resource]
     - Locked at: [timestamp] ([X] minutes ago)
     - Instance: [instance]

     This lock may be from a crashed instance.

     Options:
     1. Override stale lock and continue
     2. Cancel operation

     Choose option (1-2):
     ```

4. **If user chooses to wait (Option 1):**
   - Poll every 5 seconds
   - Re-check `.locks/locks.json`
   - If lock cleared: Proceed to acquire
   - If timeout (2 minutes): Ask to cancel or override

5. **If user cancels:**
   - Exit prompt without changes
   - Release any already-acquired locks

6. **If no lock OR override approved:**
   - Add lock entry:
     ```json
     {
       "resource": "[resource_name]",
       "timestamp": "[ISO-8601-timestamp]",
       "instance": "[instance_id]"
     }
     ```
   - Write updated JSON to `.locks/locks.json`
   - Proceed with operation

### Proceed with Prompt Operations

[Do the actual work of the prompt...]

### Release Locks (ALWAYS)

**CRITICAL:** Release locks even if operation fails or errors occur.

**For each acquired resource:**

1. Read `.locks/locks.json`

2. Remove lock entry:
   - Filter `locks` array to remove where `"resource": "[resource_name]"`

3. Write updated JSON to `.locks/locks.json`

**Use try/finally pattern to ensure locks are always released.**

---

## [Rest of prompt continues normally...]
```

---

## Resource Names Reference

Quick reference for prompt developers:

| Resource | What It Locks |
|----------|---------------|
| `Chapter_01` through `Chapter_99` | All files for that chapter |
| `FrontMatter` | All files in `Manuscript/FrontMatter/` |
| `BackMatter` | All files in `Manuscript/BackMatter/` |
| `StyleSystem` | `Style_Guide.md`, `Style_Overrides.md` |
| `QuoteRegistry` | `Chapter_Quotes.md` |
| `ImageRegistry` | `Image_Registry.md` or all chapter registries |
| `ProjectConfig` | `.config/*.json` files |

---

## Timeline

**Phase 1: Infrastructure** (✅ Complete - 2025-11-22)
- Lock management module created
- Resource names and protocols defined

**Phase 2: Prompt Updates** (Target: v0.13.0)
- Update 10 prompts to implement locks
- Add dashboard lock display (Prompt 10)
- Estimated: 2-3 hours of work per prompt

**Phase 3: Documentation** (Target: v0.13.0)
- Update main documentation
- Update quick reference
- Update CLAUDE.md

**Phase 4: Testing** (Target: v0.13.0)
- Test concurrent scenarios
- Verify lock behavior
- Test error handling

---

## Success Criteria

- ✅ Solo author can run multiple instances without conflicts
- ✅ Locks prevent simultaneous edits to same resource
- ✅ Stale locks can be overridden safely
- ✅ Works in both CLI and Desktop
- ✅ Clear all locks available for recovery
- ✅ User always in control (wait/cancel/override options)

---

## Notes

- **Image Registry Splitting:** If `Proposal/IMAGE_REGISTRY_SPLITTING.md` is implemented (v0.14.0), the `ImageRegistry` resource will lock individual chapter registries instead of single file, reducing lock contention further.

- **Git still protects data:** Even if locks fail, git prevents data loss through merge conflict detection and resolution.

- **Not needed for read-only prompts:** Prompts 7, 8, 9, 12, 13 don't modify manuscript files and don't need locks.

---

**Status:** Module complete, prompt updates pending
**Next Action:** Begin updating Prompt 1 (Initialize) with lock implementation
**Target Completion:** v0.13.0

---

**Framework Version:** 0.12.10
**Proposal Version:** 2.0.0 (Simplified)
**Last Updated:** 2025-11-22
