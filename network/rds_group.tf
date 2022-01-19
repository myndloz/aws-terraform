#--------------------------network/rds_groups.tf-----------------------

resource "aws_db_subnet_group" "rds_subnetgrp_grtz" {
  count      = var.db_subnet_group == true ? 1 : 0
  name       = "grtz_rds_sng"
  subnet_ids = aws_subnet.private_grtz_subnet.*.id
  tags = {
    Name = "grtz_rds_sng"
  }
}










