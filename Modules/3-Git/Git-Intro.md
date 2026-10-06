# GIT INTRO

- Basic workflow: 
  - Working directory → git add → staging area → git commit → repository

## Typical GIT workflow - working in a team

1. Developer pulls latest main or clones repo.
2. Creates feature branch.
3. Works locally --> commits --> pushes branch
4. Opens PR/MR --> review and merge
5. Team syncs regularly via git pull --rebase or merge.


## Version Control 
  
- Tracks changes to code over time.
- Lets you undo, inspect and collaborate.
- Everyone has their own copy with full history. 
- Every commit is a snapshot. 

- Git uses a key-value store - SHA-1 hash. 


## GIT terminology 

- Repository/REPO = a Git project (tracked folder with a .git directory)
  - If a folder has a `.git` folder inside, it's a git repo. 

- Commit = a snapshot of your files and metadata.

- Branch = A movable pointer to a specific commit e.g. main, dev etc.

- Remote/Origin = external copy of your repo e.g. Github, GitLab.. 

- Staging area/Index = a buffer between working directory and the repo.

- HEAD = current branch/commit you're working on. 


## Git Module Summary
- Repositories – 
  - Initialising (git init), cloning (git clone), and the .git directory.

- Staging & Committing – 
  - Using git add to stage changes and git commit to create snapshots.

- Branches & Merging – 
  - Creating, switching, merging branches and understanding HEAD.

- Remote Repositories – 
  - Syncing with remotes using git push and git pull.

- History & Logs – 
  - Viewing changes with git log, git diff, and git reflog.

- Undoing Changes – 
  - Commands like git reset, git revert, and git stash.


