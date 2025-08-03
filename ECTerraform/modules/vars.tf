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
