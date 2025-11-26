# Module 20: JSON Schema and Structure Standards

**Version:** 0.13.11
**Purpose:** Authoritative reference for all JSON configuration files in the framework

---

## Overview

This module defines the canonical schemas for all JSON configuration files. All prompts that create or modify JSON files MUST follow these exact structures.

**Key Principles:**
1. **Exact field names** - Use the precise names shown (case-sensitive)
2. **Required fields must exist** - Scripts validate these
3. **Consistent data types** - Strings, numbers, arrays, objects as specified
4. **Date format** - Always `YYYY-MM-DD` (ISO 8601)

---

## Configuration Files Location

All configuration files reside in `.config/` directory:

```
.config/
├── init.json        # Q&A answers from initialization
├── project.json     # Project settings and state
├── metadata.json    # Book metadata for export
├── manifest.json    # Framework version tracking
└── migrations.json  # Version migration rules
```

---

## Schema: init.json

**Purpose:** Stores answers from Prompt 1 Q&A session
**Created by:** Prompt 1 (Step 3)
**Read by:** `scripts/generate-content.sh`, `scripts/init.sh`

### Required Fields

| Field | Type | Description |
|-------|------|-------------|
| `title` | string | Book working title |
| `author` | string | Author name |
| `style` | string | Writing style name (from Style_Catalog.md) |
| `chapters` | array | Chapter objects with `number` and `title` |
| `createdDate` | string | Date created (YYYY-MM-DD) |

### Optional Fields

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `targetWordCount` | string | "50000" | Target word count |
| `targetAudience` | string | "" | Target reader description |
| `purpose` | string | "" | Book purpose/thesis |
| `targetCompletionDate` | string | "" | Target completion (YYYY-MM-DD) |
| `tocFilePath` | string | "" | Path to existing TOC file |
| `frameworkVersion` | string | - | Framework version used |

### Canonical Structure

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "description": "Initialization configuration from Q&A session",
  "title": "Book Title Here",
  "author": "Author Name",
  "targetWordCount": "60000",
  "targetAudience": "Description of target readers",
  "purpose": "What this book aims to accomplish",
  "targetCompletionDate": "2025-12-31",
  "tocFilePath": "",
  "chapters": [
    {"number": 1, "title": "Introduction"},
    {"number": 2, "title": "Chapter Two Title"},
    {"number": 3, "title": "Chapter Three Title"}
  ],
  "style": "Conversational Expert",
  "createdDate": "2025-11-24",
  "frameworkVersion": "0.13.3"
}
```

### Common Errors

| Error | Cause | Fix |
|-------|-------|-----|
| `Missing required field: style` | Used `writingStyle` instead of `style` | Use exact field name `style` |
| `Missing required field: chapters` | Chapters is null or missing | Provide array of chapter objects |
| `Invalid date format` | Used MM/DD/YYYY or other format | Use YYYY-MM-DD |

---

## Schema: project.json

**Purpose:** Project configuration and runtime state
**Created by:** Prompt 1 (Step 3)
**Modified by:** Prompts that change project settings

### Required Fields

| Field | Type | Description |
|-------|------|-------------|
| `initialized` | boolean | Whether project setup is complete |
| `frameworkVersion` | string | Current framework version |
| `createdDate` | string | Project creation date (YYYY-MM-DD) |

### Optional Fields

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `settings.prompt_9_verbose` | boolean | true | Verbose mode for Prompt 9 |
| `lastModified` | string | - | Last modification date |

### Canonical Structure

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "description": "Project configuration and settings",
  "initialized": true,
  "settings": {
    "prompt_9_verbose": true
  },
  "frameworkVersion": "0.13.3",
  "createdDate": "2025-11-24",
  "lastModified": "2025-11-24"
}
```

---

## Schema: metadata.json

**Purpose:** Book metadata for exports (EPUB, PDF, DOCX)
**Created by:** Prompt 1 (Step 3)
**Read by:** Prompt 9 (Export)

### Required Fields

| Field | Type | Description |
|-------|------|-------------|
| `title` | string | Book title |
| `author` | string | Author name |

### Optional Fields

| Field | Type | Description |
|-------|------|-------------|
| `subtitle` | string | Book subtitle |
| `publisher` | string | Publisher name |
| `publicationDate` | string | Publication date (YYYY-MM-DD) |
| `isbn` | string | ISBN number |
| `language` | string | Language code (e.g., "en") |
| `rights` | string | Copyright/rights statement |
| `keywords` | array | Keywords for metadata |

### Canonical Structure

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "description": "Book metadata for export formats",
  "title": "Book Title Here",
  "subtitle": "",
  "author": "Author Name",
  "publisher": "",
  "publicationDate": "",
  "isbn": "",
  "language": "en",
  "rights": "All rights reserved",
  "keywords": [],
  "frameworkVersion": "0.13.3",
  "createdDate": "2025-11-24"
}
```

---

## Schema: manifest.json

**Purpose:** Framework installation and version tracking
**Created by:** Prompt 1 or configure.md
**Modified by:** Framework updates

### Required Fields

| Field | Type | Description |
|-------|------|-------------|
| `framework` | string | Framework name |
| `frameworkVersion` | string | Current framework version |
| `installedVersion` | string | First installed version |
| `installedDate` | string | Installation date (YYYY-MM-DD) |

### Optional Fields

| Field | Type | Description |
|-------|------|-------------|
| `toolsAvailable.git` | boolean | Git available |
| `toolsAvailable.pandoc` | boolean | Pandoc available |
| `toolsAvailable.typst` | boolean | Typst available |
| `appliedMigrations` | array | List of applied migrations |
| `updateHistory` | array | History of framework updates |

### Canonical Structure

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "description": "Framework manifest and version tracking",
  "framework": "AI-Assisted Nonfiction Authoring",
  "frameworkVersion": "0.13.3",
  "installedVersion": "0.13.3",
  "installedDate": "2025-11-24",
  "releaseDate": "2025-11-24",
  "lastUpdated": "2025-11-24",
  "toolsAvailable": {
    "git": true,
    "pandoc": false,
    "typst": false
  },
  "appliedMigrations": [],
  "updateHistory": []
}
```

---

## Schema: migrations.json

**Purpose:** Version migration rules and history
**Created by:** Copied from template during initialization
**Read by:** configure.md during framework updates

### Structure

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "description": "Framework migration definitions",
  "migrations": [
    {
      "fromVersion": "0.12.0",
      "toVersion": "0.12.1",
      "changes": [
        {
          "type": "rename",
          "from": ".nonfiction-manifest.json",
          "to": ".config/manifest.json"
        }
      ]
    }
  ]
}
```

### Migration Change Types

| Type | Description | Required Fields |
|------|-------------|-----------------|
| `rename` | Rename/move file | `from`, `to` |
| `delete` | Remove file | `path` |
| `gitignore_add` | Add to .gitignore | `pattern` |
| `gitignore_remove` | Remove from .gitignore | `pattern` |
| `add_to_config` | Add field to config | `file`, `field`, `value` |
| `update_content` | Update file content | `file`, `search`, `replace` |

---

## Field Naming Conventions

1. **Use camelCase** for all field names
   - Correct: `targetWordCount`, `createdDate`
   - Wrong: `target_word_count`, `created-date`

2. **Use exact names** from this module
   - Correct: `style`
   - Wrong: `writingStyle`, `writing_style`, `Style`

3. **Boolean fields** use `is` or `has` prefix only when clarifying
   - Correct: `initialized`, `verbose`
   - Acceptable: `isPublished`, `hasAppendix`

4. **Date fields** end with `Date`
   - Correct: `createdDate`, `targetCompletionDate`
   - Wrong: `created`, `targetCompletion`

5. **Array fields** use plural nouns
   - Correct: `chapters`, `keywords`, `migrations`
   - Wrong: `chapter`, `keyword`, `migration`

---

## Validation Rules

### Date Validation

```
Format: YYYY-MM-DD
Regex: ^\d{4}-\d{2}-\d{2}$
Example: 2025-11-24
```

### Chapter Array Validation

```
- Must be non-empty array
- Each element must have:
  - number: positive integer
  - title: non-empty string
- Numbers should be sequential starting from 1
```

### Style Validation

```
- Must match a style name from Process/Styles/Style_Catalog.md
- Case-sensitive match
- Examples: "Conversational Expert", "Academic Authority", "Narrative Storyteller"
```

---

## Integration with Scripts

### generate-content.sh

Validates these required fields from init.json:
- `title`
- `author`
- `style`
- `chapters`
- `createdDate`

### detect-tools.sh

Updates these fields in manifest.json:
- `toolsAvailable.git`
- `toolsAvailable.pandoc`
- `toolsAvailable.typst`
- `lastUpdated`

---

## Error Messages

When validation fails, scripts should output clear messages:

```
✗ Missing required field: style
✗ Invalid date format in createdDate: expected YYYY-MM-DD
✗ chapters must be a non-empty array
✗ Style "Unknown Style" not found in Style_Catalog.md
```

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 0.13.3 | 2025-11-24 | Initial module creation |

---

**Module:** 19_JSON_Schema_Module.md
**Category:** Data Standards
**Dependencies:** None
**Used by:** Prompts 1, 9; configure.md; all scripts
