variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the project"
  default     = "zantac-poc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "ssh_allowed_cidr" {
  description = "CIDR block allowed for SSH access"
  default     = "0.0.0.0/0"  # In production, restrict to specific IPs
}

variable "ami_id" {
  description = "AMI ID for the instances"
  default     = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI (adjust as needed)
}

variable "instance_type" {
  description = "Instance type for the web servers"
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH key pair name"
  default     = "zantac-key"
}

variable "asg_min_size" {
  description = "Minimum size of the auto scaling group"
  default     = 1
}

variable "asg_max_size" {
  description = "Maximum size of the auto scaling group"
  default     = 3
}

variable "asg_desired_capacity" {
  description = "Desired capacity of the auto scaling group"
  default     = 2
}
