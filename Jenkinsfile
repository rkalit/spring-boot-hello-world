pipeline {
    agent any
    tools{
        maven 'M3'
    }
    stages{
        stage('Build Maven'){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/rkalit/spring-boot-hello-world']]])
                sh 'mvn clean install'
            }
        }
        stage('Build Image'){
            steps{
                script{
                     sh 'docker build -t rulikalit/hello-app-test:v1.$BUILD_ID .'
                     sh 'docker build -t rulikalit/hello-app-test:latest .'
                 }
            }
        }
        stage('Push image to Hub'){
             steps{
                 script{
                   withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
                    sh 'docker login -u rulikalit -p ${dockerhubpwd}'

                    }
                    sh 'docker push rulikalit/hello-app-test:v1.$BUILD_ID'
                    sh 'docker push rulikalit/hello-app-test:latest'
                 }
             }
        }
        stage('Deploy to minikube'){
            steps{
                script{
                    sh '''
                    kubectl apply -f deployment.yaml
                    kubectl apply -f service.yaml
                    kubectl rollout status deployment/hello-app
                    '''
                }
            }
        }
    }
}