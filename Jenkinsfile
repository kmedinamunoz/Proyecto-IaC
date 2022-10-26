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
      when{
        branch 'main'
      }
      steps {
        if (env.BRANCH_NAME == 'dev') {
          echo 'Terraform Apply will only executes in the main branch'
        } else {
            sh 'terraform apply --auto-approve' 
        }
      }
    }
  }
}
