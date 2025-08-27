resource "aws_cloudwatch_log_group" "ecs_python_app" {
  count             = contains(keys(var.instance_type), "ecs") ? 1 : 0
  name              = "/ecs/${var.naming_prefix}-python-app"
  retention_in_days = 30 # Optional: Keeps logs for 30 days.
}
