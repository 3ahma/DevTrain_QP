data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20250508"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

data "aws_ami" "ecs_optimized" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }
}

data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../../CommonInfra/dev/terraform.tfstate"
  }
}

data "template_file" "app_userdata" {
  # or use templatefile() if you're on 0.12+:
  template = file("../../../modules/EC2/userdata.sh.tmpl")
  vars = {
    APP_VERSION = "V1.0" //var.app_version   # bump this to force a new LT version
  }
}


data "aws_caller_identity" "current" {}


#081009271281