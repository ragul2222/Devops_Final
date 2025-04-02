pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('6f6dcbd6-8a4f-466d-86fe-37d6c7a838c7') // Docker Hub Credentials
    }

    stages {
        stage('Pull Code from GitHub') {
            steps {
                git branch: 'main', 
                    credentialsId: 'cf046fce-62a3-4f39-a069-db11f9bf6836', 
                    url: 'https://github.com/ragul2222/Devops_Final.git'
            }
        }

        stage('Verify Docker Setup') {
            steps {
                sh 'docker --version'
                sh 'docker info'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t rrragul/final:latest .'
            }
        }

        stage('Login to Docker Hub') {
            steps {
                sh 'echo "$DOCKER_HUB_CREDENTIALS" | docker login -u "rrragul" --password-stdin'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh 'docker push rrragul/final:latest'
            }
        }

        stage('Verify Kubernetes Connection') {
            steps {
                sh 'kubectl cluster-info'
                sh 'kubectl get nodes'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f k8s/deployment.yaml || { echo "❌ Deployment Failed"; exit 1; }'
                sh 'kubectl apply -f k8s/service.yaml || { echo "❌ Service Deployment Failed"; exit 1; }'
            }
        }
    }

    post {
        success {
            echo '✅ Deployment Successful!'
        }
        failure {
            echo '❌ Deployment Failed. Check logs.'
        }
    }
}
