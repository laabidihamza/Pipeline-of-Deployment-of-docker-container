pipeline {
    agent any

    stages {
        stage('Pull Image from DockerHub') {
            steps {
                echo 'Pulling the Docker image from DockerHub...'
                sh 'docker run hamzalaabidi/nestjs-web-app:5'
            }
        }

        stage('Stop and Remove Existing Container') {
            steps {
                echo 'Stopping and removing any existing container...'
                sh '''
                    if [ $(docker ps -q -f name=nestjs-web-app) ]; then
                        docker stop nestjs-app
                        docker rm nestjs-app
                    fi
                '''
            }
        }

        stage('Run New Container') {
            steps {
                echo 'Running the new container...'
                sh 'docker run -d -p 3000:3000 --name nestjs-app hamzalaabidi/nestjs-web-app:5'
            }
        }
    }

    post {
        success {
            echo 'Deployment completed successfully!'
        }
        failure {
            echo 'Deployment failed. Check the logs for details.'
        }
    }
}