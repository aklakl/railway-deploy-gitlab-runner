# Use the official Docker-in-Docker image as a base
# This image already includes the Docker Daemon and Client
FROM docker:20.10.16-dind

# Install necessary tools, such as curl for downloading GitLab Runner
RUN apk add --no-cache curl

# Download and install GitLab Runner
RUN curl -L --output /usr/local/bin/gitlab-runner "https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/latest/binaries/gitlab-runner-linux-amd64"
RUN chmod +x /usr/local/bin/gitlab-runner

# Copy our startup script to the container and grant execution permissions
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the startup command
ENTRYPOINT ["/entrypoint.sh"]