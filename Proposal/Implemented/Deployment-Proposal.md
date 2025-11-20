This is a proposal to simplify the distribution and reuse of the nonfiction framework. This would eliminate the need to clone the author-nonfiction repo and ensure the User repo has only the files needing for authoring a book.

The User should be able to:

1. create a local repo
2. download a nonfiction.zip file and an installer.md
3. ask the assistant to install
4. the assistant will unzip the nonfiction.zip
5. the assistant will then create the remote repo and git push
6. the assistant will then execute prompt 1

This may require a Prompt to build the production release. That Prompt would be excluded from the production nonfiction.zip

The zip file will contain the framework but no _chg files

The framework will be fully functional after the install.

A release version number must be embedded in a manifest or the like.

Updates to the initial release will be cumulative.

We can handle updates similarly.