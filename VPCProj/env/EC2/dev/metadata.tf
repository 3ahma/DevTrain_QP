provider "aws" {
  region = "us-east-1"


  default_tags {
    tags = {
      "Terraform"   = "true"
      "Environment" = "dev"
    }
  }

}


# terraform {
#   required_version = ">= 1.3.0" # or higher, depending on your Terraform CLI

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0" # pick a modern stable version
#     }
#   }
# }
