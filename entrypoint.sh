#!/bin/bash
set -e

# Define the path for the configuration file
CONFIG_FILE="/etc/gitlab-runner/config.toml"

# Register the runner only if the configuration file doesn't exist
if [ ! -f "$CONFIG_FILE" ]; then
  echo ">>> First time setup: Registering GitLab Runner..."
  
  # Ensure all required environment variables are set
  if [ -z "$REGISTRATION_TOKEN" ] || [ -z "$CI_SERVER_URL" ]; then
    echo "Error: REGISTRATION_TOKEN and CI_SERVER_URL environment variables must be set."
    exit 1
  fi

  # Run the registration command
  gitlab-runner register \
    --non-interactive \
    --url "$CI_SERVER_URL" \
    --token "$REGISTRATION_TOKEN" \
    --executor "docker" \
    --docker-image "docker:stable" \
    --docker-privileged \
    --docker-volumes "/certs/client" \
    --description "${RUNNER_DESCRIPTION:-Railway Docker Runner}" \
    --tag-list "${RUNNER_TAG_LIST:-docker,railway}" \
    --run-untagged="true" \
    --locked="false" \
    --access-level="not_protected"
fi

echo ">>> Setting concurrent limit to 10 in config.toml..."
# Use sed to find lines starting with 'concurrent =' and replace them with 'concurrent = 10'
# Ensure the file exists and is writable
if [ -f "$CONFIG_FILE" ]; then
  sed -i 's/^concurrent = .*/concurrent = 10/' "$CONFIG_FILE"
  echo ">>> config.toml updated with concurrent = 10."
else
  echo "WARNING: config.toml not found after registration. Concurrent setting might not be applied."
fi
# ------------------------------

# Start the GitLab Runner service with the command provided to the entrypoint
echo ">>> Starting GitLab Runner..."
exec gitlab-runner "$@"
