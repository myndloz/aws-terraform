#--------------------------network/outputs.tf-----------------------

output "vpc_id" {
  value = aws_vpc.vpc_grtz.id
}

output "rds_subgrp_name" {
  value = aws_db_subnet_group.rds_subnetgrp_grtz.*.name
}

output "private_sec_grp_ids" {
  value = [aws_security_group.sg_grtz["private"].id]
}

output "public_sec_grp_ids" {
  value = [aws_security_group.sg_grtz["public"].id]
}

output "public_sub_ids" {
  value = aws_subnet.public_grtz_subnet.*.id
}

