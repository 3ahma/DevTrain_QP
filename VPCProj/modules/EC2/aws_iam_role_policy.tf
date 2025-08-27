resource "aws_iam_role_policy" "app_server_policy" {
  name = "${var.naming_prefix}-app-server-policy"
  role = aws_iam_role.app_server_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "ssm:GetParameter"
        ],
        Resource = "arn:aws:ssm:${var.region}:${var.account_id}:parameter/my-app/image"
      },
      {
        Effect   = "Allow",
        Action   = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ],
        Resource = "*"
      }
    ]
  })
}