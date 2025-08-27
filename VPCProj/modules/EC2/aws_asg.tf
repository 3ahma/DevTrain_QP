# --- ASG for scalable roles ---
resource "aws_autoscaling_group" "scalable" {
  for_each = aws_launch_template.scalable

  name                = "${var.naming_prefix}-${each.key}"
  desired_capacity    = lookup(var.instance_type[each.key], "desired_capacity", 1)
  min_size            = lookup(var.instance_type[each.key], "min_size", 1)
  max_size            = lookup(var.instance_type[each.key], "max_size", 3)
  vpc_zone_identifier = [var.instance_type[each.key].subnet_id]

  protect_from_scale_in = true

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 90
      max_healthy_percentage = 125
    }
    #triggers = ["launch_template"]
  }




  launch_template {
    id      = each.value.id
    version = "$Latest"
  }

  //target_group_arns = lookup(var.instance_type[each.key], "target_group_arns", [])
  target_group_arns = each.key == "backend" ? ["arn:aws:elasticloadbalancing:us-east-1:081009271281:targetgroup/dev-backend/bd9306e2b72630af"] : lookup(var.instance_type[each.key], "target_group_arns", [])
  health_check_type = "EC2" //"ELB"
  force_delete      = true

  tag {
    key                 = "Name"
    value               = "${var.naming_prefix}-${each.key}"
    propagate_at_launch = true
  }
}
