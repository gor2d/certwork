pipeline {
    
    agent none
  
    stages {


        stage ('Deploy 2 instans to AWS') {
        agent any  
            steps {
                sh 'terraform init -input=false'
                sh 'terraform plan -out=tfplan -input=false'
                sh 'terraform apply -input=false tfplan'
            } 
        }
         
        stage ('Wait deployment AWS') {
            steps {
             echo 'Waiting 5 min for deployment to complete install software'
             sleep 300
             }
          }

        stage ('Build & run App') {
        agent any
            steps {
                sh 'sudo ansible-playbook roles.yml'
            }

        }    
    }


}

