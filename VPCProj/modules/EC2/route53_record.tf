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

resource "aws_route53_record" "asg_record" {
  for_each = { for k, v in var.instance_type : k => v if lookup(v, "scalable", false) }
  zone_id  = aws_route53_zone.my_app_zone.zone_id
  name     = "${each.key}.${var.domain_name}"
  type     = "CNAME"
  ttl      = 60
  records  = [aws_lb.dev_nlb.dns_name]
}
