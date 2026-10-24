# Modules

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

## Why modules:

- Reusability -> dry -> do not repeat yourself.
- Organization
- Consistency
- Collaboration

- Module = blueprint for a single piece of infrastructure.
  - They let us package and reuse infrastructure code.

## What makes a good module

- Output values - can use those values.
- Documentation - include a readme or comments.
- Simplicity. 
- Avoid hardcoding values. 
- Regularly tested and versioned. 



1. Create a folder for modules.
2. Create a subfolder depending on the service the module is for. E.g. ec2.
3. Reference the module in the main.tf file. 

```
 module "name" {
  source = "./modules/ec2"
}
```

## Modules can cause some destroy issues in pre-existing env:


- If doing modularising something in a production environment/pre-existing terraform env, terraform sees modules as a new path so the state file changes.
  - This causes the new modularized services to be destroyed and re-created. 
  - Do `terraform init` - terraform recognises new module


- 2 ways of telling terraform not to destroy and re-create:

  1. `terraform state mv aws_instance.web module.servers.aws_instance.web` = tell terraform it's the same EC2 through command. 
         

  2. Use a moved block inside the main.tf file. 

```
   moved {
     from = aws_instance.web
     to   = module.servers.aws_instance.web
   }

```
- Just put the old name in from and the new name in to.
- Do `terraform plan` to make sure nothing's getting destroyed. 
- `terraform state list` -> shows full name of everything terraform is managing. 



