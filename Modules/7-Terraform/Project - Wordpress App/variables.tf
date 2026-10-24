
# Set the region for the vpc
variable "region" {
  default = "eu-west-1"
}

 # ALB Needs 2 AZ's - each public subnet in a different az.
variable "az-2" {
  default = "eu-west-1b"
}

variable "az-1" {
  default = "eu-west-1a"
}

# Setting a variable for ami ID for the wordpress app. 
variable "ami-id" {
  default = "ami-058cbf9cc17bf0455"
}

# Setting a variable for instance type 
variable "instance-type" {
  default = "t3.micro"
}

# VPC CIDR block
# covers 10.0.0.0 all the way to 10.0.255.255
variable "vpc-cidr" {
  default = "10.0.0.0/16"
}

# VPC CIDR block
variable "private-subnet-cidr" {
  default = "10.0.0.0/26"
}


variable "public-subnet-cidr-1" {
  default = "10.0.1.0/26"
}

variable "public-subnet-cidr-2" {
  default = "10.0.2.0/26"
}


variable "domain-name" {
  default = "zainabf.co.uk"
}