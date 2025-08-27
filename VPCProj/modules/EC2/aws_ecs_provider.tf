resource "aws_ecs_capacity_provider" "ecs" {
  count = contains(keys(var.instance_type), "ecs") ? 1 : 0
  name  = "${var.naming_prefix}-ecs-capacity-provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.scalable["ecs"].arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      status                    = "ENABLED"
      target_capacity           = 75
      minimum_scaling_step_size = 1
      maximum_scaling_step_size = 2
    }
  }
}
