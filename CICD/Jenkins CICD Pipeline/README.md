# Creating a CI/CD pipeline using Jenkins, Maven, SonarQube etc. 

![Untitled Diagram drawio](https://github.com/user-attachments/assets/af039afa-5198-4b58-8b29-0258f03de2cd)

### Creating an EC2 Instance in AWS cloud to use for this project:
- I used a Terraform script to deploy an EC2 instance along with the necessary components such as VPC, subnets, security groups, Key pairs, an internet gateway and route tables. 
- The terraform script can be found in my terraform folder in the DevOps repository.

### Installing the necessary components:
- Firstly, jenkins needs to be installed-
```
sudo apt update

sudo apt install openjdk-17-jre

java -version
 
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update

sudo apt-get install jenkins

sudo systemctl start jenkins.service

sudo systemctl status Jenkins

```
