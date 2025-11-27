# Proposal: License and Disclaimer

**Issue:** #35
**Status:** Draft
**Created:** 2025-11-26

---

## Executive Summary

Add an MIT License and comprehensive Disclaimer to the AI-Assisted Nonfiction Authoring Framework. The disclaimer must be viewed and acknowledged during Prompt 1 (Initialize) with a git commit serving as proof of acknowledgment. The disclaimer will also be linked from the user's project README.md.

---

## Requirements

1. **MIT License** for the framework code
2. **Disclaimer** covering:
   - No liability for published works created using the framework
   - No responsibility for damages arising from framework use
   - No guarantee of AI accuracy (despite Anti-Hallucination Protocol)
   - No responsibility for user-created content
3. **Forced acknowledgment** during Prompt 1 (one-time per project)
4. **Git commit** as proof of acknowledgment
5. **README link** to disclaimer in user's project repository

---

## Technical Design

### New Files

#### 1. `LICENSE` (Repository Root)

Standard MIT License file:

```
MIT License

Copyright (c) 2025 scooter-indie

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

#### 2. `Process/DISCLAIMER.md`

Comprehensive disclaimer document:

```markdown
# AI-Assisted Nonfiction Authoring Framework - Disclaimer

**IMPORTANT: Please read this disclaimer carefully before using this framework.**

---

## No Warranty

This framework is provided "AS IS" without warranty of any kind, express or
implied. The authors and contributors make no representations or warranties
regarding the accuracy, completeness, or suitability of this framework for
any particular purpose.

## No Liability for Published Works

The authors and contributors of this framework accept NO LIABILITY for any
works created, published, or distributed using this framework. This includes
but is not limited to:

- Books, articles, or other written content
- Errors, omissions, or inaccuracies in published content
- Claims of plagiarism, copyright infringement, or defamation
- Commercial losses or damages arising from published works
- Reputation damage resulting from published content

**You are solely responsible for all content you create and publish.**

## No Guarantee of AI Accuracy

This framework uses AI assistance for content creation and editing. Despite
the Anti-Hallucination Protocol and verification guidelines included in this
framework:

- AI-generated content may contain factual errors
- AI may fabricate statistics, quotes, or citations
- AI suggestions may be inappropriate for your context
- Verification tools and protocols are guidelines, not guarantees

**You must independently verify all facts, quotes, statistics, and claims
before publication.**

## No Responsibility for Damages

The authors and contributors accept no responsibility for any damages arising
from the use of this framework, including but not limited to:

- Direct, indirect, incidental, or consequential damages
- Loss of data, profits, or business opportunities
- Legal fees or settlements arising from published content
- Technical failures or data corruption

## User Responsibilities

By using this framework, you agree that:

1. You are solely responsible for all content you create
2. You will verify all facts, quotes, and citations before publication
3. You will comply with all applicable laws regarding your published content
4. You will not hold the framework authors liable for any outcomes

## Acknowledgment

By initializing a book project with this framework (Prompt 1), you acknowledge
that you have read, understood, and agree to this disclaimer. The git commit
created during initialization serves as your acknowledgment.

---

**Framework:** AI-Assisted Nonfiction Authoring Framework
**License:** MIT License
**Version:** 0.15.0+
```

### Modified Files

#### 3. `Process/Prompts/Prompt_1_Initialize.md`

Add disclaimer acknowledgment step after project details collection, before any file creation:

**New Section (insert after "Collect Project Information" and before "Create Directory Structure"):**

```markdown
### Step 2: Disclaimer Acknowledgment (REQUIRED)

**STOP and display the following:**

---

**⚠️ DISCLAIMER ACKNOWLEDGMENT REQUIRED**

Before creating your book project, you must acknowledge the framework disclaimer.

[Display full contents of Process/DISCLAIMER.md]

---

**To proceed, type exactly:** `I acknowledge the disclaimer`

**If user does not acknowledge:**
- Do NOT proceed with project creation
- Remind user that acknowledgment is required
- Wait for acknowledgment

**If user acknowledges:**
- Record acknowledgment in `.config/init.json`:
  ```json
  {
    "disclaimer_acknowledged": true,
    "acknowledged_date": "[CONFIRMED_DATE]",
    "acknowledged_version": "0.15.0"
  }
  ```
- Proceed to directory structure creation
```

**Update Step Numbering:**
- Step 1: Collect Project Information (existing)
- Step 2: Disclaimer Acknowledgment (NEW)
- Step 3: Create Directory Structure (was Step 2)
- Step 4: Initialize Git Repository (was Step 3)
- etc.

#### 4. `Process/Templates/README_AUTHORS_template.md`

Add disclaimer link section:

```markdown
## Legal

This project was created using the [AI-Assisted Nonfiction Authoring Framework](https://github.com/scooter-indie/author-nonfiction).

**[Read the Framework Disclaimer](Process/DISCLAIMER.md)**

By using this framework, you have acknowledged responsibility for all content created.
```

#### 5. `.config/init.json` Schema Update

Add disclaimer acknowledgment fields:

```json
{
  "project_name": "...",
  "author": "...",
  "disclaimer_acknowledged": true,
  "acknowledged_date": "YYYY-MM-DD",
  "acknowledged_version": "0.15.0",
  ...
}
```

---

## Implementation Plan

### Phase 1: Create License and Disclaimer Files
1. Create `LICENSE` file in repository root (MIT License)
2. Create `Process/DISCLAIMER.md` with full disclaimer text
3. Commit: "Add MIT License and Disclaimer (#35)"

### Phase 2: Update Prompt 1
1. Add disclaimer acknowledgment step to `Prompt_1_Initialize.md`
2. Update step numbering
3. Add acknowledgment recording to `.config/init.json`
4. Update `Prompt_1_Reference.md` with new step documentation
5. Commit: "Add disclaimer acknowledgment to Prompt 1 (#35)"

### Phase 3: Update Templates
1. Update `README_AUTHORS_template.md` with disclaimer link section
2. Commit: "Add disclaimer link to project README template (#35)"

### Phase 4: Documentation Updates
1. Update `CLAUDE.md` to mention disclaimer requirement
2. Update `FRAMEWORK_CORE.md` to reference disclaimer
3. Update version to 0.15.0
4. Commit: "Update documentation for disclaimer (#35)"

---

## Acceptance Criteria

- [ ] MIT License file exists at repository root
- [ ] Disclaimer file exists at `Process/DISCLAIMER.md`
- [ ] Prompt 1 requires explicit disclaimer acknowledgment before proceeding
- [ ] Acknowledgment is recorded in `.config/init.json`
- [ ] Git commit during Prompt 1 includes acknowledgment proof
- [ ] User README template includes link to disclaimer
- [ ] Documentation references the disclaimer requirement
- [ ] Existing projects are not affected (acknowledgment only for new projects)

---

## Notes

- This is a **one-time acknowledgment** during Prompt 1 (project initialization)
- No bypass mechanism needed since Prompt 1 runs once per project
- Git commit serves as immutable proof of acknowledgment
- Disclaimer is included in the Process/ directory so it's present in every user installation

---

## Open Questions

1. Should the disclaimer version be tracked separately from framework version?
2. Should we add a CONTRIBUTING.md file with contributor agreement?
3. Should the disclaimer also appear during framework updates/migrations?

---

*Proposal created for issue #35*
