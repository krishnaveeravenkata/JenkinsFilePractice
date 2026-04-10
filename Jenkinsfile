pipeline {
    agent any

    stages {
         stage('Init') {
            steps {
                  sh  'terraform init'
            }
        }
        stage('Krishna Plannig') {
            steps {
                  sh  'terraform plan'
            }
        }
        stage('Terraform Apply') {
            steps {
                  sh  'terraform apply -auto-approve'
            }
      
        }   
    }
}
