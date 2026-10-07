# Pre-Commit

## Hooks

- Happens before the commit happens. 
- `ls .git/hooks` --> shows you the git native sample hooks - not scalable. 

### Install pre-commit.

- `sudo apt install pre-commit` - linux.
- `pip install pre-commit` - if using git bash on windows. 
- `pre-commit --version` = shows if installed and which version. 


### Set it up
- Create a new file : `touch .pre-commit-config.yaml`.
- Enter this config into the file: just off claude - beginner friendly config.

```
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v5.0.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files
      - id: check-merge-conflict
      - id: detect-private-key
```

-  `pre-commit install`
-  Make a change in a file so we can commit a change. 
-  `git add .`
-  `git commit -m "add new feature"`
-  pre-commit will be running before the commit happens - will be able to see it in terminal. 
-  Can also add terraform pre-commits etc. 
-  pre-commits can fail. need to fix before committing. 
-  Once the checks have passed - `git push`. 