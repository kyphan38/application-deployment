FROM grafana/grafana:10.0.12-ubuntu

USER root

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y sudo && \
  apt-get install -y curl && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*
