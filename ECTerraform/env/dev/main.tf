module "dev" {
  source        = "../../modules"
  ami_id        = data.aws_ami.ubuntu.id
  naming_prefix = "dev"
  environment   = "dev"
  instance_type = "t3.micro"
  disk_size     = 30
  key_name      = aws_key_pair.dev_key.key_name
}
