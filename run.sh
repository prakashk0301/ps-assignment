#!/bin/bash
set -e

echo "Starting Zantac POC deployment..."

# Deploy Terraform infrastructure
cd terraform
echo "Initializing Terraform..."
terraform init

echo "Applying Terraform configuration..."
terraform apply -auto-approve

# Wait for instances to be ready
echo "Waiting for instances to be ready..."
sleep 60

# Run Ansible playbook
cd ../ansible
echo "Configuring web servers with Ansible..."
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory_aws_ec2.yml playbook.yml

# Output the ALB DNS name
cd ../terraform
echo "Deployment complete! Access the application at:"
terraform output alb_dns_name

echo "POC Deployment finished successfully."
