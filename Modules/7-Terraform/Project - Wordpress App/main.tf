
# When referencing variables to modules:
# The left side (region) is the name from the module’s variables.tf. It’s the box you’re filling in. 
# The right side (var.region) is the name from the root variables.tf, with var. in front. 
# It’s the value you’re putting in the box.

# Structure of variables in modules (from root to module): 
# Root variables.tf → root main.tf (module block) → module variables.tf → module’s resources       

# Structure of variables in modules (from module to module): 
#   Output created of variable in module1.
#   Variable defined in module2 variables file (empty variable).
#   Variable referenced in root main.tf file and filled into the empty variable. 
#   E.g. pub-sub-id = module.vpc.public-subnet-id



module "vpc" {
  source         = "./modules/networking"
  region         = var.region
  az-2           = var.az-2
  az-1           = var.az-1
  pub-sub-cidr   = var.public-subnet-cidr-1
  pub-sub-cidr-2 = var.public-subnet-cidr-2
  priv-sub-cidr  = var.private-subnet-cidr
  vpc-cidr       = var.vpc-cidr 
}


module "ec2" {
  source        = "./modules/app"
  region        = var.region
  vpc-cidr      = var.vpc-cidr
  instance_type = var.instance-type
  ami-id        = var.ami-id
  pub-sub-id    = module.vpc.public-subnet-id
  pub-sub-id-2  = module.vpc.public-subnet-id-2
  priv-sub-id   = module.vpc.private-subnet-id
  vpc-id        = module.vpc.vpc-id
}

