resource "aws_ecs_cluster" "ecs" {
  count = contains(keys(var.instance_type), "ecs") ? 1 : 0
  name  = "${var.naming_prefix}-ecs-cluster"
}
