module "prod_server" {
  source   = "../../../modules/EC2"
  key_name = aws_key_pair.dev_key.key_name

  ami_id        = data.aws_ami.ubuntu.id
  naming_prefix = "prod"
  environment   = "prod"
  domain_name   = "python-processes-app.me"

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  public_subnet_ids       = data.terraform_remote_state.vpc.outputs.public_subnets
  private_subnet_ids      = data.terraform_remote_state.vpc.outputs.private_subnets

  instance_type = {
    frontend = {
      scalable          = true
      instance_type     = "t3.micro"
      disk_size         = 30
      subnet_id         = data.terraform_remote_state.vpc.outputs.private_subnets[0]
      type              = "frontend"
      desired_capacity  = 2
      min_size          = 1
      max_size          = 4
      target_group_arns = [module.dev_server.frontend_tg_arn]
    }
    backend = {
      scalable          = true
      instance_type     = "t3.micro"
      disk_size         = 30
      subnet_id         = data.terraform_remote_state.vpc.outputs.private_subnets[0]
      type              = "backend"
      desired_capacity  = 1
      min_size          = 1
      max_size          = 3
      target_group_arns = [module.dev_server.backend_tg_arn]
    }
    database = {
      scalable      = false
      instance_type = "t3.micro"
      disk_size     = 30
      subnet_id     = data.terraform_remote_state.vpc.outputs.database_subnets[0]
      type          = "database"
    }
  }
}
