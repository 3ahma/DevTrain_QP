# resource "aws_autoscaling_instance_refresh" "instance_refresh" {
#   autoscaling_group_name = aws_autoscaling_group.scalable.name

#   strategy = "Rolling"

#   preferences {
#     min_healthy_percentage = 80
#     max_healthy_percentage = 125
#   }

#   triggers = ["launch_template"]
# }
