# Merging multiple variables into one.

- E.g. Merging tags

- This example shows multiple tag values.
- At the end, when creating the ec2 instance, `merge` is used to bring all the tags together instead of repeating the tags again. 


```
locals {
  default_tags = {
    CreatedBy  = "Terraform"
    Department = "Engineering"
  }
}

variable "env_tags" {
  type = map(string)
  default = {
    Env  = "dev"
    Tier = "sandbox"
  }
}

resource "aws_instance" "merged_tags_example" {
  ami           = "ami-test"
  instance_type = "t2.micro"

  tags = merge(
    local.default_tags,
    var.env_tags,
    {
      Name = "merged-tags-${var.environment}"
    }
  )
}


```