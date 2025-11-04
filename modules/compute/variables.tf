variable "project_name" {
  type        = string
  description = "Project name"
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "public_subnet_id" {
  type        = string
  description = "Public subnet ID"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "allow_ssh_cidr" {
  type        = string
  description = "CIDR allowed for SSH"
}

variable "ami_id" {
  type        = string
  description = "Optional EC2 AMI ID override to skip data source"
  default     = null
}