FROM postgres:16

USER root

# Install some packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY init.sql /docker-entrypoint-initdb.d/init.sql
