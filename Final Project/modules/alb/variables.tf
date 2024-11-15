
# Name of the Load Balancer
variable "name" {
  description = "Name of the Load Balancer"
  type        = string
}

# Whether the Load Balancer is internal or external
variable "internal" {
  description = "Set to true if the Load Balancer is internal"
  type        = bool
}

# List of subnet IDs for the Load Balancer
variable "subnets" {
  description = "List of subnets where the Load Balancer will be created"
  type        = list(string)
}

# VPC ID
variable "vpc_id" {
  description = "ID of the VPC where the Load Balancer and its resources will be deployed"
  type        = string
}

# Main target group configuration
variable "target_group_name" {
  description = "Name of the main target group"
  type        = string
}

variable "target_group_port" {
  description = "Port number for the main target group"
  type        = number
}

variable "target_group_protocol" {
  description = "Protocol for the main target group (e.g., HTTP)"
  type        = string
}

# Python application target group configuration
variable "python_target_group_name" {
  description = "Name of the Python application target group"
  type        = string
}

variable "python_target_group_port" {
  description = "Port number for the Python application target group"
  type        = number
}

variable "python_target_group_protocol" {
  description = "Protocol for the Python application target group (e.g., HTTP)"
  type        = string
}
