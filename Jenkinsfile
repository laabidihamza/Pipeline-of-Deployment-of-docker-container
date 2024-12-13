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



// pipeline {
//     agent any

//     environment {
//         DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials') // DockerHub credentials ID
//         DOCKER_IMAGE = 'hamzalaabidi/nestjs-web-app'
//         GIT_REPO = 'https://github.com/laabidihamza/Pipeline-of-Deployment-of-docker-container.git'
//         IMAGE_TAG = 'v1'
//     }

//     stages {
//         stage('Checkout Code') {
//             steps {
//                 echo 'Cloning the repository from GitHub...'
//                 git branch: 'main', url: "${GIT_REPO}"
//             }
//         }

//         stage('Build Docker Image') {
//             steps {
//                 echo 'Building Docker image...'
//                 sh '''
//                 docker build -t ${DOCKER_IMAGE}:${IMAGE_TAG} .
//                 '''
//             }
//         }

//         stage('Push Docker Image to DockerHub') {
//             steps {
//                 echo 'Logging into DockerHub and pushing the image...'
//                 sh '''
//                 echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
//                 docker push ${DOCKER_IMAGE}:${IMAGE_TAG}
//                 '''
//             }
//         }

//         stage('Deploy Docker Container') {
//             steps {
//                 echo 'Stopping and removing any existing container...'
//                 sh '''
//                 docker stop nestjs-container || true
//                 docker rm nestjs-container || true
//                 '''

//                 echo 'Running the new container...'
//                 sh '''
//                 docker run -d -p 3000:3000 --name nestjs-container ${DOCKER_IMAGE}:${IMAGE_TAG}
//                 '''
//             }
//         }
//     }

//     post {
//         success {
//             echo 'Pipeline executed successfully. The application is running.'
//         }
//         failure {
//             echo 'Pipeline failed. Check the logs for details.'
//         }
//     }
// }

