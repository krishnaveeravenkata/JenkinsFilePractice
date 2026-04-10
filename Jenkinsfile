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
        stage('Wait for EC2') {
            steps {
                echo 'Waiting for EC2 to initialize...'
                sleep(time: 60, unit: 'SECONDS')
            }
        }
        stage ('Connecting to EC2') {
            steps withCredentials([sshUserPrivateKey(
                    credentialsId: 'krish',
                    keyFileVariable: 'SSH_KEY'
                )]) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no -i kkp.pem ec2-user@$(terraform output -raw public_ip) << 'EOF'
                    cd /home/ec2-user
                    git clone https://github.com/CloudTechDevOps/python-backend-testing.git
                    cd python-backend-testing/backend
                    python3 -m venv venv
                    source venv/bin/activate
                    pip install -r requirements.txt
                    nohup python3 app.py > app.log 2>&1 &
                    EOF
                        '''
            }
        }
    }
}
