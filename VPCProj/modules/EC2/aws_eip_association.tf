resource "aws_eip_association" "eip_assoc" {
  # for_each = aws_instance.app_server

  # instance_id   = each.value.id

  for_each      = var.instance_type
  instance_id   = aws_instance.app_server[each.key].id
  allocation_id = aws_eip.static_ip[each.key].id
}
