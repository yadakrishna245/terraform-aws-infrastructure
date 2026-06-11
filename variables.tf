variable "aws_region" {
  description = "AWS region for resource deployment"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name prefix for all resources"
  type        = string
  default     = "krishna-tf"
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "Dev"
}
