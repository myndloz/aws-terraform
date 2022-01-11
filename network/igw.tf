#--------------------------network/igw.tf-----------------------

resource "aws_internet_gateway" "igw_grtz" {
  vpc_id = aws_vpc.vpc_grtz.id

  tags = {
    Name = "igw-grtz"
  }
}

