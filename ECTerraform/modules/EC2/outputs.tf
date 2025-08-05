output "elastic_ip" {
  description = "The static public IP address of the EC2 instance."
  value       = aws_eip.static_ip.public_ip
}
