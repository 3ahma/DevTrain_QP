resource "aws_lb_target_group" "frontend" {
  name        = "dev-frontend-tg"
  port        = 80
  protocol    = "TCP"
  vpc_id      = var.vpc_id //data.terraform_remote_state.vpc.outputs.vpc_id
  target_type = "instance"
}

resource "aws_lb_target_group" "backend" {
  name        = "dev-backend-tg"
  port        = 8080
  protocol    = "TCP"
  vpc_id      = var.vpc_id //data.terraform_remote_state.vpc.outputs.vpc_id
  target_type = "instance"
}
