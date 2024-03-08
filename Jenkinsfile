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
        git branch: 'develop', credentialsId: 'github-credentials', url: "https://github.com/kyphan38/application-deployment.git"
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
  }
}
