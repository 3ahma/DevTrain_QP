provider "aws" {
  region = "me-south-1"

  default_tags {
    tags = {
      "Terraform" = "true"
      "Environment" = "prod"
    }
  }
}
