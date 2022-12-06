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
        stage("Lint HTML"){
            steps{
                dir("${WORKSPACE}/capstone/frontend"){
                    sh 'tidy index.html'
                    sh 'hadolint Dockerfile'
                }
            }
        }
        stage("Build Docker Nginx"){
            steps{
                dir("${WORKSPACE}/capstone/frontend"){
                    sh 'pwd'
                    sh 'docker build . -t duypk2000/capstone-frontend:v2'
                    sh 'docker images'
                }

            }
        }

        stage("Push Docker Image"){
            steps{
                sh 'docker login -u duypk2000 -p Duyatt123'
                sh 'docker push duypk2000/capstone-frontend:v2'
            }
        }
        
        stage("Cleanup"){
            steps{
                sh 'docker rmi duypk2000/capstone-frontend:v2'
            }
        }

        // stage("Create EKS cluster"){
        //     steps{
        //         dir("${WORKSPACE}/capstone"){
        //             withAWS(credentials: 'capstone', region: 'us-east-1'){   
        //                 // sh 'chmod +x check_existing_cluster.sh'
        //                 // sh './check_existing_cluster.sh'  
        //                 sh 'eksctl create cluster --name duypk5-udacity --region us-east-1'                  
        //                 sh 'kubectl get nodes -o wide'
        //             }
        //         }

        //     }
        // }

        // stage("Deploy pod to eks cluster"){
        //     steps{
        //         dir("${WORKSPACE}/capstone"){
        //             withAWS(credentials: 'capstone', region: 'us-east-1'){
        //                 sh 'kubectl apply -f deployment.yaml'
        //                 sh 'kubectl get pods -A'
        //                 sh 'kubectl get svc'
        //             }

        //         }
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
        // failure{
        //     sh 'eksctl delete cluster --name duypk5-udacity --region us-east-1'
        // }
    }
}