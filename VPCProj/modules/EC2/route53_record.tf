resource "aws_route53_record" "app_server_a_record" {

  for_each = aws_eip.static_ip
  zone_id  = aws_route53_zone.my_app_zone.zone_id
  name     = var.domain_name
  type     = "A"
  ttl      = 60
  records  = [each.value.public_ip]
}

resource "aws_route53_record" "www" {
  for_each = aws_eip.static_ip
  zone_id  = aws_route53_zone.my_app_zone.zone_id
  name     = "www.${var.domain_name}"
  type     = "A"
  ttl      = 60
  records  = [each.value.public_ip]
}
