resource "aws_lb_target_group" "frontend" {
  name        = "dev-frontend"
  port        = 80
  protocol    = "TCP"
  vpc_id      = var.vpc_id //data.terraform_remote_state.vpc.outputs.vpc_id
  target_type = "instance"
}

resource "aws_lb_target_group" "backend" {
  name        = "dev-backend"
  port        = 80
  protocol    = "TCP"
  vpc_id      = var.vpc_id //data.terraform_remote_state.vpc.outputs.vpc_id
  target_type = "instance"
}

resource "aws_lb_target_group" "ecs_new" {
  name     = "${var.naming_prefix}-ecs"
  port     = 9090
  protocol = "TCP"
  vpc_id   = var.vpc_id

  target_type = "ip"

  health_check {
    path = "/health"
  }

  lifecycle {
    create_before_destroy = true
  }
}
