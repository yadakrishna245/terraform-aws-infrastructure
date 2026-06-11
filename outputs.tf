output "cloudfront_url" {
  description = "CloudFront distribution domain name"
  value       = module.s3_cloudfront.cloudfront_url
}

output "s3_bucket_name" {
  description = "S3 bucket name"
  value       = module.s3_cloudfront.s3_bucket_name
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc_ec2.vpc_id
}

output "ec2_public_ip" {
  description = "EC2 instance public IP"
  value       = module.vpc_ec2.ec2_public_ip
}

output "rds_endpoint" {
  description = "RDS database endpoint"
  value       = module.rds.rds_endpoint
}

output "iam_user_arn" {
  description = "IAM user ARN"
  value       = module.iam.user_arn
}
