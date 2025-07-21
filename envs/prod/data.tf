data "terraform_remote_state" "dev" {
  backend = "local"
  config = {
    path = "../dev/terraform.tfstate"
  }
}