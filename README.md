# Introduction
Welcome to my project, where we focus on building a CI/CD pipeline for a web application. This pipeline is designed to automate the process of integrating code changes, testing those changes, and deploying them to production efficiently and securely.

I leverage several tools, including GitHub, Jenkins, Maven, SonarQube, Docker, Trivy, Prometheus, and Grafana. These tools are utilized within a local containerization environment.

# Configuration
## Application builing
  - To build and start all applications defined in your docker-compose.yaml file, use the following command:
    ```shell
    docker-compose up -d --build
    ```

## Jenkins
  - Access Jenkins via `localhost:9090` and change the default password.
  - Set up an agent as the host system using the method: Launch agent by connecting it to the controller.
  - Install and configure several plugins:
    - Maven Integration, Pipeline Maven Integration, Eclipse Temurin installer.
    - Set the Maven version in the plugin to 3.9.
    - Set the Java version in the plugin to 17.
  - Set up credentials for GitHub.
  - Set up a pipeline from SCM (Source Code Management).
  - Set up a webhook to trigger automatically using ngrok:
    ```shell
    ngrok http http://localhost:9090
     ```
    - Then, insert the ngrok URL into the payload URL section of the webhook settings.

## Sonarquebe
  - Change the following configuration on the host system:
    ``` shell
    sudo sysctl -w vm.max_map_count=262144
    chmod -R 777 ./data/sonarqube
    ```
  - Configure Jenkins for SonarQube:
    - Configure the API Token of SonarQube in Jenkins (using secret text) under `jenkins-credentials`.
    - Install and configure the SonarQube Scanner plugin on Jenkins.
    - Configure the plugin:
      - Check "Environment variables."
      - Name: sonarqube-scanner
      - Server URL: `http://sonarqube:9000`
      - Server authentication token: `jenkins-credentials`
  - Set up a webhook for Jenkins (for the quality gate):
    - Name: `jenkins-webhook`
    - URl: `http://jenkins:8080/sonarqube-webhook`
    - Secret: leave blank

## Docker
  - Install the following plugins in Jenkins: Docker, Docker Commons, Docker Pipeline, Docker API, docker-build-step, CloudBees Docker Build and Publish.
  - Add Docker Hub credentials to Jenkins.

## Trivy:
  - Install Trivy on host system.

## Prometheus:
  - Install the following plugins in Jenkins: Prometheus Metrics, Otel Agent Host Metrics Monitoring, and Cortex Metrics.
  - Configuration file located at `./config/prometheus/prometheus.yaml`.

## Grafana
  - Set up Grafana through the UI to integrate with Prometheus.
