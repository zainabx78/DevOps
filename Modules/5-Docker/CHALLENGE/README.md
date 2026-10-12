# CoderCo Containers Challenge

Building a Multi-Container Application

## Objective

Create a multi-container application that consists of a simple Python Flask web application and a Redis database. The Flask application should use Redis to store and retrieve data.

## Requirements

1. **Flask Web Application**:
   - A Flask app that has two routes:
     - `/`: Displays a welcome message.
     - `/count`: Increments and displays a visit count stored in Redis.

2. **Redis Database**:
   - Use Redis as a key-value store to keep track of the visit count.

3. **Dockerize Both Services**:
   - Create Dockerfiles for both the Flask app and Redis.
   - Use Docker Compose to manage the multi-container application.

## Bonus

- Persistent Storage for Redis: Configure Redis to use a volume to persist its data.
- Environment Variables: Modify the Flask application to read Redis connection details from environment variables and update the docker-compose.yml accordingly.
- Scaling the Application: Scale the Flask service to run multiple instances and load balance between them using Docker Compose.


# HOW I DID IT: 


1. Application 
   - downloaded 2 files:
     - app.py
     - requirements.txt

- Created 2 dockerfiles:
  - 1 for the App container
  - 1 for the database container
  - Using multistages for this - size optimization. 



2. Build the docker images:

- `docker build -f Dockerfile.app -t myapp:v1 .`
- `docker build -f Dockerfile.redis -t redis:v1 .`



3. Create a custom network

- `docker network create my-network`



4. Create the containers on the same network

- `docker run -d --name myapp --network my-network -p 5000:5000 myapp:v1`

- `docker run -d --name redis --network my-network redis:v1`

WORKS!



## Using Docker Compose Instead:

1. Create a docker compose yaml file:

```yml
version: '3.12'

services:
  web:
    image: myapp:v1
    ports:
      - "5000:5000"
    depends_on:
      - redis

  redis:
    image: redis:v1

```

- `docker compose up` 
- WORKS!

![alt text](../../Images/success12.png)


![alt text](../../Images/ymlsuccess.png)



## BONUS:

1. Persistent redis storage = 
   - Use this in the docker-compose.yml.
  
```yml
redis:
    image: redis:v1
    volumes:
       - redis-data:/data

volumes:
  redis-data:

```

- Left side (redis-data) is the name of a storage space that Docker creates and looks after on your computer.
  
- Right side (/data) is a folder inside the container. Redis saves its data there.

- So, when the container gets deleted, the data is still on your computer. 



2. Environment Variables

- don’t write Redis’s address inside the code. Give it to the app from outside, as a setting, when the container starts.
- In real world scenario, hard coding values isn't ideal. 
- Need to add it into the docker-compose.yml.


```yml

  app:
    image: my-app
    ports:
      - "5000:5000"
    environment:
      - REDIS_HOST=redis
      - REDIS_PORT=6379
    depends_on:
      - redis

```


- Replace the redis line in app.py with this:

- `r = redis.Redis(host=os.environ.get("REDIS_HOST", "redis"), port=int(os.environ.get("REDIS_PORT", 6379)), decode_responses=True)`

- `Also adding import os` at the top of the app.py file. 


- Rebuild the app image and run docker compose up. 
  - `docker build -f Dockerfile.app -t my-app .`
  - `docker compose up`


3. Scaling Flask Service + Load balancing

- Use Nginx = popular ready-made web server.
- Can't use the same port 5000 for all containers - use nginx. 


- Create nginx.conf
  
```conf
events {}

http {
  upstream flask {
    server app:5000;
  }

  server {
    listen 80;
    location / {
      proxy_pass http://flask;
    }
  }
}

```

  - This file ensures : there’s a group of Flask apps at the name app, port 5000. Listen for visitors on port 80, and pass them all to that group.
  - If something asks “where is app?”, Docker answers with all three addresses. Nginx then takes turns sending requests to each one.

- Update Docker Compose file:

```yml

services:
  redis:
    image: redis:v1
    volumes:
      - redis-data:/data

  app:
    image: my-app:latest
    environment:
      - REDIS_HOST=redis
      - REDIS_PORT=6379
    depends_on:
      - redis
    deploy:
      replicas: 3

  nginx:
    image: nginx:alpine
    ports:
      - "5000:80"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
    depends_on:
      - app

volumes:
  redis-data:


```

  - The app no longer has ports:. Only Nginx is open to your computer now, so there’s no port clash. The app copies are only reachable inside the private network.
  - The new nginx service uses the official image, opens port 5000 on your computer (sending it to Nginx’s port 80), and loads your nginx.conf file into it. :ro means read-only, so Nginx can’t change your file.

- Run `docker compose up`
- `docker compose down -v`


