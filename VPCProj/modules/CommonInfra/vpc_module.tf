module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.9.0"

  //name = "${local.name}-vpc"
  name = var.name
  cidr = var.cidr

  azs              = var.azs
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
  database_subnets = var.database_subnets

  manage_default_route_table    = true
  manage_default_security_group = true

  enable_nat_gateway = true
  single_nat_gateway = true

  //tags = local.tags
}