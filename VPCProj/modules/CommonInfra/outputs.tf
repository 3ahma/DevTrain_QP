output "vpc_cidr" {
  description = "VPC CIDR block"
  value       = var.cidr
}

output "azs" {
  description = "Availability zones"
  value       = var.azs
}

output "public_subnets" {
  description = "Public subnet CIDR blocks"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "Private subnet CIDR blocks"
  value       = module.vpc.private_subnets
}

output "database_subnets" {
  description = "Database subnet CIDR blocks"
  value       = module.vpc.database_subnets
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

