# Containers on AWS

## Docker

- Docker is a software development platform to deploy apps. 
- Apps are packaged in containers that can be run on any OS.
- Apps run the same, regardless of where they're run. 
- Used for microservices architecture, lift and shift apps from on prem to AWS cloud. 


- All containers run on top of a single OS. They share the same OS kernal but keep processes, memory etc separate. 
- Each container has its own environment. 
- Share host OS. 
- Lightweight. 
- Less resource intensive. 

## DOCKER VS VM
- Virtual machines = on it's own separate OS. 
  - Large and slow to boot up 
  - Higher resource usage. 

- Containers
  - Share OS kernal. 
  - Lighter
  - Many containers on the same server. 
  - Fast
  - Use less CPU and memory. 


## Dockerfile
- Becomes a docker Image
- Includes all the details for the container. 


## Docker Image
    - Like a blueprint for application. 
    - Docker image becomes self contained unit after docker build that you can run as a container. 
    - Docker repository = like folders for docker images. 
    - E.g. Dockerhub - public repository. 


## ECR
- Elastic Container Registry 
- Container image repository. 
- Private repository by default. 
- Public repo - ECR public gallery. 
- Docker can push and pull images from ECR. 
- Backed by S3. 
- Access is controlled through IAM. 
- Supports image vulnerability scanning, versioning image tags, lifecycle.. 


## ECS
- Elastic Container Service
- AWS's own container orchestration platform. 
- Fully managed service. 

- Launch docker containers on AWS = launch ECS tasks on ECS clusters. 
  
- Launch types:
  
  - EC2 launch type
    - you must provision and maintain the infrastructure. 
    - Each EC2 instance must run the ECS agent to register in the ECS cluster.
    - AWS takes care of starting and stopping the containers and the lifecycle of the containers.
    - You still need to manage underlying infrastructure. 


  - Fargate Launch type
    - No managing/provisioning infrastructure.
    - Serverless!
    - You just need to create task definitions.
    - AWS just runs ECS tasks for you based on CPU/RAM. 
    - To scale = increase the number of tasks. 
    - Flexibility, not managing underlying infrastructure. 


- IAM Roles for ECS
  - EC2 instance profile (EC2 launch type only).
    - Used by ECS agent. 
    - Makes API calls to ECS service.
    - Send container logs to CloudWatch Logs. 
    - Pull Docker images from ECR.
    - Reference sensitive data in secrets. 
    - Manager or SSM parameter store. 

  - ECS Task Role
    - Allows each task to have a specific role.
    - Use different roles for different ECS services you run.
    - Task role is defined in the task definition.

  - Load balancer integrations
    - ALB - supported and works for most use cases.
    - NLB - recommended only for high throughput/high performance use cases, or pair it with AWS private link. 
    - CLB - Supported but no recommended.

  - ECS Service Auto Scaling
    - Automatically increase/decrease the desired number of ECS tasks.
    - It uses AWS application auto scaling.
    - Average CPU.
    - Average Memory - scale on RAM.
    - ALB request count per target - from ALB.
    - Target tracking with cloudwatch metrics.
    - Step scaling - cloudwatch alarms. 

## EKS
- Elastic Kubernetes Service
- Open source
- Managed

- It's a way to launch managed kubernetes clusters on AWS.
- Kubernetes = open source system for automatic deployment, scaling and management of containerized (usually docker) applications.
- An alternative to ECS -  Different API.
- Kubernetes = cloud agnostic. 
- 1 EKS cluster per region. 
- Collect logs and metrics using CloudWatch Container Insights. 


- Node types:

  - Managed Node Groups:
    - Creates and manages nodes for you. 
    - Nodes are part of an ASG managed by EKS. 
    - Supports on demand or spot instances. 

  - Self managed nodes
    - Created by you and registered to the EKS cluster and managed by an ASG.
    - You can use pre-built AMI - EKS optimized AMI.
    - Supports on demand and spot instances.

  - AWS Fargate
    - No maintenance required.


## AWS Fargate
- Serverless container platform. 
- Works with ECS and EKS. 





