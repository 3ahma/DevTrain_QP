resource "tls_private_key" "dev_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "dev_key" {
  key_name   = "dev-instance-key"
  public_key = tls_private_key.dev_ssh_key.public_key_openssh
}

resource "local_file" "dev_private_key_pem" {
  content         = tls_private_key.dev_ssh_key.private_key_pem
  filename        = "dev-key.pem"
  file_permission = "0400"
}
