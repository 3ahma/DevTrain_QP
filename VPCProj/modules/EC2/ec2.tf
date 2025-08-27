resource "aws_instance" "app_server" {
  ami = var.ami_id

  for_each = {
    for k, v in var.instance_type :
    k => v if !lookup(v, "scalable", false)
  }

  instance_type = each.value.instance_type
  key_name      = var.key_name
  subnet_id     = each.value.subnet_id

  vpc_security_group_ids = [
    aws_security_group.ssh.id,
    aws_security_group.http.id,
    aws_security_group.https.id,
    aws_security_group.app_port.id
  ]

  root_block_device {
    volume_type = "gp3"
    volume_size = each.value.disk_size
  }

  tags = {
    Name = "${var.naming_prefix}-app-server-${each.value.type}"
  }
}









