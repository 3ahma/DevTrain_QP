resource "aws_route53_record" "app_server_a_record" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.domain_name
  type    = "A"
  ttl     = 60
  records = [aws_eip.static_ip.public_ip]
}
