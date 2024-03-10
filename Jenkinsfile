pipeline {
  agent {
    label "jenkins-agent"
  }
  tools{
    jdk "java17"
    maven "maven3"
  }
  environment {
    APP_NAME = "application-deployment"
    VERSION = "1.0.0"
    DOCKER_USERNAME = "kyphan3802"
    DOCKER_PASSWORD = "dockerhub-credentials"   // Credentials ID
    IMAGE_NAME = "${DOCKER_USERNAME}/${APP_NAME}"
    IMAGE_TAG = "${VERSION}-${BUILD_NUMBER}"
  }
  stages {
    stage("Clean Workspace") {
      steps {
        deleteDir()
      }
    }

    stage("Clone Repository") {
      steps {
        git branch: "develop", credentialsId: "github-credentials", url: "https://github.com/kyphan38/application-deployment.git"
      }
    }

    stage("Build App") {
      steps {
        sh "mvn clean package"
      }
    }

    stage("Run Tests") {
      steps {
        sh "mvn test"
      }
    }

    stage("Run SonarQube Analysis") {
      steps {
        script {
          withSonarQubeEnv(credentialsId: "sonarqube-credentials") {
            sh "mvn sonar:sonar -Dsonar.host.url=http://localhost:9000"
          }
        }
      }
    }

    stage("Run Quality Gate") {
      steps {
        script {
          waitForQualityGate abortPipeline: false, credentialsId: "sonarqube-credentials"
        }
      }
    }

    stage("Build and Push Docker Image") {
      steps {
        script {
          docker.withRegistry("", DOCKER_PASSWORD) {
            docker_image = docker.build "${IMAGE_NAME}"
          }

          docker.withRegistry("", DOCKER_PASSWORD) {
            docker_image.push("${IMAGE_TAG}")
            docker_image.push("latest")
          }
        }
      }
    }

    stage("Scan Image with Trivy") {
      steps {
        script {
		      sh ("docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image kyphan3802/application-deployment:latest --no-progress --scanners vuln  --exit-code 0 --severity HIGH,CRITICAL --format table")
        }
      }

    }

    stage ("Cleanup Artifacts") {
      steps {
        script {
          sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG}"
          sh "docker rmi ${IMAGE_NAME}:latest"
        }
      }
    }
  }
}
