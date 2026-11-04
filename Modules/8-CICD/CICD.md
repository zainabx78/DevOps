# CI/CD

CI = Continuous Integration
  - Developers add their code changes often
  - Each change is automatically built and tested
  - Steps: Code → Build → Test

CD = two possible meanings:

  - Continuous Delivery
    - Every change is always ready to release
    - A person decides when to release it

  - Continuous Deployment
    - Every change that passes the tests is released automatically
    - No person needed

Full DevOps loop:
  Plan → Code → Build → Test → Release → Deploy → Operate → Monitor → (back to Plan)

### CICD IN DEVOPS:

Source control --> CICD ---> Monitoring and Logging.


## CICD Pipeline

- Series of steps that the code changes go through from the moment they're committed to being deployed to production.


1. Commit change (github).
2. Trigger build (the commit triggers the build process)
3. Build (code is compiled and all dependencies are built.)
4. Notify of build outcome
5. Run tests
6. Notify of test outcome
7. Deliver build to staging
8. Deploy to production.


- Faster delivery
- Improved quality - fixing bugs frequently.
- Reduced risk
- Better collaboration. 


- CICD Helps to build test and deploy software quicker and more reliably. 


## Popular CICD tools

- Gitlab CICD =
  - Integrated into gitlab - version control.
  - User friendly. 

- Jenkins
  - Most popular.
  - Quite complex.
  - Powerful. 

- CircleCI
  - Speed and simplicity.
  - Integrates well with github.
  - cloud based

- TravisCI
  - Cloud based
  - Simplicity

- Github Actions
  - Deep integration with github. 

- AWS, Azure and GCP have their own CICD tools. 


## CICD In the Real World

### Linting
- Analysing code for potential errors and enforcing coding standards
- maintain code quality.
- catch syntax errors
- Tools:
  - ESLint - javascript
  - pylint - python

### Automated testing
- Running tests automatically on your codebase to ensure it works as expected.
- Detect issues early. 
- Ensure code quality. 
- Tools:
  - unittest
  - pytest
  - j unit
  - jest
  - mocha


### Deploying to different environments

- Environment types:
  - Development - dev
  - staging - stable env that mirrors production as closely as possible.
  - production - prod - live environment.

- Deployment strategies
  - Manual deployments
  - Automated deployments



## Security in CICD

- Secure your secrets - NEVER HARDCODE
  - Use github secrets/any other secret management tool. 


- Control access
  - Implement least priviledge - only give permissions needed and nothing more.
  - RBAC 

- Scan for vulnerabilities regularly 
  - Security scanners integrated with CICD pipeline. 

- Audit and monitor 
  - Keep track of who did what and when. 
  - Set up alerts for security incidents. 


## Debugging workflow failures

- Failed tests
- Dependency errors
- Configuration errors
- permission issues

- Solutions:

  - Review logs
  - re-run jobs
  - Update dependencies
  - check configuration


## Summary :


- CI/CD (Continuous Integration and Continuous Deployment) is a key DevOps practice for delivering software efficiently, reliably, and securely. Key concepts you have learnt include:

  - Continuous Integration (CI) – Frequently merging code changes, running automated builds and tests to detect issues early.

  - Continuous Deployment/Delivery (CD) – Automating deployment to production or staging environments for faster releases.


  - GitHub Actions Workflows – Defining automated tasks in .yml files stored under .github/workflows and using triggers (on:) to start jobs.


  - YAML Basics – Using key-value pairs, lists, and nested elements for workflow configuration.


  - Jobs & Steps – Running commands (run) and reusing actions (uses) to streamline pipelines.


  - Secrets Management – Storing sensitive data securely and accessing via ${{ secrets.SECRET_NAME }}.


  - Pipeline Best Practices – DRY principle, linting for code quality, implementing security measures like least privilege, and avoiding hard-coded secrets.