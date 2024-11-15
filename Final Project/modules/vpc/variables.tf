
variable "vpc_name" {
  description = "Name for the VPC"
  type        = string
  default     = "my-vpc"
}

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

variable "region" {
  description = "AWS Region for the VPC resources"
  type        = string
  default     = "ap-south-1"
}

variable "enable_nat_gateway" {
  description = "Boolean to determine if a NAT Gateway should be created"
  type        = bool
  default     = true
}
