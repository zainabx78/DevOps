# DOCKER INSTALLATION

- Install docker desktop for windows. 
- `https://www.docker.com/products/docker-desktop/`

- Once installed, open terminal (powershell) -       
  - `docker--version`
- Should output a version:
`Docker version 29.8.2, build 7fc2dff`

- Can also use `docker info` for detailed info. 

## Pulling a Hello World Image:

- `docker run hello-world`
- Here's what happens:

```

Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
4f55086f7dd0: Pull complete
Digest: sha256:5e23090353324d887c48ad5e5c56d294eab81588df9605b07d1afe895f9cc8f8
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/

```

- Docker checks whether the hello-world image is present in your local machine. 
- If its not, it pulls the image from dockerhub and docker creates a container from image and runs it. 


## Checking containers that are running

- `docker ps` -> lists containers that are running.
- `docker ps -a` -> lists all containers even the ones that are stopped. 

- The hello-world container won't show in `docker ps` because it stops running after is shows us `hello world`. So, it'll be listed in `docker ps -a` instead. 