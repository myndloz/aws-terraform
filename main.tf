#--------------------------root/main.tf-----------------------

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
  dbname                 = var.dbname
  dbuser                 = var.dbuser
  dbpassword             = var.dbpassword
  db_identifier          = "grtz-db"
  skip_db_snapshot       = true
  db_subnet_group_name   = module.network.rds_subgrp_name #"${module.network.rds_subgrp_name}"
  vpc_security_group_ids = module.network.private_sec_grp_ids
  count_in               = 1
}

module "compute" {
  source                 = "./compute"
  count_in               = 2
  subnet_id              = module.network.public_sub_ids
  instance_type          = "t3.micro"
  vpc_security_group_ids = module.network.public_sec_grp_ids
  volume_size            = 10
  key_name               = "minty-vm"
  public_key_path        = "/home/smyndlo/.ssh/myndloz-ssh.key.pub"
  user_data_path         = "${path.root}/userdata.tpl"
  dbname                 = var.dbname
  dbuser                 = var.dbuser
  dbpassword             = var.dbpassword
  db_endpoint            = module.database.db_endpoint_id[0]
  lb_target_group_arn = module.network.lb_target_group_arn
  tg_port = 8000
}
