resource "aws_eip" "static_ip" {
  for_each = var.instance_type
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}
