
Use docker-compose to build ...

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


- Download a application
- Build and run
    - mvn clean install
    - java -jar target/demoapp.jar
    - Go to localhost:8080 to view that web application
