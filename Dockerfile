# Use the official GitLab Runner image as the base
FROM gitlab/gitlab-runner:latest

# Set the working directory
WORKDIR /etc/gitlab-runner

# Copy the custom entrypoint script into the container
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Make the script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint to our custom script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# The CMD is what the entrypoint script will run in the final step
CMD ["run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]
