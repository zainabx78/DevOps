
variable "instance_type" {
  type = string
  default = "t2.micro"
  
}

 
locals {
  instance_ami = "ami-03s3a8798ds5" # made up
}


output "private_ip" {
    description = "The private IP of ec2 Instance"
    value = aws_instance.Test.private_ip
}