# How GIT is actually used - GIT workflow

## Typical GIT workflow - working in a team

1. Developer pulls latest main or clones repo.
2. Creates feature branch.
3. Works locally --> commits --> pushes branch
4. Opens PR/MR --> review and merge
5. Team syncs regularly via git pull --rebase or merge.


## THE WORKFLOW:

1. Make sure you use `git pull` first - everything up to date. 

2. Create a new branch and checkout into it. `git checkout -b feature/add-about-page`
   
3. `echo "This is the about page" > about.md`

4. `git status` --> should see red.
   
5. `git add about.md`
   
6. `git commit -m "Add about page"`
   
7. `git push --set-upstream origin feature/add-about-page`
   
8. Then need to create pull request/merge request. The terminal gives link - go to link and create request. 
9. Then, someone has to approve the request.
10. Then you can finally push the merge through github. 
11. On github --> delete the branch (after merge is done there's an option to delete branch).
- Change should be reflected in main branch.


## UNDDOING IN GIT

- `git checkout main` --> go back to main branch if you're in a branch.
- `git pull` --> latest changes from remote main ALWAYS!
- `echo "original line" > undo.txt`
- `git add undo.txt`
- `git commit -m "test"` -> commit the change.

### Example 1: Mistake - not staged
- `echo "bad change" > undo.txt` --> edit the file and override it with an unwanted line -- MISTAKE FOR THIS EXAMPLE!
- Use `git restore undo.txt` = file will restore file to the last committed state.


### Example 2: Mistake - staged
-  `echo "bad change" > undo.txt` --> edit the file and override it with an unwanted line -- MISTAKE FOR THIS EXAMPLE!
-  `git add undo.txt` - stage the change. 
-  `git restore --staged undo.txt` --> takes the file out of staged area. 
-  


### Example 3: Mistake - committed
- `echo "oops commit" > undo.txt`
- `git status`
- `git add undo.txt` 
- `git commit -m "bad commit"` 

3 ways to fix a bad commit:

1. Soft reset 
   - `git reset --soft HEAD~1` --> reset one back from head
   - Undoes the commit and goes back into staging.

2. Mixed
   - `git reset --mixed HEAD~1` --> Unstages the file but keeps changes in the file. 
   - `git status` - should show red because not staged.

3. Hard - not a safe way. 
   - `git reset --hard HEAD~1`
   - Undoes the commit AND deletes the changes completely.
   - `git status` - should show nothing (clean), and undo.txt is gone.
   - Careful: your work is erased. Only use this if you truly want to throw it away.

### Production mistake - pushed.

- `echo "production mistake" > undo.txt"`
- `git add .`
- `git commit -m "prod mistake"`
- `git push`

SAFE UNDO COMMIT: `git revert "prod mistake"`
  - Creates a new commit that undoes the last commit. 
  - The bad commit stays in the history, but its changes are cancelled out.
  - Then `git push` to send the "undo" to everyone else.

### BONUSES

- Use `git log --oneline` --> shows history of what's been happening. 
- `git reflog` --> tracks every single move. Can even recover commits etc. 


## GIT AMEND - CHANGING COMMITS

- `echo "line 1" > notes.txt`
- `git add notes.txt`
- `git commit -m "add note file"`
- `echo "metadata" > meta.txt`
- `git add meta.txt`
- `git commit --amend` --> adds meta.txt into the LAST commit + lets you change the message

Options:
  - `git commit --amend` --> opens an editor to change the message
  - `git commit --amend -m "new message"` --> change the message straight away
  - `git commit --amend --no-edit` --> add the file, keep the old message

- Only amend commits you HAVEN'T pushed yet.
- If already pushed, use `git revert` instead.

- What amend actually does: 
  - instead of making a new commit, it opens up your last commit and slips the new changes into it. 
  - So you end up with one commit containing both notes.txt and meta.txt, rather than two separate ones.