#--------------------------network/subnets.tf-----------------------

resource "aws_subnet" "public_grtz_subnet" {
  count                   = var.public_sn_count
  vpc_id                  = aws_vpc.vpc_grtz.id
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = random_shuffle.az.result[count.index]
  #availability_zone = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"][count.index]

  tags = {
    Name = "grtz_public_${count.index + 1}"
  }
}

resource "aws_route_table_association" "public_grtz_association" {
  count          = var.public_sn_count
  subnet_id      = aws_subnet.public_grtz_subnet.*.id[count.index]
  route_table_id = aws_route_table.rt_table_public.id
}

resource "aws_subnet" "private_grtz_subnet" {
  count                   = var.private_sn_count
  vpc_id                  = aws_vpc.vpc_grtz.id
  cidr_block              = var.private_cidrs[count.index]
  map_public_ip_on_launch = false
  availability_zone       = random_shuffle.az.result[count.index]

  tags = {
    Name = "grtz_private_${count.index + 1}"
  }
}
