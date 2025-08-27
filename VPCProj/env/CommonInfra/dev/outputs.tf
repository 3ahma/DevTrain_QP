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

output "private_route_table_ids" {
  value = module.vpc.private_route_table_ids
}

