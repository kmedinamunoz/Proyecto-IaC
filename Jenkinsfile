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
        dir('/Users/karen.medina/Documents/TERRAFORM/Proyecto-IaC') {
          sh 'terraform init'
        }
      }
    }
    stage('Terraform Plan') {
      steps {
        dir('/Users/karen.medina/Documents/TERRAFORM/Proyecto-IaC') {
          sh 'terraform plan'
        }
      }
    }
    stage('Terraform Apply') {
      when {
        branch 'main'
      }
      steps {
        dir('/Users/karen.medina/Documents/TERRAFORM/Proyecto-IaC') {
          sh 'terraform apply --auto-approve'
        }
      }
    }
    // stage('Terraform Destroy') {
    //   when{
    //     branch "destroy"
    //   }
    //   steps {
    //     dir('/Users/karen.medina/Documents/TERRAFORM/Proyecto-IaC') {
    //       sh 'terraform destroy --auto-approve'
    //     }
    //   }
    // }
  }

  post {
    always {
      echo "Build #${env.BUILD_NUMBER}. ${env.JOB_NAME}: ${currentBuild.currentResult}"
    }
  }
}
