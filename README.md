Jenkins
- Install java 17
- Install Jenkins
- Install default plugins
- Setup agent as host system
    - Check sshd service using sudo systemctl status sshd
    - Add credentials (using the correct username of host) check whoami
    - Setup agent (using the correct host) check hostname -i

- Download a application
- Build and run
    - mvn clean install
    - java -jar target/demoapp.jar
    - Go to localhost:8080 to view that web application