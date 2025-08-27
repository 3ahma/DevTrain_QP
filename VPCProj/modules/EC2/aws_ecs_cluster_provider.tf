resource "aws_ecs_cluster_capacity_providers" "ecs" {
  count        = contains(keys(var.instance_type), "ecs") ? 1 : 0
  cluster_name = aws_ecs_cluster.ecs[0].name

  # This associates the provider with the cluster
  capacity_providers = [aws_ecs_capacity_provider.ecs[0].name]

  # This sets the provider as the default for the cluster
  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.ecs[0].name
    weight            = 1
    base              = 1
  }
}
