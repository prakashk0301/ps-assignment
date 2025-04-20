output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "alb_dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.web_lb.dns_name
}

output "asg_name" {
  description = "Name of the auto scaling group"
  value       = aws_autoscaling_group.web_asg.name
}

output "restart_user_name" {
  description = "Name of the IAM user with restart permissions"
  value       = aws_iam_user.restart_user.name
}

output "web_sg_id" {
  description = "ID of the web server security group"
  value       = aws_security_group.web_sg.id
}
