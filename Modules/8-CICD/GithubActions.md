# Github Actions 

## CI/CD Workflow:

1. Code
2. Commit
3. Trigger from commit
4. Build - build code / compiling
5. Automated tests - tests code - maintains code quality.
6. If build and test are successful - code is packaged. E.g. docker image, compiled binary etc.
7. Package pushed to production.
8. Continuous Monitoring


## Github Actions Use Cases

- Continuous Integration
  - Automatically builds and tests code everytime changes are pushed to repo. 
  - Any issues are caught early. 
  - E.g. running unit tests on every pull requests
    - Ensures Any new code doesn't break existing functionality. 
  
- Continuous Deployment
  - After code passes all tests, github actions can automatically deploy to production or any other env, 
  - E.g. deploying application to the cloud. 

- Automation 
  - Github actions can automate repetitive tasks. 
  - E.g. managing project board automation.
    - Helps keep project board up to date without manual effort. 


## Creating a Github Repo for CICD

1. Create a new repository.
   - In github create a new repo called cicd. 
   - Keep it private. 


2. Initalise repository.
   - In local computer - create a new folder called cicd:  `mkdir cicd` --> `/c/Users/zaina/OneDrive/Desktop/cicd`.  
   - `git clone git@github.com:zainabx78/cicd.git` - SSH clone from github. This makes a new folder called cicd in the cicd folder. Need to be in that folder for the next part. 
   - `cd cicd`
   - Create a README file and .gitignore.
   - `echo "# ReadMe File!" > README.md`
   - `touch .gitignore`
   - `git status` `git add .` `git commit -m "first commit!"` `git push`. 

   - Should see the files in the git repo in github too now. 


3. Set up Repository for CI/CD.





