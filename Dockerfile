# Use the official GitLab Runner image as the base
FROM gitlab/gitlab-runner:latest

# Set the working directory
WORKDIR /etc/gitlab-runner

# Step 1: Copy the certificate into the image.
# Place your certificate file (e.g., gitlab-cert.crt) in the same directory as your Dockerfile.
# This copies it to the designated location within the image.
COPY gitlab-cert.crt /etc/gitlab-runner/certs/gitlab-cert.crt

# Step 2: Set the TLS CA file environment variable.
# This tells the GitLab Runner to use your custom certificate file.
ENV CA_CERTIFICATES_PATH="/etc/gitlab-runner/certs/gitlab-cert.crt"

# Copy the custom entrypoint script into the container
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Make the script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint to our custom script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# The CMD is what the entrypoint script will run in the final step
CMD ["run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]
