# module "dev_server" {
#   source        = "../../modules/PythonProcApp"
#   ami_id        = data.aws_ami.ubuntu.id
#   naming_prefix = "dev"
#   environment   = "dev"
#   instance_type = "t3.micro"
#   disk_size     = 30
#   key_name      = aws_key_pair.dev_key.key_name
#   domain_name   = "python-processes-app.me"
# }

locals {
  # Since your naming_prefix is "dev", the cluster name will be "dev-ecs-cluster"
  ecs_cluster_name = "dev-ecs-cluster"
}

module "dev_server" {
  source   = "../../../modules/EC2"
  key_name = aws_key_pair.dev_key.key_name

  ami_id         = data.aws_ami.ubuntu.id
  aws_ami_ecs_id = data.aws_ami.ecs_optimized.id
  app_image      = "081009271281.dkr.ecr.us-east-1.amazonaws.com/my-app:ae3be47"
  naming_prefix  = "dev"
  environment    = "dev"
  domain_name    = "python-processes-app.me"
  account_id     = data.aws_caller_identity.current.account_id
  region         = "us-east-1"

  acm_certificate_arn = "arn:aws:acm:us-east-1:081009271281:certificate/b09175c1-21dd-49e5-bf75-f98d1f1ebd2a"

  //user_data = data.template_file.app_userdata.rendered

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  public_subnet_ids  = data.terraform_remote_state.vpc.outputs.public_subnets
  private_subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnets

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
      user_data         = templatefile("../../../modules/EC2/userdata.sh.tmpl", {})
    }
    database = {
      scalable      = false
      instance_type = "t3.micro"
      disk_size     = 30
      subnet_id     = data.terraform_remote_state.vpc.outputs.database_subnets[0]
      type          = "database"
    }
    ecs = {

      scalable         = true
      instance_type    = "t3.small"
      subnet_id        = data.terraform_remote_state.vpc.outputs.private_subnets[0]
      disk_size        = 30
      type             = "ecs"
      desired_capacity = 2
      min_size         = 1
      max_size         = 3
      user_data        = templatefile("../../../modules/EC2/userdata_ecs.sh.tmpl", { cluster_name = local.ecs_cluster_name })
    }
  }

}
