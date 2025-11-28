# Prompt 1 Reference Documentation

**Version:** 0.16.0
**Purpose:** Detailed Q&A examples, config formats, and troubleshooting

---

## Overview

This reference provides detailed Q&A workflows, configuration file formats, and troubleshooting. Load when:
- First time using Prompt 1
- Need config file format details
- Troubleshooting initialization
- Understanding re-initialization

**For core workflow:** See `Prompt_1_Initialize.md`

---

## Q&A Session Example

### Sample Interaction

**Q1:** What is the working title of your book?
> "The Future of Remote Work"

**Q2:** What is your name (author)?
> "Jane Smith"

**Q3:** What is the target total word count?
> "60,000"

**Q4:** Who is the target audience?
> "Business professionals and HR managers"

**Q5:** What is the book's purpose or main thesis?
> "To provide a practical guide for implementing effective remote work policies"

**Q6:** What is your target completion date? (YYYY-MM-DD format)
> "2025-06-30"

**Note:** Date must be in the future. If user provides a past date:
```
That date is in the past. Please provide a future date (after [CONFIRMED_DATE]).
```

**Q7:** Do you have an existing TOC file?
> "No"

**Q8:** How many chapters and what are their topics/titles?
> "8 chapters: Introduction, History of Remote Work, Technology Requirements, Management Strategies, Employee Well-being, Legal Considerations, Case Studies, Future Trends"

**Q9:** Writing style selection - two-step process:

**Step A - Show categories:**
```
5 style categories available:

1. Academic & Research (4 styles)
2. Business & Professional (2 styles)
3. Narrative & Storytelling (4 styles)
4. Personal Development (3 styles)
5. Cultural & Social Commentary (6 styles)

Which category? (1-5, or "all" to see everything)
```

> "2"

**Step B - Show styles in selected category:**
```
Business & Professional:

1. Business Professional
   Management/leadership, data-driven

2. Conversational Expert
   Accessible expertise, friendly tone

Which style? (1-2)
```

> "2 - Conversational Expert"

---

### Disclaimer Acknowledgment (After Q&A)

**Display disclaimer header:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️  DISCLAIMER ACKNOWLEDGMENT REQUIRED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Before creating your book project, you must acknowledge
the framework disclaimer.
```

**Then display full contents of `Process/DISCLAIMER.md`**

**Ask:**
```
To proceed, type exactly: I acknowledge the disclaimer
```

> "I acknowledge the disclaimer"

**If user refuses or types something else:**
```
Acknowledgment required to proceed. Please type exactly:
I acknowledge the disclaimer

Or type "cancel" to abort initialization.
```

---

**Alternative - If user says "all":**
```
All 19 styles:

ACADEMIC & RESEARCH:
1. Academic Authority
2. Scientific Communicator
3. Technical Precision
4. Medical/Health Narrative

BUSINESS & PROFESSIONAL:
5. Business Professional
6. Conversational Expert

NARRATIVE & STORYTELLING:
7. Narrative Storyteller
8. Historical Chronicler
9. Investigative Journalist
10. Confessional Memoir

PERSONAL DEVELOPMENT:
11. Practical Guide
12. Inspirational Teacher
13. Philosophical Contemplative

CULTURAL & SOCIAL:
14. Cultural Critic
15. Satirical Humorist
16. Activist Advocate
17. Lyrical Nature Writer
18. Spiritual/Religious Writer
19. Sports Writer

Which style? (1-19)
```

**Formatting Notes:**
- Use numbered list (1-19) for consistent presentation
- Keep descriptions short (one line max)
- Use ALL CAPS for category headers
- Leave blank line between categories

---

## Configuration File Formats

**CRITICAL:** Use exact field names shown below. The scripts validate these exact names.

**See:** `Process/_COMMON/20_JSON_Schema_Module.md` for complete schema documentation.

### `.config/init.json`

**Required fields:** `title`, `author`, `style`, `chapters`, `createdDate`, `disclaimer_acknowledged`, `disclaimer_version`, `acknowledged_date`

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "description": "Initialization configuration from Q&A session",
  "title": "The Future of Remote Work",
  "author": "Jane Smith",
  "targetWordCount": "60000",
  "targetAudience": "Business professionals and HR managers",
  "purpose": "Practical guide for implementing effective remote work policies",
  "targetCompletionDate": "2025-06-30",
  "tocFilePath": "",
  "chapters": [
    {"number": 1, "title": "Introduction"},
    {"number": 2, "title": "History of Remote Work"},
    {"number": 3, "title": "Technology Requirements"},
    {"number": 4, "title": "Management Strategies"},
    {"number": 5, "title": "Employee Well-being"},
    {"number": 6, "title": "Legal Considerations"},
    {"number": 7, "title": "Case Studies"},
    {"number": 8, "title": "Future Trends"}
  ],
  "style": "Conversational Expert",
  "createdDate": "2025-11-24",
  "frameworkVersion": "0.15.0",
  "disclaimer_acknowledged": true,
  "disclaimer_version": "1.0",
  "acknowledged_date": "2025-11-24"
}
```

### `.config/project.json`

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "description": "Project configuration and settings",
  "initialized": true,
  "settings": {
    "prompt_9_verbose": true
  },
  "frameworkVersion": "0.15.0",
  "createdDate": "2025-11-24",
  "lastModified": "2025-11-24"
}
```

### `.config/metadata.json`

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "description": "Project metadata",
  "book": {
    "title": "The Future of Remote Work",
    "subtitle": "",
    "author": "Jane Smith",
    "publisher": "",
    "isbn": "",
    "targetAudience": "Business professionals and HR managers",
    "genre": "",
    "description": "Practical guide for implementing effective remote work policies",
    "keywords": []
  },
  "version": {
    "current": "1.0.0",
    "history": []
  },
  "dates": {
    "started": "2025-11-24",
    "firstDraft": "",
    "published": "",
    "targetCompletion": "2025-06-30"
  },
  "stats": {
    "totalChapters": 8,
    "totalWords": 0,
    "targetWordCount": 60000,
    "completionPercentage": 0
  }
}
```

### `.config/manifest.json`

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "description": "Framework installation manifest",
  "frameworkVersion": "0.15.0",
  "installedDate": "2025-11-24",
  "lastUpdated": "2025-11-24",
  "installationMethod": "Prompt 1",
  "configureCompleted": false,
  "toolsAvailable": {
    "git": true,
    "pandoc": false,
    "typst": false
  }
}
```

---

## Directory Structure Created

```
[Project Root]/
├── .config/
│   ├── init.json
│   ├── project.json
│   ├── metadata.json
│   ├── manifest.json
│   └── migrations.json
├── .locks/
│   └── locks.json
├── Manuscript/
│   ├── Chapters/
│   │   ├── Chapter_01/
│   │   │   ├── Chapter_01.md
│   │   │   └── Chapter_01_chg.md
│   │   ├── Chapter_02/
│   │   └── ...
│   ├── FrontMatter/
│   │   └── Copyright.md
│   ├── BackMatter/
│   │   ├── About_Author.md
│   │   └── Bibliography/
│   ├── Style/
│   │   ├── Style_Guide.md
│   │   ├── Style_Overrides.md
│   │   └── epub-style.css
│   ├── _TOC_/
│   │   ├── TOC.md
│   │   └── TOC_chg.md
│   ├── Quotes/
│   │   ├── Chapter_Quotes.md
│   │   └── Chapter_Quotes_chg.md
│   ├── images/
│   │   └── Image_Registry.md
│   ├── Inbox/
│   ├── Drafts/
│   └── Exports/
├── USAGE_GUIDE.md
├── PROJECT_CONTEXT.md
├── README.md
└── .gitignore
```

---

## Script Output Examples

### init.sh Output

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Nonfiction Framework Initialization Script v0.15.0
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Validating preconditions...
✓ Config file found
✓ Valid JSON config
✓ Git is installed
✓ Process/Templates directory found
✓ All required templates found
✓ All preconditions met

Creating directory structure...
✓ Created: Manuscript/Chapters
✓ Created: Manuscript/FrontMatter
✓ Created: Manuscript/BackMatter
✓ Created: Manuscript/Style
✓ Created: Manuscript/_TOC_
✓ Created: Manuscript/Quotes
✓ Created: Manuscript/images
✓ Created: Manuscript/Inbox
✓ Created: Manuscript/Drafts
✓ Created: Manuscript/Exports

Copying templates...
✓ Copied: Image_Registry.md
✓ Copied: Copyright.md
✓ Copied: epub-style.css
✓ Copied: .gitignore

Initializing git repository...
✓ Git repository initialized

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ Initialization script completed successfully
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### generate-content.sh Output

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Batch Content Generator v0.15.0
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Validating preconditions...
✓ Config file found
✓ jq is installed
✓ Valid JSON config
✓ All required fields present
✓ Process/Styles directory found
✓ All preconditions met

Parsing configuration...
✓ Configuration parsed
  • Title: The Future of Remote Work
  • Author: Jane Smith
  • Style: Conversational Expert
  • Chapters: 8

Locating style file...
✓ Style file found: Professional/Conversational_Expert.md

Generating content files...

✓ Generated Style_Guide.md
✓ Generated Style_Overrides.md
✓ Generated TOC.md
✓ Generated TOC_chg.md
✓ Generated Chapter_Quotes.md
✓ Generated Chapter_Quotes_chg.md
✓ Generated USAGE_GUIDE.md
✓ Generated PROJECT_CONTEXT.md
✓ Generated README.md
✓ Generated Chapter_01 files
✓ Generated Chapter_02 files
✓ Generated Chapter_03 files
✓ Generated Chapter_04 files
✓ Generated Chapter_05 files
✓ Generated Chapter_06 files
✓ Generated Chapter_07 files
✓ Generated Chapter_08 files

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✓ Content generation complete
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Total: 17 files created
```

---

## Troubleshooting

### "Config file not found"

**Cause:** Q&A not completed

**Solution:**
1. Ensure you completed Step 2 (Q&A)
2. Check `.config/init.json` exists
3. Re-run Q&A if needed

### "Git not installed"

**Cause:** Git not in PATH

**Solution:**
1. Install git: https://git-scm.com/
2. Restart terminal
3. Verify: `git --version`

### "Templates not found"

**Cause:** Wrong directory or missing templates

**Solution:**
1. Run from project root
2. Verify `Process/Templates/` exists
3. Re-extract framework if needed

### "jq not installed" (generate-content.sh)

**Cause:** jq JSON processor not installed

**Solution:**
- Windows: `winget install jqlang.jq`
- macOS: `brew install jq`
- Linux: `sudo apt install jq`

### "Already initialized"

**Cause:** Running Prompt 1 on existing project

**Solution:**
Choose appropriate option:
1. Update framework files only
2. Full re-initialization (destructive)
3. Cancel

### "Lock conflict"

**Cause:** Another initialization in progress

**Solution:**
1. Wait for other process
2. Override if stale (>15 min)
3. Check `.locks/locks.json`

---

## Anti-Hallucination Note

During initialization:
- **DO NOT** generate sample chapter content
- **DO NOT** create example quotes/epigraphs
- **DO NOT** fabricate book descriptions
- **ONLY** use data from user Q&A

---

## Related Prompts

| Prompt | Relationship |
|--------|--------------|
| Prompt 2 | Add chapters after initialization |
| Prompt 10 | View dashboard after initialization |

---

**Version:** 0.16.0
**For Core Workflow:** See `Prompt_1_Initialize.md`
