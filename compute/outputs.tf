#--------------------------compute/ec2.tf-----------------------

output "instance_details" {
  value = aws_instance.ec2_grtz_node[*]
  sensitive = true
}





