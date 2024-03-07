pipeline {
  agent {
    label "jenkins-agent"
  }
  tools{
    jdk 'java17'
    maven 'maven3'
  }
  stages {
    stage("Cleanup workspace") {
      steps {
        deleteDir()
      }
    }

    stage("Checkout repository") {
      steps {
        git branch: 'develop', credentialsId: 'github-credentials', url: "https://github.com/kyphan38/application-deployment.git"
      }
    }

    stage("Build Application") {
      steps {
        sh "mvn clean package"
      }
    }

    stage("Test Application") {
      steps {
        sh "mvn test"
      }
    }
  }
}