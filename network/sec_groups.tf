#--------------------------network/sg_public.tf-----------------------

resource "aws_security_group" "sg_grtz" {
  for_each    = var.security_groups_in
  name        = each.value.name
  description = each.value.description
  vpc_id      = aws_vpc.vpc_grtz.id

  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.access_ip_in] # "0.0.0.0/0"
  }

  tags = {
    Name = "${each.value.name}"
  }
} #SG Resource



















