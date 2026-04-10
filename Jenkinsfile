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
        // stage('Wait for EC2') {
        //     steps {
        //         echo 'Waiting for EC2 to initialize...'
        //         sleep(time: 60, unit: 'SECONDS')
        //     }
        // }
        stage ('Connecting to EC2') {
            steps {
                 withCredentials([sshUserPrivateKey(
                    credentialsId: 'krish',
                    keyFileVariable: 'SSH_KEY'
                )]) {
sh '''
IP=$(terraform output -raw public_ip)

ssh -o StrictHostKeyChecking=no -i $SSH_KEY ec2-user@$IP << EOF
set -e

cd /home/ec2-user/python-backend-testing/backend

python3 -m venv venv
. venv/bin/activate

python3 -m pip install --upgrade pip
pip install -r requirements.txt

nohup python3 app.py > app.log 2>&1 &

exit
EOF
'''
                }
            }
        }
    }
}
