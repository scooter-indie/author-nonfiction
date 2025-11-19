# Fiction Framework Proposal

**Status:** Draft - Awaiting User Decisions
**Created:** 2025-11-19
**Based on:** Nonfiction Framework v0.10.0
**Proposed Version:** Fiction Framework v0.1.0

---

## Executive Summary

This proposal outlines the requirements, architecture, and implementation plan for creating a **Fiction Authoring Framework** based on the proven AI-Assisted Nonfiction Authoring Framework v0.10.0.

The fiction framework would support authors creating:
- **Short stories** (single file, 1,000-15,000 words)
- **Standalone novels** (70,000-120,000 words)
- **Series** (trilogies, multi-book series, endless series)
- **D&D Adventures** (single-session, 3-5 hour gameplay)
- **D&D Campaigns** (multi-session, 10-100+ hours)
- **Anthologies** (collections of short stories)

**Key Challenge:** Fiction requires fundamentally different organizational structures, tracking systems, and creative workflows compared to nonfiction's research-based chapter model.

---

## Table of Contents

1. [Core Differences: Fiction vs. Nonfiction](#core-differences-fiction-vs-nonfiction)
2. [Clarifying Questions (AWAITING USER INPUT)](#clarifying-questions-awaiting-user-input)
3. [Proposed Architecture](#proposed-architecture)
4. [Fiction-Specific Features](#fiction-specific-features)
5. [File Structure](#file-structure)
6. [Prompt Adaptations](#prompt-adaptations)
7. [Shared vs. Unique Components](#shared-vs-unique-components)
8. [Implementation Phases](#implementation-phases)
9. [Anti-Hallucination for Fiction](#anti-hallucination-for-fiction)
10. [Technical Challenges](#technical-challenges)
11. [Estimated Effort](#estimated-effort)
12. [Migration Strategy](#migration-strategy)
13. [Success Metrics](#success-metrics)

---

## Core Differences: Fiction vs. Nonfiction

### Structural Differences

| Aspect | Nonfiction | Fiction |
|--------|-----------|---------|
| **Organization** | Linear chapters, logical progression | Plot arcs, story beats, non-linear timelines |
| **Content Type** | Research-based, factual, educational | Creative, character-driven, world-building |
| **Verification** | Citations, fact-checking, sources | Internal consistency, continuity tracking |
| **Chapters** | Self-contained topics | Sequential story progression with cliffhangers |
| **Development** | Outline → Research → Write | Outline → Character/World → Draft → Revise |
| **Metadata** | Author bio, credentials, references | Character sheets, world-building, timelines |
| **Consistency Checking** | Style guide, terminology | Plot continuity, character consistency, world rules |

### Creative Process Differences

**Nonfiction:**
1. Define topic/thesis
2. Research and gather sources
3. Organize into logical chapters
4. Write with citations
5. Review for accuracy

**Fiction:**
1. Develop premise/concept
2. Create characters and world
3. Outline plot structure
4. Write scenes with character arcs
5. Revise for pacing, consistency, emotional impact

### Content Tracking Differences

**Nonfiction needs:**
- Quote verification
- Citation management
- Source tracking
- Fact-checking

**Fiction needs:**
- Character tracking (appearance, personality, arc)
- Plot continuity (timeline, cause-effect)
- World-building consistency (magic systems, geography, culture)
- POV management (who's narrating when)
- Scene/beat tracking (granular story structure)

---

## Clarifying Questions (AWAITING USER INPUT)

### Question 1: Scope and Priorities

**Which format(s) should the fiction framework prioritize?**

- [ ] **Option A:** Start with standalone novels only (v0.1.0), expand to series/short stories later
- [ ] **Option B:** Support novels + series from day one, add short stories/RPG later
- [ ] **Option C:** Support ALL formats from v0.1.0 (ambitious, more complex)
- [ ] **Option D:** Start with short stories (simpler), expand to novels/series

**USER DECISION:** _____________________

**Rationale for decision:** _____________________

---

### Question 2: Relationship to Nonfiction Framework

**How should the fiction framework relate to the nonfiction framework?**

- [ ] **Option A: Separate Framework**
  - Completely independent codebase
  - Can diverge freely from nonfiction
  - Users download fiction-specific framework
  - Pros: Clean separation, no confusion
  - Cons: Duplicate maintenance, harder to share improvements

- [ ] **Option B: Shared Core with Mode Selection**
  - Single framework, user chooses "Fiction" or "Nonfiction" during Prompt 1
  - Shared prompts (3, 5, 6, 8, 9, 10) with mode-aware behavior
  - Separate Process/Fiction/ and Process/Nonfiction/ directories
  - Pros: Code reuse, unified updates, cross-pollination
  - Cons: More complex, potential mode-switching bugs

- [ ] **Option C: Clone and Fork**
  - Start with nonfiction framework as base
  - Create fiction-specific fork (separate repo)
  - Manually port improvements between frameworks
  - Pros: Independent evolution, clear boundaries
  - Cons: Eventual divergence, manual synchronization

**USER DECISION:** _____________________

**Rationale for decision:** _____________________

---

### Question 3: Fiction-Specific Features (Must-Have vs. Nice-to-Have)

**Rate each feature: MUST (v0.1.0), SHOULD (v0.2.0), COULD (v0.3.0+), or WON'T**

| Feature | Priority | Notes |
|---------|----------|-------|
| Character tracking (sheets, arcs, relationships) | _____ | |
| Plot/story arc management (beats, structure) | _____ | |
| World-building database (settings, magic, culture) | _____ | |
| Timeline management (chronological events) | _____ | |
| POV tracking (perspective per scene/chapter) | _____ | |
| Scene/beat tracking (below chapter level) | _____ | |
| Series continuity (multi-book tracking) | _____ | |
| D&D encounter design tools | _____ | |
| D&D stat blocks and NPCs | _____ | |
| Revision tracking (draft versions: alpha, beta, final) | _____ | |
| Subplot tracking | _____ | |
| Dialogue attribution tracking | _____ | |
| Pacing analysis | _____ | |
| Emotional arc tracking | _____ | |

**USER DECISION:** (Fill in priority column)

---

### Question 4: Content Organization

**How should different fiction formats be organized?**

**For Standalone Novels:**
- [ ] **Option A:** Same as nonfiction (Manuscript/Chapters/Chapter_XX/)
- [ ] **Option B:** Scene-based (Manuscript/Scenes/Scene_XX/) with chapters as groupings
- [ ] **Option C:** Act-based (Manuscript/Acts/Act_I/Chapter_XX/)

**USER DECISION:** _____________________

**For Series (multiple books):**
- [ ] **Option A:** Single project with Manuscript/Books/Book_01/, Book_02/, etc.
- [ ] **Option B:** Separate project per book, manual continuity tracking
- [ ] **Option C:** Single project with shared World/ directory, Books/ separated

**USER DECISION:** _____________________

**For Short Stories:**
- [ ] **Option A:** Collection in single project (Manuscript/Stories/Story_01.md)
- [ ] **Option B:** One project per story
- [ ] **Option C:** Hybrid: Collection project with Stories/ directory, can extract to standalone

**USER DECISION:** _____________________

**For D&D Adventures/Campaigns:**
- [ ] **Option A:** Campaign/Adventures/Adventure_XX/Acts/Encounters/
- [ ] **Option B:** Campaign/Sessions/Session_XX/
- [ ] **Option C:** Campaign/Chapters/Chapter_XX/ (like novels, but with encounter notes)

**USER DECISION:** _____________________

---

### Question 5: Anti-Hallucination for Fiction

**Fiction involves creating made-up content. How should anti-hallucination rules work?**

- [ ] **Option A: Strict Consistency Verification**
  - AI can create fictional content freely
  - BUT must verify consistency with established story elements
  - Example: "You established magic requires sacrifice. Should this spell follow that rule?"
  - Prevents continuity errors, not creative generation

- [ ] **Option B: Creative Choice Verification**
  - AI must ASK before making creative choices that affect plot/characters
  - Example: "Should the protagonist accept the quest, or refuse?"
  - User retains creative control, AI assists execution

- [ ] **Option C: Hybrid Approach**
  - AI can generate minor details (description, dialogue)
  - AI must ASK for major decisions (plot turns, character choices)
  - AI must VERIFY consistency with world rules

- [ ] **Option D: Minimal Restrictions**
  - Trust AI to generate fiction creatively
  - Only verify against explicit user instructions

**USER DECISION:** _____________________

**Rationale for decision:** _____________________

---

### Question 6: Compatibility Requirements

**Should the fiction framework maintain the same compatibility model?**

- [ ] **Yes:** Same Desktop/CLI compatibility as nonfiction (DESKTOP-FRIENDLY, CLI-ONLY prompts)
- [ ] **No:** CLI-only for all operations (simpler, more powerful)
- [ ] **Modified:** Different compatibility for different formats (novels=CLI, short stories=Desktop)

**USER DECISION:** _____________________

---

### Question 7: Timeline and Implementation

- [ ] **Planning Only:** This proposal is for understanding scope and requirements
- [ ] **Implement Soon:** Begin implementation after approval
- [ ] **Phased Rollout:** Implement iteratively (v0.1.0, v0.2.0, etc.)

**USER DECISION:** _____________________

**Target Timeline:** _____________________

---

## Proposed Architecture

### Option A: Separate Fiction Framework

```
fiction-framework/
├── CLAUDE.md                          # Fiction framework context
├── INSTALLATION.md
├── CHANGELOG.md
├── configure.md
├── system-instructions.md
├── Process/
│   ├── AI-Assisted_Fiction_Authoring_Process.md
│   ├── Anti-Hallucination_Guidelines.md      # Fiction-adapted
│   ├── Style_Examples.md                     # Fiction styles (literary, genre, etc.)
│   ├── _COMMON/                              # Shared modules (from nonfiction)
│   │   ├── 01_Prompt_Structure_Template.md
│   │   ├── 05_Git_Integration_Module.md
│   │   ├── 06_Validation_Protocols.md
│   │   └── ... (reuse where applicable)
│   ├── _FICTION_COMMON/                      # Fiction-specific modules
│   │   ├── 01_Character_Management_System.md
│   │   ├── 02_Plot_Structure_Templates.md
│   │   ├── 03_World_Building_Protocol.md
│   │   ├── 04_Timeline_Management.md
│   │   ├── 05_POV_Tracking_System.md
│   │   ├── 06_Scene_Beat_Structure.md
│   │   ├── 07_Series_Continuity_Protocol.md
│   │   └── 08_DnD_Adventure_Design.md
│   ├── Prompts/
│   │   ├── README.md
│   │   ├── Prompt_1_Initialize.md            # Fiction-adapted (choose format)
│   │   ├── Prompt_2_Add_Chapter.md           # Or Add_Scene, Add_Act
│   │   ├── Prompt_3_Modify_File.md           # Same concept, adapted
│   │   ├── Prompt_4_Integrate_Inbox.md       # Same
│   │   ├── Prompt_5_Compile.md               # Same (compile manuscript)
│   │   ├── Prompt_6_Consistency.md           # Fiction-specific checks
│   │   ├── Prompt_7_Export.md                # Same (DOCX, PDF, EPUB)
│   │   ├── Prompt_8_Dashboard.md             # Fiction-adapted metrics
│   │   ├── Prompt_9_Git.md                   # Same
│   │   ├── Prompt_10_Update_Change_Tracking.md # Same
│   │   ├── Prompt_11_Character_Manager.md    # NEW: Manage character database
│   │   ├── Prompt_12_World_Builder.md        # NEW: Manage world-building
│   │   └── Prompt_13_Timeline_Manager.md     # NEW: Manage chronology
│   └── Templates/
│       ├── Character_Sheet_Template.md
│       ├── World_Building_Template.md
│       ├── Plot_Outline_Template.md
│       ├── Scene_Template.md
│       └── DnD_Encounter_Template.md
└── .gitignore
```

### Option B: Unified Framework with Mode

```
author-framework/                              # Renamed from "nonfiction"
├── CLAUDE.md                                  # Updated for both modes
├── Process/
│   ├── _COMMON/                               # Shared modules
│   ├── _NONFICTION_MODULES/                   # Nonfiction-specific
│   │   ├── Quote_Management_System.md
│   │   └── Citation_Protocol.md
│   ├── _FICTION_MODULES/                      # Fiction-specific
│   │   ├── Character_Management_System.md
│   │   ├── Plot_Structure_Templates.md
│   │   └── World_Building_Protocol.md
│   └── Prompts/
│       ├── Prompt_1_Initialize.md             # Mode selection prompt
│       ├── Prompt_3_Modify_File.md            # Mode-aware behavior
│       ├── Prompt_6_Consistency.md            # Mode-specific checks
│       ├── Prompt_11_Character_Manager.md     # Fiction-only
│       └── Prompt_12_Quote_Manager.md         # Nonfiction-only
```

---

## Fiction-Specific Features

### Feature 1: Character Management System

**Purpose:** Track all characters across the story/series with consistency.

**Implementation:**
- Central file: `World/Characters/Character_Database.md`
- Individual character sheets: `World/Characters/[CharacterName].md`
- Change tracking: `World/Characters/[CharacterName]_chg.md`

**Character Sheet Template:**
```markdown
# Character: [Name]

**Status:** [Main Character | Supporting | Minor | Antagonist]
**First Appearance:** Chapter X / Scene Y
**Last Appearance:** Chapter Z

---

## Basic Information

**Full Name:** [First Last]
**Nickname(s):** [Optional]
**Age:** [Number] (as of Chapter X)
**Species/Race:** [Human, Elf, etc.]
**Gender:** [Optional]
**Occupation:** [Job/Role]

---

## Physical Description

**Appearance:**
- Height: [X ft Y in]
- Build: [Slim, Athletic, etc.]
- Hair: [Color, length, style]
- Eyes: [Color]
- Distinguishing Features: [Scars, tattoos, etc.]

**Clothing Style:** [Description]

---

## Personality

**Traits:**
- [List 5-7 core personality traits]

**Strengths:**
- [What they're good at]

**Weaknesses:**
- [Flaws, fears, limitations]

**Motivations:**
- **Wants:** [Surface-level goals]
- **Needs:** [Deep emotional needs]

**Fears:**
- [What scares them]

---

## Background

**Backstory:** [Brief history before story begins]

**Family:**
- Parents: [Names/status]
- Siblings: [Names/status]
- Spouse/Partner: [Name/status]
- Children: [Names/status]

**Key Life Events:**
- [Major events that shaped them]

---

## Relationships

**Allies:**
- [Character Name]: [Relationship description]

**Enemies:**
- [Character Name]: [Conflict description]

**Romantic Interests:**
- [Character Name]: [Relationship status]

---

## Character Arc

**Starting Point (Chapter 1):**
- Beliefs: [What they believe]
- State: [Emotional/physical state]

**Character Growth:**
- Chapter X: [Development milestone]
- Chapter Y: [Development milestone]

**Transformation:**
- Ending Point: [How they've changed]

---

## Dialogue Voice

**Speech Patterns:**
- [How they talk: formal, casual, accents, quirks]

**Catchphrases:**
- "[Recurring phrases they use]"

**Vocabulary Level:** [Simple, Educated, Technical, etc.]

---

## Story Role

**Narrative Function:** [Mentor, Catalyst, Love Interest, etc.]

**Plot Contributions:**
- Chapter X: [What they do]

---

## Consistency Notes

**Important Details to Remember:**
- [Eye color must stay blue]
- [Left-handed]
- [Allergic to shellfish]
- [Scar on right cheek from Chapter 3]

---

## Change Tracking

**Character established in:** Chapter X (v1.0.0)
**Last modified:** Chapter Y (v1.5.0)

**Evolution Log:**
- v1.0.0: Initial character creation
- v1.2.0: Added backstory about father
- v1.5.0: Character gained confidence after Chapter 12 events
```

**Prompt Support:**
- **Prompt 11 (Character Manager):** Add/modify/view characters
- **Prompt 6 (Consistency):** Check character consistency across manuscript
  - Name spelling consistency
  - Physical description consistency
  - Personality consistency
  - Timeline consistency (age, events)

---

### Feature 2: Plot Structure Management

**Purpose:** Track story structure, beats, and pacing.

**Implementation:**
- Central file: `Planning/Plot_Outline.md`
- Story beat tracking per chapter
- Act structure templates

**Plot Outline Template:**
```markdown
# Plot Outline: [Story Title]

**Story Type:** [Novel | Trilogy | Series]
**Genre:** [Fantasy, Sci-Fi, Mystery, etc.]
**Target Word Count:** [70,000-120,000]
**Current Word Count:** [X]

---

## Premise

**Logline:** [One-sentence story description]

**Elevator Pitch:** [2-3 sentence compelling summary]

**Core Conflict:** [What's the main problem?]

---

## Story Structure

**Structure Type:** [Three-Act | Hero's Journey | Save the Cat | Custom]

### Act I: Setup (25%)

**Hook (Chapter 1):**
- Opening Scene: [Description]
- Inciting Incident: [What disrupts normal world?]
- Stakes: [What's at risk?]

**Setup (Chapters 2-X):**
- Introduce characters: [List]
- Establish world: [Key elements]
- Plant seeds: [Foreshadowing]

**First Plot Point (End Act I):**
- Event: [What forces protagonist into Act II?]
- No Turning Back: [Point of no return]

### Act II: Confrontation (50%)

**Rising Action (First Half):**
- Obstacles: [List challenges]
- Subplots: [Concurrent storylines]
- Character development: [Growth moments]

**Midpoint:**
- Event: [Major revelation or shift]
- Raise Stakes: [How does it get worse?]

**Rising Action (Second Half):**
- Complications: [Things get harder]
- Dark Moment: [Lowest point]

**Second Plot Point (End Act II):**
- Event: [Final push toward climax]
- All is Lost: [Moment of defeat]

### Act III: Resolution (25%)

**Climax:**
- Confrontation: [Final battle/conflict]
- Resolution: [How conflict is resolved]

**Denouement:**
- Wrap-up: [Loose ends tied]
- New Normal: [How world has changed]

---

## Story Beats by Chapter

### Chapter 1: [Title]
- **Beat:** Hook + Introduction
- **POV:** [Character Name]
- **Word Count:** [Target: X]
- **Key Events:**
  - [Event 1]
  - [Event 2]
- **Character Development:** [Who grows, how?]
- **Plot Advancement:** [How does story move forward?]
- **Cliffhanger/Transition:** [How does it end?]

### Chapter 2: [Title]
- [Same structure]

[Continue for all chapters...]

---

## Subplots

### Subplot A: [Name]
- **Type:** [Romance, Mystery, Character Arc]
- **Characters:** [Involved characters]
- **Introduction:** Chapter X
- **Development:** Chapters Y-Z
- **Resolution:** Chapter N
- **Purpose:** [Why this subplot matters]

---

## Pacing Tracker

| Chapter | Act | Word Count | Pacing | Action Level | Emotional Intensity |
|---------|-----|------------|--------|--------------|---------------------|
| 1       | I   | 3,500      | Fast   | High         | Medium              |
| 2       | I   | 4,200      | Medium | Medium       | Low                 |
[Continue...]

**Pacing Legend:**
- Fast: Quick scenes, high action
- Medium: Balanced
- Slow: Introspective, world-building

---

## Scene List

### Chapter 1
- **Scene 1.1:** [Location] - [POV Character]
  - Action: [What happens]
  - Purpose: [Why this scene exists]
  - Beats: [Emotional/plot beats]

- **Scene 1.2:** [Location] - [POV Character]
  - [Same structure]

---

## Tension Arc

**Overall Tension Curve:**
```
High |                      *Climax
     |                    /   \
     |                  /       \
     |    *Midpoint   /           \
     |    /    \    /               \
     |  /        \/                   *Resolution
Low  |/________________________________
     Act I     Act II          Act III
```

---

## Plot Threads

### Thread 1: [Main Plot]
- Setup: Chapter X
- Development: Chapters Y-Z
- Payoff: Chapter N
- Status: [Active | Resolved | Ongoing]

### Thread 2: [Secondary Plot]
- [Same structure]

---

## Consistency Notes

**World Rules Established:**
- [Magic system limitations]
- [Technology level]
- [Social structures]

**Must Track:**
- [Timeline of events]
- [Character locations]
- [Cause and effect chains]
```

**Prompt Support:**
- **Prompt 1 (Initialize):** Create plot outline during setup
- **Prompt 3 (Modify):** Update plot as story evolves
- **Prompt 6 (Consistency):** Check plot coherence, beat pacing, thread resolution
- **Prompt 8 (Dashboard):** Show progress through acts, beat completion

---

### Feature 3: World-Building Database

**Purpose:** Maintain consistent fictional world details.

**Implementation:**
- Central file: `World/World_Bible.md`
- Category files:
  - `World/Geography.md`
  - `World/Magic_System.md`
  - `World/History.md`
  - `World/Cultures.md`
  - `World/Technology.md`
  - `World/Organizations.md`

**World Bible Template:**
```markdown
# World Bible: [World Name]

**Genre:** [Fantasy, Sci-Fi, etc.]
**Setting Type:** [Medieval, Futuristic, Modern, etc.]
**Tech Level:** [Bronze Age, Renaissance, Space-faring, etc.]
**Magic Level:** [None, Low, Medium, High]

---

## Geography

### Continents/Regions
- **[Region Name]:** [Description, climate, notable features]
- **[Region Name]:** [Description]

### Major Locations
- **[City/Place Name]:**
  - Population: [Number]
  - Government: [Type]
  - Economy: [Main industries]
  - Notable Features: [Landmarks, culture]
  - First Mentioned: Chapter X

### Map References
- [Link to map file or description]

---

## Magic System (if applicable)

**Magic Type:** [Hard/Soft, Source-based, Willpower-based, etc.]

**Rules:**
1. [Core rule 1: e.g., "Magic requires sacrifice"]
2. [Core rule 2: e.g., "Only those born with the gift can use magic"]
3. [Core rule 3: e.g., "Using too much magic causes physical exhaustion"]

**Limitations:**
- [What magic CAN'T do]

**Costs:**
- [What it costs to use magic]

**Manifestations:**
- [How magic appears/works in practice]

**Consistency Check:**
- Every spell used MUST follow established rules
- Track exceptions explicitly with rationale

---

## Technology

**General Tech Level:** [Description]

**Available Technology:**
- Transportation: [Horses, cars, spaceships, etc.]
- Communication: [Letters, phones, telepathy, etc.]
- Weapons: [Swords, guns, energy weapons, etc.]
- Medicine: [Herbs, modern, advanced, etc.]

**Unavailable/Unknown Technology:**
- [Things that don't exist in this world]

**Consistency:** Technology level must remain consistent unless plot explicitly introduces advancement

---

## History

### Timeline

**Ancient Era ([Dates]):**
- [Major event]
- [Major event]

**Classical Era ([Dates]):**
- [Major event]

**Modern Era ([Dates]):**
- [Current story takes place here]

### Major Historical Events

**[Event Name] ([Date]):**
- What happened: [Description]
- Impact: [How it shaped the world]
- Relevance to story: [Why it matters]

---

## Cultures and Societies

### [Culture/Nation Name]

**Government:** [Monarchy, Democracy, etc.]
**Values:** [What they believe in]
**Customs:**
- Greetings: [How they greet]
- Marriage: [Customs]
- Death: [Funeral rites]
- Taboos: [Forbidden things]

**Religion:**
- Deities: [Names, domains]
- Practices: [Rituals, prayers]
- Clergy: [Structure]

**Social Structure:**
- Classes: [Nobility, commoners, etc.]
- Mobility: [Can people change class?]

**Notable Traits:**
- [Unique cultural elements]

---

## Organizations

### [Organization Name]

**Type:** [Guild, Military, Secret Society, etc.]
**Purpose:** [Why they exist]
**Leadership:** [Structure, current leaders]
**Membership:** [How to join]
**Influence:** [Power level in world]
**Headquarters:** [Location]
**First Mentioned:** Chapter X

---

## Languages

- **[Language Name]:** Spoken by [People/Region]
  - Sample Phrases: [If used in story]
  - Script: [Alphabet type]

---

## Currency and Economy

**Currency:**
- [Copper/Silver/Gold coins, Credits, etc.]
- Exchange rates: [If multiple currencies]

**Economic System:** [Feudal, Capitalist, Barter, etc.]

---

## Flora and Fauna

### Unique Creatures

**[Creature Name]:**
- Appearance: [Description]
- Habitat: [Where found]
- Behavior: [Aggressive, docile, etc.]
- Abilities: [Special powers/traits]
- Danger Level: [Harmless, Deadly, etc.]

### Unique Plants

**[Plant Name]:**
- Appearance: [Description]
- Uses: [Medicinal, poisonous, etc.]
- Location: [Where it grows]

---

## Consistency Tracker

**Rules That Must Never Change:**
1. [Fundamental world rule]
2. [Fundamental world rule]

**Evolution Log:**
- Chapter X: Established magic system requires sacrifice
- Chapter Y: Introduced Southern Continent geography
- Chapter Z: Revealed ancient war 500 years ago
```

**Prompt Support:**
- **Prompt 12 (World Builder):** Add/modify world elements
- **Prompt 6 (Consistency):** Check world rule consistency
  - Magic system violations
  - Geography contradictions
  - Technology anachronisms
  - Historical timeline conflicts

---

### Feature 4: Timeline Management

**Purpose:** Track chronological order of events, especially for non-linear storytelling.

**Implementation:**
- Central file: `Planning/Timeline.md`
- Event tracking with dates/time markers
- Cross-reference to chapters

**Timeline Template:**
```markdown
# Timeline: [Story Title]

**Timeline Type:** [Linear | Non-Linear | Multiple Timelines]
**Time Span:** [Days, Months, Years covered]
**Current Story Date:** [In-world date]

---

## Master Timeline (Chronological Order)

| Date/Time | Event | POV | Chapter | Location | Characters Involved |
|-----------|-------|-----|---------|----------|---------------------|
| Year -500 | Ancient War begins | N/A | Backstory | Continent | Nations A, B |
| Day 1, Morning | Protagonist wakes to alarm | Alex | Ch. 1 | Home | Alex |
| Day 1, Noon | Discovers letter | Alex | Ch. 1 | Home | Alex, Messenger |
| Day 1, Evening | Meets mentor | Alex | Ch. 2 | Tavern | Alex, Mentor |
| Day 2, Dawn | Training begins | Alex | Ch. 3 | Forest | Alex, Mentor |
| Day 3 | [Flashback: 5 years ago] | Alex | Ch. 4 | Hometown | Alex, Father |
| Day 4 | Returns to present | Alex | Ch. 5 | Forest | Alex |

---

## Story Timeline (As Presented to Reader)

**Narrative Order:**
- Chapter 1: Day 1 (present)
- Chapter 2: Day 1-2 (present)
- Chapter 3: Day 2-3 (present)
- Chapter 4: 5 years ago (flashback)
- Chapter 5: Day 4 (present)
- Chapter 6: Day 5 (present)

**Non-Linear Elements:**
- Flashbacks: [List chapters with flashbacks]
- Flash-forwards: [List chapters with flash-forwards]
- Parallel timelines: [If applicable]

---

## Character Age Tracker

| Character | Starting Age | Current Age (Day X) | Age at End |
|-----------|--------------|---------------------|------------|
| Alex | 25 | 25 | 26 |
| Mentor | 60 | 60 | 61 |

---

## Day-by-Day Breakdown

### Day 1
**In-World Date:** [Month Day, Year]
**Chapters:** 1-2
**Duration:** 18 hours (6am - midnight)

**Morning (6am-12pm):**
- 6:00am: Alex wakes
- 8:00am: Discovers letter
- 10:00am: Departs home

**Afternoon (12pm-6pm):**
- 12:00pm: Arrives at tavern
- 2:00pm: Meets mentor
- 4:00pm: Agrees to training

**Evening (6pm-12am):**
- 7:00pm: Dinner discussion
- 10:00pm: First lesson in magic
- 11:59pm: Day ends (cliffhanger)

### Day 2
[Same structure]

---

## Seasonal/Annual Events

**Recurring Events:**
- **Festival of Lights:** Every summer solstice
  - First mentioned: Chapter 5
  - Story event: Takes place during Act II

- **Royal Coronation:** Once per monarch death
  - Relevant to plot: Previous king died 2 years before story

---

## Travel Time Calculator

**Distance Between Locations:**
- Home → Tavern: 10 miles (2 hours on foot, 1 hour on horse)
- Tavern → Capital: 50 miles (2 days on foot, 1 day on horse)
- Capital → Ancient Ruins: 100 miles (4 days on foot)

**Travel Log:**
- Day 1: Home → Tavern (on foot, 2 hours)
- Day 5-7: Tavern → Capital (on horse, 1 day + rest)

---

## Consistency Checks

**Verify:**
- [ ] Character ages match timeline
- [ ] Travel times are realistic
- [ ] Seasonal references match dates
- [ ] Cause-effect sequences preserved
- [ ] No contradictions in event order
- [ ] Flashbacks clearly marked and consistent

**Common Errors to Catch:**
- Character in two places at once
- Events happening in impossible sequence
- Aging errors (character should be older/younger)
- Seasonal inconsistencies (snow in summer)
```

**Prompt Support:**
- **Prompt 13 (Timeline Manager):** Add events, check chronology
- **Prompt 6 (Consistency):** Verify timeline logic
  - Detect impossible sequences
  - Flag age inconsistencies
  - Check travel time realism

---

### Feature 5: POV (Point of View) Tracking

**Purpose:** Track narrative perspective and ensure POV consistency within scenes.

**Implementation:**
- Metadata in each chapter/scene file
- POV validator in Prompt 6

**POV Tracking Template:**
```markdown
# POV Tracking: [Story Title]

**POV Type:** [First Person | Third Person Limited | Third Person Omniscient | Multiple POV]
**POV Characters:** [List of characters who have POV scenes]

---

## POV Rules for This Story

**Restrictions:**
- [e.g., "Only Alex and Villain have POV scenes"]
- [e.g., "No head-hopping within a scene"]
- [e.g., "Each chapter is single POV"]

**POV Style:**
- Tense: [Past | Present]
- Depth: [Deep POV | Narrative Distance]

---

## POV Distribution

| Chapter | POV Character | Scene Count | Word Count | % of Total |
|---------|---------------|-------------|------------|------------|
| 1 | Alex | 3 | 3,500 | 5% |
| 2 | Alex | 2 | 3,200 | 4.5% |
| 3 | Mentor | 2 | 2,800 | 4% |
| 4 | Alex | 4 | 4,500 | 6% |

**Total POV Balance:**
- Alex: 60% (target: 60-70%)
- Mentor: 25% (target: 20-30%)
- Villain: 15% (target: 10-20%)

---

## Scene-Level POV

### Chapter 1

**Scene 1.1 (POV: Alex)**
- Lines: 1-350
- Location: Home
- Can see/know: Only what Alex perceives
- Cannot reveal: Other characters' thoughts

**Scene 1.2 (POV: Alex)**
- Lines: 351-700
- Location: Journey to tavern
- Maintains Alex's perspective

### Chapter 3

**Scene 3.1 (POV: Mentor)**
- Lines: 1-400
- Location: Forest
- **POV SWITCH:** First scene from Mentor's perspective
- Can see/know: Mentor's thoughts and perceptions
- Reveals: Mentor's hidden motivations

---

## POV Consistency Checks

**Verify Each Scene:**
- [ ] POV character tagged correctly
- [ ] No head-hopping (seeing into other characters' minds)
- [ ] Sensory details limited to POV character's perception
- [ ] Internal thoughts match POV character only
- [ ] Knowledge limited to what POV character knows

**Common POV Errors:**
- "She didn't know that he was lying" (Omniscient slip in limited POV)
- "He thought about his past while she wondered about her future" (Head-hopping)
- Describing POV character's facial expression without mirror/reflection

---

## POV Transitions

**How POV Switches Are Marked:**
- [ ] Chapter breaks
- [ ] Scene breaks with separator (---)
- [ ] Clear indication in text

**Example Transition:**
```
[End of Alex's scene]

---

[Mentor's POV begins - Chapter 3]
```
```

**Prompt Support:**
- **Prompt 3 (Modify):** Specify POV when writing new scenes
- **Prompt 6 (Consistency):** Check POV violations
  - Detect head-hopping
  - Flag omniscient slips
  - Verify POV character knowledge limits

---

### Feature 6: Scene and Beat Tracking

**Purpose:** Track story structure at granular level (below chapter).

**Implementation:**
- Scene metadata in chapter files
- Beat-level outline in planning

**Scene Template:**
```markdown
# Chapter X: [Chapter Title]

**POV:** [Character Name]
**Setting:** [Location, Time]
**Word Count Target:** [X,000]
**Purpose:** [Why this chapter exists in the story]

---

## Scene Breakdown

### Scene X.1: [Scene Title/Description]

**Location:** [Specific place]
**Time:** [Day/Time]
**POV:** [Character]
**Characters Present:** [List]
**Word Count:** [Target]

**Story Purpose:**
- Advance plot: [How?]
- Develop character: [Who? How?]
- Reveal information: [What?]

**Scene Goal:** [What protagonist wants in this scene]
**Conflict:** [What prevents them from getting it]
**Outcome:** [Win, lose, or complication]

**Beats:**
1. **Opening:** [How scene starts - hook]
2. **Action/Dialogue:** [What happens - conflict builds]
3. **Turning Point:** [Key moment - revelation, decision, action]
4. **Resolution:** [How scene ends - transition to next]

**Emotional Arc:**
- Start: [Character's emotional state]
- End: [Character's emotional state]
- Change: [How they've shifted]

**Key Dialogue:**
- "[Important line that must be included]"

**Sensory Details:**
- Sight: [Visual elements]
- Sound: [Auditory elements]
- Smell/Taste/Touch: [Other senses]

**Foreshadowing:**
- [Elements planted for later payoff]

**Callback:**
- [References to earlier events]

---

### Scene X.2: [Scene Title/Description]
[Same structure]

---

## Chapter Summary

**Total Scenes:** [Number]
**Total Words:** [Actual count]
**Pacing:** [Fast, Medium, Slow]

**Chapter Arc:**
- Opens: [Situation at start]
- Develops: [Conflict in middle]
- Closes: [Cliffhanger or resolution]

**Plot Threads Advanced:**
- Thread A: [How it progressed]
- Thread B: [How it progressed]

**Character Development:**
- [Character Name]: [How they changed/learned]

**Continuity Notes:**
- [Important details to remember]
- [e.g., "Character is now wearing blue cloak (mentioned in description)"]
```

**Prompt Support:**
- **Prompt 3 (Modify):** Write/revise scenes with beat structure
- **Prompt 6 (Consistency):** Check scene pacing, beat distribution
- **Prompt 8 (Dashboard):** Show scene completion status

---

### Feature 7: Series Continuity Tracking

**Purpose:** Maintain consistency across multiple books in a series.

**Implementation:**
- Shared World/ directory across all books
- Series-level tracking files
- Cross-book references

**Series Structure (Option C from Question 4):**
```
my-fantasy-series/
├── .git/
├── CLAUDE.md
├── configure.md
├── Project_Config.md
├── World/                                     # Shared across all books
│   ├── Characters/
│   │   ├── Character_Database.md
│   │   ├── Protagonist.md
│   │   ├── Protagonist_chg.md
│   │   └── ...
│   ├── World_Bible.md
│   ├── Geography.md
│   ├── Magic_System.md
│   └── ...
├── Planning/                                  # Series-wide planning
│   ├── Series_Outline.md
│   ├── Series_Timeline.md
│   └── Story_Arcs.md
├── Books/
│   ├── Book_01_The_Beginning/
│   │   ├── Manuscript/
│   │   │   ├── Chapters/
│   │   │   │   ├── Chapter_01/
│   │   │   │   │   ├── Chapter_01.md
│   │   │   │   │   └── Chapter_01_chg.md
│   │   │   │   └── ...
│   │   │   ├── _TOC_/
│   │   │   ├── FrontMatter/
│   │   │   └── BackMatter/
│   │   ├── Planning/
│   │   │   ├── Plot_Outline.md              # Book 1 specific
│   │   │   └── Timeline.md                  # Book 1 specific
│   │   └── Drafts/
│   ├── Book_02_The_Journey/
│   │   ├── Manuscript/
│   │   ├── Planning/
│   │   └── Drafts/
│   └── Book_03_The_End/
│       └── ...
└── Series/
    ├── Series_Bible.md                      # Continuity tracker
    ├── Character_Arcs.md                    # Multi-book character development
    └── Plot_Threads.md                      # Series-wide plot tracking
```

**Series Bible Template:**
```markdown
# Series Bible: [Series Name]

**Total Books Planned:** [Number or "Ongoing"]
**Books Completed:** [X of Y]
**Genre:** [Fantasy, Sci-Fi, etc.]
**Target Audience:** [YA, Adult, etc.]

---

## Series Overview

**Series Logline:** [One-sentence description of entire series]

**Series Theme:** [Overarching message/exploration]

**Series Conflict:** [Main antagonist/problem across all books]

---

## Book Summaries

### Book 1: [Title]
**Status:** [Draft | Published | Released YYYY-MM-DD]
**Word Count:** [X,000]
**Logline:** [One sentence]
**Main Plot:** [Summary]
**Ends With:** [Cliffhanger/Resolution description]

### Book 2: [Title]
**Status:** [Planning | Draft | etc.]
**Word Count:** [Target]
**Logline:** [One sentence]
**Picks Up:** [How it continues from Book 1]
**Main Plot:** [Summary]

[Continue for all books...]

---

## Series-Wide Character Arcs

### [Protagonist Name]

**Book 1:**
- Starts: [Naive farm boy]
- Learns: [Magic exists, he has power]
- Ends: [Reluctant hero, leaves home]

**Book 2:**
- Starts: [Reluctant hero, training]
- Learns: [Responsibility, cost of power]
- Ends: [Accepts destiny]

**Book 3:**
- Starts: [Confident hero]
- Learns: [True enemy revealed]
- Ends: [Master of power, saves world]

**Overall Arc:** [Farm boy → Reluctant hero → World-saving master]

### [Supporting Character Name]
[Same structure]

---

## Series Plot Threads

### Thread 1: [Main Prophecy]
- **Introduced:** Book 1, Chapter 3
- **Developed:** Book 1 (hints), Book 2 (explored), Book 3 (fulfilled)
- **Resolved:** Book 3, Chapter 25
- **Payoff:** [How it resolves]

### Thread 2: [Secondary Romance]
- **Introduced:** Book 1, Chapter 7
- **Developed:** Books 1-2 (slow burn), Book 3 (relationship)
- **Resolved:** Book 3, Chapter 30
- **Payoff:** [Couple gets together]

---

## Continuity Tracker

### Physical Descriptions
**[Character Name]:**
- Book 1: Blue eyes, brown hair, 5'10"
- Book 2: Same (aged 1 year, now 26)
- Book 3: Same (scar on left arm from Book 2, Chapter 15)

**Consistency Note:** Eyes must ALWAYS be blue. Scar must appear in all Book 3 descriptions.

### World Rules
**Magic System:**
- Book 1: Established magic requires sacrifice
- Book 2: Revealed sacrifice can be anything valuable
- Book 3: Protagonist discovers ultimate sacrifice loophole

**Consistency Note:** All magic use must follow sacrifice rule unless explicitly explained.

### Timeline
- Book 1: Takes place over 6 months
- Gap: 3 months between books 1 and 2
- Book 2: Takes place over 1 year
- Gap: 1 month between books 2 and 3
- Book 3: Takes place over 6 months

**Total Series Timeline:** 2 years, 4 months

### Locations
**[City Name]:**
- Book 1: Protagonist's hometown, peaceful
- Book 2: Mentioned in passing, still peaceful
- Book 3: Destroyed in Chapter 10 (raises stakes)

**Consistency Note:** Geography must match established map. City destruction is permanent.

---

## Foreshadowing Tracker

**Planted in Book 1, Paid Off Later:**
- Chapter 3: Mentor says "The sword will sing when the time comes"
  - Payoff: Book 3, Chapter 20 - Sword glows during final battle

- Chapter 15: Strange symbol on ancient door
  - Payoff: Book 2, Chapter 8 - Symbol is ancient language

---

## Series Mythology

**Established Facts:**
- [List of canon facts that cannot change]
- Ancient war happened 500 years ago
- Magic was outlawed 100 years ago
- Only royal bloodline can use healing magic

**Expanded in Each Book:**
- Book 1: [What was revealed]
- Book 2: [What was added]
- Book 3: [What was revealed]

---

## Continuity Checks for New Books

**Before Writing Next Book:**
- [ ] Review all character descriptions for consistency
- [ ] Check timeline and character ages
- [ ] Verify world rules haven't been contradicted
- [ ] Confirm all plot threads from previous books are tracked
- [ ] Review foreshadowing to ensure payoffs are planned

**Common Continuity Errors:**
- Character eye color changes
- Geography contradictions
- Timeline math errors (ages don't add up)
- Forgotten plot threads
- World rule violations
```

**Prompt Support:**
- **Prompt 1 (Initialize):** Choose "Series" mode, set up structure
- **Prompt 6 (Consistency):** Check cross-book continuity
  - Character description consistency
  - World rule compliance
  - Timeline accuracy across books
  - Plot thread tracking

---

### Feature 8: D&D Adventure/Campaign Design Tools

**Purpose:** Support RPG content creation with encounter design, stat blocks, and session planning.

**Implementation:**
- Adventure structure templates
- Encounter design tools
- NPC and monster stat blocks

**D&D Adventure Structure:**
```
dnd-campaign-rise-of-dragons/
├── .git/
├── CLAUDE.md
├── Campaign/
│   ├── Campaign_Overview.md
│   ├── Campaign_Timeline.md
│   └── Story_Arcs.md
├── World/                                     # Same as fiction
│   ├── Geography.md
│   ├── Factions.md
│   ├── Deities.md
│   └── History.md
├── Adventures/
│   ├── Adventure_01_The_Missing_Caravan/
│   │   ├── Adventure_Overview.md
│   │   ├── Acts/
│   │   │   ├── Act_1_Investigation/
│   │   │   │   ├── Scene_01_Tavern_Rumors.md
│   │   │   │   ├── Scene_02_Interview_Witness.md
│   │   │   │   └── Encounter_01_Ambush.md
│   │   │   ├── Act_2_Journey/
│   │   │   └── Act_3_Showdown/
│   │   ├── Maps/
│   │   │   ├── tavern_battlemap.png
│   │   │   └── forest_path.png
│   │   ├── Handouts/
│   │   │   ├── letter_from_merchant.md
│   │   │   └── ancient_prophecy.md
│   │   └── Session_Notes/
│   │       ├── Session_01_Notes.md
│   │       └── Session_02_Notes.md
│   └── Adventure_02_Cult_Rising/
│       └── ...
├── NPCs/
│   ├── NPC_Database.md
│   ├── Friendly/
│   │   ├── Merchant_Garan.md                # Stat block + character info
│   │   └── ...
│   ├── Hostile/
│   │   ├── Bandit_Leader.md
│   │   └── ...
│   └── Neutral/
│       └── ...
├── Monsters/
│   ├── Custom_Monsters.md
│   ├── Shadow_Drake.md
│   └── ...
├── Magic_Items/
│   ├── Item_Database.md
│   ├── Sword_of_Flames.md
│   └── ...
└── DM_Notes/
    ├── Session_Prep/
    ├── Player_Characters/
    │   ├── PC_Theron_Fighter.md
    │   └── ...
    └── Campaign_Secrets.md
```

**Encounter Template:**
```markdown
# Encounter: [Encounter Name]

**Type:** [Combat | Social | Exploration | Puzzle]
**Difficulty:** [Easy | Medium | Hard | Deadly]
**Expected Duration:** [X minutes]
**Recommended Level:** [X-Y]

---

## Setup

**Location:** [Where this takes place]
**Time of Day:** [Morning, Night, etc.]
**Weather:** [If relevant]

**Read-Aloud Text:**
> [Boxed text to read to players when encounter starts]
> "You enter a dimly lit cavern. The sound of dripping water echoes
> from deeper within. Suddenly, you hear a low growl..."

---

## Creatures/NPCs

### [Creature Name] (X appearing)
- **Stat Block:** [Reference to MM p.XX or custom stat block below]
- **HP:** [Average (dice)]
- **AC:** [Number]
- **Tactics:** [How they fight - aggressive, defensive, etc.]
- **Motivation:** [Why they're here, what they want]
- **Morale:** [When they flee or surrender]

**Custom Stat Block:**
```
SHADOW DRAKE
Medium dragon, neutral evil

Armor Class 15 (natural armor)
Hit Points 52 (8d8 + 16)
Speed 30 ft., fly 60 ft.

STR 16 (+3)  DEX 14 (+2)  CON 14 (+2)
INT 8 (-1)   WIS 12 (+1)  CHA 10 (+0)

Skills Stealth +4, Perception +3
Damage Resistances cold
Senses darkvision 60 ft., passive Perception 13
Languages Draconic
Challenge 3 (700 XP)

Shadow Blend. In dim light or darkness, the shadow drake has
advantage on Stealth checks.

ACTIONS

Multiattack. The drake makes two attacks: one with its bite
and one with its claws.

Bite. Melee Weapon Attack: +5 to hit, reach 5 ft., one target.
Hit: 8 (1d10 + 3) piercing damage.

Claws. Melee Weapon Attack: +5 to hit, reach 5 ft., one target.
Hit: 6 (1d6 + 3) slashing damage.

Shadow Breath (Recharge 5-6). The drake exhales shadowy energy
in a 15-foot cone. Each creature in that area must make a DC 12
Dexterity saving throw, taking 14 (4d6) necrotic damage on a
failed save, or half as much on a successful one.
```

---

## Map

**Map Reference:** [Link to map file or description]

**Terrain Features:**
- [Rock formations, pillars, water, etc.]
- [Cover options]
- [Hazards]

**Grid Size:** [30x30 squares, each 5ft]

**Key Locations:**
- A: Entrance (10ft wide tunnel)
- B: Central chamber (40ft diameter, 20ft high ceiling)
- C: Drake's nest (difficult terrain, bones scattered)
- D: Hidden alcove (DC 15 Perception check to notice)

---

## Encounter Flow

### Round 1-2: Surprise/Initiative
- Drakes are initially hidden (Stealth +4)
- Players who succeed DC 14 Perception check notice drakes
- Roll initiative

### Round 3-5: Combat Escalation
- Drakes use hit-and-run tactics
- Fly up, use breath weapon, retreat
- If bloodied (26 HP remaining), use lair action

### Round 6+: Resolution
- If alpha drake dies, others attempt to flee
- If reduced to 1/4 HP, drakes surrender (can be negotiated with)

---

## Treasure

**On Creatures:**
- 2d6 × 10 gp scattered among bones
- 1 gemstone (50 gp)

**In Nest (Hidden, DC 15 Investigation):**
- Potion of Healing
- Scroll of Misty Step
- [Magic item if level appropriate]

---

## Outcomes

**Victory:**
- Players gain treasure
- Clear path to next area
- XP: 700 × number of drakes defeated

**Retreat:**
- Can return later, drakes heal to half HP
- Drakes are now alert (no surprise possible)

**Negotiation:**
- Drakes reveal information about [plot hook]
- May become allies if players help them with [problem]

---

## Scaling

**For Lower Level Party (Level 2):**
- Reduce drakes to 2 instead of 3
- Remove Multiattack, reduce HP to 35

**For Higher Level Party (Level 5):**
- Increase drakes to 4
- Add Adult Shadow Drake (CR 5) as alpha
- Add environmental hazard (collapsing ceiling)

---

## DM Notes

**Roleplay Notes:**
- Drakes are intelligent but prideful
- Respond to Draconic language
- May bargain if overpowered

**Plot Hooks:**
- Drakes were driven here by [BBEG]
- Nest contains clue to [mystery]
- One drake has swallowed [plot item]

**Common Player Tactics:**
- Expect players to use cover
- Prepare for attempts to negotiate
- Watch for creative use of environment (cave-in, smoke them out)

**Backup Plans:**
- If TPK seems likely, drakes knock PCs unconscious and take captive
- If too easy, add reinforcements from deeper cave
```

**NPC Stat Block Template:**
```markdown
# NPC: [Name]

**Role:** [Quest Giver | Merchant | Ally | Villain | Neutral]
**Race:** [Human, Elf, etc.]
**Class:** [Fighter, Wizard, Commoner, etc.]
**Level:** [X]
**Alignment:** [Lawful Good, etc.]

---

## Basic Information

**Appearance:**
- Age: [X years]
- Height/Build: [Description]
- Distinguishing Features: [Scars, clothing, etc.]

**Personality:**
- Traits: [Nervous, confident, greedy, etc.]
- Ideals: [What they believe in]
- Bonds: [Who/what they care about]
- Flaws: [Weaknesses]

**Voice/Mannerisms:**
- [How to roleplay them - accent, speech patterns, gestures]

---

## Stat Block

**[Name]**
Medium humanoid (human), neutral good

**Armor Class** 12 (leather armor)
**Hit Points** 22 (4d8 + 4)
**Speed** 30 ft.

**STR** 10 (+0)  **DEX** 14 (+2)  **CON** 12 (+1)
**INT** 14 (+2)  **WIS** 13 (+1)  **CHA** 11 (+0)

**Skills** Insight +3, Persuasion +2
**Senses** passive Perception 11
**Languages** Common, Elvish
**Challenge** 1/2 (100 XP)

**Actions**

*Dagger.* Melee or Ranged Weapon Attack: +4 to hit, reach 5 ft. or range 20/60 ft., one target. Hit: 4 (1d4 + 2) piercing damage.

---

## Story Role

**Quest:** [What quest they give or are involved in]

**Information They Know:**
- [Key fact 1 - reveals willingly]
- [Key fact 2 - requires persuasion DC 12]
- [Secret - only reveals if trusted]

**Motivation:**
- **Wants:** [Surface-level goal]
- **Needs:** [Deep need players can help with]

**Can Provide:**
- Information about [topic]
- Item: [Specific item or service]
- Connection: [Knows important NPC or location]

---

## Dialogue

**First Meeting:**
> "Well met, travelers! You look like capable folk. I have a problem
> you might be able to help with..."

**When Hired:**
> "Excellent! I knew I could count on you. Let me tell you everything..."

**If Betrayed:**
> "You... you've ruined everything! I'll see you pay for this!"

---

## Relationships

- **Ally:** [NPC Name] - childhood friend
- **Enemy:** [Villain Name] - killed their sibling
- **Employer:** [Faction Name]

---

## DM Notes

**Roleplay Tips:**
- Nervous tick: taps fingers when lying
- Will betray party if offered 500+ gp
- Secretly working for [faction] (players don't know)

**Development:**
- If rescued: becomes loyal ally, provides info
- If ignored: joins villain's side
- If befriended: reveals secret about BBEG
```

**Prompt Support:**
- **Prompt 1 (Initialize):** Choose "D&D Adventure" or "D&D Campaign" mode
- **Prompt 2 (Add Chapter):** Becomes "Add Adventure" or "Add Encounter"
- **Prompt 3 (Modify):** Edit encounters, stat blocks, session notes
- **Prompt 6 (Consistency):** Check CR balance, treasure economy, plot hooks
- **Prompt 8 (Dashboard):** Show campaign progress, session count, XP totals
- **NEW Prompt 14 (Encounter Builder):** Create balanced encounters
- **NEW Prompt 15 (NPC Generator):** Generate NPCs with stat blocks

---

## Prompt Adaptations

### Prompt 1: Initialize Project

**Nonfiction Version:**
- Choose book title, author, target word count
- Select writing style
- Create initial chapter structure

**Fiction Version - New Questions:**

1. **Format Selection:**
   - [ ] Short Story (single file, 1K-15K words)
   - [ ] Standalone Novel (70K-120K words)
   - [ ] Series (multiple books)
   - [ ] D&D Adventure (single session, 3-5 hours)
   - [ ] D&D Campaign (multi-session, 10-100+ hours)
   - [ ] Anthology (collection of short stories)

2. **Genre Selection:**
   - [ ] Fantasy (High, Low, Urban, Dark)
   - [ ] Science Fiction (Hard, Soft, Space Opera, Cyberpunk)
   - [ ] Mystery/Thriller
   - [ ] Romance
   - [ ] Horror
   - [ ] Historical Fiction
   - [ ] Literary Fiction
   - [ ] Other: __________

3. **Story Structure:**
   - [ ] Three-Act Structure
   - [ ] Hero's Journey
   - [ ] Save the Cat
   - [ ] Seven-Point Story Structure
   - [ ] Custom

4. **POV Type:**
   - [ ] First Person (single character)
   - [ ] Third Person Limited (single character)
   - [ ] Third Person Limited (multiple POVs)
   - [ ] Third Person Omniscient
   - [ ] Second Person (rare)

5. **Organization Preference:**
   - [ ] Chapter-based (traditional)
   - [ ] Scene-based (granular)
   - [ ] Act-based (structural)
   - [ ] Part-based (for long novels)

6. **Series Settings (if applicable):**
   - Total books planned: [Number or "Ongoing"]
   - Shared world: [Yes/No]

**Creates:**
- Project structure based on format choice
- Character database starter files
- World-building templates
- Plot outline template
- Style guide adapted to genre
- Timeline file
- POV tracker

---

### Prompt 2: Add Chapter (Fiction: Add Scene/Act/Encounter)

**Nonfiction Version:**
- Add new chapter to book
- Renumber existing chapters
- Update TOC

**Fiction Adaptations:**

**For Novels/Short Stories:**
- **Option A:** Add Chapter
  - Insert chapter at position X
  - Renumber subsequent chapters
  - Create chapter file with scene breakdown template
  - Update plot outline
  - Update timeline

- **Option B:** Add Scene (within existing chapter)
  - Insert scene within chapter
  - Update scene numbering
  - Add to timeline
  - Link to character arcs

- **Option C:** Add Act (for act-based structure)
  - Create Act_X directory
  - Set up chapters within act
  - Update plot outline

**For D&D Adventures:**
- Add Encounter
  - Create encounter file with template
  - Add to adventure timeline
  - Update difficulty tracker
  - Link to map/handouts

**For Series:**
- Add Book
  - Create Book_XX directory
  - Copy shared World/ references
  - Create book-specific plot outline
  - Update series bible

**Questions Asked:**
1. What type are you adding? [Chapter | Scene | Act | Encounter | Book]
2. Title/Name?
3. Where does it go? [After chapter X, At end, etc.]
4. POV character? [If applicable]
5. Purpose? [Plot advancement, character development, etc.]

---

### Prompt 3: Modify File

**Nonfiction Version:**
- Read instructions from _chg file
- Apply modifications
- Archive to version history
- Commit to git

**Fiction Adaptations:**

**Additional Checks:**
- **Character Consistency:**
  - Check character descriptions against Character Database
  - Flag contradictions (eye color change, height discrepancy)

- **Plot Consistency:**
  - Verify events match timeline
  - Check cause-effect logic
  - Ensure plot threads are tracked

- **World Rules:**
  - Verify magic system compliance
  - Check technology level consistency
  - Flag geography contradictions

- **POV Consistency:**
  - Detect head-hopping
  - Verify POV character knowledge limits
  - Check for omniscient slips

**Workflow (Same as Nonfiction):**
1. Read [filename]_chg.md instructions
2. Apply modifications to content file
3. **NEW:** Run fiction-specific consistency checks
4. Update character database if character details changed
5. Update timeline if events modified
6. Archive instructions to Version History
7. Update _chg file with new version
8. Provide git commit command

---

### Prompt 4: Integrate Inbox

**Same as nonfiction**, but with fiction-specific targets:
- Integrate research notes into World/
- Integrate character ideas into Characters/
- Integrate plot ideas into Planning/Plot_Outline.md
- Integrate scene snippets into appropriate chapters

---

### Prompt 5: Compile Manuscript

**Same as nonfiction:**
- Read all chapters in order
- Combine into single manuscript file
- Generate in `Drafts/Full_Draft_[date]_v[version].md`

**Fiction Additions:**
- Include chapter summaries at end (for revision reference)
- Generate word count statistics by chapter/act
- Optionally insert scene breaks
- For series: Compile specific book

---

### Prompt 6: Consistency Checker

**Nonfiction Version:**
- Style consistency
- Cross-reference validation
- Placeholder detection
- Quote verification

**Fiction Additions:**

**Character Consistency:**
- Physical descriptions (eye color, height, age)
- Personality traits (behavior matches character sheet)
- Name spelling variations
- Character knowledge (doesn't know things they shouldn't)
- Character location (can't be in two places at once)

**Plot Consistency:**
- Timeline logic (events in correct order)
- Cause-effect sequences (results match causes)
- Plot thread tracking (all threads resolved or intentionally left open)
- Foreshadowing payoffs (planted elements have payoff)

**World Consistency:**
- Magic system rules (all magic follows established rules)
- Technology level (no anachronisms)
- Geography (locations match map, travel times realistic)
- Social structures (customs consistent)
- Historical events (backstory doesn't contradict)

**POV Consistency:**
- No head-hopping within scenes
- Knowledge limited to POV character
- Sensory details match POV character's perception
- Internal thoughts only from POV character

**Pacing Analysis:**
- Scene length distribution
- Action vs. introspection balance
- Dialogue vs. narrative balance
- Chapter ending strength (hooks, cliffhangers)

**Continuity (for Series):**
- Character descriptions match across books
- World rules consistent across books
- Timeline accurate across series
- Plot threads from previous books addressed

**Report Format:**
```markdown
# Consistency Check Report - [Story Title]

**Generated:** [Date]
**Scope:** [Chapter X-Y | Full Manuscript | Book X]

---

## CRITICAL ISSUES (Must Fix)

### Character Consistency Errors
- Chapter 5: Alex's eyes described as "brown" but Character Database says "blue"
- Chapter 12: Sarah knows about the prophecy, but wasn't present when revealed (Ch. 8)

### Plot Logic Errors
- Chapter 7: Event A happens on Day 3, but Chapter 9 says it happened on Day 5
- Chapter 15: Sword was destroyed in Chapter 10, but appears again here

### World Rule Violations
- Chapter 14: Magic used without sacrifice (violates established rule from Ch. 2)

---

## WARNINGS (Should Review)

### POV Slips
- Chapter 3, Line 450: Omniscient narrator reveals villain's thoughts during Alex's POV

### Pacing Concerns
- Chapters 8-10: Three consecutive slow chapters (introspection heavy, low action)

---

## SUGGESTIONS (Optional Improvements)

### Foreshadowing
- Chapter 5 plants mysterious symbol, no payoff yet (verify payoff planned)

### Character Development
- Protagonist has no growth arc in Act II (Chapters 10-15)

---

## STATISTICS

**Word Count:** 78,500
**Chapters:** 25
**Scenes:** 87
**Average Chapter Length:** 3,140 words

**POV Distribution:**
- Alex: 65% (target: 60-70%) ✓
- Sarah: 35% (target: 30-40%) ✓

**Pacing Distribution:**
- Fast: 40%
- Medium: 35%
- Slow: 25%

**All Issues Found:** 12
- Critical: 4
- Warning: 3
- Suggestion: 5
```

---

### Prompt 7: Export and Format

**Same as nonfiction:**
- Export to DOCX, PDF, EPUB, LaTeX
- Format for submission/publication
- Clean up markdown for print

**Fiction Additions:**
- Optionally remove scene breaks for publication
- Format dialogue according to genre standards
- Generate cover page with genre-appropriate formatting
- For series: Compile specific book or entire series

---

### Prompt 8: Progress Dashboard

**Nonfiction Version:**
- Word count progress
- Chapter completion status
- Consistency issues
- Next recommendations

**Fiction Additions:**

**Metrics:**
- Word count by chapter/act
- Scene completion status
- Character arc progress
- Plot thread status (open, developing, resolved)
- Pacing distribution chart
- POV balance chart

**Story Health:**
- Consistency issues count
- Unresolved plot threads
- Character arcs completion %
- Timeline coverage

**Series Dashboard (if applicable):**
- Books completed
- Overall series word count
- Cross-book continuity issues

**Example Dashboard:**
```markdown
# Fiction Project Dashboard: [Title]

**Generated:** [Date]
**Format:** Standalone Novel
**Genre:** Fantasy

---

## OVERVIEW

**Overall Progress:** 65% (78,500 / 120,000 words)

**Status:** Draft - Act II complete, Act III in progress

**Target Completion:** [User-set date or "No deadline"]

---

## WORD COUNT PROGRESS

Current: 78,500 words
Target: 120,000 words
Remaining: 41,500 words (35%)

Progress: [████████░░] 65%

**By Act:**
- Act I: 30,000 / 30,000 (100%) ✓
- Act II: 48,500 / 60,000 (81%)
- Act III: 0 / 30,000 (0%)

---

## CHAPTER STATUS

Total Chapters: 25 (target: 40)
Completed: 20
In Progress: 5
Not Started: 15

**Recent Activity:**
- Chapter 20: Completed [Date]
- Chapter 21: In progress (v0.3.0, 60% complete)
- Chapter 22: Drafted (needs revision)

---

## CHARACTER ARC PROGRESS

**Protagonist (Alex):**
- Arc Progress: 60% (Act II complete)
- Status: On track
- Next Milestone: Face inner demon (Act III)

**Antagonist (Villain):**
- Arc Progress: 70%
- Status: Ahead of schedule
- Next Milestone: Reveal true plan (Chapter 30)

**Supporting (Mentor):**
- Arc Progress: 100% ✓
- Status: Complete (died Chapter 18)

---

## PLOT THREAD STATUS

**Open Threads:** 5
1. Ancient prophecy (introduced Ch. 3, developing)
2. Mysterious artifact (introduced Ch. 12, unresolved)
3. Romance subplot (introduced Ch. 7, developing)
4. Political intrigue (introduced Ch. 15, developing)
5. Hidden betrayal (planted Ch. 5, no payoff yet)

**Resolved Threads:** 8
- Training arc ✓ (Ch. 1-10)
- Mentor relationship ✓ (Ch. 1-18)
[etc.]

---

## CONSISTENCY HEALTH

**Critical Issues:** 2 ⚠️
**Warnings:** 5
**Suggestions:** 8

**Latest Check:** [Date]
**Action Needed:** Run Prompt 6 (Consistency Checker)

---

## PACING ANALYSIS

**Fast Chapters:** 10 (40%)
**Medium Chapters:** 9 (35%)
**Slow Chapters:** 6 (25%)

**Balance:** Good ✓

**Longest Chapter:** Chapter 15 (5,200 words)
**Shortest Chapter:** Chapter 8 (1,800 words)

---

## POV DISTRIBUTION

**Alex:** 51,000 words (65%) - Target: 60-70% ✓
**Sarah:** 27,500 words (35%) - Target: 30-40% ✓

**Balance:** On target ✓

---

## TIMELINE COVERAGE

**Story Timespan:** 6 months
**Chapters per Month:** ~3-4
**Largest Gap:** 2 weeks (between Ch. 10-11)

**Timeline Status:** Complete ✓

---

## WORLD-BUILDING STATUS

**Character Database:** 47 characters defined
**Locations:** 12 major locations
**World Rules:** Magic system defined ✓
**History:** Timeline established ✓

**Completeness:** 85%

---

## NEXT STEPS

**Recommended Actions:**
1. Fix 2 critical consistency issues (Run Prompt 6)
2. Complete Chapter 21 (Run Prompt 3)
3. Plan Act III chapters (Update plot outline)
4. Write Chapters 26-30 (5 chapters, ~12,500 words)

**Estimated Time to Completion:** 4-6 weeks (at current pace)

---

## MILESTONES

◯ 25% - Complete (Chapter 10)
◯ 50% - Complete (Chapter 20)
◯ 75% - Not Reached (Chapter 30, ~90,000 words)
◯ 100% - Not Reached (Chapter 40, ~120,000 words)

---

## RECENT COMMITS

- [Date]: "Complete Chapter 20 - Alex faces betrayal v1.8.0"
- [Date]: "Add Sarah's backstory reveal to Chapter 19 v1.7.0"
- [Date]: "Fix timeline error in Chapter 15 v1.6.1"

**Last Commit:** [X] days ago
```

---

### Prompt 9: Git Operations

**Same as nonfiction:**
- Commit, tag, branch, view history
- Push/pull to remote
- Status checks

**No fiction-specific changes needed** - Git operations are universal.

---

### Prompt 10: Update Change Tracking

**Same as nonfiction:**
- Sync _chg files with manual edits
- Reconstruct version history from git diffs
- Update _chg files for all modified files

**Fiction Additions:**
- Update character database _chg files
- Update world-building _chg files
- Update timeline _chg if events modified

---

### NEW Prompt 11: Character Manager

**Purpose:** Manage character database (add, modify, view characters).

**Questions:**
1. What would you like to do?
   - [ ] Add new character
   - [ ] Modify existing character
   - [ ] View character details
   - [ ] Check character consistency
   - [ ] Generate character relationships map

2. If adding: Character name?
3. Character role? [Main | Supporting | Minor | Antagonist]
4. Should I create from template or import from notes?

**Workflow:**
1. Create/read character file: `World/Characters/[Name].md`
2. Create _chg file: `World/Characters/[Name]_chg.md`
3. Update Character_Database.md index
4. If modifying: track changes in _chg file
5. Run consistency check against manuscript
6. Commit changes

---

### NEW Prompt 12: World Builder

**Purpose:** Manage world-building database (geography, magic, history, cultures).

**Questions:**
1. What aspect of the world are you working on?
   - [ ] Geography (locations, maps)
   - [ ] Magic System (rules, limitations)
   - [ ] History (timeline, events)
   - [ ] Cultures (societies, customs)
   - [ ] Technology (tools, weapons)
   - [ ] Organizations (guilds, factions)

2. Action?
   - [ ] Add new element
   - [ ] Modify existing element
   - [ ] View world bible
   - [ ] Check world consistency

**Workflow:**
1. Update appropriate world file
2. Update World_Bible.md
3. Create _chg entry
4. Run consistency check (ensure no contradictions)
5. Commit changes

---

### NEW Prompt 13: Timeline Manager

**Purpose:** Manage story timeline and chronology.

**Questions:**
1. What would you like to do?
   - [ ] Add event to timeline
   - [ ] View timeline
   - [ ] Check timeline consistency
   - [ ] Generate day-by-day breakdown

2. If adding event:
   - Event description?
   - Date/time?
   - Which chapter/scene?
   - Characters involved?

**Workflow:**
1. Update Planning/Timeline.md
2. Cross-reference with chapters
3. Check for timeline conflicts
4. Update character ages if needed
5. Verify travel times
6. Commit changes

---

### NEW Prompt 14: Encounter Builder (D&D Only)

**Purpose:** Create balanced D&D encounters with stat blocks.

**Questions:**
1. Encounter type? [Combat | Social | Exploration | Puzzle]
2. Party level? [X]
3. Party size? [Y players]
4. Desired difficulty? [Easy | Medium | Hard | Deadly]
5. Environment? [Dungeon, Forest, City, etc.]

**Workflow:**
1. Calculate encounter XP budget
2. Suggest creatures from MM or custom
3. Create encounter file with full template
4. Add terrain and tactics
5. Balance treasure for level
6. Link to adventure structure
7. Commit changes

---

### NEW Prompt 15: NPC Generator (D&D Only)

**Purpose:** Generate NPCs with stat blocks and personality.

**Questions:**
1. NPC role? [Quest Giver | Merchant | Ally | Villain | Neutral]
2. Importance? [Major | Minor]
3. Race/Class?
4. Level/CR?

**Workflow:**
1. Generate stat block
2. Create personality traits
3. Assign motivations and secrets
4. Link to relevant quests
5. Add to NPC database
6. Commit changes

---

## Shared vs. Unique Components

### Components to REUSE from Nonfiction (Unchanged or Minor Tweaks)

**From Process/_COMMON/:**
- ✅ `01_Prompt_Structure_Template.md` - Same prompt structure works
- ✅ `02_Desktop_Compatibility_Module.md` - Same compatibility model
- ✅ `05_Git_Integration_Module.md` - Git operations identical
- ✅ `06_Validation_Protocols.md` - Same validation concepts
- ✅ `08_Semantic_Versioning_Guide.md` - Same versioning rules
- ✅ `09_Report_Templates.md` - Adapt for fiction metrics
- ✅ `11_Interactive_Patterns.md` - Same question/answer patterns
- ✅ `12_Workflow_Patterns.md` - Same workflow sequences
- ✅ `14_Enforcement_Rules_Module.md` - Same enforcement rules (file mods → _chg updates)

**Prompts to Reuse:**
- ✅ Prompt 4 (Integrate Inbox) - Same concept
- ✅ Prompt 5 (Compile) - Same operation
- ✅ Prompt 7 (Export) - Same export formats
- ✅ Prompt 9 (Git) - Same git operations
- ✅ Prompt 10 (Update Tracking) - Same change tracking

### Components to ADAPT from Nonfiction

- 🔄 `03_Anti_Hallucination_Protocols.md` → Fiction-specific anti-hallucination rules
- 🔄 `04_File_Operations_Library.md` → Add character/world file operations
- 🔄 `13_PROJECT_CONTEXT_Protocol.md` → Fiction project context template
- 🔄 Prompt 1 (Initialize) → Fiction-specific questions and structure
- 🔄 Prompt 2 (Add Chapter) → Add Scene/Act/Encounter/Book options
- 🔄 Prompt 3 (Modify) → Add fiction consistency checks
- 🔄 Prompt 6 (Consistency) → Complete rewrite for fiction checks
- 🔄 Prompt 8 (Dashboard) → Fiction-specific metrics

### Components UNIQUE to Fiction (New Development)

**New Modules in Process/_FICTION_COMMON/:**
- ❌ `01_Character_Management_System.md`
- ❌ `02_Plot_Structure_Templates.md`
- ❌ `03_World_Building_Protocol.md`
- ❌ `04_Timeline_Management.md`
- ❌ `05_POV_Tracking_System.md`
- ❌ `06_Scene_Beat_Structure.md`
- ❌ `07_Series_Continuity_Protocol.md`
- ❌ `08_DnD_Adventure_Design.md`

**New Prompts:**
- ❌ Prompt 11 (Character Manager)
- ❌ Prompt 12 (World Builder)
- ❌ Prompt 13 (Timeline Manager)
- ❌ Prompt 14 (Encounter Builder) - D&D only
- ❌ Prompt 15 (NPC Generator) - D&D only

**New Templates:**
- ❌ Character_Sheet_Template.md
- ❌ World_Building_Template.md
- ❌ Plot_Outline_Template.md
- ❌ Scene_Template.md
- ❌ DnD_Encounter_Template.md
- ❌ NP C_Stat_Block_Template.md

---

## Anti-Hallucination for Fiction

### The Challenge

Fiction writing involves creating fabricated content (characters, events, worlds). Traditional anti-hallucination rules prevent fabrication. **How do we balance creative generation with consistency verification?**

### Proposed Solution: Hybrid Approach (Option C from Question 5)

**Three-Tier Anti-Hallucination System:**

#### Tier 1: Creative Generation (AI Can Freely Generate)
**Applies to:** Minor details, descriptions, dialogue, prose

**Examples:**
- ✅ AI can describe room furnishings
- ✅ AI can generate dialogue for established characters
- ✅ AI can create sensory details (sounds, smells, textures)
- ✅ AI can craft descriptive prose

**Rule:** AI may generate creative details freely as long as they don't:
- Contradict established facts
- Introduce new major elements
- Make character decisions

#### Tier 2: Creative Choice Verification (AI Must ASK)
**Applies to:** Major plot decisions, character choices, world-building rules

**Examples:**
- ❌ AI cannot decide: "Should protagonist accept the quest?"
- ❌ AI cannot decide: "Does the magic system allow resurrection?"
- ❌ AI cannot decide: "Is character X secretly a traitor?"
- ❌ AI cannot decide: "Should this chapter end with a cliffhanger or resolution?"

**Rule:** AI must present options and ask user to choose:
```
I'm writing the scene where Alex discovers the letter. How should Alex react?

Option A: Accept the quest immediately (eager, impulsive)
Option B: Refuse initially, then reluctantly accept (hesitant arc)
Option C: Reject entirely (different story direction)
Option D: Other (please describe)

Your choice: _____
```

#### Tier 3: Consistency Verification (AI Must VERIFY)
**Applies to:** All content against established story elements

**Examples:**
- ✅ AI checks: "Character database says eyes are blue, I wrote them as brown → FLAG ERROR"
- ✅ AI checks: "Magic system requires sacrifice, this spell has none → FLAG VIOLATION"
- ✅ AI checks: "Timeline shows character is 25, I wrote 'when I was 30' → FLAG AGE ERROR"
- ✅ AI checks: "POV is Alex's third-person limited, I wrote Sarah's thoughts → FLAG POV SLIP"

**Rule:** AI must verify all generated content against:
- Character database
- World bible
- Timeline
- Plot outline
- POV rules
- Established facts

### Implementation in Prompts

**Prompt 3 (Modify File) Workflow:**
```
1. Read instructions from _chg file
2. Generate content (Tier 1: freely create details)
3. PAUSE: If major choice needed (Tier 2: ask user)
4. Apply modifications
5. VERIFY: Check consistency (Tier 3: validate against databases)
6. If errors found: Report to user, offer fixes
7. Archive and commit
```

**Example Interaction:**
```
User writes in Chapter_05_chg.md:
---
[INSTRUCTIONS FOR THIS REVISION]
Alex enters the tavern and meets the mysterious stranger who will
become their mentor. Add dialogue where they discuss the quest.
---

AI executes Prompt 3:

Step 1: Read instructions ✓
Step 2: Generate tavern description (Tier 1 - free generation)
Step 3: PAUSE for major choice (Tier 2 - ask user):

"I'm writing the dialogue where the mentor offers the quest.
What tone should the mentor take?

A) Cryptic and mysterious (hints at quest, doesn't explain)
B) Direct and urgent (clearly states quest and stakes)
C) Testing Alex (challenges them before revealing quest)
D) Other (please describe)

Your choice: _____"

[User chooses B]

Step 4: Generate dialogue with direct, urgent tone
Step 5: VERIFY consistency (Tier 3):
  - Check: Mentor's personality in Character DB → "wise, urgent" ✓
  - Check: Mentor's speech patterns → "formal, educated" ✓
  - Check: Quest details match Plot Outline → ✓
  - Check: POV is Alex (shouldn't reveal mentor's hidden thoughts) ✓

Step 6: All checks pass ✓
Step 7: Apply modifications, archive instructions, commit
```

### Anti-Hallucination Guidelines for Fiction

**Modified from Nonfiction:**

**ASK FIRST - Don't Assume (Tier 2):**
- ✅ **DO ASK** before making major plot decisions
- ✅ **DO ASK** before introducing new world rules
- ✅ **DO ASK** before making character choices that affect arc
- ✅ **DO ASK** before changing established facts

**VERIFY ALWAYS - Check Consistency (Tier 3):**
- ✅ **ALWAYS VERIFY** against character database
- ✅ **ALWAYS VERIFY** against world bible
- ✅ **ALWAYS VERIFY** against timeline
- ✅ **ALWAYS VERIFY** against plot outline
- ✅ **ALWAYS VERIFY** POV consistency

**CREATE FREELY - Within Bounds (Tier 1):**
- ✅ **CAN CREATE** descriptive details (room furnishings, weather, etc.)
- ✅ **CAN CREATE** dialogue matching character voice
- ✅ **CAN CREATE** minor characters (background NPCs)
- ✅ **CAN CREATE** sensory details enhancing scenes

**FORBIDDEN - Never Do:**
- ❌ **NEVER** contradict established character facts
- ❌ **NEVER** violate world rules without asking
- ❌ **NEVER** create timeline contradictions
- ❌ **NEVER** make major plot decisions without user input
- ❌ **NEVER** change POV without authorization
- ❌ **NEVER** assume user's creative intent

**Label System:**
- **[USER DECISION NEEDED]** - Major choice point
- **[CONSISTENCY WARNING]** - Potential contradiction detected
- **[VERIFICATION PASSED]** - Content verified against databases
- **[CREATIVE GENERATION]** - AI-generated minor details

---

## Technical Challenges

### Challenge 1: Character Database Consistency Checking

**Problem:** How does AI verify character consistency across potentially 100+ chapters?

**Solution:**
- Maintain Character_Database.md with searchable facts
- Each character has dedicated sheet: `Characters/[Name].md`
- Prompt 6 (Consistency) regex searches for character name in manuscript
- Extract all descriptions/mentions
- Compare against character sheet
- Flag discrepancies

**Example Check:**
```
Searching for "Alex" in all chapters...
Found 342 mentions.

Extracting physical descriptions...
- Chapter 1, Line 45: "blue eyes"
- Chapter 5, Line 230: "piercing blue gaze"
- Chapter 12, Line 567: "brown eyes" ❌ MISMATCH

Character Database: Alex - Eyes: blue

CRITICAL ERROR: Chapter 12 describes Alex with brown eyes,
contradicts database. Fix required.
```

### Challenge 2: Timeline Validation

**Problem:** How to track events across non-linear narratives and flashbacks?

**Solution:**
- Maintain master timeline in chronological order
- Tag each chapter/scene with timeline position
- Validate:
  - Character ages match dates
  - Travel times are realistic
  - Cause-effect sequences preserved
  - No character in two places at once

**Example Check:**
```
Timeline Verification:
Day 3, 10am: Alex in Capital (Chapter 8)
Day 3, 11am: Alex in Forest (Chapter 9)

ERROR: Travel time Capital → Forest is 4 hours on horse.
Alex cannot be in Forest at 11am. Minimum arrival: 2pm.

Suggested fix:
- Change Forest scene to "late afternoon" or
- Adjust departure time from Capital
```

### Challenge 3: World Rule Enforcement

**Problem:** Magic systems and world rules must be consistently applied.

**Solution:**
- Define rules explicitly in World_Bible.md
- Tag all magic use in manuscript
- Validate each use against rules
- Require explicit justification for exceptions

**Example Check:**
```
Scanning for magic use...

Chapter 5, Line 234: Alex casts fireball
- Rule Check: Magic requires sacrifice ✓
- Sacrifice mentioned: "blood from his palm" ✓
- PASS

Chapter 14, Line 678: Sarah casts healing spell
- Rule Check: Magic requires sacrifice ✓
- Sacrifice mentioned: NONE ❌
- FAIL

CRITICAL ERROR: Chapter 14 shows magic without sacrifice.
This violates World_Bible.md rule established in Chapter 2.

Fix required:
- Add sacrifice to scene, or
- Explicitly explain why no sacrifice needed (document exception)
```

### Challenge 4: POV Head-Hopping Detection

**Problem:** Detecting when narrative slips into another character's perspective.

**Solution:**
- Tag each scene with POV character
- Scan for thought attribution
- Flag sentences revealing non-POV thoughts
- Use keyword detection: "he thought", "she wondered", internal monologue

**Example Check:**
```
Chapter 7, POV: Alex (third person limited)

Line 345: "Alex watched the stranger across the room." ✓
Line 346: "Something felt wrong about him." ✓ (Alex's feeling)
Line 347: "The stranger hoped Alex wouldn't recognize him." ❌

WARNING: POV SLIP - Line 347 reveals stranger's thoughts,
but POV is Alex's limited perspective. Alex cannot know
what stranger is thinking.

Fix:
- Remove internal thought, or
- Show stranger's thought through action/dialogue, or
- Switch to omniscient POV (requires changing entire chapter)
```

### Challenge 5: Series-Wide Continuity

**Problem:** Tracking details across multiple books (trilogy, endless series).

**Solution:**
- Shared `World/` directory for all books
- Series_Bible.md tracks cross-book elements
- Prompt 6 can check current book against previous books
- Maintain character ages, world events across timeline

**Example Check:**
```
Checking Book 2 against Book 1...

Character: Alex
- Book 1 (End): Age 26, brown hair, scar on right hand
- Book 2 (Start): Age 27 ✓, brown hair ✓, scar on LEFT hand ❌

CRITICAL ERROR: Scar location changed.
Book 1, Chapter 20: "scar on his right hand"
Book 2, Chapter 1: "scar on his left hand"

Fix required.
```

### Challenge 6: Pacing and Structure Analysis

**Problem:** How to measure pacing and detect structural issues?

**Solution:**
- Track word count per chapter/scene
- Categorize pacing: Fast (action), Medium (balanced), Slow (introspective)
- Analyze distribution
- Flag issues: Too many slow chapters in row, unbalanced acts

**Example Check:**
```
Pacing Analysis:

Act I (Chapters 1-10):
- Fast: 4 chapters (40%)
- Medium: 5 chapters (50%)
- Slow: 1 chapter (10%)
- Assessment: Good balance ✓

Act II (Chapters 11-25):
- Fast: 3 chapters (20%)
- Medium: 4 chapters (27%)
- Slow: 8 chapters (53%)
- Assessment: Too slow ⚠️

WARNING: Act II has 53% slow chapters.
Chapters 18-22 are 5 consecutive slow chapters.
Recommendation: Add action/tension in Chapter 20 or 21.
```

### Challenge 7: D&D Encounter Balancing

**Problem:** Ensuring D&D encounters are appropriately challenging.

**Solution:**
- Implement CR (Challenge Rating) calculation
- XP budget based on party level and size
- Validate encounter difficulty
- Suggest adjustments

**Example Check:**
```
Encounter: Forest Ambush
Party: 4 level 5 characters
Difficulty Target: Medium

Creatures:
- 3 Hobgoblins (CR 1/2 each) = 300 XP
- 1 Hobgoblin Captain (CR 3) = 700 XP
Total XP: 1,000

Adjusted XP (for 4 creatures): 1,000 × 2 = 2,000

Medium Encounter Budget for 4 level 5 PCs: 2,000 XP

Assessment: Perfect match ✓

Recommendation: Encounter is appropriately balanced for Medium difficulty.
```

---

## Implementation Phases

### Phase 0: User Decisions (AWAITING INPUT)

**Duration:** Until user answers clarifying questions

**Deliverables:**
- User completes Question 1-7
- Architect approves final approach
- Scope locked

---

### Phase 1: Foundation & Architecture

**Duration:** 2-3 weeks

**Tasks:**
1. **Decision:** Separate framework vs. unified mode (Question 2)
2. **Create directory structure** (based on chosen architecture)
3. **Port reusable modules** from nonfiction Process/_COMMON/
4. **Create fiction-specific templates:**
   - Character_Sheet_Template.md
   - World_Building_Template.md
   - Plot_Outline_Template.md
   - Scene_Template.md

**Deliverables:**
- Complete directory structure
- All templates ready
- Reusable modules ported

---

### Phase 2: Core Fiction Modules

**Duration:** 3-4 weeks

**Tasks:**
1. **Create Fiction-Specific Modules:**
   - 01_Character_Management_System.md
   - 02_Plot_Structure_Templates.md
   - 03_World_Building_Protocol.md
   - 04_Timeline_Management.md
   - 05_POV_Tracking_System.md
   - 06_Scene_Beat_Structure.md

2. **Adapt Anti-Hallucination Guidelines** (Tier 1/2/3 system)

**Deliverables:**
- 6 core fiction modules
- Fiction anti-hallucination guidelines

---

### Phase 3: Adapt Existing Prompts

**Duration:** 4-5 weeks

**Tasks:**
1. **Adapt Prompt 1 (Initialize):**
   - Fiction format selection
   - Genre selection
   - POV selection
   - Structure choice
   - Create character/world databases

2. **Adapt Prompt 2 (Add Chapter):**
   - Add Scene option
   - Add Act option
   - Add Book option (for series)

3. **Adapt Prompt 3 (Modify):**
   - Add character consistency checks
   - Add timeline validation
   - Add world rule checks
   - Add POV verification

4. **Completely Rewrite Prompt 6 (Consistency):**
   - Character consistency checker
   - Plot logic validator
   - World rule enforcer
   - POV slip detector
   - Pacing analyzer
   - Series continuity checker

5. **Adapt Prompt 8 (Dashboard):**
   - Fiction-specific metrics
   - Character arc progress
   - Plot thread status
   - POV balance
   - Pacing distribution

**Deliverables:**
- 5 adapted prompts (1, 2, 3, 6, 8)
- All fiction checks implemented

---

### Phase 4: New Fiction Prompts

**Duration:** 3-4 weeks

**Tasks:**
1. **Create Prompt 11 (Character Manager):**
   - Add/modify characters
   - Check character consistency
   - Generate character relationships

2. **Create Prompt 12 (World Builder):**
   - Add/modify world elements
   - Check world consistency
   - View world bible

3. **Create Prompt 13 (Timeline Manager):**
   - Add events
   - Check chronology
   - Validate timeline logic

**Deliverables:**
- 3 new fiction prompts (11, 12, 13)

---

### Phase 5: D&D Support (Optional - Skip if Not Priority)

**Duration:** 2-3 weeks

**Tasks:**
1. **Create D&D-Specific Modules:**
   - 08_DnD_Adventure_Design.md
   - DnD_Encounter_Template.md
   - NPC_Stat_Block_Template.md

2. **Create Prompt 14 (Encounter Builder):**
   - CR calculation
   - Encounter balancing
   - Stat block generation

3. **Create Prompt 15 (NPC Generator):**
   - Stat block creation
   - Personality generation
   - Quest integration

**Deliverables:**
- D&D module
- 2 D&D prompts (14, 15)
- D&D templates

---

### Phase 6: Series Support (Optional - Skip if Not Priority)

**Duration:** 2-3 weeks

**Tasks:**
1. **Create Series Module:**
   - 07_Series_Continuity_Protocol.md
   - Series_Bible_Template.md

2. **Adapt Prompt 2:** Add "Add Book" option
3. **Extend Prompt 6:** Cross-book consistency checks

**Deliverables:**
- Series module
- Series templates
- Multi-book support

---

### Phase 7: Testing & Documentation

**Duration:** 2-3 weeks

**Tasks:**
1. **Create comprehensive README** (Fiction version of CLAUDE.md)
2. **Create INSTALLATION.md** (fiction-specific)
3. **Create CHANGELOG.md**
4. **Test all prompts end-to-end:**
   - Standalone novel workflow
   - Short story workflow
   - Series workflow (if implemented)
   - D&D adventure workflow (if implemented)

5. **Create style examples** (Fiction genres: Literary, Fantasy, Sci-Fi, Mystery, etc.)

**Deliverables:**
- Complete documentation
- Tested workflows
- Style guide for fiction

---

### Phase 8: Release

**Duration:** 1 week

**Tasks:**
1. Create GitHub repository
2. Set up GitHub Actions for releases
3. Create v0.1.0 release
4. Publish release notes
5. Create user onboarding guide

**Deliverables:**
- Fiction Framework v0.1.0 released
- Public repository
- User documentation

---

## Estimated Effort

### Time Estimates by Phase

| Phase | Duration | Dependency |
|-------|----------|------------|
| Phase 0: User Decisions | Until complete | None |
| Phase 1: Foundation | 2-3 weeks | After Phase 0 |
| Phase 2: Core Modules | 3-4 weeks | After Phase 1 |
| Phase 3: Adapt Prompts | 4-5 weeks | After Phase 2 |
| Phase 4: New Prompts | 3-4 weeks | After Phase 3 |
| Phase 5: D&D (Optional) | 2-3 weeks | After Phase 4 |
| Phase 6: Series (Optional) | 2-3 weeks | After Phase 4 |
| Phase 7: Testing | 2-3 weeks | After all dev phases |
| Phase 8: Release | 1 week | After Phase 7 |

### Total Effort Estimates

**Minimum (Core Features Only):**
- Phases 1-4, 7-8: **17-22 weeks** (4-5 months)
- Supports: Standalone novels, short stories, basic series

**Medium (Core + D&D):**
- Phases 1-5, 7-8: **19-25 weeks** (5-6 months)
- Supports: Novels, short stories, D&D adventures/campaigns

**Maximum (All Features):**
- Phases 1-8 (all): **21-28 weeks** (5-7 months)
- Supports: Everything (novels, series, D&D, short stories, anthologies)

---

## Migration Strategy

### For Users of Nonfiction Framework

**Scenario:** User has a nonfiction book project, wants to start a fiction project.

**If Separate Framework (Option A):**
1. Download fiction framework zip
2. Extract to new directory (separate from nonfiction project)
3. Run configure.md
4. Execute Prompt 1 (Initialize) for fiction project
5. No migration needed - separate projects

**If Unified Framework (Option B):**
1. Update framework to version with fiction mode
2. Existing nonfiction projects: Automatically detected as "Nonfiction Mode"
3. New projects: Choose mode during Prompt 1

### For Authors Starting New Fiction Project

**Steps:**
1. Download fiction framework (or unified framework)
2. Extract to project directory
3. Run configure.md
4. Execute Prompt 1 (Initialize)
5. Answer format/genre/POV questions
6. Framework creates appropriate structure
7. Begin writing

---

## Success Metrics

### Quantitative Metrics

**v0.1.0 Release:**
- ✅ All core prompts (1-10) adapted for fiction
- ✅ 3 new fiction prompts (11-13) functional
- ✅ Character database working
- ✅ World-building database working
- ✅ Timeline tracking working
- ✅ Consistency checker catches 90%+ common errors
- ✅ Support standalone novels (70K-120K words)
- ✅ Support short stories (1K-15K words)
- ✅ Zero regressions from nonfiction (shared code works in both)

**Optional Metrics (if included):**
- ✅ D&D encounter builder balances encounters correctly
- ✅ Series support tracks continuity across 3+ books

### Qualitative Metrics

- ✅ Fiction authors can use framework without confusion
- ✅ Character consistency is maintained automatically
- ✅ Timeline validation prevents logical errors
- ✅ POV tracking prevents head-hopping
- ✅ Documentation is comprehensive and clear
- ✅ Anti-hallucination system balances creativity and consistency

---

## Open Questions for User

### CRITICAL DECISIONS NEEDED:

1. **Architecture Choice (Question 2):**
   - [ ] Separate fiction framework (recommended)
   - [ ] Unified framework with mode selection
   - [ ] Clone and fork

   **My recommendation:** Separate framework
   **Reason:** Simpler for users, cleaner codebase, easier to maintain

2. **Feature Priorities (Question 3):**
   - Which features are MUST-HAVE for v0.1.0?
   - Which can wait for v0.2.0+?

   **My recommendation for v0.1.0 MUST-HAVE:**
   - Character tracking
   - Plot structure management
   - World-building database
   - Timeline management
   - POV tracking
   - Basic consistency checking

   **Defer to v0.2.0:**
   - D&D tools
   - Series continuity (unless high priority)
   - Advanced pacing analysis

3. **Format Priorities (Question 1):**
   - Should v0.1.0 support ALL formats, or start with novels?

   **My recommendation:** Start with novels + short stories
   **Reason:** Core use case, simpler than series/D&D

4. **Anti-Hallucination Approach (Question 5):**
   - Hybrid approach (Tier 1/2/3) as proposed?

   **My recommendation:** Yes, hybrid approach
   **Reason:** Balances creativity with consistency

5. **Timeline:**
   - When do you want v0.1.0 ready?
   - Is this urgent or planning-only?

---

## Next Steps

### Option 1: Proceed with Implementation

**If you approve this proposal:**
1. **You answer Questions 1-7** above
2. I create detailed specification for approved features
3. Begin Phase 1 (Foundation)
4. Implement iteratively with your feedback

### Option 2: Revise Proposal

**If you want changes:**
1. Provide feedback on proposal
2. I revise based on your direction
3. Re-submit for approval
4. Then proceed

### Option 3: Planning Only

**If this is exploratory:**
1. No action needed now
2. This document serves as reference
3. Implement when ready in future

---

## Conclusion

The fiction framework represents a **significant but feasible** expansion of the proven nonfiction framework. By reusing core infrastructure (git, change tracking, prompts) and adding fiction-specific features (characters, world-building, timelines, POV), we can create a powerful tool for fiction authors.

**Key Advantages:**
- Leverage existing nonfiction framework investment
- Proven workflow model (write in _chg, execute prompt, commit)
- Modular architecture from v0.10.0 makes adaptation easier
- Fiction-specific consistency checking prevents common errors

**Key Challenges:**
- More complex data model (characters, world, timeline vs. simple chapters)
- Anti-hallucination must balance creativity with verification
- Larger scope (more prompts, more features)

**Estimated Effort:** 4-7 months for full-featured v0.1.0

**Recommended Approach:** Start with core features (novels, short stories, characters, world, timeline), defer D&D and advanced series support to v0.2.0+.

---

**Status:** Awaiting user decisions on Questions 1-7

**Framework Version:** Based on Nonfiction v0.10.0
**Proposed Fiction Version:** v0.1.0
**Created:** 2025-11-19
**Last Updated:** 2025-11-19
