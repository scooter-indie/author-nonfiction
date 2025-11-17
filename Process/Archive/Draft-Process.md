We will create a process for AI-assisted nonfiction book authoring.

All files created by this process will be Markdown files.

The purpose of this repo is as basis for clone repos to be used for authoring books. 

The process will comprise distinct reusable prompts to

1. [Prompt] Create a table of contents based on a series of questions. This will be a onetime use prompt to create the initial table of contents. This prompt will:
   1. Create the directory structure:
      1. [working-title]/TOC
      2. [working-title]/Preface
      3. [working-title]/Chapters
      4. [working-title]/Chapters/Chapter_01 to [working-title]/Chapters/Chapter_NN based on the table of contents
      5. [working-title]/Bibliography
      6. [working-title]/New-Content (this directory to remain empty upon creation)
   2. Create placeholder files based on the table of contents
   3. Each file in the directory structure will have a corresponding file having _chg added to the end of filename before the extension (e.g. TOC.md and TOC_chg.md). These files are for recording changes and will have a section for proposed revisions. See Change File Specs below.
2. [Prompt] A prompt that will create a new TOC entry based on User input. All impacted files must be re-organized and renamed as needed to accommodate the new TOC entry.
3. [Prompt] A prompt that will cause the target file to be modified per [INSTRUCTIONS FOR THIS REVISION].
4. [Prompt] A prompt that will examine the files(s) in [working-title]/New-Content and based on interactions with the User, will insert or update the Preface, a Chapter or a Bibliography. This action may also force a reorganization and renaming of the TOC and affected chapters.
5. [Prompt] A prompt that create a single Markdown file from the existing content even should some of that content be placeholder.



[Change File Specs-START]

Add to each _chg file: {{

Document Version: N.M

Target File: {e.g Chapter_01.md}

[REWRITE-START]
[CRITICAL: Keep all content in [Target File] unchanged, except as instructed below in the [INSTRUCTIONS FOR THIS REVISION] block. Each update to this file must be recorded in the CHANGE IN VERSION sections. The version number will be incremented per change.]

[CHANGES IN VERSION N.M]

[INSTRUCTIONS FOR THIS REVISION]
{will have content as required}

[KEEP THIS INSTRUCTION IN EVERY DOCUMENT] -> {

Always add the [REWRITE] blocks
}
[REWRITE-END]
}}

Edits will be noted in that _chg file as the result of using an appropriate prompt or when made by the author.

[Change File Specs-END]









