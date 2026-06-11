output "rds_endpoint" {
  value = aws_db_instance.mysql.endpoint
}

output "rds_deletion_protection" {
  value = aws_db_instance.mysql.deletion_protection
}
