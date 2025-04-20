# IAM User for Restarting Web Servers
resource "aws_iam_user" "restart_user" {
  name = "${var.project_name}-restart-user"
  path = "/"

  tags = {
    Name = "${var.project_name}-restart-user"
  }
}

# IAM Policy for Restarting Web Servers
resource "aws_iam_policy" "restart_policy" {
  name        = "${var.project_name}-restart-policy"
  description = "Policy to allow restarting web servers"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeAutoScalingInstances",
          "ec2:DescribeInstances",
          "ec2:RebootInstances"
        ]
        Effect   = "Allow"
        Resource = "*"
        Condition = {
          StringEquals = {
            "ec2:ResourceTag/Project" = var.project_name
          }
        }
      }
    ]
  })
}

# Attach Policy to User
resource "aws_iam_user_policy_attachment" "restart_attachment" {
  user       = aws_iam_user.restart_user.name
  policy_arn = aws_iam_policy.restart_policy.arn
}
