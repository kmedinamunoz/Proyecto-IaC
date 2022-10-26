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
        sh 'terraform init'
      }
    }
    stage('Terraform Plan') {
      steps {
        sh 'terraform plan'
      }
    }
    stage('Terraform Apply') {
      when {
        branch 'main'
      }
      steps {
        sh 'terraform apply --auto-approve'
      }
    }
  }
  post {
    always {
      echo "Full Project Name: ${env.JOB_NAME}"
      echo "Build: #${env.BUILD_NUMBER}"
      echo "Status: ${currentBuild.currentResult}"
    }
  }
}
