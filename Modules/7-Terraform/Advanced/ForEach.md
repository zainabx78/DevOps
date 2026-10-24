# For Each Argument

- Multiple resources with different attributes.

```
locals {

    instances = {

        dev1 = {
            instance_type = "t2.micro"
            ami_id = "ami-dev1"
        }


        dev2 = {
            instance_type = "t3.micro"
            ami_id = "ami-dev2"
        }


        dev3 = {
            instance_type = "t3.micro"
            ami_id = "ami-dev3"
        }
    }

}



resource "aws_instance" "test" {
    for_each = local.instances

    instance_type = each.value.instance_type
    ami = each.value.ami_id


    tags = {
        Name = each.key
    }
}
```
