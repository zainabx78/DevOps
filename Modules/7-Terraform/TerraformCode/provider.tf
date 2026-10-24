
# The provider version
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
    key    = "terraform.tfstate"
    region = "eu-west-1"
    
  }
}



# Configure the AWS Provider
provider "aws" {
  region = "eu-west-1"
}



