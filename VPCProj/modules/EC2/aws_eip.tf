resource "aws_eip" "static_ip" {
  for_each = { for k, v in var.instance_type : k => v if !lookup(v, "scalable", false) }
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}
