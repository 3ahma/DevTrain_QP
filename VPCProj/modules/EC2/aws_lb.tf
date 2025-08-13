resource "aws_lb" "dev_nlb" {

 // for_each      = var.instance_type  
  name               = "dev-nlb"
  load_balancer_type = "network"
  internal           = false
  subnets            = var.public_subnet_ids//each.value.public_subnets //data.terraform_remote_state.vpc.outputs.public_subnets

  tags = {
    Environment = "dev"
    Name        = "dev-nlb"
  }
}

variable "public_subnet_ids" {
  description = "A list of public subnet IDs for the NLB."
  type        = list(string)
}
