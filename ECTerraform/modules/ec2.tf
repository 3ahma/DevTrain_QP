resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [
    aws_security_group.ssh.id,
    aws_security_group.http.id,
    aws_security_group.https.id
  ]

  root_block_device {
    volume_type = "gp3"
    volume_size = var.disk_size
  }

  tags = {
    Name = "${var.naming_prefix}-${var.instance_name}"
  }
}
