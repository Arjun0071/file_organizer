# VPC Variables
variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

# # EC2 Variables
variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0aebec83a182ea7ea"
}

variable "key_name" {
  description = "Name of the SSH key pair to associate with the instance"
  type        = string
  default     = "default-keypair"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

# ALB Variables
variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
  default     = "app-alb"
}

# SQS Variables
variable "incoming_queue_name" {
  description = "Name of the incoming SQS queue"
  type        = string
  default     = "incoming-queue"
}

variable "completion_queue_name" {
  description = "Name of the completion SQS queue"
  type        = string
  default     = "completion-queue"
}

# S3 Variables
variable "bucket_name" {
  description = "Name of the S3 Bucket"
  type        = string
  default     = "app-bucket"
}

# Secrets Manager Variables
variable "secret_name" {
  description = "Name of the Secrets Manager secret"
  type        = string
  default     = "app-secret"
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "myzapp-bucket"
}

variable "incoming_queue_url" {
  description = "URL of the incoming SQS queue"
  type        = string
  default     = "incoming_url"
}

variable "completion_queue_url" {
  description = "URL of the completion SQS queue"
  type        = string
  default     = "completion_url"
}
