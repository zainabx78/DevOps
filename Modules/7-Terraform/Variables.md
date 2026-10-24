# Variables in Terraform

- Manage different environments with the same configuration files. 
- Enable dynamic configuration changes without altering code.
- Make module reusable across multiple project. Make it dry! 


## Variable Hierarchy

- From highest precedence to lowest:

1. Command line flags (using -var flag)
2. TF_VAR environment variables 
3. .tfvars files. 
4. default values.



## Variable types:

### Input variables

- These are the blanks. Someone outside the instructions fills them in, usually through the tfvars file. They’re meant to be changed.
  
- Declaring an input variable:
  
```
variable "image_id" {
    type = string
}
    
```

- Reference it as `var.image_id`
- If no value is set, it asks for a prompt of the value for that variable. 
- The value has to be string since that's what we set it as.


- Using a default value:

```
variable "instance_type" {
    type = string
    default = "t2.micro"
}
    
```

- This will no longer ask for an input from the user. 


### terraform.tfvars file:

1. Create the blank variable (usually in variables.tf)

`variable "region" {}`

2. Fill in the value in the .tfvars file (terraform.tfvars is loaded automatically)

`region = "us-west-1"`

3. Use the variable anywhere in your Terraform files

`location = var.region`

Note: the name must match exactly in all three places ("region").


### Local variables

- Internal to the terraform configuration.
- Helps you to keep your code dry. 
- These are values the instructions work out for themselves. Nobody fills them in from outside, and a tfvars file can’t change them. They’re mainly used to avoid typing the same thing over and over, or to combine other values together.


```
locals {
    ami_id = "i-dfjjoesoijfs"
    instance_type = "t2.micro"
}


```
- Reference it by using `local.ami_id` or `local.instance_type`


### Output Variables

- used to display values after the entire terraform apply has run. 
- Useful to passing information to other things. 
- Output block

```
output "private_ip" {
    description = "The private IP of ec2 Instance"
    value = aws_instance.test.private_ip
}

```

- Best practices:
  - Use descriptive names. 
  - Document the outputs - include descriptions for outputs.
  - Use outputs for critical information.
  - Secure sensitive outputs. Be careful. 




## Types of Variables

### Primitive types (single ingredients)

Hold one simple value.

| Type | What it holds | Example | Cooking comparison |
|---|---|---|---|
| string | Text, in quotes | `"hello world"` | The label on an ingredient |
| number | Whole or decimal numbers | `42` or `6.28` | How much of the ingredient |
| bool | Only `true` or `false` | `true` | A yes/no question, e.g. "Is the oven preheated?" |

### Complex types (full recipes)

Group several values together.

| Type | What it holds | Example | Cooking comparison |
|---|---|---|---|
| list | Several values in order, all the same type | `["flour", "sugar", "eggs"]` | A shopping list |
| map | Pairs of names and values | `{ flour = 500, eggs = 3 }` | A cookbook index pairing ingredients with amounts |
| object | Several named values that can be different types | `{ name = "Sam", age = 30, active = true }` | A full recipe card |

**Note:** a variable's default value is the weakest setting. Any other way of giving the variable a value overrides it.


# ---------------------------------------------------------------------------------

# HOW VARIABLES WORK IN MODULES: ROOT TO MODULE

- Root variables.tf → root main.tf (module block) → module variables.tf → module’s resources

1. Set a variable in the root variables file. 

```yml

# This is the only place "eu-west-2" ever appears.
variable "region" {
  default = "eu-west-2"
}

```


2. To move that variable to another module --> reference it in the module block in main.tf

   - The left side (region) is the name from the module’s variables.tf. It’s the box you’re filling in. The right side (var.region) is the name from the root variables.tf, with var. in front. It’s the value you’re putting in the box.

```yml

module "networking" {
  source = "./modules/networking"
  region = var.region 
}

```


3. Create that variable in the module's variables.tf

```yml

variable "region" {}

```




4. Use that variable as you would normally in the resource file in the module. 


```yml

resource "aws_instance" "test" {
  region = var.region
}

```

# ---------------------------------------------------------------------------------

# VARIABLES -> MODULE TO MODULE
 
- Structure of variables in modules (from module to module): 
  - Output created of variable in module1.
  - Variable defined in module2 variables file (empty variable).
  - Variable referenced in root main.tf file and filled into the empty variable. 
  - `E.g. pub-sub-id = module.vpc.public-subnet-id`


**E.g. there's 2 modules  --> app and networking. I need the VPC ID from networking for the app:**

1. Create an output in the module where the value you need is. Output it. 

   - vpc_id is the name you’re giving it on the way out
  
```yml

output "vpc_id" {
  value = aws_vpc.main.id
}

```

2. Create that variable in the module you want to use it in

```yml
variable "vpc_id" {}
```

3. Connect them at the root main.tf file

```yml

module "networking" {
  source = "./modules/networking"
}

module "app" {
  source = "./modules/app"
  vpc_id = module.networking.vpc_id
}

```


# ---------------------------------------------------------------------------------
