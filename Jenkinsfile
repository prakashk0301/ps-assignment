pipeline {
    agent any
    
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        TF_IN_AUTOMATION = 'true'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }
        
        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }
        
        stage('Approval') {
            steps {
                input message: 'Do you want to apply the plan?', ok: 'Apply'
            }
        }
        
        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
        
        stage('Wait for Instances') {
            steps {
                sh 'sleep 60'
            }
        }
        
        stage('Configure Instances with Ansible') {
            steps {
                dir('ansible') {
                    sh 'ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory_aws_ec2.yml playbook.yml'
                }
            }
        }
    }
    
    post {
        success {
            dir('terraform') {
                script {
                    def albDns = sh(script: 'terraform output alb_dns_name', returnStdout: true).trim()
                    echo "Deployment successful! Access the application at: ${albDns}"
                }
            }
        }
    }
}
