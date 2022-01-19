# #--------------------------database/outputs.tf-----------------------

output "db_endpoint_id" {
  value = aws_db_instance.db_grtz_node.*.endpoint
}