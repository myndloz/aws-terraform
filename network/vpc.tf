#--------------------------network/vpc.tf-----------------------

data "aws_availability_zones" "AZs_grtz" {
  state = "available"
}

resource "random_shuffle" "az" {
  input        = data.aws_availability_zones.AZs_grtz.names
  result_count = var.max_subnets
}

resource "random_integer" "random" {
  min = 1
  max = 100
}

resource "aws_vpc" "vpc_grtz" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "grtz_vpc-${random_integer.random.id}"
  }
  lifecycle {
    create_before_destroy = true
  }
} #Resource

resource "aws_default_route_table" "rt_table_private" {
  #Pointing to the default route table that is created with the VPC
  #..as the route table to use by default...i.e it is private
  default_route_table_id = aws_vpc.vpc_grtz.default_route_table_id
  tags = {
    Name = "grtz_private"
  }
}

resource "aws_route_table" "rt_table_public" {
  vpc_id = aws_vpc.vpc_grtz.id

  tags = {
    Name = "grtz_public"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.rt_table_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_grtz.id
}
















