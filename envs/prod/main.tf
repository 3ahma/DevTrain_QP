module "prod"{
    source       = "../../modules"
    file_content = data.terraform_remote_state.dev.outputs.file_content
}