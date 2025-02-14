output "vpc_id" {
  value       = module.network.vpc_id
  description = "Created VPC ID"
}

output "public_subnet_id" {
  value       = module.network.public_subnet_id
  description = "Public Subnet ID"
}

output "bucket_name" {
  value       = module.s3.bucket_name
  description = "S3 Bucket Name"
}

output "instance_id" {
  value       = module.compute.instance_id
  description = "EC2 Instance ID"
}

output "instance_public_ip" {
  value       = module.compute.public_ip
  description = "EC2 Public IP"
}