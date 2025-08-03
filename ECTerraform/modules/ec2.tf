resource "aws_instance" "app_server" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.this.name]

  root_block_device {
    volume_type = "gp3"
    volume_size = var.disk_size
  }
  
  tags = {
    Name        = "${var.naming_prefix}-${var.instance_name}"
  }
}
