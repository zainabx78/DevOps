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
  region = "eu-west-1"

  default_tags {
    tags = {
      Project     = "ci/cd"
      Environment = "dev"
    }
  }
}


resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket-zainab-123"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
