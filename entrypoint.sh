#!/bin/sh
set -e

# Start the Docker-in-Docker daemon in the background
# Logs are output to stdout/stderr for easy viewing in Railway
dockerd-entrypoint.sh &

# Wait for the Docker daemon to start and communicate through sockets
echo ">>> Waiting for the Docker daemon to start..."
sleep 5 # Simply wait for a few seconds
while ! docker info > /dev/null 2>&1; do
    echo -n "."
    sleep 1
done
echo ">>> The Docker daemon is ready! "

# Start GitLab Runner
# Note: We no longer register in the script, registration should be a one-time operation.
# If you need to re-register, manually enter the container operation or clear the Railway's volume.
echo ">>> Start GitLab Runner..."
exec gitlab-runner run