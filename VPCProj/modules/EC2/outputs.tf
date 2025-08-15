# output "elastic_ip" {
#   description = "The static public IP address of the EC2 instance."
#   value       = aws_eip.static_ip.public_ip
# }

output "elastic_ip" {
  description = "The static public IP addresses of the EC2 instances."
  value       = { for k, eip in aws_eip.static_ip : k => eip.public_ip }
}

output "frontend_tg_arn" {
  value = aws_lb_target_group.frontend.arn
}

output "backend_tg_arn" {
  value = aws_lb_target_group.backend.arn
}