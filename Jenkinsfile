pipeline {
    agent any

    stages{
        stage('Checkout'){
            steps{

                 git branch: "${env.BRANCH_NAME}", url: 'https://github.com/Nandoo-03/Final-Project.git'
            }
        }
        stage('Build'){
            steps{
                script {
                    echo "Building the Docker image based on the branch..."
                    sh 'chmod +x build.sh && ./build.sh'
                }
            }
        }
        stage('Push to DockerHub'){
            steps{
                    echo "Login to DockerHub..."
                withCredentials([usernamePassword(credentialsId:"docker-cred",passwordVariable:"dockerHubPass",usernameVariable:"dockerHubUser")]){
                    
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"

                script {
                    echo "Pushing the Docker image to DockerHub based on the branch..."
                        if (env.BRANCH_NAME == 'dev') {
                            sh "docker tag final-dev:latest ${env.dockerHubUser}/dev:latest"
                            sh "docker push ${env.dockerHubUser}/dev:latest"
                        } else if (env.BRANCH_NAME == 'master') {
                            sh "docker tag final-prod:latest ${env.dockerHubUser}/prod:latest"
                            sh "docker push ${env.dockerHubUser}/prod:latest"
                        }
                    }
                }
            }
        }
        stage('Deploy to Server'){
            when {
                expression { env.BRANCH_NAME == 'master' }
            }
            steps{
                script {
                    echo "Deploying the Docker image using Docker Compose..."
                    sh 'chmod +x deploy.sh && ./deploy.sh'
                }
            }
        }
    }
}
