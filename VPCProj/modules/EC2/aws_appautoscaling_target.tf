resource "aws_appautoscaling_target" "ecs_service_scaling_target" {
  count              = contains(keys(var.instance_type), "ecs") ? 1 : 0
  max_capacity       = 10 # Scale up to a maximum of 10 tasks
  min_capacity       = 2  # Scale down to a minimum of 2 tasks
  resource_id        = "service/${aws_ecs_cluster.ecs[0].name}/${aws_ecs_service.python_service[0].name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}
