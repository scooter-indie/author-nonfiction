Proposed Architectural Change

PROJECT_ROOT/
	├─.git/
	├─.gitignore ( ignore the entire FW_ROOT directory
	├─ start-authoring.bat/.sh and bp-start-authoring.bat/sh
	├─ FW_ROOT/ (only files cloned from -dist )
	├─ BOOKS_ROOT/ 
		├─ "Book1"/Manuscript/...
		├─ "Book2"/Manuscript/...
		├─  Archive/
			├─ "Book3"/Manuscript/...
			├─ "Book4"/Manuscript/...

​	├─ CONFIG_ROOT/ ( as  .config/)
​		├─ fw-location.json   		
​		├─ books-registry.json
​		├─ settings.json
​		├─ CLAUDE.md
​		├─ .claude/
​			├─ agents/
​				├─ book-writing-assistant.md
​			├─ commands/
​				├─ fw-init.md
​				├─ manage-book.md
​				├─ switch-book.md

Assertions Needing Confirmation

1. The bat/sh scripts with CD to PROJECT_ROOT/CONFIG_ROOT/ and start Claude Code CLI in the .config directory. Claude Code will load CLAUDE.md and will have access to /fw-init.
2. Claude Code will know the location of FW_ROOT from fw-location.json 
3. Claude Code will know location of BOOKS_ROOT from books-registry.json
4. Having an new .git repo in the PROJECT_ROOT will allow everything not in .gitignore to be versioned. 
5. The BOOKS_ROOT directory will contain only Book related files and directories and the Archive directory of Book related files and directories. 
6. Claude Desktop must be made aware of this directory structure via system-instructions and/or other required configuration.





  