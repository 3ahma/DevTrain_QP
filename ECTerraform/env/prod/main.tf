module "prod_server" {
  source        = "../../modules"
  ami_id        = data.aws_ami.ubuntu.id
  prefix        = "prod"
  environment   = "prod"
  instance_type = "t3.micro"
  instance_name = "app-server"
  disk_size     = 30
  key_name      = aws_key_pair.prod_key.key_name
}