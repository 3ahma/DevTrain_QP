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

module "dev_server" {
  source   = "../../../modules/EC2"
  key_name = aws_key_pair.dev_key.key_name

  ami_id        = data.aws_ami.ubuntu.id
  naming_prefix = "dev"
  environment   = "dev"
  domain_name   = "python-processes-app.me"

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id


  instance_type = {
    frontend = {
      instance_type = "t3.micro"
      disk_size     = 30
      subnet_id     = data.terraform_remote_state.vpc.outputs.private_subnets[0]
      type          = "frontend"
    }
    # frontend2 = {
    #   instance_type = "t3.micro"
    #   disk_size     = 30
    #   subnet_id     = data.terraform_remote_state.vpc.outputs.private_subnets[1]
    # }

    backend = {
      instance_type = "t3.micro"
      disk_size     = 30
      subnet_id     = data.terraform_remote_state.vpc.outputs.private_subnets[0]
      type          = "backend"
    }
    # backend2 = {
    #   instance_type = "t3.micro"
    #   disk_size     = 30
    #   subnet_id     = data.terraform_remote_state.vpc.outputs.private_subnets[1]
    # }

    database = {
      instance_type = "t3.micro"
      disk_size     = 30
      subnet_id     = data.terraform_remote_state.vpc.outputs.database_subnets[0]
      type          = "database"
    }
    # database2 = {
    #   instance_type = "t3.micro"
    #   disk_size     = 30
    #   subnet_id     = data.terraform_remote_state.vpc.outputs.database_subnets[1]
    # }
  }
}
