pipeline {
    agent none
    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage('Build') {
            agent {
                docker {
                    image 'maven:3.9.4-eclipse-temurin-17-alpine'
                    args '-v /root/.m2:/root/.m2'
                }
            }
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }
        stage('Test') {
            agent {
                docker {
                    image 'maven:3.9.4-eclipse-temurin-17-alpine'
                    args '-v /root/.m2:/root/.m2'
                }
            }
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('Build Docker Image') {
            agent {
                label 'built-in'
            }
            steps {
                sh 'pwd'
                sh 'ls -la'
                sh 'docker build -t vulnerable-spring-boot-application:0.1 .'
            }
        }
        stage('Deploy Docker Image') {
            agent {
                label 'built-in'
            }
            steps {
                sh 'pwd'
                sh 'ls -la'
                sh 'docker rm --force vulnerable-spring-boot-application'
                sh 'docker run -it --detach -p 8000:8000 --name vulnerable-spring-boot-application vulnerable-spring-boot-application:0.1'
            }
        }
    }
}

