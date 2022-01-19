#--------------------------network/variables.tf-----------------------

variable "vpc_cidr" {
  type = string
}

variable "public_cidrs" {
  type = list(any)
}

variable "private_cidrs" {
  type = list(any)
}

variable "private_sn_count" {
  type = number
}

variable "public_sn_count" {
  type = number
}

variable "max_subnets" {
  type = number
}

variable "access_ip_in" {
  type = string
}

variable "security_groups_in" {}

variable "db_subnet_group" {
  type = bool
}
#----- Target Group
variable "tg_protocol" {
  type    = string
  default = "HTTP"
}

variable "tg_port" {
  type    = number
  default = 8000
}

variable "alb_healthy_threshold" {
  type    = number
  default = 2
}

variable "alb_unhealthy_threshold" {
  type    = number
  default = 2
}

variable "alb_timeout" {
  type    = number
  default = 3
}

variable "alb_interval" {
  type    = number
  default = 30
}








