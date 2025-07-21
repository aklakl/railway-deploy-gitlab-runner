#!/bin/bash
set -e

# This is where the Runner configuration file is stored
CONFIG_FILE=/etc/gitlab-runner/config.toml

# Check if the configuration file already exists. If it does, the Runner has already been registered.
if [ ! -f "$CONFIG_FILE" ]; then
  echo ">>> Configuration file not found, registering Runner for the first time..."
  gitlab-runner register \
    --non-interactive \
    --url "$GITLAB_URL" \
    --registration-token "$GITLAB_RUNNER_TOKEN" \
    --executor "shell" \
    --description "$RUNNER_DESCRIPTION" \
    --tag-list "$RUNNER_TAGS" \
    --run-untagged="true" \
    --locked="false" \
    --access-level="not_protected"
fi

# Start the Runner service, it will begin pulling jobs from GitLab
echo ">>> Starting GitLab Runner..."
exec gitlab-runner run