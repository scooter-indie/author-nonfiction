# Lock Management Module

**Module ID:** 18_Lock_Management_Module
**Version:** 1.0.0
**Purpose:** Prevent concurrent editing conflicts when multiple Claude Code instances (CLI or Desktop) work on the same book project

---

## Overview

This module defines a resource-level locking system that prevents multiple Claude Code instances from modifying the same parts of your book simultaneously.

**Key Principles:**
- Solo author with multiple instances (CLI and/or Desktop)
- Resource-level locking (chapters, style system, image registry, etc.)
- Single JSON lock file (`.locks/locks.json`)
- 15-minute stale lock timeout
- User control over lock conflicts

**Works in:** Both Claude Code CLI and Claude Desktop

---

## Lock File Structure

### Location

`.locks/locks.json` (in project root)

**Note:** The `.locks/` directory should be added to `.gitignore` (locks are local, not committed)

### Format

```json
{
  "locks": [
    {
      "resource": "Chapter_03",
      "timestamp": "2025-11-22T10:30:00Z",
      "instance": "CLI-12345"
    },
    {
      "resource": "StyleSystem",
      "timestamp": "2025-11-22T10:32:00Z",
      "instance": "Desktop-67890"
    }
  ]
}
```

### Fields

- **resource** (string): The resource being locked (see Resource Names below)
- **timestamp** (ISO 8601 string): When the lock was acquired
- **instance** (string): Identifier for the instance holding the lock (e.g., "CLI-12345", "Desktop-67890")

---

## Resource Names

### Chapter Resources

Format: `Chapter_XX` (zero-padded, two digits)

Examples:
- `Chapter_01` - Locks all files for Chapter 1
- `Chapter_02` - Locks all files for Chapter 2
- `Chapter_15` - Locks all files for Chapter 15

**What's locked:**
- `Manuscript/Chapters/Chapter_XX/Chapter_XX.md`
- `Manuscript/Chapters/Chapter_XX/Chapter_XX_chg.md`
- Any section files within the chapter directory
- (Or flat structure: `Manuscript/Chapters/Chapter_XX.md`, `Manuscript/Chapters/Chapter_XX_chg.md`)

### Shared Resources

| Resource Name | What It Locks |
|---------------|---------------|
| `FrontMatter` | All files in `Manuscript/FrontMatter/` |
| `BackMatter` | All files in `Manuscript/BackMatter/` |
| `StyleSystem` | `Manuscript/Style/Style_Guide.md`, `Manuscript/Style/Style_Overrides.md` |
| `QuoteRegistry` | `Manuscript/Quotes/Chapter_Quotes.md` |
| `ImageRegistry` | `Manuscript/images/Image_Registry.md` (or all chapter registries if split) |
| `ProjectConfig` | `.config/metadata.json`, `.config/project.json`, `.config/manifest.json` |

---

## Lock Operations

### Initialize Lock File

**When:** First use of any prompt that needs locks

**Operation:**
1. Check if `.locks/` directory exists
2. If not, create `.locks/` directory using bash: `mkdir -p .locks`
   - **CRITICAL:** Use `mkdir -p` (bash/sh command), NOT Windows CMD syntax (`if not exist`)
3. Check if `.locks/locks.json` exists
4. If not, create with empty structure:
   ```json
   {
     "locks": []
   }
   ```

### Acquire Lock

**When:** Before modifying a resource

**Steps:**

1. **Read lock file:** Load `.locks/locks.json`

2. **Check for existing lock:**
   - Search `locks` array for entry where `resource` matches

3. **If lock exists:**
   - Calculate lock age: `current_time - lock.timestamp`
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

4. **If no lock exists OR user chooses to override:**
   - Add new lock entry to `locks` array:
     ```json
     {
       "resource": "[resource_name]",
       "timestamp": "[current_ISO_timestamp]",
       "instance": "[instance_identifier]"
     }
     ```
   - Write updated JSON to `.locks/locks.json`
   - Proceed with operation

5. **If user chooses to wait (Option 1):**
   - Poll every 5 seconds
   - Check if lock still exists
   - If lock cleared, acquire lock and proceed
   - If timeout (2 minutes), ask user to cancel or override

6. **If user cancels:**
   - Exit prompt without making changes

### Release Lock

**When:** After completing modification of a resource

**Steps:**

1. **Read lock file:** Load `.locks/locks.json`

2. **Remove lock entry:**
   - Filter `locks` array to remove entry where `resource` matches

3. **Write updated JSON:** Save to `.locks/locks.json`

**CRITICAL:** Always release locks, even if operation fails or errors occur. Use try/finally pattern.

### Check Lock Status

**When:** User wants to see current locks (via Prompt 10 Dashboard or manual check)

**Steps:**

1. **Read lock file:** Load `.locks/locks.json`

2. **Display all locks:**
   ```
   Active Locks:
   - Chapter_03: Locked 5 minutes ago by CLI-12345
   - StyleSystem: Locked 12 minutes ago by Desktop-67890

   Total: 2 active locks
   ```

3. **Identify stale locks:**
   ```
   Stale Locks (>15 minutes):
   - Chapter_07: Locked 23 minutes ago by CLI-99999 (STALE)

   Use "Clear All Locks" to remove stale locks.
   ```

### Clear All Locks

**When:** User needs to manually clear stuck locks (recovery operation)

**Steps:**

1. **Read lock file:** Load `.locks/locks.json`

2. **Show current locks:**
   ```
   Current locks:
   - Chapter_03: Locked 5 minutes ago by CLI-12345
   - Chapter_07: Locked 23 minutes ago by CLI-99999 (STALE)

   This will clear ALL locks, including active ones.
   ```

3. **Confirm with user:**
   ```
   ⚠️ WARNING: This will clear all locks, including active ones from other instances.
   Only do this if you're sure no other instances are actively working.

   Clear all locks? (yes/no):
   ```

4. **If confirmed:**
   - Set `locks` to empty array: `{"locks": []}`
   - Write to `.locks/locks.json`
   - Display: `✓ All locks cleared.`

5. **If not confirmed:**
   - Cancel operation
   - Display: `Cancelled. Locks unchanged.`

---

## Instance Identifiers

Generate unique instance identifiers to track which instance holds a lock:

**Format:** `[Environment]-[RandomID]`

**Examples:**
- `CLI-12345`
- `Desktop-67890`
- `CLI-54321`

**Generation:**
- Use random number or process ID
- Include environment type (CLI or Desktop)
- Generate once per session, reuse for all locks in that session

---

## Prompts That Require Locks

### Prompts Requiring Locks (Write Operations)

| Prompt | Resources Locked |
|--------|------------------|
| **Prompt 1:** Initialize | `ProjectConfig` |
| **Prompt 2:** Add Chapter | `Chapter_XX` (new chapter), `ProjectConfig` |
| **Prompt 3:** Change by Chg | `Chapter_XX` (for each chapter being modified) |
| **Prompt 4:** Interactive Change | `Chapter_XX` (for chapter being modified) |
| **Prompt 5:** Scan For User Edits | `Chapter_XX` (for each chapter being scanned) |
| **Prompt 6:** Integrate Inbox | Depends on content: `Chapter_XX`, `FrontMatter`, `BackMatter`, `ImageRegistry` |
| **Prompt 11:** Style Manager | `StyleSystem` |
| **Prompt 14:** Citation Finder | `Chapter_XX` (for chapter receiving citations), `BackMatter` (if updating bibliography) |
| **Prompt 15:** Visual Content Suggester | `Chapter_XX` (for chapter), `ImageRegistry` |
| **Prompt 16:** Image Manager | `ImageRegistry`, possibly `Chapter_XX` (if inserting references) |

### Prompts NOT Requiring Locks (Read-Only)

- **Prompt 7:** Compile (reads files, writes to `Drafts/` which is not locked)
- **Prompt 8:** Consistency Checker (read-only analysis)
- **Prompt 9:** Export (reads `Manuscript/`, writes to `Exports/`)
- **Prompt 10:** Dashboard (read-only, but can display lock status)
- **Prompt 12:** Git Operations (doesn't modify manuscript files directly)
- **Prompt 13:** AI Detection Analysis (read-only analysis)

---

## Workflow Integration

### Standard Prompt Pattern

Every prompt that needs locks follows this pattern:

```markdown
## Step 0: Lock Management

1. **Initialize lock system** (if first use):
   - Check/create `.locks/` directory
   - Check/create `.locks/locks.json` with empty locks array

2. **Determine required resources:**
   - [Based on prompt type, identify which resources will be modified]
   - Example: Prompt 3 modifying Chapter 5 → Resource: "Chapter_05"

3. **Acquire locks:**
   - For each required resource:
     - Check if locked
     - If locked < 15 min: Offer wait/cancel/override
     - If locked >= 15 min: Offer override/cancel
     - If not locked: Acquire lock
   - If any lock acquisition fails/cancelled: Exit prompt

4. **Generate instance ID** (if not already set for this session):
   - Format: `CLI-[random]` or `Desktop-[random]`

5. **Proceed with prompt operations:**
   - [Do the actual work...]

6. **Release locks** (always, even on error):
   - For each acquired resource:
     - Remove lock entry from `.locks/locks.json`
```

### Example: Prompt 3 (Change by Chg)

```markdown
## Execution Flow with Locks

1. User asks to execute Prompt 3 for Chapter 5
2. Prompt checks `.locks/locks.json`
3. Attempts to acquire lock on "Chapter_05"
4. If locked by another instance:
   - Shows lock details
   - Offers: wait, cancel, or override (if stale)
   - If wait: polls every 5 seconds
5. Once lock acquired:
   - Reads Chapter_05_chg.md
   - Applies changes to Chapter_05.md
   - Updates Chapter_05_chg.md
   - Commits to git
6. Releases lock on "Chapter_05"
7. Done
```

---

## Error Handling

### Lock File Corruption

**If `.locks/locks.json` is corrupted or invalid JSON:**

1. **Backup corrupted file:**
   - Rename to `.locks/locks.json.corrupt.[timestamp]`

2. **Create fresh lock file:**
   - Initialize with empty locks: `{"locks": []}`

3. **Warn user:**
   ```
   ⚠️ Lock file was corrupted and has been reset.
   Backup saved to: .locks/locks.json.corrupt.[timestamp]

   All previous locks have been cleared.
   Proceeding with operation...
   ```

### Lock Not Released (Crash Recovery)

**If instance crashes without releasing lock:**

- Lock remains in `.locks/locks.json`
- After 15 minutes, becomes stale
- Next instance can override stale lock
- Or user can run "Clear All Locks"

**Best practice:** Always release locks in finally/cleanup blocks

### Concurrent Lock Acquisition

**If two instances try to acquire same lock simultaneously:**

- Risk: Both read lock file, see no lock, both add lock
- **Mitigation:** Keep lock acquisition window small (read → check → write quickly)
- **Detection:** If multiple locks for same resource exist, newest timestamp wins
- **Recovery:** User runs "Clear All Locks" if detection occurs

**Note:** This is rare in practice, but documented for completeness

---

## .gitignore Entry

Add to `.gitignore`:

```
# Lock files (local only, not committed)
.locks/
```

**Rationale:** Locks are local to each machine. They should never be committed to git, as they're only relevant for local concurrent instances.

---

## Dashboard Integration (Prompt 10)

Prompt 10 should display current lock status:

```markdown
## Active Locks

**Current locks:**
- Chapter_03: Locked 5 minutes ago (CLI-12345)
- StyleSystem: Locked 12 minutes ago (Desktop-67890)

**Stale locks (>15 minutes):**
- Chapter_07: Locked 23 minutes ago (CLI-99999) ⚠️ STALE

**No active locks:** System ready for concurrent editing.

---

To clear all locks manually, use the "Clear All Locks" operation.
```

---

## Implementation Checklist

### Phase 1: Infrastructure (v0.13.0) ✅

- [x] Create `.locks/` directory (via prompts, not pre-created)
- [x] Add `.locks/` to `.gitignore`
- [x] Document this module (18_Lock_Management_Module.md)
- [x] Update `CLAUDE.md` to reference lock system for concurrent editing

### Phase 2: Prompt Updates (v0.13.0) ✅

Update prompts to use locks:

- [x] Prompt 1: Initialize
- [x] Prompt 2: Add Chapter
- [x] Prompt 3: Change by Chg
- [x] Prompt 4: Interactive Change
- [x] Prompt 5: Scan For User Edits
- [x] Prompt 6: Integrate Inbox
- [x] Prompt 11: Style Manager
- [x] Prompt 14: Citation Finder
- [x] Prompt 15: Visual Content Suggester
- [x] Prompt 16: Image Manager

### Phase 3: Dashboard Integration (v0.13.0) ✅

- [x] Prompt 10: Display active locks, stale locks, clear all option

### Phase 4: Documentation (v0.13.0) ✅

- [x] Add concurrency section to `Process/AI-Assisted_Nonfiction_Authoring_Process.md`
- [x] Update `Process/Prompts/QUICK_REFERENCE.md` with lock guidance
- [x] Simplify `Proposal/CONCURRENCY.md` to reference this module

---

## Usage Examples

### Example 1: Two Instances, Different Chapters

```
Terminal 1:
- Execute Prompt 3 for Chapter 3
- Acquires lock: "Chapter_03"
- Makes changes
- Releases lock

Terminal 2 (simultaneous):
- Execute Prompt 3 for Chapter 7
- Acquires lock: "Chapter_07"
- Makes changes
- Releases lock

Result: No conflict, both succeed
```

### Example 2: Two Instances, Same Chapter

```
Terminal 1:
- Execute Prompt 3 for Chapter 3
- Acquires lock: "Chapter_03" at 10:30 AM
- Making changes...

Terminal 2 (while Terminal 1 still working):
- Execute Prompt 3 for Chapter 3
- Attempts lock: "Chapter_03"
- Finds existing lock (3 minutes old)
- Shows options: wait/cancel/override
- User chooses: Wait
- Polls every 5 seconds...
- Terminal 1 finishes, releases lock
- Terminal 2 detects lock cleared
- Acquires lock: "Chapter_03"
- Makes changes
- Releases lock

Result: Terminal 2 waits, then succeeds. No conflict.
```

### Example 3: Stale Lock

```
Terminal 1:
- Execute Prompt 3 for Chapter 5
- Acquires lock: "Chapter_05" at 10:00 AM
- Instance crashes (lock not released)

Terminal 2 (at 10:20 AM):
- Execute Prompt 3 for Chapter 5
- Attempts lock: "Chapter_05"
- Finds existing lock (20 minutes old - STALE)
- Shows options: override/cancel
- User chooses: Override
- Removes stale lock, acquires new lock
- Makes changes
- Releases lock

Result: Stale lock overridden safely
```

### Example 4: Clear All Locks

```
User has multiple crashed instances, lock file has many stale locks

Execute Prompt 10:
- Shows dashboard with 5 stale locks
- User selects "Clear All Locks"
- Confirms warning
- All locks cleared
- Ready for fresh work

Result: Clean slate
```

---

## Best Practices

### For Users

1. **Work on different chapters simultaneously** - Minimizes lock contention
2. **Don't override active locks** - Wait for them to clear
3. **Use "Clear All Locks" after crashes** - Clean up stale locks
4. **Check Dashboard (Prompt 10) before starting** - See what's locked

### For Prompt Developers

1. **Always release locks** - Use try/finally pattern
2. **Acquire locks as late as possible** - Minimize lock duration
3. **Lock smallest resource needed** - Chapter-level, not whole manuscript
4. **Handle lock failures gracefully** - Don't leave partial changes

---

## Limitations

1. **Not atomic across instances** - Small race condition window (rare in practice)
2. **Local only** - Doesn't coordinate across different machines (same git repo, different computers)
3. **Requires discipline** - Users can override locks (but warned)
4. **JSON-based** - Not industrial-strength locking (fine for solo author use)

**Mitigation:** Git still protects against data loss. Locks prevent conflicts, git recovers from them.

---

## Future Enhancements (Post v0.13.0)

- **Auto-cleanup on prompt start** - Remove locks older than 1 hour automatically
- **Lock ownership validation** - Verify instance still exists before waiting
- **Read locks vs write locks** - Allow multiple readers, single writer
- **Network coordination** - Support multi-machine scenarios (advanced)

---

## Module Version History

### v1.0.0 - 2025-11-22
- Initial lock management module
- Resource-level locking (chapters, shared resources)
- Single JSON lock file (`.locks/locks.json`)
- 15-minute stale lock timeout
- Works in both CLI and Desktop
- Clear all locks functionality

---

**End of Module**
