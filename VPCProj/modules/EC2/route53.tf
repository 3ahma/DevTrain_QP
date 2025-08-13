resource "aws_route53_zone" "my_app_zone" {
  name = var.domain_name
}
