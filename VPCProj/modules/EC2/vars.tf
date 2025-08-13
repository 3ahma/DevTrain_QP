variable "instance_type" {
  description = "Map of instance configs"
  type = map(object({
    instance_type = string
    disk_size     = number
    subnet_id     = string
    type          = string
  }))
}


variable "key_name" {
  description = "Name of the key pair to use for SSH access"
  type        = string
}

variable "ami_id" {
  description = "The ID of the AMI to use for the EC2 instance."
  type        = string
}

variable "naming_prefix" {
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

variable "domain_name" {
  description = "The domain name to manage in Route 53 (e.g., my-app.com)."
  type        = string
}

variable "vpc_id" {
  type = string
}

