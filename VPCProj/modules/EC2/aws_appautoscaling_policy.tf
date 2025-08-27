resource "aws_appautoscaling_policy" "ecs_service_cpu_scaling_policy" {
  count              = contains(keys(var.instance_type), "ecs") ? 1 : 0
  name               = "${var.naming_prefix}-cpu-scaling-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_service_scaling_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_service_scaling_target[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_service_scaling_target[0].service_namespace

  target_tracking_scaling_policy_configuration {
    target_value       = 60
    scale_in_cooldown  = 300
    scale_out_cooldown = 60

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}
