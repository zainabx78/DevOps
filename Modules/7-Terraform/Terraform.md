
# Terraform Deployment


## Terraform Connection to the Cloud

- Provider block
  
  - Plugin - that allows you to interact with cloud platforms, services and other technologies. 


```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

```
- Run `terraform init`


### Terraform Init

  - Initializes the backend - the state file. 
  - The provider block to make sure it has/downloads the required providers/plugins to communicate with the cloud.


### Terraform plan

- Previewing the changes before they happen to ensure everything is right. Security first mindset. 

- The changes between current and desired state. Those changes are the ones that will be deployed. 

- `create` `+` will show the resources being created.
- `update in-place` `~` will show the resources being modified.
- `destroy` `-` will show the resources being destroyed. 


### Terraform apply 

- Deploy the changes/desired configuration.
- Takes the execution plan and applies to the infrastructure. 
- `terraform apply --auto-approve` to bypass the question. 


### Terraform destroy

- Destroys all objects managed by a terraform configuration. 
- Convenient. 
- Prompt you to confirm before destroy. 

- Terraform updates the state file to reflect the destroyed resources to ensure that the state file remains accurate and up to date. 



## Terraform Registry  - provider

- `registry.terraform.io`
- Browse providers - choose AWS.
- Documentation.
  - Tells you how to use that provider. 
  

- Run `terraform init` once provider code is in the file. Initialize it. 


## Creating an EC2 instance

### Configuring a resource block

- Defining a resource you want to manage. 

- Use the documentation - find out the code to create an EC2 instance. 

- In the documentation - check which arguments are actually required within the ec2 resource type. 
  
  - Find the AMI ID from the aws portal - when creating EC2, when you pick the image to use it shows you the AMI ID for it too. 

```
resource "aws_instance" "Test" {
    ami                     = "ami-016457383cd81"
    instance_type           = "t2.micro"

tags = {
    Name = "Hello World"
  }
}


```


### Connecting Terraform to AWS account

- Need access key ID and secret value for the access key.
- In IAM - Users - access keys.
- Make sure the IAM user has permissions to create/manage the resources you're trying to create through terraform.  

- Use these commands: 

  - export AWS_ACCESS_KEY_ID="your_access_key_id"

  - export AWS_SECRET_ACCESS_KEY="your_secret_access_key"

  - export AWS_DEFAULT_REGION="your_default_region"

OR:

- Could use `aws configure` to connect aws account to terraform. And then use the same values there. (Secret key and ID).





