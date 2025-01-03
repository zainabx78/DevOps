# Creating a CI/CD pipeline using Jenkins, Maven, SonarQube, Docker etc. 

![Untitled Diagram drawio](https://github.com/user-attachments/assets/af039afa-5198-4b58-8b29-0258f03de2cd)

### Creating an EC2 Instance in AWS cloud to use for this project:
- I created a Terraform script to deploy an EC2 instance along with the necessary components such as VPC, subnets, security groups, Key pairs, an internet gateway and route tables. 
- The terraform script can be found in my terraform folder in the DevOps repository.

### Installing and configuring Jenkins:
- Firstly, jenkins needs to be installed-
```
sudo apt update

sudo apt install openjdk-17-jre

java --version
 
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update

sudo apt-get install jenkins

sudo systemctl start jenkins.service

sudo systemctl status jenkins

```
- Use `ps -ef | grep jenkins ` to view jenkins running on port 8080 on the ec2 instance.
- In google, go to `PublicIpOfEC2:8080` to access the jenkins server.
- Use `sudo cat /var/lib/jenkins/secrets/initialAdminPassword` to view the password and enter into the Jenkins server.
  
  ![Screenshot 2024-12-22 195653](https://github.com/user-attachments/assets/afdecdf6-1c3c-4123-b9e2-52067480fc0c)

Install suggested plugins:
- Install docker pipeline plugin in jenkins: This is so I can use a docker agent for my jenkins pipeline. The docker agent creates a docker container to execute all stages of a pipeline and then the container is deleted once the stages are complete. This leads to a more cost effective and lightweight approach to execute pipelines.
- Install SonarQube Scanner plugin.
- Maven ---> maven is already installed on the docker plugin. 

Create a jenkins pipeline ---> link it to github repository which contains the jenkinsfile. The jenkins file can have any name and "jenkinsfile" name is not necessary. Save and apply.

### Installing and configuring Sonar Server in the EC2:
```
  apt install unzip
adduser sonarqube
su - sonarqube
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.4.0.54424.zip
unzip *
chmod -R 755 /home/sonarqube/sonarqube-9.4.0.54424
chown -R sonarqube:sonarqube /home/sonarqube/sonarqube-9.4.0.54424
cd sonarqube-9.4.0.54424/bin/linux-x86-64/
./sonar.sh start
```
Access SonarQube ----> In google, `publicIpEC2:9000`. SonarQube runs on port 9000. 
- By default, the username and password are both `admin`.
Connect SonarQube to jenkins:
- In SonarQube ---> My account ---> Security ---> Create Token and copy it.
- In jenkins ---> Manage Jenkins ---> Credentials ---> global credentials ---> add credential ---> secret text.

![Screenshot 2024-12-27 153323](https://github.com/user-attachments/assets/f33fdca6-7fbd-4313-af1a-05c9aa3d4e20)

### Installing and configuring the Docker slave in the EC2 instance containing Jenkins and SonarQube:
- In EC2, use root user `sudo su` after exiting the sonarqube user `exit`.
```
sudo apt install docker.io
sudo su - 
usermod -aG docker jenkins
usermod -aG docker ubuntu
systemctl restart docker
```
- Restart jenkins (add /restart at the end of the url port 8080).

### Installing Kubernetes:
- Open powershell ---> open wsl (ubuntu) terminal.
```
minikube start --driver=docker
```
![Screenshot 2024-12-28 170059](https://github.com/user-attachments/assets/b5c5e00e-7e1f-4474-96cc-18ec02800ccb)

### Installing ArgoCD
```
curl -sL https://github.com/operator-framework/operator-lifecycle-manager/releases/download/v0.30.0/install.sh | bash -s v0.30.0
kubectl create -f https://operatorhub.io/install/argocd-operator.yaml
kubectl get csv -n operators
```
![Screenshot 2024-12-28 170927](https://github.com/user-attachments/assets/ed11c8d3-03ed-41bd-98e7-39a6322429e1)
### Running the Jenkins pipeline
![Screenshot 2024-12-28 180810](https://github.com/user-attachments/assets/67bfbb70-3b84-4a76-9a70-740ae8de5a28)


