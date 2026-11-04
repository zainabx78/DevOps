# 8 - CI/CD

This module covers **CI/CD (Continuous Integration / Continuous Delivery)**: automatically building, testing and delivering an app every time code is pushed, using **GitHub Actions**.

## Notes

| File | What it covers |
|------|----------------|
| [CICD.md](CICD.md) | What CI/CD is and why it's used |
| [Pipelines.md](Pipelines.md) | How a pipeline is made of stages, jobs and steps |
| [GithubActions.md](GithubActions.md) | GitHub Actions basics: workflows, triggers, runners |
| [yaml-syntax.yml](yaml-syntax.yml) | YAML syntax used to write workflow files |
| [Secrets.md](Secrets.md) | Storing passwords and tokens safely in GitHub |
| [ManualTriggers.md](ManualTriggers.md) | Running a workflow by hand instead of on every push |
| [MatrixBuilds.md](MatrixBuilds.md) | Running the same job across several versions or systems at once |
| [CustomActions.md](CustomActions.md) | Creating my own reusable actions |

## Projects

### [Project 1 - Docker Hub](Project-1-Dockerhub/)

A small Python weather app that is packaged as a Docker image. On every push, the workflow:

1. Builds the Docker image
2. Tags it with the run number and `latest`
3. Pushes both tags to Docker Hub
4. Runs the new image as a container on my PC, using a self-hosted runner

**Main files:** `app.py` (the app), `dockerfile` (how the image is built), `requirements.txt` (Python packages), `ci.yaml` (the workflow).

### [Project 2 - Auto Tests](Project-2-Auto-Tests/)

A workflow that runs automated tests on every push, so broken code is caught before it's delivered.

## What I learned

- How a workflow file is structured: `on`, `jobs`, `runs-on` and `steps`
- How to keep login details out of the code using **secrets** and **variables**
- How to link jobs together with `needs`, so one waits for another to finish
- The difference between GitHub-hosted runners and a **self-hosted runner** on my own PC
- How to build, tag and push Docker images automatically