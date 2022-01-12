#--------------------------network/loadbalancer.tf-----------------------

resource "aws_lb" "alb_grtz" {
  name               = "alb-grtz"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_grtz["public"].id]
  subnets            = [for subnet in aws_subnet.public_grtz_subnet : subnet.id]
  idle_timeout       = 400

  #enable_deletion_protection = true
}





