locals {
  name = "my-app"
  tags = {
    Project     = "My App"
    ManagedBy   = "Terraform"
    Environment = "dev"
  }
}

module "vpc" {
  source = "../../../modules/CommonInfra"

  name             = local.name
  cidr             = "10.0.0.0/16"
  azs              = ["us-east-1a", "us-east-1b"]
  public_subnets   = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]
  database_subnets = ["10.0.5.0/24", "10.0.6.0/24"]
  //tags             = local.tags
}
