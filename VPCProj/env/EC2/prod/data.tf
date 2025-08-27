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


data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../../CommonInfra/dev/terraform.tfstate"
  }
}
