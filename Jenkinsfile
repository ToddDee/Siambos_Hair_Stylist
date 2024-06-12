pipeline {

  environment {
    dockerimagename = "td7165/siambos-hair-stylist"
    dockerImage = ""
  }

  agent any

  stages {

    stage('Checkout Source') {
        steps {
            git branch: 'main', url: 'https://github.com/ToddDee/Siambos_Hair_Stylist.git'
        }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build dockerimagename
        }
      }
    }

    stage('Pushing Image') {
      environment {
               registryCredential = 'docker-hub-credentials'
           }
      steps{
        script {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push("v0.0.0")
          }
        }
      }
    }

    stage('Integrate Remote k8s with Jenkins') {
        steps {
            withKubeCredentials(kubectlCredentials: [[caCertificate: '', clusterName: 'siambos hair stylist', contextName: '', credentialsId: 'SECRET_TOKEN', namespace: 'siambos-hair-stylist', serverUrl: 'https://192.168.49.2:8443']]) {
                sh 'kubectl get nodes'
                sh 'kubectl config current-context'
                sh 'kubectl apply -f deploymentservice.yaml'
            }
        }
    }

  }

}
