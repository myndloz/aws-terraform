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
  db_subnet_group    = true
} #Module

module "database" {
  source                 = "./database"
  db_storage             = 10
  db_engine_version      = "5.7.22"
  db_instance_class      = "db.t2.micro"
  dbname                 = "rancher"
  dbuser                 = "bobby"
  dbpassword             = "=5pAtn1ck!"
  db_identifier          = "grtz-db"
  skip_db_snapshot       = true
  db_subnet_group_name   = module.network.rds_subgrp_name[0]
  vpc_security_group_ids = module.network.security_grp_ids
}