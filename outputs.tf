# #--------------------------root/outputs.tf-----------------------

output "public_sub_ids" {
  value = [module.network.public_sub_ids]
}

output "public_sec_grps" {
  value = module.network.public_sec_grp_ids
}

output "db_node_id" {
  value = module.database.db_endpoint_id
}

output "rds_sec_grp" {
  value = module.network.rds_subgrp_name
}

output "instances" {
  value = {for x in module.compute.instance_details: x.tags.Name => x.public_ip}
  sensitive = true
}