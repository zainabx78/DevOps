# Docker Registries

- Storage and distribution hub.
- System for storing and sharing docker images.

- Public Registries = E.g. Dockerhub.
- Private Registries = E.g. AWS ECR - Secure and restricted. Can make the images public or private. 


- Streamlines deployment.
- Enhances collaboration.
- Ensures consistency. 

- Build docker image locally and push to docker registry.
- Pull image from registry to use it in the pipeline to make it all automated. 


## DockerHub

- Most popular docker registry.
- Developers store and share and access docker images. 
- Public - accessible. 
- Official secure images. 
- Free tier to host public images. 


### Sign up to dockerhub. I used signed up through google. 
- In terminal - `docker login` - use the link and enter code to login. 


### In dockerhub - Create a repository:
  - name: flask-mysql
  - Public.


### Need to build and tag image correctly:
- `docker build -t zainabx1/flask-mysql:v1 .`
  - Building an image from our docker file in current directory (.) with a tag. 
  - Make sure I'm in the hello_flask folder where the dockerfile is.
  - If you built it with just  `-t flask-mysql`, there’d be no username on the label, so docker push wouldn’t know which account it belongs to and would fail.
  - The username in the tag isn’t sending anything yet. It’s the “address label” that docker push reads later to know which Docker Hub account to upload to.


### Push the image to dockerhub repo:
- `docker push zainabx1/flask-mysql:v1`
  - Uses the dockerhub username, repo name and tag. 

- Go to dockerhub - should be able to see the newly pushed image. 


### Pulling the image to local machine:
- `docker pull zainabx1/flask-mysql:v1`
- You can share this with others to use. 


