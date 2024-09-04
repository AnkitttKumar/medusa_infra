output "ecs_service_name" {
  value = aws_ecs_service.medusa_service.name
}

output "rds_endpoint" {
  value = aws_db_instance.medusa_db.endpoint
}

output "s3_bucket" {
  value = aws_s3_bucket.medusa_bucket.bucket
}

