# Terraform State File

- Terraform state file is the blueprint.
- It's a record of the existing infrastructure.
- Up-to-date record version of actual state of cloud environment. 
- Idempotency = no matter how many times you run it, it'll give you the same result. Only changes get applied, not everything/the whole infrastructure. 


- Statefiles shouldn't be comitted to git repo - sensitive info may be exposed. 

## Desired vs Current State

- State file = current state.

- Desired state = .tf files / configuration.

- The terraform state file compares the terraform configuration (.tf files and config you're trying to deploy) with the current state and then terraform decides on what needs to be created - the difference between the 2 states. 


## Local and Remote Statefiles


### Local statefile = Locally stored on your computer.
  - Suitable for small projects and indiviual use. 


### Remote statefile = stored remotely. 
  - E.g. S3, Azure Blob storage, Terraform cloud. 
  - Suitable for team environment and larger projects.
  - Multiple people can access the same state.


- Creating remote statefiles:
  
  1. Create S3 bucket.
  2. Ensure the IAM user has the permissions to create, read and write to the s3 bucket. Also check bucket policies to make sure nothing is overriding these permissions. Error 403 with s3 is usually a permissions error. 
  3. Add the backend block within the terraform block:

```

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

# Configure remote backend 
  backend "s3" {
    bucket = "bucket_name"
    key    = "terraform.tfstate" # path to the tf state file inside the bucket
    region = "eu-west-1"
    
  }
}

```

4. Run `terraform init`. 
   - Copies the local statefile to the s3 backend. 
   - Statefile is now stored remotely!






- STATE LOCKING = 
    - Helps prevent users making changes at the same time. 


- Automatic backups and security
  - Many remote backends can automatically backup state file and apply encryption. 

