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
            steps {
                 withCredentials([sshUserPrivateKey(
                    credentialsId: 'krish',
                    keyFileVariable: 'SSH_KEY'
                )]) {
sh '''
chmod 400 $SSH_KEY
IP=$(terraform output -raw public_ip)
echo "Connecting to $IP"
ssh -o StrictHostKeyChecking=no -i $SSH_KEY ec2-user@$IP << EOF
cd /home/ec2-user
# Install required tools
sudo yum update -y
sudo yum install -y git python3
rm -rf python-backend-testing
git clone https://github.com/CloudTechDevOps/python-backend-testing.git
cd python-backend-testing/backend
python3 -m venv venv
. venv/bin/activate
pip install -r requirements.txt
nohup python3 app.py > app.log 2>&1 &
EOF
'''
                }
            }
        }
    }
}
