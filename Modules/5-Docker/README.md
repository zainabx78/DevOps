# 5 - Docker

Notes and hands-on practice for building, running, sharing and deploying containers with Docker.

## Contents

| # | Topic | What it covers |
|---|-------|----------------|
| 1 | [Docker Intro](Intro.md) | What Docker is, what containers are and why they're used |
| 2 | [Installation](Installation.md) | Setting up Docker and checking it works |
| 3 | [Docker Commands](Docker-Commands.md) | Everyday commands for working with images and containers |
| 4 | [Dockerfile Notes](Dockerfile-Notes.md) | How to write a Dockerfile to build your own images |
| 5 | [Multistage Builds](Multistage-builds.md) | Using multiple build stages to make smaller, cleaner images |
| 6 | [Docker Web App](DockerWebAPP.md) | Building and running a web app inside a container |
| 7 | [Docker Networking](Networking.md) | How containers talk to each other and the outside world |
| 8 | [Docker Compose](DockerCompose.md) | Running multiple containers together with one file |
| 9 | [Docker Registries](DockerRegistries.md) | Storing and sharing images with registries like Docker Hub |
| 10 | [AWS ECR](AWS-ECR.md) | Pushing and pulling images with Amazon's container registry |
| 11 | [Production](PRODUCTION.md) | Making containers secure and reliable for real-world use |

## Hands-On Practice

| Folder | What it contains |
|--------|------------------|
| [hello_flask](hello_flask/) | A simple Flask web app with its own `Dockerfile` and `docker-compose.yml` |
| [CHALLENGE](CHALLENGE/) | A challenge task putting the module into practice |

## Key Takeaways

- An image is the blueprint and a container is the running copy.
- Use multistage builds to keep final images small.
- Use `-p` to map ports so you can reach the app from your browser.
- Containers on the same network can reach each other by name.
- Use Docker Compose to start a whole setup with `docker compose up`.
- Push images to a registry like Docker Hub or AWS ECR to share and deploy them.
- In production, use specific image tags, run as a non-root user and keep secrets out of images.

[⬅ Back to main page](../../README.md)