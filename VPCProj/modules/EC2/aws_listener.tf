resource "aws_lb_listener" "frontend" {
  load_balancer_arn = aws_lb.dev_nlb[0].arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }
}

resource "aws_lb_listener" "backend_http" {
  load_balancer_arn = aws_lb.dev_nlb[0].arn
  port              = 8080
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend.arn
  }
}

# Listener for HTTPS on port 443
resource "aws_lb_listener" "backend_https" {
  load_balancer_arn = aws_lb.dev_nlb[0].arn
  port              = 443
  protocol          = "TLS"                   # <-- Use TLS for HTTPS
  certificate_arn   = var.acm_certificate_arn # <-- Reference the certificate

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend.arn
  }
}

# resource "aws_lb_listener" "backend" {
#   load_balancer_arn = aws_lb.dev_nlb[0].arn
#   port              = 8080
#   protocol          = "TCP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.backend.arn
#   }
# }

resource "aws_lb_listener" "ecs" {
  count             = contains(keys(var.instance_type), "ecs") ? 1 : 0
  load_balancer_arn = aws_lb.dev_nlb[0].arn
  port              = 9090
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_new.arn
  }

  depends_on = [aws_lb_target_group.ecs_new]
}
