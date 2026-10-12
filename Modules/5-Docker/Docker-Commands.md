# Important Docker Commands


## Docker Images:

-  ` docker images ` - quick overveiw of all the images stored locally. 
  
- `docker inspect <image ID>` - Details about the image. 

- `docker rmi <imageID>` - delete images that you want to clean up and remove/no longer need.

- `docker system prune` - remove unused images/stopped containers/unused networks. 


## Containers

- `docker ps` - lists all running containers.

- `docker ps -a` - lists all stopped and running containers.

- `docker stop <container ID> <container ID>` - stop containe/multiple containers. 

- `docker rm <container ID>` - removes containers. 


## Volumes

- `docker volume ls` - lists all volumes.
- `docker volume inspect flask-app_redis-data` - detail about the volume.

- `docker compose down -v` - deletes the volume along with the containers. 


## EXEC

- `docker exec` lets you run a command inside a container that’s already running
- `docker compose exec app sh`





## Debugging

Before teaching “good Dockerfiles”, we need to learn how to look inside a container.

✔️ Running containers `docker ps`

  - Shows all active containers.

✔️ Viewing logs `docker logs <container>`

  - Useful when:

    - app crashes

    - app fails to start

    - healthchecks fail

✔️ Entering a container `docker exec -it <container> sh`

  - Allows inspecting:

    - filesystem

    - installed deps

    - processes

    - config

    - permissions

✔️ Inspecting full container metadata `docker inspect <container> | jq`

  - Shows:

    - env vars

    - entrypoint

    - mounts

    - IP address

    - networks

✔️ Debugging build failures `docker build --progress=plain .`

  - Shows full build logs.

✔️ Running a “broken” image with a shell `docker run --rm -it --entrypoint sh myimage`

  - Ignores CMD/ENTRYPOINT → gives you access to debug.
