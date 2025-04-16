pipeline {
  agent any

  environment {
    // Azure credentials from Jenkins (Secret Text)
    ARM_CLIENT_ID        = credentials('ARM_CLIENT_ID')
    ARM_CLIENT_SECRET    = credentials('ARM_CLIENT_SECRET')
    ARM_SUBSCRIPTION_ID  = credentials('ARM_SUBSCRIPTION_ID')
    ARM_TENANT_ID        = credentials('ARM_TENANT_ID')

    // GitHub access via PAT
    GIT_CREDENTIALS_ID = 'git-https-pat'

    // VM admin password (Secret Text)
    ADMIN_PASSWORD = credentials('vm-admin-password')
  }

  stages {
    stage('Clone Code') {
      steps {
        git credentialsId: "${GIT_CREDENTIALS_ID}", url: 'https://github.com/x23167645/tf-jenkins.git', branch: 'main'
      }
    }

    stage('Terraform Init') {
      steps {
        sh 'terraform init'
      }
    }

    stage('Terraform Plan') {
      steps {
        withEnv(["TF_VAR_admin_password=${ADMIN_PASSWORD}"]) {
          sh 'terraform plan -var-file="terraform.tfvars"'
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        input message: 'Proceed with Apply?'
        withEnv(["TF_VAR_admin_password=${ADMIN_PASSWORD}"]) {
          sh 'terraform apply -auto-approve -var-file="terraform.tfvars"'
        }
      }
    }

    stage('Terraform Destroy') {
      steps {
        input message: 'Proceed with Destroy?'
        withEnv(["TF_VAR_admin_password=${ADMIN_PASSWORD}"]) {
          sh 'terraform destroy -auto-approve -var-file="terraform.tfvars"'
        }
      }
    }
  }
} 