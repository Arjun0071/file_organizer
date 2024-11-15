variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0aebec83a182ea7ea"
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t3.medium"
}

variable "subnet_id" {
  description = "The Subnet ID where the EC2 instance will be launched"
  type        = string
}

variable "key_name" {
  description = "The key pair name for the EC2 instance"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the resources will be created"
  type        = string
}
