# Making our images lighter - Multistage Builds!

- Optimise large size dockerfiles using multistage builds. 

- Multistage builds = multiple from statements.
- Use one stage to build your actual application and another lighter stage to create the final image. 
- E.g. one stage includes all dependencies needed to build application but they're not included in the final image.

- This lets you discard unnecessary files and dependencies and results in an optimised smaller image. 
  - Smaller image = 
  - quicker to pull from registry
  - Faster to deploy
  - take up less disk space. 


## How to reduce the image size

- In the original dockerfile - installing the mysqlclient package:
  - This is what contributes to the large size.
  - Takes time to even build the image. 

1. Build the image - original large one:
    - `docker build -t my-flask-app:original .`

2. Get details on that image: Find the size
   - `docker images my-flask-app:original`
   - Disk usage = 502MB  = 1/2 gigabyte = LARGE!
   - This is because all the python3 dev, etc are all included in the final image. 

3. Create the multistage dockerfile:

- Goes from this: 

```
FROM python:3.8-slim

WORKDIR /app

COPY . .

RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    libmariadb-dev \
    pkg-config

RUN pip install flask mysqlclient

EXPOSE 5000

CMD ["python", "app.py"]


```


- TO THIS: 


```

# Stage 1: Build stage

FROM python:3.8-slim as Build

WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    libmariadb-dev \
    pkg-config

COPY . .

RUN pip install flask mysqlclient



# Stage 2 - Production stage

FROM python:3.8-slim 

WORKDIR /app

COPY --from=Build /app /app

EXPOSE 5000

CMD ["python", "app.py"]


```

4. Build the new image from this dockerfile: 

   - `docker build -t my-flask-app:multistage .`

5. Check the new file size:

   - `docker images my-flask-app:multistage`
   - Size reduced to 125 MB !!

DONE!


## Can also build this container using docker compose: 

```
version: '3.8'

services:
  web:
    image: my-flask-app:multistage
    ports:
      - "5000:5000"
    depends_on:
      - db

  mydb:
    image: mysql:5.7
    environment:
      MYSQL_ROOT_PASSWORD: my-secret-pw

```

- `docker compose up`

- Might result in ERROR: 
  - The old Dockerfile (single stage) built everything in one place. It installed the tools, installed Flask, and copied my files into the same image. Flask was installed into that image, so when the app ran, Flask was right there. Nothing got thrown away.

  - The new Dockerfile (multistage) builds in two separate images:

  - Stage 1 installs the tools and Flask, and copies your files.
  
  - Stage 2 starts completely fresh from a clean python:3.8-slim, and only gets what I copy across.

  - pip install ignores the WORKDIR set. No matter what your WORKDIR is, pip always puts Flask in Python’s own folder. So, the app may not be carried over to the 2nd stage. 


- FIX: 

  - `docker rmi a7f681b032d2 ` - Delete the multistage image created previously. 
  - Update the dockerfile:

```

# Stage 1: Build stage

FROM python:3.8-slim as Build

WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    libmariadb-dev \
    pkg-config

COPY . .

RUN pip install --prefix=/install flask mysqlclient



# Stage 2 - Production stage

FROM python:3.8-slim 

WORKDIR /app

RUN apt-get update && apt-get install -y libmariadb3 && rm -rf /var/lib/apt/lists/*

COPY --from=build /install /usr/local
COPY --from=build /app /app

EXPOSE 5000

CMD ["python", "app.py"]

```

- The fix uses `--prefix=/install`. It tells pip, “put everything in /install instead,” so you know exactly which folder to carry across to Stage 2.

- Build the new image: `docker build -t my-app-flask:multistage .`

- `docker compose up`