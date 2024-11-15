# VPC Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = module.vpc.private_subnet_id
}

# # EC2 Outputs
output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = module.ec2.instance_id
}

# # ALB Outputs
# output "alb_dns_name" {
#   description = "DNS name of the Application Load Balancer"
#   value       = module.alb.alb_dns_name
# }

# SQS Outputs
output "sqs_queue_urls" {
  description = "URLs of the SQS Queues"
  value = {
    "incoming_queue_url"   = module.sqs.incoming_queue_url
    "completion_queue_url" = module.sqs.completion_queue_url
  }
}

# S3 Outputs
output "s3_bucket_arn" {
  description = "ARN of the S3 Bucket"
  value       = module.s3.s3_bucket_arn
}

output "s3_bucket_name" {
  description = "Name of the created S3 bucket"
  value       = module.s3.s3_bucket_name
}

# Secrets Manager Outputs
output "secret_arn" {
  description = "ARN of the Secrets Manager secret"
  value       = module.secrets_manager.secret_arn
}
