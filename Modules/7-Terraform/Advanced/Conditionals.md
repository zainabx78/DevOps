# Conditionals for Dynamic Configuration

- Allow you to execute different blocks depending on certain conditions e.g. value of a variable. 

- The `?` is a way of writing an if/else on one line. It always comes with a :, and reads like this:

`question ? answer if yes : answer if no`


1. If environment variable is prod, use t3 otherwise use t2.micro. 

```yml
variable "environment" {
  type    = string
  default = "dev"
}

resource "aws_instance" "conditional_instance" {
  ami = "ami-test"

  # If environment = "prod", use t3.large, else t2.micro
  instance_type = var.environment == "prod" ? "t3.large" : "t2.micro"

  tags = {
    Name = "conditional-instance-${var.environment}"
  }
}

```


2. Conditional resource creation 

- Whether or not to create an elastic IP based on the environment. 


```yml
variable "environment" {
  type    = string
  default = "dev"
}

resource "aws_instance" "main" {
  ami           = "ami-test"
  instance_type = "t2.micro"

  tags = {
    Name = "main-instance"
  }
}

resource "aws_eip" "optional_eip" {
  count    = var.environment == "prod" ? 1 : 0
  instance = aws_instance.main.id

  # Tag it for reference
  tags = {
    Name = "conditional-eip"
  }
}
```

- `  count    = var.environment == "prod" ? 1 : 0` . This means if the env is prod, create 1 eip, Otherwise create 0. 


3. Conditional logic in locals

- This variable decides whether we use bigger instance type and special tag. 


```yml
variable "is_high_priority" {
  type    = bool
  default = false
}

locals {
  selected_type = var.is_high_priority ? "t3.large" : "t2.micro"

  # If it's high priority, let's add a special tag
  extra_tags = var.is_high_priority ? { Priority = "High" } : {}
}

resource "aws_instance" "local_conditional" {
  ami           = "ami-test"
  instance_type = local.selected_type

  tags = merge(
    {
      Name = "local-conditional"
    },
    local.extra_tags
  )
}
```

- If variable is true, (default value) --> the type becomes t3.large.
  - If false, the type is t2.micro. 

- If variable is true, (default value) --> the special tag gets added.
  - If false, the tag is kept empty. 

- At the end (tags), it merges the tag specified and the special tag (could be empty or special dependent on the variable).





4. Conditional Expressions in a Dynamic Block


- Dynamic block. 
- Ingress rules are all always written out. What if we want to open SSH only sometimes:
  - If the variable is false, the SSH rule doesn't get created. 


```yml
variable "enable_ssh" {
  type    = bool
  default = false
}

resource "aws_security_group" "dynamic_rules" {
  name        = "conditional-sg"
  description = "Example security group with optional SSH"

  vpc_id = "vpc-123456" # localstack ignores this, but we must define something

  # Always create a rule for HTTP
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Conditionally create an SSH rule
  dynamic "ingress" {
    for_each = var.enable_ssh ? [1] : []
    content {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
```
- `for_each = var.enable_ssh ? [1] : []` 
  - This means that if the variable is true, make the ssh rule. If false, make nothing from in that resource (the ssh rule).




5. Combining Conditionals


- 2 Variables
- 

```yml
variable "environment" {
  type    = string
  default = "dev"
}

variable "is_high_priority" {
  type    = bool
  default = false
}

resource "aws_instance" "combo_instance" {
  count = var.environment == "prod" ? (var.is_high_priority ? 3 : 2) : 1

  ami           = "ami-test"
  instance_type = "t2.micro"

  tags = {
    Name         = "combo-instance-${count.index}"
    Environment  = var.environment
    HighPriority = var.is_high_priority ? "yes" : "no"
  }
}

```



`  count = var.environment == "prod" ? (var.is_high_priority ? 3 : 2) : 1`

  - There's 2 variables. 
  - If the env variable is prod, and high priority is true, create 3 instance. 
  - If the env variable is prod and the high priority variable is false, create 2 instance. 
  - If the env variable is dev, it creates 1 instance. 


