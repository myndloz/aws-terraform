#--------------------------network/subnets.tf-----------------------

resource "aws_subnet" "public_grtz_subnet" {
  count = length(var.public_cidrs)
  vpc_id     = aws_vpc.vpc_grtz.id
  cidr_block = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"][count.index]
 
  tags = {
    Name = "grtz_public_${count.index + 1}"
  }
}

resource "aws_subnet" "private_grtz_subnet" {
  count = length(var.private_cidrs)
  vpc_id     = aws_vpc.vpc_grtz.id
  cidr_block = var.private_cidrs[count.index]
  map_public_ip_on_launch = false
  availability_zone = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"][count.index]
 
  tags = {
    Name = "grtz_private_${count.index + 1}"
  }
}
