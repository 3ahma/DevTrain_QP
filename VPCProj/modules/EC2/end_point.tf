module "endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  vpc_id = var.vpc_id

  endpoints = {
    s3 = {
      service      = "s3"
      service_type = "Gateway"
      tags         = { Name = "s3-vpc-endpoint" }
    },
    dynamodb = {
      service         = "dynamodb"
      service_type    = "Gateway"
      route_table_ids = var.private_route_table_ids
      tags            = { Name = "dynamodb-vpc-endpoint" }
    },
    sns = {
      service    = "sns"
      subnet_ids = var.private_subnet_ids
      tags       = { Name = "sns-vpc-endpoint" }
    },
    sqs = {
      service             = "sqs"
      private_dns_enabled = true
      security_group_ids = [
        aws_security_group.ssh.id,
        aws_security_group.http.id,
        aws_security_group.https.id,
        aws_security_group.app_port.id
      ]
      subnet_ids = var.private_subnet_ids
      tags       = { Name = "sqs-vpc-endpoint" }
    },
  }
  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}

