resource "aws_ecs_service" "python_service" {
  count           = contains(keys(var.instance_type), "ecs") ? 1 : 0
  name            = "${var.naming_prefix}-python-service"
  cluster         = aws_ecs_cluster.ecs[0].id
  task_definition = aws_ecs_task_definition.python_app[0].arn
  desired_count   = 1
  #launch_type     = "EC2"

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.ecs[0].name
    weight            = 1
  }

  network_configuration {
    subnets         = [var.instance_type["ecs"].subnet_id]
    security_groups = [aws_security_group.app_port.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_new.arn
    container_name   = "python-app"
    container_port   = 8000
  }

  depends_on = [aws_lb_listener.ecs]
}
