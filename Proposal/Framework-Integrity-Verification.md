# Framework Integrity Verification System

**Proposal Date:** 2025-11-26
**Framework Version:** 0.13.14
**Status:** Draft
**Priority:** Security Enhancement

---

## Executive Summary

**Problem:** Framework files in customer projects could be accidentally modified, corrupted during installation, or maliciously tampered with. Currently there is no mechanism to verify file integrity.

**Solution:** Implement a SHA-256 hash-based verification system that:
- Verifies all `Process/` files against known-good hashes
- Detects unauthorized/injected files
- Runs at end of `configure.md` and on-demand via commands
- Stores hashes locally with optional remote verification (requires consent)

**Outcome:** Users can trust their framework installation is authentic and unmodified.

---

## Requirements (User-Confirmed)

| Requirement | Decision |
|-------------|----------|
| **Scope** | All `Process/` files |
| **Threat Model** | Accidental modification, malicious tampering, corruption |
| **Hash Storage** | Local manifest + optional remote verification |
| **Hash Algorithm** | SHA-256 |
| **Failure Handling** | Strong warning, suggest reinstall (no blocking) |
| **Triggers** | End of configure.md + on-demand commands |
| **Detect Extra Files** | Yes - flag unauthorized files in Process/ |
| **Remote Verification** | Requires explicit user consent |

---

## Technical Design

### 1. Hash Manifest Structure

**File:** `Process/INTEGRITY.json`

```json
{
  "framework_version": "0.13.14",
  "generated": "2025-11-26T12:00:00Z",
  "algorithm": "SHA-256",
  "verification_url": "https://raw.githubusercontent.com/scooter-indie/author-nonfiction/v0.13.14/Process/INTEGRITY.json",
  "files": {
    "Process/FRAMEWORK_CORE.md": {
      "hash": "a1b2c3d4e5f6...",
      "size": 12345
    },
    "Process/Anti-Hallucination_Guidelines.md": {
      "hash": "b2c3d4e5f6a1...",
      "size": 8765
    },
    "Process/Prompts/Prompt_1_Initialize.md": {
      "hash": "c3d4e5f6a1b2...",
      "size": 15432
    }
  },
  "expected_file_count": 47
}
```

**Fields:**
- `framework_version`: Version this manifest corresponds to
- `generated`: ISO timestamp of manifest generation
- `algorithm`: Hash algorithm used (always SHA-256)
- `verification_url`: URL to fetch remote manifest for comparison
- `files`: Object mapping relative paths to hash and size
- `expected_file_count`: Total expected files (for detecting missing files)

### 2. Verification Logic

```
VERIFICATION ALGORITHM:

1. Load local INTEGRITY.json
2. For each file in manifest:
   a. Check file exists → if not, add to MISSING list
   b. Calculate SHA-256 hash
   c. Compare to manifest → if mismatch, add to MODIFIED list
3. Scan Process/ directory recursively
4. For each file found:
   a. Check if in manifest → if not, add to UNAUTHORIZED list
5. Generate report

RESULT CATEGORIES:
- VALID: File exists and hash matches
- MISSING: File in manifest but not on disk
- MODIFIED: File exists but hash doesn't match
- UNAUTHORIZED: File exists but not in manifest
```

### 3. Trigger Points

#### A. End of configure.md (Automatic)

After successful framework configuration:

```markdown
## Step X: Verify Framework Integrity

Run the integrity check to confirm all framework files are authentic:

**Claude Code CLI:**
Claude will automatically verify framework integrity.

**Claude Desktop:**
After configuration, say: "check the framework"
```

#### B. On-Demand Commands

Users can trigger verification by saying:
- "check the framework"
- "security scan"
- "verify framework integrity"
- "framework integrity check"

### 4. Output Format

#### Success Output

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Framework Integrity Check - PASSED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Framework Version: 0.13.14
Files Verified: 47/47
Algorithm: SHA-256

Status: ✓ All framework files are authentic and unmodified

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

#### Failure Output

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Framework Integrity Check - FAILED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Framework Version: 0.13.14
Files Verified: 44/47
Algorithm: SHA-256

⚠️  INTEGRITY ISSUES DETECTED

MODIFIED FILES (hash mismatch):
  ✗ Process/Prompts/Prompt_3_Change_by_Chg.md
    Expected: a1b2c3d4...
    Found:    x9y8z7w6...

MISSING FILES:
  ✗ Process/Prompts/Prompt_14_Citation_Finder.md

UNAUTHORIZED FILES (not in manifest):
  ⚠ Process/Prompts/malicious_script.md
  ⚠ Process/hidden_file.txt

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️  STRONG WARNING: Framework integrity compromised!

Your framework files have been modified, are missing, or
unauthorized files have been added. This could indicate:

  • Accidental modification during editing
  • Corruption during installation or file transfer
  • Potential security compromise (tampering)

RECOMMENDED ACTION:
  Reinstall the framework from the official release:
  https://github.com/scooter-indie/author-nonfiction/releases/v0.13.14

  Follow the installation instructions in INSTALLATION.md

Do NOT execute framework prompts until integrity is restored.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 5. Remote Verification (Optional)

When user explicitly requests remote verification:

```
User: "verify framework with remote check"

Claude: "Remote verification requires fetching the hash manifest from GitHub.
This will make a network request to:
https://raw.githubusercontent.com/scooter-indie/author-nonfiction/v0.13.14/Process/INTEGRITY.json

Do you want to proceed? (yes/no)"

User: "yes"

Claude: [Fetches remote manifest, compares to local files AND local manifest]
```

**Remote verification checks:**
1. All files match remote hashes (primary check)
2. Local INTEGRITY.json matches remote INTEGRITY.json (detects manifest tampering)

---

## Implementation Plan

### Phase 1: Manifest Generation (Build-Time)

**Location:** Prompt 99 (Build Release) or dedicated script

**Tasks:**
1. Create hash generation logic (PowerShell/Bash)
2. Generate INTEGRITY.json during release build
3. Include INTEGRITY.json in release package
4. Upload INTEGRITY.json to GitHub release assets

**Hash Generation Script (Conceptual):**

```powershell
# generate-integrity.ps1
$files = Get-ChildItem -Path "Process" -Recurse -File
$manifest = @{
    framework_version = "0.13.14"
    generated = (Get-Date -Format "o")
    algorithm = "SHA-256"
    verification_url = "https://raw.githubusercontent.com/..."
    files = @{}
    expected_file_count = $files.Count
}

foreach ($file in $files) {
    $relativePath = $file.FullName -replace [regex]::Escape($PWD.Path + "\"), ""
    $relativePath = $relativePath -replace "\\", "/"
    $hash = (Get-FileHash -Path $file.FullName -Algorithm SHA256).Hash
    $manifest.files[$relativePath] = @{
        hash = $hash
        size = $file.Length
    }
}

$manifest | ConvertTo-Json -Depth 4 | Set-Content "Process/INTEGRITY.json"
```

### Phase 2: Verification Logic

**Location:** New file or integrate into fw-init command

**Tasks:**
1. Create verification function
2. Implement file scanning
3. Implement hash comparison
4. Generate human-readable report
5. Handle edge cases (permissions, missing manifest)

### Phase 3: Integration Points

**Tasks:**
1. Add verification step to end of configure.md
2. Create on-demand command recognition in CLAUDE.md or fw-init
3. Document commands in INSTALLATION.md
4. Add optional remote verification with consent flow

### Phase 4: Testing

**Tasks:**
1. Test with clean installation (should pass)
2. Test with modified file (should detect)
3. Test with missing file (should detect)
4. Test with extra file (should detect)
5. Test remote verification flow
6. Test on Windows/Mac/Linux

---

## Files to Create/Modify

### New Files

| File | Purpose |
|------|---------|
| `Process/INTEGRITY.json` | Hash manifest (generated at build time) |
| `Process/Scripts/generate-integrity.ps1` | Windows hash generation script |
| `Process/Scripts/generate-integrity.sh` | Unix hash generation script |

### Modified Files

| File | Changes |
|------|---------|
| `configure.md` | Add integrity check step at end |
| `CLAUDE.md` | Add on-demand command recognition |
| `.claude/commands/fw-init.md` | Optional: Add integrity check |
| `Process/Prompts/Prompt_99_Build_Release.md` | Add manifest generation step |
| `INSTALLATION.md` | Document integrity verification |

---

## Security Considerations

### Threat: Manifest Tampering

**Risk:** Attacker modifies both files AND INTEGRITY.json to match

**Mitigation:**
1. Remote verification compares against GitHub-hosted manifest
2. Users can manually verify manifest hash against release notes
3. Consider GPG signing manifest in future enhancement

### Threat: MITM Attack on Remote Verification

**Risk:** Attacker intercepts remote manifest fetch

**Mitigation:**
1. HTTPS only for remote fetch
2. Pin to specific release URL (includes version)
3. User must explicitly consent to remote check

### Threat: Compromised Build System

**Risk:** Malicious manifest generated during build

**Mitigation:**
1. Manifest generated from clean source
2. Release workflow includes verification step
3. GitHub Actions audit trail

---

## Future Enhancements (Out of Scope)

1. **GPG Signing:** Sign INTEGRITY.json with maintainer key
2. **Auto-Repair:** Download and replace corrupted files
3. **fw-init Integration:** Run verification at every session startup (if fast enough)
4. **Checksum in Release Notes:** Publish INTEGRITY.json hash for manual verification
5. **CI/CD Integration:** Verify integrity in GitHub Actions before release

---

## Open Questions

1. **Performance:** How long does verification take for ~50 files?
   - Need to benchmark before deciding on fw-init integration

2. **Partial Verification:** Should users be able to verify specific subdirectories?
   - e.g., "check prompts only" vs "check everything"

3. **Manifest Location:** Should INTEGRITY.json be in Process/ or root?
   - Process/ keeps it with framework files
   - Root makes it more visible

4. **Version Mismatch:** What if user has v0.13.12 files but v0.13.14 manifest?
   - Should we detect version mismatches separately?

---

## Acceptance Criteria

- [ ] INTEGRITY.json generated correctly during build
- [ ] All Process/ files included in manifest
- [ ] Verification detects modified files
- [ ] Verification detects missing files
- [ ] Verification detects unauthorized files
- [ ] Clear warning message on failure
- [ ] Reinstall instructions provided
- [ ] configure.md includes verification step
- [ ] On-demand commands work ("check the framework", "security scan")
- [ ] Remote verification requires consent
- [ ] Documentation updated

---

## Timeline Estimate

| Phase | Effort |
|-------|--------|
| Phase 1: Manifest Generation | Small |
| Phase 2: Verification Logic | Medium |
| Phase 3: Integration | Small |
| Phase 4: Testing | Small |
| **Total** | **Medium** |

---

## Conclusion

This proposal outlines a straightforward integrity verification system using SHA-256 hashes. The design prioritizes:

1. **Security:** Detects all forms of tampering (modification, deletion, injection)
2. **Privacy:** Remote verification requires explicit consent
3. **Usability:** Clear warnings with actionable remediation steps
4. **Maintainability:** Manifest auto-generated during build process

The system adds a meaningful security layer while remaining simple to implement and use.

---

**Proposal Version:** 1.0
**Author:** Claude (Opus 4.5)
