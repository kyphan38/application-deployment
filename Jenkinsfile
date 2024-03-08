pipeline {
  agent {
    label "jenkins-agent"
  }
  tools{
    jdk 'java17'
    maven 'maven3'
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
  }
}
