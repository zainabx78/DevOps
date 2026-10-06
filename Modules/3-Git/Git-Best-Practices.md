# GIT BEST PRACTICES

## Commit Hygiene and Best Practices

- Write good commits -clear and informative.
  - Commits should tell a story.
- Use squashing before merging PRs.
  - When you have multiple commits need to squash them into one commit before opening a pull request.
- One logical change per commit.
- Avoid noisy merges e.g. fix fix fix final final2 etc


## Pre-Commit and Automation

- Run linters/tests before committing. Use tools like pre-commit, Husky, tflint/sec etc. 
- These tools hook into git - they run automatically before your code gets committed.
- These checks stop broken code, inconsistent formatting etc. 
- Can also hook these tools to CI in pipeline. 
  - for formatting, testing and scanning. 


## Common Mistakes in the Real World

1. Forgetting to pull before pushing - ALWAYS PULL BEFORE PUSHING!

  - If someone else has pushed new saves since you last pulled, Git will simply refuse your push. Nothing breaks, you just get a rejection message and have to pull first anyway. So the habit of pulling first saves you that round trip.

  - The reason Git refuses is the real point. Your copy and the remote have gone in different directions:

    ```
    Remote:   A — B — C — X     ← someone else's new save
    Yours:    A — B — C — Y     ← your new save

    ```

  - If Git accepted your push as-is, the remote would jump to your version and save X would be lost. Git won't let that happen, so it makes you pull X down first, combine it with your work (via merge or rebase), and then push the combined result.



2. Force pushing into shared branches

  - The genuinely dangerous mistake is what some people do after getting rejected: they use a "force push" (git push --force) to make Git accept it anyway. That does overwrite the remote, and your teammate's save X disappears from the shared copy. This is one of the classic ways people accidentally wipe out a colleague's work.

3. Committing secrets 

- Github can be scraped by hackers etc. Use tools to protect yourself.

4. Merging without review 
- Always review what you're merging. 

5. NOT using .gitignore properly - Not committing secrets or sensitive files. 
- Make sure the files you don't want to be pushed to github are in the .gitignore.


## GIT AT SCALE

### Monorepo 

- Instead of having one repo per service, teams sometimes dump everything into one repo.
- Simplifies shared tooling and dependencies.
- Makes CI harder.


### Sparse checkout
- When a repo is enormous, you don't want to download the whole thing to your computer. Sparse checkout lets you grab only the folders you actually work on, like borrowing a few chapters instead of the entire encyclopedia.


### Git LFS

- Large file support (Git LFS). 
- Git is great with text files (like code) but bad with big files like videos, images, or design files. They bloat the repo and slow everything down. Git LFS stores those big files somewhere else and leaves a small placeholder in the repo pointing to them.

### Clean up legacy history

- Clean up legacy history (filter-branch, filter-repo). 
- Old projects collect junk over the years, like huge files someone shouldn't have added, or a password accidentally saved years ago. These tools rewrite the history to remove that stuff. It's like rebase on a massive scale, so the same warning applies: it rewrites history, which causes headaches for everyone with a copy.

### Submodules vs subtrees in microservices repos.

- Submodules vs subtrees in microservice repos.
- Sometimes one project needs to include another project inside it. Submodules and subtrees are two different ways of doing that. Submodules keep a link to the other project, while subtrees copy it in. Each has trade-offs in convenience and complexity.

### Selective CI builds
- Selective CI builds (e.g. Turborepo, Nx, Bazel). 
- "CI" means automated checks that run every time someone pushes changes, to make sure nothing is broken. In a giant repo, re-checking everything for every small change would take hours. These tools figure out which parts were actually affected and only check those.

### Commit linting
- Commit linting, bots to enforce rules. 
- Teams often have rules for how saves should be described, like "every commit message must say what it fixes." 
- Linting tools and bots automatically check those messages and reject ones that break the rules, so nobody has to police it by hand.

### Gitops style deployments
- GitOps-style deployments (e.g. ArgoCD, Flux). - 
- "Deploying" means putting your software live for real users. GitOps means the Git repo becomes the single source of truth: whatever is in the repo is automatically what's running live. 
- To change the live system, you change the repo, and tools like ArgoCD make the live system match.


### Server side Git hooks
- Server-side Git hooks (e.g. pre-commit.ci, Lefthook). 
- Hooks are automatic scripts that run at certain moments, like just before a save is made or a push is accepted. 
- They can block changes that break rules or fail checks. One small note: the slide groups these examples a bit loosely. 
- Lefthook actually runs hooks on your own computer, and pre-commit.ci runs them as an online check, rather than either being strictly "server-side." 
- The overall idea is the same, though: automatic gatekeepers that catch problems early.


## Git Security and Secrets Hygiene

- Preventing secret leaks in commit - do not commit secrets.
- Using git-secrets, trufflehog.
- Cleaning secrets from history. 
- Auditing repo contributors + logs.
