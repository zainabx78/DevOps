
## Resource block 
resource "aws_instance" "Test" {
    ami = local.instance_ami
    instance_type = var.instance_type

tags = {
    Name = "Hello World"
  }
}
 