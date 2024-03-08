#!/bin/bash

# Setup environment
JENKINS_CONTAINER="jenkins"
JENKINS_URL="http://localhost:9090"

# Clean PIDs
pgrep -f 'java -jar agent.jar' | xargs kill

sleep 2

# Check if the Jenkins container is running
if docker ps | grep -q $JENKINS_CONTAINER; then
  echo "Jenkins container is already running."
else
  docker start $JENKINS_CONTAINER
  echo "Jenkins container just started"
fi

# Start the Jenkins agent
cd ./agent && nohup java -jar agent.jar -url $JENKINS_URL/ -secret $JENKINS_AGENT_SECRET -name "jenkins-agent" -workDir "$(pwd)" > "$(pwd)/jenkins-agent.log" 2>&1 & cd ..
