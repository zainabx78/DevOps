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