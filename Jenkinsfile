pipeline {
    agent any
    
    environment {
        APP_NAME = "golang-web-app"
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Cloning repository...'
                checkout scm
            }
        }

        stage('Test & Build Docker Image (CI)') {
            steps {
                echo 'Building Image and Running Tests...'
                sh 'docker build -t ${APP_NAME}:${BUILD_NUMBER} .'
            }
        }

        stage('Deploy (CD)') {
            steps {
                echo 'Deploying the container...'
                sh 'docker rm -f ${APP_NAME} || true'
                sh 'docker run -d -p 8081:8080 --name ${APP_NAME} ${APP_NAME}:${BUILD_NUMBER}'
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution completed.'
        }
        success {
            echo '✅ Deployment Successful! Check the app at http://192.168.199.133:8081'
        }
    }
}