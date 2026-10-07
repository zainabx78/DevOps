# ADVANCED GIT USAGE

## Git Stash and Pop

- Use when switching branches mid-task.
- Great for "I'm not ready to commit, but i need to move"

- `git stash` = temporarily save uncommitted changes.
- `git stash list` = view all stashes`
- `git stash apply` = reapply latest stash (keeps stash)
- `git stash pop` = reapply and delete the stash.
  

## REVERT, RESET AND CHERRY-PICK

### Git Revert
- Safer option
- creates a new commit that undoes another.
- Safe for shared history. Doesn't mess with the history so safe to use for shared branches!.
- Used in production.

### Git Reset
- Moves branch pointer backwards.
- soft = moves pointer backwards but keeps changes staged.
- mixed = moves the pointer and unstages changes
- hard = nukes everything - use with care!
- Rewrites history - don't use in shared branches!


### Git Cherry-pick
- Apply a single commit from another branch 
- Useful for hotfixes or targeted changes.


- `git checkout -b feature-cherry`
- `echo "hotfix config for prod" > hotfix.txt`
- `git add hotfix.txt`
- `git commit -m "hotfix - add prod config fix"`
- `git push --set-upstream origin feature-cherry`
- `git log --oneline`
- Get that commit id and copy e.g. `57a34bc`

The cherry pick part:

- `git checkout main` --> go to the main branch
- `git cherry-pick 57a34bc` --> everything in that commit will come to the main branch. 
- `git push origin main` --> hotfix.txt will be in both branches now (main and cherry one).


## FORKS AND PULL REQUESTS (PR)

- Fork = your own copy of someone else's repository e.g. on github.
  - Clone the repository to your local machine.
  - Make changes - push to your fork.
  - Open a pull request to propose your changes.
  - Used in open source and cross-team workflows.
  - Original repo owner can reveiw, comment and merge.

pull request = proposal to merge your copy into the main copy.
merge requests = same thing. 


## Collaborating Practices

- Use branches to isolate work --> always work on a separate branch not main branch.
- Push to remote and open pull requests. 
- Assign reviewers, use Github's UI for comments.
- Resolve merge conflicts before merge.
- Use issues, projects and discussions to track work.
- Keep commits focused and clean. 

## Typical GIT workflow - working in a team

1. Developer pulls latest main or clones repo.
2. Creates feature branch.
3. Works locally --> commits --> pushes branch
4. Opens PR/MR --> review and merge
5. Team syncs regularly via git pull --rebase or merge.


## Trunk-Based Developement

- All devs commit to main or short-lived branches
- Heavy CI/testing gates
- Used in fast-moving orgs
