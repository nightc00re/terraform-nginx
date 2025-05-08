pipeline {
    agent any
    environment {
        AWS_DEFAULT_REGION = 'us-east-1'  // Or your desired region
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/nightc00re/terraform-nginx.git', branch: 'main'
            }
        }
        stage('Set up AWS Credentials') {
            steps {
                withCredentials([aws(credentialsId: 'cc911b6f-32eb-48d8-b8ac-659095548ee8')]) {
                    sh 'echo AWS credentials configured'
                }
            }
        }
        stage('Init Terraform') {
            steps {
                sh 'terraform init -backend-config=bucket=nightc00re -backend-config=key=nginx-state/terraform.tfstate -backend-config=region=us-east-1'
            }
        }
        stage('Plan Terraform') {
            steps {
                sh 'terraform plan'
            }
        }
        stage('Apply Terraform') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
    }
}

