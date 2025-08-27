resource "aws_ecs_task_definition" "python_app" {
  count                    = contains(keys(var.instance_type), "ecs") ? 1 : 0
  family                   = "${var.naming_prefix}-python-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["EC2"]

  execution_role_arn = aws_iam_role.ecs_task_execution_role[0].arn

  cpu    = "256"
  memory = "512"

  container_definitions = jsonencode([
    {
      name      = "python-app"
      image     = var.app_image # e.g. "1234567890.dkr.ecr.us-east-1.amazonaws.com/python-app:latest"
      essential = true
      portMappings = [
        {
          containerPort = 8000
          hostPort      = 8000
          protocol      = "tcp"
        }
      ]
      healthCheck = {
        command     = ["CMD-SHELL", "curl -f http://localhost:8000/health || exit 1"]
        interval    = 30
        timeout     = 5
        retries     = 3
        startPeriod = 60
      }

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs_python_app[0].name
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
}


#sha256:607da442cbc3ccea0366218d7ecf17aad7d1bccd4f0229bbaa01401fe45117ee
#sha256:3a0ab860686192f457670285078bfa593367a4e87bc31352b4664c7e07356495
