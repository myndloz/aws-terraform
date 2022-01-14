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