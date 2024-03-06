FROM jenkins/jenkins:2.447-jdk17

USER root

# Install some packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*