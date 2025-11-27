Proposal: create one or more potential deployment architectures where THIS framework is deployed to a particular directory (FW_ROOT) and in a separate directory the User can create individual book projects as subdirectories. Consider these assertions:

1. The User will use both Claude Desktop and Claude Code CLI. 
2. Claude Desktop will use the Filesystem MCP connector. 
3. Book projects must have a common parent directory (BOOKS_ROOT). That parent directory will be configured to provide full access to Claude Desktop via the Claude Desktop Filesystem MCP connector.
4. The Git repository will be created in BOOKS_ROOT.
5. A book registry or configuration file located in BOOKS_ROOT could be used by Claude Desktop to have the User select which book to work and switch to another book as needed. 
6. The book registry or configuration file located in BOOKS_ROOT could be used by Claude Code CLI to have the User select which book to work and switch to another book as needed. 
7. Each book under BOOKS_ROOT may need a PROJECT_CONTEXT file to be read by  Claude Code CLI or Claude Desktop.
8. It is understood that after each Claude Code CLI compaction, it will likely be necessary to re-initialize the framework.
9. If the User opts in for configuring a private GitHub repository for their books, all of the Users books will be managed from that single repository. 
10. If the User opts out for having a private GitHub repository, we will provide a Prompt that will ZIP all books in BOOKS_ROOT and place that ZIP in a directory the User provides.  
11. The system instructions loaded into Claude Desktop should be as minimal as possible and have no framework version dependency. The system instructions must force Claude Desktop to read the minimal number of framework documents to be functional (i.e. FRAMEWORK_CORE.md). 
12. The Claude Desktop Filesystem MCP connector will be configured for full access to the root directory in which the framework is deployed.
13. Claude Code CLI can start in an arbitrary directory. Ideally, if not required, we would want to control where Claude Code CLI starts or where it changes directory too. Perhaps a OS specific script could be created to start Claude Code CLI in the BOOKS_ROOT directory.
14. The User must change Projects in Claude Desktop to work on different book.
15. Ideally, the User could switch book projects from within Claude Code CLI.
16. The framework will be deployed from https://github.com/scooter-indie/author-nonfiction-dist using a git clone or equivalent.
17. When first opening a Claude Desktop book project, the system will check if an update to the framework exists at https://github.com/scooter-indie/author-nonfiction-dist. If an update/upgrade is available, the user will be informed and provided the Claude Code "code" in a Copy-code block to paste into Claude Code CLI to effect the upgrade.
18. When first opening Claude Code CLI to work on a book project, the system will check if an update to the framework exists at https://github.com/scooter-indie/author-nonfiction-dist. If an update/upgrade is available, the user will be informed and provided the Claude Code "code" in a Copy-code block to paste into Claude Code CLI to effect the upgrade.
19. The system will provide a mechanism to update/upgrade the framework in FW_ROOT. That update/upgrade process with make all required changes to configuration files and/or registry files in FW_ROOT and BOOK_ROOT and their respective subdirectories. 