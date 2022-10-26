pipeline {
  agent {
    label 'CR-HER-WKS19787'
  }

  environment {
    AWS_ACCESS_KEY_ID = credentials('AWS-ID')
    AWS_SECRET_ACCESS_KEY = credentials('AWS-Key')
    AWS_REGION = credentials('AWS-Region')
  }
  stages{
    stage('Terraform Init') {
      steps {
        dir('/Users/karen.medina/Documents/TERRAFORM/PROYECTO-IaC') {
          sh 'terraform init'
        }
      }
    }
    stage('Terraform Plan') {
      steps {
        dir('/Users/karen.medina/Documents/TERRAFORM/PROYECTO-IaC') {
          sh 'terraform plan'
        }
      }
    }
    stage('Terraform Apply') {
      when{
        branch 'main'
      }
      steps {
        dir('/Users/karen.medina/Documents/TERRAFORM/PROYECTO-IaC') {
          sh 'terraform apply --auto-approve'
        }
      }
    }
  }
  post {
    always {
      echo "SUCCESSFULLY COMPLETED"
    }
  }
}