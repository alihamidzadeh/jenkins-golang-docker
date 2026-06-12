pipeline {
    agent any
    
    // تعریف متغیرهای محیطی برای استفاده در طول پایپ‌لاین
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

        stage('Test (CI)') {
            steps {
                echo 'Running Golang Tests using a temporary Docker container...'
                // ما رو جنکینز گو نداریم! پس یه کانتینر موقت میاریم بالا تا کدهامون رو تست کنه
                sh 'docker run --rm -v "${PWD}":/usr/src/app -w /usr/src/app golang:1.21 go test -v'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building the Docker Image...'
                // داکر ایمیج برنامه خودمون رو می‌سازیم و شماره بیلد جنکینز رو به عنوان تگ بهش میدیم
                sh 'docker build -t ${APP_NAME}:${BUILD_NUMBER} .'
            }
        }

        stage('Deploy (CD)') {
            steps {
                echo 'Deploying the container...'
                // اول اگر کانتینر قبلی با این اسم وجود داره، پاکش میکنیم (|| true باعث میشه اگر نبود، ارور نده)
                sh 'docker rm -f ${APP_NAME} || true'
                
                // کانتینر جدید رو اجرا میکنیم. (پورت 8081 سرور رو وصل میکنیم به 8080 کانتینر، چون 8080 دست خود جنکینزه!)
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