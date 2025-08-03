# output "dev_server_public_ip" {
#   description = "The public IP of the dev server."
#   value       = module.dev_server.instance_public_ip
# }

# output "ssh_command" {
#   description = "The command to SSH into the dev server."
#   value       = "ssh -i ${local_file.dev_private_key_pem.filename} ubuntu@${module.dev_server.instance_public_ip}"
# }
