pipeline {
    agent any
    
    tools {
        // Refer to the tools you configured in Jenkins
        jdk 'JDK 11'
        maven 'Maven 3.8.6'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }
        
        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit '**/target/surefire-reports/*.xml'
                }
            }
        }
        
        stage('Build and Run Docker') {
            steps {
                sh 'docker-compose down || true'
                sh 'docker-compose build'
                sh 'docker-compose up -d'
            }
        }
        
        stage('Integration Test') {
            steps {
                sh 'mvn verify -DskipUnitTests'
            }
        }
    }
    
    post {
        always {
            sh 'docker-compose logs'
        }
        failure {
            sh 'docker-compose down || true'
        }
        success {
            echo 'Build and deployment successful!'
        }
    }
}
