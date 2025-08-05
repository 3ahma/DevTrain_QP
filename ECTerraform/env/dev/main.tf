module "dev" {
  source        = "../../modules/EC2"
  ami_id        = data.aws_ami.ubuntu.id
  naming_prefix = "dev"
  environment   = "dev"
  instance_type = "t3.micro"
  disk_size     = 30
  key_name      = aws_key_pair.dev_key.key_name
}

module "dns" {
  source      = "../../modules/Route53"
  domain_name = "python-processes-app.me"
  record_ip   = module.dev.elastic_ip
}
