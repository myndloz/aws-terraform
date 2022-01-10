#--------------------------network/vpc.tf-----------------------

resource "random_integer" "random" {
  min = 1
  max = 100
}

resource "aws_vpc" "vpc_grtz" {
  cidr_block           = var.vpc_cidr #"10.100.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "grtz_vpc-${random_integer.random.id}"
  }
} #Resource



















