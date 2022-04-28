pipeline {
    agent any

    stages {
        stage('Git_checkout') {
             steps {
                git branch: 'main', credentialsId: '6eb49cdc-cd7e-4037-9404-1b849b0fff7e', url: 'https://github.com/sathish103/k8s-java-app.git'
            }
        }
        stage('docker login') {
            steps {
                sh 'aws ecr get-login-password --region ap-south-1 |sudo docker login --username AWS --password-stdin 516035830226.dkr.ecr.ap-south-1.amazonaws.com'
            }
        }
        stage('docker build') {
            steps {
		        sh 'sudo docker build -t 516035830226.dkr.ecr.ap-south-1.amazonaws.com/sathish-repo:$BUILD_NUMBER .'
                }
        }
        stage('docker image') {
            steps {
		        sh 'sudo docker push 516035830226.dkr.ecr.ap-south-1.amazonaws.com/sathish-repo:$BUILD_NUMBER'
                }
        }
        stage('replace build number') {
            steps {
		        sh 'sed -i s/number/$BUILD_NUMBER/g all-yaml/deployment.yaml'
                }
        }
        stage('1.namespace') {
            steps {
		        sh 'kubectl apply -f all-yaml/namespace.yaml'
                }
        }
         stage('2.deployment') {
            steps {
		        sh 'kubectl apply -f all-yaml/deployment.yaml'
                }
        }
        stage('3.service') {
            steps {
		        sh 'kubectl apply -f all-yaml/service.yaml'
                }
        }
        stage('4.ingress') {
            steps {
		        sh 'kubectl apply -f all-yaml/ingress.yaml'
                }
        }
        stage('get ingress enpoint') {
            steps {
		        sh 'kubectl get ingress -n java-space'
                }
        }
        
   }
}
