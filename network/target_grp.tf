#--------------------------network/target_grp.tf-----------------------

resource "aws_lb_target_group" "tg_alb_grtz" {
  name     = "tg-grtz-${substr(uuid(), 0, 3)}"
  port     = var.tg_port     #80
  protocol = var.tg_protocol #HTTP
  vpc_id   = aws_vpc.vpc_grtz.id
  health_check {
    healthy_threshold   = var.alb_healthy_threshold   #2
    unhealthy_threshold = var.alb_unhealthy_threshold #2
    timeout             = var.alb_timeout              #3
    interval            = var.alb_interval             #30
  }
}

resource "aws_lb_listener" "tg_grtz_listener" {
  load_balancer_arn = aws_lb.alb_grtz.arn
  port              = var.tg_port
  protocol          = var.tg_protocol
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_alb_grtz.arn
  }
}

# resource "aws_lb_target_group_attachment" "tg_alb_attachment" {
#   target_group_arn = aws_lb_target_group.tg_alb_grtz.arn
#   target_id        = aws_instance.test.id
#   port             = 80
# }







