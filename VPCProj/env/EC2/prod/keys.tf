resource "tls_private_key" "prod_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "prod_key" {
  key_name   = "prod-instance-key"
  public_key = tls_private_key.prod_ssh_key.public_key_openssh
}

resource "local_file" "prod_private_key_pem" {
  content         = tls_private_key.prod_ssh_key.private_key_pem
  filename        = "prod-key.pem"
  file_permission = "0400"
}
