resource "aws_launch_template" "scalable" {
  for_each = {
    for k, v in var.instance_type :
    k => v if lookup(v, "scalable", false)
  }

  name_prefix   = "${var.naming_prefix}-${each.key}-"
  image_id      = var.ami_id
  instance_type = each.value.instance_type
  key_name      = var.key_name

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = each.value.disk_size
      volume_type = "gp3"
    }
  }

  network_interfaces {
    associate_public_ip_address = false
    subnet_id                   = each.value.subnet_id
    security_groups = [
      aws_security_group.ssh.id,
      aws_security_group.http.id,
      aws_security_group.https.id,
      aws_security_group.app_port.id
    ]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "${var.naming_prefix}-${each.key}"
      Environment = var.environment
      Role        = each.value.type
    }
  }
}
