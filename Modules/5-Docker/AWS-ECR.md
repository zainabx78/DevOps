# Pushing our images to Amazon ECR

1. Build the image
2. Tag with ECR
3. Push to ECR
4. Pull from ECR
5. Docker run

- Create an AWS account. 
- Go to ECR - Elastic Container Registry. 

## Create a repository
- Name: flask-mysql
- Private

- Once created, click on the private repo you just created. 
- Click `view push commands`. 
- Gives you the commands to use. 
- E.g. login and build and push command etc. 


## Logging in to ecr via terminal.

- Copy the first command from ecr and run in terminal.
- Make sure AWS CLI is installed. 
  - `aws configure` 
  - Go to the AWS portal and IAM --> overview --> Security credentials --> Create access key.
  - Create a new access key and add that ID and access key to aws configure. 

- Run the command in terminal:
- `aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/c4z4m4f5`


- Docker error - 
  - Docker tries to save the login password in Windows’ built-in password storage (Credential Manager).

  ```
  error saving credentials: error storing credentials - err: exit status 1, out: `The stub received bad data.`
  ```

- Need to go into the docker config file and delete one line.
- `notepad $HOME\.docker\config.json`
  - Delete the `	"credsStore": "desktop",` line. 

- Re-run the command: 
- `aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/c4z4m4f5`
- Should see login success message!
- This logs into private registry in ecr. 

## Tagging image with ecr:

- Build the image first:
- Copy ccommand from aws ecr page - 
- `docker build -t flask-mysql .`

- Tag the image:
- Copy docker tag command from the ecr repo page. 
- `docker tag flask-mysql:latest public.ecr.aws/c4z4m4f5/flask-mysql:latest`


## Pushing image to ecr
- Push the image - copy command from ecr page again.
- `docker push public.ecr.aws/c4z4m4f5/flask-mysql:latest`

- Should be able to see the imagine in ECR repo. 

## Pulling image in ecr
- Same as push command but use pull instead.
- `docker pull public.ecr.aws/c4z4m4f5/flask-mysql:latest`


## This is just trial and error - go to step of creating custom network below for next step!

## Create a container from that image

- `docker run -p 5000:5000 public.ecr.aws/c4z4m4f5/flask-mysql:latest`
- This is running the image pulled from the ecr repository and running it on local host port 5000. 
- This won't work as I don't have a running version of mysql db. 


## Creating mysql db container

- `docker run -d --name mydb -e MYSQL_ROOT_PASSWORD=my-secret-pw mysql:8`

- A docker container with that name (mydb) already exists! 
- Need to delete previous container:
  - `docker ps -a`
  - See stopped container called mydb.
  - `docker rm -f mydb`
- Can also delete this from docker desktop. 

- Run command again - 
  - `docker run -d --name mydb -e MYSQL_ROOT_PASSWORD=my-secret-pw mysql:8`


## Create flask web app container:

-  `docker run -p 5000:5000 public.ecr.aws/c4z4m4f5/flask-mysql:latest`
- ERROR = The containers are not on the same network!

## Creating a custom network and putting both containers on the same network

- Delete the previous mysql container (was created using the `-d` flag so it running even after CTRL+C)
  - `docker ps`
  - `docker stop dac0891ce20f` - container ID.
  - `docker rm -f mydb`

THENNNN...: 
- Create a custom network and put both containers on the same network!!!

- Create a custom Docker network
  - `docker network create my-app-network`

- Run a MySQL container on the custom network
  - `docker run -d --name db --network my-app-network -e MYSQL_ROOT_PASSWORD=my-secret-pw mysql:8`

- Run a Flask container on the custom network, mapping port 5002 and using the specified image
  - `docker run -d -p 5000:5000 --network my-app-network public.ecr.aws/c4z4m4f5/flask-mysql:latest`


![alt text](../Images/localhostsuccess.png)

Or use:
`http://127.0.0.1:5000/`