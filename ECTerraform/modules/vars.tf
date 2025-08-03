/*variable "region" {
  description = "AWS region to deploy into"
  type        = string
}*/

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "The name for the EC2 instance and its resources."
  type        = string
}

variable "key_name" {
  description = "Name of the key pair to use for SSH access"
  type        = string
}

variable "tags" {
  description = "Tags for the EC2 instance"
  type        = map(string)
  default     = {}
}

variable "allowed_ports" {
  description = "List of ports to allow inbound (e.g., [22, 80, 443])"
  type        = list(number)
  default     = [22, 80]
}

variable "ami_id" {
  description = "The ID of the AMI to use for the EC2 instance."
  type        = string
}

variable "prefix" {
  description = "A prefix to be used for naming resources."
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, prod) for tagging."
  type        = string
}

variable "disk_size" {
  description = "The size of the root EBS volume in GB."
  type        = number
  default     = 8
}
