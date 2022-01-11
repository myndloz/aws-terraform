#--------------------------root/main.tf-----------------------
#-------------------------------------------------------------

module "network" {
  source             = "./network"
  vpc_cidr           = local.vpc_cidr
  access_ip_in       = var.access_ip
  security_groups_in = local.security_groups
  max_subnets        = 20
  private_sn_count   = 3
  public_sn_count    = 2
  public_cidrs       = [for x in range(2, 255, 2) : cidrsubnet(local.vpc_cidr, 8, x)]
  private_cidrs      = [for x in range(1, 255, 2) : cidrsubnet(local.vpc_cidr, 8, x)]
  db_subnet_group = true
} #Module

# module "database" {
#   source = "./database"

  
# }