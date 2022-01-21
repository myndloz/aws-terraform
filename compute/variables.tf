#--------------------------compute/variables.tf-----------------------

# variable "instance_count" {
#   type = number
#   default = 1
# }

variable "instance_type" {
  type = string
}

variable "count_in" {}
variable "subnet_id" {}
variable "vpc_security_group_ids" {}
variable "volume_size" {}
variable "key_name" {}
variable "public_key_path" {}
variable "user_data_path" {}
variable "dbuser" {}
variable "dbname" {}
variable "dbpassword" {}
variable "db_endpoint" {}
variable "lb_target_group_arn" {}
variable "tg_port" {}
