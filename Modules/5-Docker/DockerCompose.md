# Docker Compose

- Helps you to run multiple docker containers together.
- Key features: 
  - Docker-compose.yml file.
  - Commands.


  - Networking - docker compose handles this for you.
    - Docker compose automatically creates the custom networks for you, ensuring your containers can communicate with eachother. 

- Docker compose makes development and testing easier.
- Ensures consistency.
- Enhances teamwork - each member is using the same thing.


## First docker-compose.yml file

- Think of it as a recipe that lists all the ingredients/services that your application needs.
- Write down everything in this one file. 
  
- We're going to write a docker-compose file for both containers I created in the hello_flask practical (the flask web app container and the sql database container ) :

- `touch docker-compose.yml`
- Add this to that yml file: 

```
version: '3.8'

services:
  web:
    build: .
    ports:
      - "5000:5000"
    depends_on:
      - db

  db:
    image: mysql:5.7
    environment:
      MYSQL_ROOT_PASSWORD: my-secret-pw

```

- This creates the 2 containers - web and sql in one file. 
- The web service container being created depends on the db container being created - db gets created first. 

- To run this file  =  SO SIMPLE = `docker-compose up -d`
- The `-d` means it runs it in the background.

DONE! - CHECK WEB APP ON LOCAL HOST:5000

![alt text](image.png)

- To stop the containers = `docker compose down`
- To re-run containers after a change = `docker compose up -d --build` so it doesn't reuse previous image. 

## Debugging

![alt text](../Images/dockersuccess2.png)