module "prod" {
  source        = "../../modules"
  ami_id        = data.aws_ami.ubuntu.id
  naming_prefix = "prod"
  environment   = "prod"
  instance_type = "t3.micro"
  disk_size     = 30
  key_name      = aws_key_pair.prod_key.key_name
}
