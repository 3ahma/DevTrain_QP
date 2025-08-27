resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "${var.naming_prefix}-ecs-instance-profile"
  role = aws_iam_role.ecs_instance_role.name
}

resource "aws_iam_instance_profile" "app_server_profile" {
  name = "${var.naming_prefix}-app-server-profile"
  role = aws_iam_role.app_server_role.name
}