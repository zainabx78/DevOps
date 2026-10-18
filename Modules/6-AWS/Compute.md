# COMPUTE

- Renting virtual machines - EC2.
- Storing data on virtual drives - EBS.
- Distributing load across machines - ELB.
- Scaling the services using an auto-scaling group - ASG.


## EC2 CONFIG

- Operating system - E.g. linux, windows, mac..
- How much compute power and cores - CPU.
- Random access memory - RAM. 
- Storage space - 
  - Network attached - EBS and EFS.
  - Hardware - EC2 instance store.
- Network Card = speed of the card, public IP address. 
- Firewall rules - security group. 
- Bootstrap script - EC2 user data - configures at first launch. 


## EC2 USER DATA
- Bootstrapping = launching commands when the machine starts. 
- The script only runs once at the instance first start. 
- The user data script runs with root.
- EC2 user data is used to automate boot tasks such as:
  - Installing updates.
  - Installing software. 
  - Downloading common files from the internet.
  - Etc..

## EC2 Instance Types:

- General purpose.
- Compute Optimized.
- Storage Optimized. 
- Memory optimized.
- HPC optimized.
- Accelerated computing.

- Naming convention = m5.2xlarge
  - m = instance class.
  - 5 = generation.
  - 2xlarge = size within the class. 



## EC2 Purchasing Options

- On demand = 
  - Short workload.
  - Predictable pricing.
  - Pay by second. 

- Reserved = 
  - Long workloads.
  - 1 and 3 years.

- Savings plan = 
  - 1 and 3 years.
  - Commitment to an amount of usage.
  - Long workload.

- Spot instances = 
  - Short workloads.
  - Cheap.
  - Can lose instances - less reliable.

- Dedicated hosts = 
  - book an entire physical server - contraol instance placement.

- Dedicated instances = 
  - No other customers will share your hardware.

- Capacity Reservations = 
  - Reserve capacity in a specific AZ for any duration. 


Instance type finder - can help find the right instance type to use for your workload. 


## AMI
- Amazon Machine Image
- Blueprint for launching EC2 instances. 
- Built for specific regions and can be copied across regions.
- Allowing automation of EC2 set up.
- Includes everything that's needed to set up instance. 
- Can launch identical instances. 


