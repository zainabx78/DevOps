# Setup a pipeline which builds and pushes your container image to DockerHub (Container registry)

- Did everything manually first to understand the steps and commands involved.


## Ensuring the docker container actually runs
## Also using multistage builds to optimise the size of image 
### Manually 



1. Get the app file - app.py
   - Using a weather app that I can query and it returns the weather. 
   - Put that code into an app.py file. 
  

3. Create a requirements.txt file
    - The requirements file is a shopping list of those add-ons. When I run pip install -r requirements.txt, pip reads the list and installs everything on it. 
    - Without the list, I'd have to remember and install each add-on myself.

    - Python comes with a set of built-in tools, but this app uses two add-ons that don’t come with it. 
      - `Flask`lets Python act like a small website and answer your browser. 
      - `Requests` is what the app uses to talk to the weather service.

4. Run the app locally to find the entry point. 
    - Each dockerfile needs to know entrypoint.
    - Since this app is just a python app, I have to use `python app.py` to run this app locally. 


5. Create a docker file for the application

```dockerfile

# Stage 1: Build stage

FROM python:3.8-slim as Build

# Create a folder called /app and go into it. Everything after this happens inside that folder
WORKDIR /app

# Install everything on the shopping list. --no-cache-dir throws away leftover download files to keep things small. 
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# Copy the rest of your project (like app.py) into /app.
COPY . .




# Stage 2 - Production stage

FROM python:3.8-slim 

WORKDIR /app

# Reach back into the “build” stage and grab the installed packages from /install. 
# Put them in /usr/local, which is where Python automatically looks for packages.
COPY --from=build /install /usr/local
COPY --from=build /app /app

# Create a normal, limited user called appuser
RUN useradd appuser

# Switch to that user, so the app doesn’t run as root (the all-powerful admin). 
# Safer if someone breaks in.
USER appuser

EXPOSE 5000

CMD ["python", "app.py"]

```



6. Create a docker image from the dockerfile. 
    - `docker build -t weather-app .`
      - This builds a docker image.
      - `-t` = tag
      - `.` at the end means build a docker image from the current folder dockerfile. 
      - `docker images` - shows the created image in the list

    - Keeping the size small: 
      - Using multistage builds so that the image is lightweight.
      - `docker images`

    ![alt text](../../Images/imagesdockermulti.png)



7. Run the container using that image: 

    - `docker run -d --name weather-app -p 5000:5000 -t weather-app:latest`
      - `-d` means detached mode - keeps running in the background.

CONTAINER RUNS!

![alt text](../../Images/app10.png)

## Pushing image to Dockerhub - Manually 

- Create a repository in Dockerhub first
  - name: weather-app
  - public
- In terminal - 
- `docker login` 
  - This might fail: 
  - Login error command to do with credentials. 
  - Need to get rid of the config file that holds the credentials for docker so it can create a new config file. 
  - `rm ~/.docker/config-old.json` 
  - Then run `docker login` again. 

  ![alt text](../../Images/dockerlogin.png)

- `docker build -t zainabx1/weather-app:latest .`
- `docker push zainabx1/weather-app:latest`

  ![alt text](../../Images/dockerpush.png)


- Should see the image in Dockerhub:

  ![alt text](../../Images/dockerimageonline.png)






## Pushing the image to DockerHub via Github Actions workflow (pipeline)


1. Create a `.github/workflows` folder.

2. Create a `ci.yaml` file.
   - Need to push the image to DockerHub via the workflow file. 
   - This pipeline builds and pushes the image everytime there's a git push (any change is made).
 
```yml

name: Pushing Docker Image to Dockerhub via workflow

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: checkout code
      uses: actions/checkout@v4

    - name: Building the image 
      run: docker build -t zainabx1/weather-app:${{ github.run_number }} .

    - name: Tagging image with latest as it's the latest image
      run: docker tag zainabx1/weather-app:${{ github.run_number }} zainabx1/weather-app:latest

    - name: Pushing image to dockerhub 
      run: docker push zainabx1/weather-app:${{ github.run_number }}
           docker push zainabx1/weather-app:latest
```
