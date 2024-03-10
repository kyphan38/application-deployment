FROM bitnami/prometheus:2.50.1

USER root

# Install some packages
RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y sudo && \
  apt-get install -y curl && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*
