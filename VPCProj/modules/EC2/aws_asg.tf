# --- ASG for scalable roles ---
resource "aws_autoscaling_group" "scalable" {
  for_each = aws_launch_template.scalable

  name                = "${var.naming_prefix}-${each.key}-asg"
  desired_capacity    = lookup(var.instance_type[each.key], "desired_capacity", 1)
  min_size            = lookup(var.instance_type[each.key], "min_size", 1)
  max_size            = lookup(var.instance_type[each.key], "max_size", 3)
  vpc_zone_identifier = [var.instance_type[each.key].subnet_id]

  launch_template {
    id      = each.value.id
    version = "$Latest"
  }

  //target_group_arns = lookup(var.instance_type[each.key], "target_group_arns", [])
  health_check_type = "EC2"
  force_delete      = true

  tag {
    key                 = "Name"
    value               = "${var.naming_prefix}-${each.key}"
    propagate_at_launch = true
  }
}
