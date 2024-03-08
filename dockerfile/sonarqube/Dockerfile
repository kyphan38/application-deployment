FROM sonarqube:9.9.4-community

USER root

# Install some packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y sudo && \
    apt-get install -y curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Important: Switch back to the non-root user
USER sonarqube
