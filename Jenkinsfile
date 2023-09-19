pipeline {
    agent {
        docker {
            image 'maven:3.9.4-eclipse-temurin-17-alpine'
            args '-v /root/.m2:/root/.m2'
        }
    }
    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }
        stage('Test') {
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
                docker {
                    image 'docker:dind'
                    args '-v /root/.m2:/root/.m2'
                }
            }
            steps {
                sh 'docker build -t vulnerable-spring-boot-application .'
            }
        }
        stage('Deploy Docker Image') {
            agent {
                docker {
                    image 'docker:dind'
                    args '-v /root/.m2:/root/.m2'
                }
            }
            steps {
                sh 'docker run -it --rm --detach -p 8000:8000 --name vulnerable-spring-boot-application vulnerable-spring-boot-application'
            }
        }
    }
}

