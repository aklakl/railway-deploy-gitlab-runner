# Use a stable base image
FROM ubuntu:22.04

# Set environment variable to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary dependencies: curl for downloading, ca-certificates for https
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Download and install the latest version of GitLab Runner for Linux amd64
RUN curl -L --output /usr/local/bin/gitlab-runner "https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/latest/binaries/gitlab-runner-linux-amd64"
RUN chmod +x /usr/local/bin/gitlab-runner

# Create a dedicated user for running GitLab Runner
RUN useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash

# Install GitLab Runner service
RUN gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner

# Copy our startup script into the container and give it execute permissions
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the startup command
ENTRYPOINT ["/entrypoint.sh"]