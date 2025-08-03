module "dev" {
  source        = "../../modules"
  ami_id        = data.aws_ami.ubuntu.id
  prefix        = "dev"
  environment   = "dev"
  instance_type = "t3.micro"
  instance_name = "app-server"
  disk_size     = 30
  key_name      = aws_key_pair.dev_key.key_name
}
