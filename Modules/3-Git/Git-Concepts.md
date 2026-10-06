# Git Internals and Core Concepts

## The .git directory

- Contains all history and config that git needs to function.
- Hidden file (do ls -la to see it).

- `.git/refs/` = git stores tags and branches here.

- `.git/objects/` = object store - all your commits, blobs and trees (like harddrive).

- `.git/config` = repo-specific settings.

- `.git/HEAD` = current branch pointer.

- `.git/index` = staging area.


## Git Common Commands

- `git init` = initializes a new git repo with a .git directory. 

- `git add` = stage changes.

- `git commit` = snapshot changes

- `git status` = show staged/unstaged work.

- `git log` = show commit history.

- `git diff` = show what changed.

- `git config` = set user/email.

- `git help <command>` = build in docs.

- `git clone` = copy a remote repo.

- `git rm` = remove files.

- `git mv` = rename files.

- `git restore` = undo file changes = newer.



## The areas of git:

### 1. Working directory

- Files you're editing 


### 2. Staging area

- Changes marked for commit 


### 3. Repository

- Commit snapshots.


## VIEWING HISTORY IN GIT

- `git log` = see commit history 

- `git log --oneline --graph` = visual summary

- `git show <commit>` = view a specific commit

- `git diff` = compare unstaged vs last commit.

- `git diff --staged` = compare staged vs last commit.

- `git blame <file>` = show who last changed each line.

- `git reflog` = view local HEAD history (even deleted branches).


## Git VS Github 

- Git runs locally. Github runs remotely in the cloud.
- You can use git offline, can't use gihub offline.
- Github = repo hosting and collaboration. Owned by microsoft.
- Git = version control tool. Open source. 