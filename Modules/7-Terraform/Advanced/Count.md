# Terraform Advanced

## The count argument

- Can create multiple identical resources with one block. 


```
resource "aws_instance" "example" {
    count = 2
    ami = "ami-test"
    instance_type = "t2.micro"


    tags = {
        Name = "example-instance-${count.index}"
    }
}

```


