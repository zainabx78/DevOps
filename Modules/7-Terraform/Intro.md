# Terraform 

- Infrastructure as code = IAC.
- Cloud agnostic - can be deployed to any cloud environment. 
- Can be used with many different tools e.g. kubernetes etc. 
- IAC can be stored in version control systems e.g. git. 

- Make sure things are not repeated. (Dry software engineering principle)


1. Terraform init

2. Terraform plan

3. Terraform apply --auto-approve

- Terraform validate = validates the terraform configuration files to ensure they are syntactically valid and internally consistent. 
- Terraform fmt = formats everything neatly. 


## Infrastructure Orchestration

- Terraform 
- Cloudformation

- This is used to deploy the infrastructure.


## Config management

- Ansible
- Puppet
- Chef

- This is used to configure the infrastructure to run certain things e.g. running a server. 


## Installing terraform 
- I already had terraform installed.
- It showed that it had a new update. 
- Installed new version from browser.
- `where terraform` to see where my terraform package lives.
- Replaced it with the new one I installed. 
- `terraform --version` 