# Configuration GUIDE

Jenkins
  - Access Jenkins via localhost 9090
  - Change password by default
  - Setup agent as host system
    - Check sshd service using sudo systemctl status sshd
    - Add credentials (using the correct username of host) check whoami
    - Setup agent (using the correct host) check hostname -i

  - Install default plugins
    - Maven Integration, Pipeline Maven, Integration, Eclipse Temurin installer
    - Setup maven version of plugin is 3.9
    - Setup java version of plugin is 17
  - Setup credentials
    - Add PAT for GitHub
  - Setup a pipeline from SCM

  - Setup webhook using ngrok
    - Install ngrok
    - ngrok http http://localhost:9090
    - Payload URL of webhooks should be "https://b105-171-243-48-114.ngrok-free.app/github-webhook/"

HOST jenkins as internet : using ngrok => " ..abc"

Sonarquebe
  - Install sonarquebe:
    - sudo sysctl -w vm.max_map_count=262144
    - Change permission for sonarqube folder 777

  - Configure Jenkins for Sonarqube
    - Generate API Token on Sonarqube
    - Configure API for Jenkins (using secret text) - jenkins-credentials
    - Install plugin: sonarqube scanner
    - Install Sonarque scanner using plugins
      -  sonarquebe5 Sonarquebe scanner 5.0.0.2966
    - Configure plugin:
      - Tick on: Environment variables
      - Name: sonarqube-scanner
      - Server URL: http://sonarqube:9000 # OK call api
      - Server authentication token: jenkins-credentials
  - Setup webhook for jenkins (quality gate)
    - Name: jenkins-webhook
    - URl: http://jenkins:8080/sonarqube-webhook
    - secret: leave a blank

Docker
  - Install plugin: Docker, Dockermomons pipeline docker api docker buidl setp, CloudBees Docker Build and Publish
  - Add crentials of docker hub to jenkins







# Configuration Guide

This guide provides step-by-step instructions for configuring Jenkins and SonarQube.

## Jenkins Configuration

### Accessing Jenkins

- Access Jenkins via: `http://localhost:9090`

### Initial Setup

- **Change the default password** immediately after the first login.
- **Set up an agent on the host system**:
  1. Verify the SSHD service is running:
     ```shell
     sudo systemctl status sshd
     ```
  2. Add credentials:
     - Use the correct username of the host (check using `whoami`).
  3. Set up the agent:
     - Use the correct host (check using `hostname -i`).

### Installing Plugins

Install the following default plugins:

- Maven Integration
- Pipeline Maven Integration
- Eclipse Temurin installer

Configuration:

- Set Maven version in the plugin to `3.9`.
- Set Java version in the plugin to `17`.
