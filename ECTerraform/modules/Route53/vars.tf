variable "domain_name" {
  description = "The domain name to manage in Route 53 (e.g., my-app.com)."
  type        = string
}

variable "record_ip" {
  description = "The IP address that the domain's A record should point to."
  type        = string
}
