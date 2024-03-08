#!/bin/bash

# Setup environment
NGROK_URL_PORT="4045"                 # Define in $HOME/.config/ngrok/ngrok.yml
JENKINS_CONTAINER="jenkins"
JENKINS_URL="http://localhost:9090"
OWNER="kyphan38"
REPO="application-deployment"

# Clean PIDs
pgrep -f 'java -jar agent.jar' | xargs kill
pkill -f ngrok

sleep 2

NGROK_PID=$(lsof -ti:$NGROK_URL_PORT)
if [ ! -z "$PID" ]; then
  echo "Killing process with PID $PID on port 4045."
  kill -9 $NGROK_PID
fi

# Check if the Jenkins container is running
if docker ps | grep -q $JENKINS_CONTAINER; then
  echo "Jenkins container is already running."
else
  docker start $JENKINS_CONTAINER
  echo "Jenkins container just started"
fi

# Start the Jenkins agent
cd ./agent && nohup java -jar agent.jar -url $JENKINS_URL/ -secret $JENKINS_AGENT_SECRET -name "jenkins-agent" -workDir "$(pwd)" > "$(pwd)/jenkins-agent.log" 2>&1 & cd ..

# Start an ngrok tunnel to expose the Jenkins server running on localhost to the internet
ngrok http $JENKINS_URL > /dev/null &

sleep 2

# Retrieve the public HTTPS URL of the ngrok tunnel
PAYLOAD_URL=$(curl -s http://localhost:$NGROK_URL_PORT/api/tunnels | jq -r '.tunnels[] | select(.proto == "https") | .public_url')

# Retrieve the ID of the GitHub webhook
HOOK_ID=$(curl -s -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_PAT" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/$OWNER/$REPO/hooks | jq '.[].id')

# Update the GitHub webhook
RESPONSE=$(curl -s -L \
  -X PATCH \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_PAT" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "https://api.github.com/repos/$OWNER/$REPO/hooks/$HOOK_ID/config" \
  -d "{\"content_type\":\"json\",\"url\":\"$PAYLOAD_URL\"}")

# Check if the update was successful and print a message
if echo "$RESPONSE" | grep -q "url"; then
  echo "Updated PAYLOAD URL: $PAYLOAD_URL\n"
fi
