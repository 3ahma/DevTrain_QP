resource "aws_route53_record" "app_server_a_record" {
  zone_id = aws_route53_zone.my_app_zone.zone_id
  name    = var.domain_name
  type    = "A"
  ttl     = 60
  records = [aws_eip.static_ip.public_ip]
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.my_app_zone.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"
  ttl     = 60
  records = [aws_eip.static_ip.public_ip]
}
