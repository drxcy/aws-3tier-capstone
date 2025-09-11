output "db_endpoint" {
  value = aws_db_instance.postgres.endpoint
}

output "db_port" {
  value = aws_db_instance.postgres.port
}

output "db_sg_id" {
  value = aws_security_group.db_sg.id
}

output "db_subnet_group" {
  value = aws_db_subnet_group.db_subnets.name
}
