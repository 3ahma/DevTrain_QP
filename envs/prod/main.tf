terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}


provider "local" {}

module "my_file"{
    source       = "../../modules"
    file_content = data.terraform_remote_state.dev.outputs.file_content
}

variable "file_content" {
  description = "String in the file"
  type        = string 
}

data "terraform_remote_state" "dev" {
  backend = "local"
  config = {
    path = "../dev/terraform.tfstate"
  }
}