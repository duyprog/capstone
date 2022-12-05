pipeline{
    agent any
    
    environment{
        WORKSPACE = "/var/lib/jenkins/workspace"
        GIT_URL = "https://github.com/duyprog/capstone.git"
        DOCKER_REGISTRY="duypk2000/capstone"
    }

    options{
        buildDiscarder(logRotator(numToKeepStr: '20', artifactNumToKeepStr: '20'))
    }

    stages{
        stage("Checkout SCM"){
            steps{
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: "master"]],
                    doGenerateSubmoduleConfiguration: false,
                    userRemoteConfigs: [[url: "${GIT_URL}"]]
                ])
            }
        }
        stage("Build Docker Nginx"){
            steps{
                dir('${WORKSPACE}/capstone/frontend'){
                    sh 'pwd'
                    sh 'docker build . -t duypk2000/capstone-frontend:v1'
                    sh 'docker images'
                }

            }
        }

        stage("Push Docker Image"){
            steps{
                sh 'docker login -u duypk2000 -p Duyatt123'
                sh 'docker push duypk2000/capstone-frontend:v1'
            }
        }
        
        // stage("Cleanup"){
        //     step{
        //         sh 'docker rmi $DOCKER_REGISTRY:$IMAGE_TAG'
        //     }
        // }

        // stage("Install Dependencies"){
        //     sh 'curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.24.7/2022-10-31/bin/linux/amd64/kubectl'
        //     sh 'chmod +x ./kubectl'
        //     sh 'mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin'
        //     sh 'kubectl version --short --client'
        // }
    }
    post{
        always{
            deleteDir()
        }
    }
}