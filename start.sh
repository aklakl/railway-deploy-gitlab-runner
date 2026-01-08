#!/bin/bash
set -e

CONFIG_FILE="/etc/gitlab-runner/config.toml"

echo "🚀 GitLab Runner starting..."

if [ -z "$GITLAB_URL" ] || [ -z "$REGISTRATION_TOKEN" ]; then
  echo "❌ GITLAB_URL or REGISTRATION_TOKEN is missing"
  exit 1
fi

# Register Runner (if config does not exist)
if [ ! -f "$CONFIG_FILE" ]; then
  echo "🔐 Registering GitLab Runner..."

  gitlab-runner register \
    --non-interactive \
    --url "$GITLAB_URL" \
    --registration-token "$REGISTRATION_TOKEN" \
    --executor shell \
    --name "$RUNNER_NAME" \
    --tag-list "$RUNNER_TAGS" \
    --run-untagged="true" \
    --locked="false"

  echo "✅ Runner registered"
else
  echo "ℹ️ Runner already registered"
fi

echo "Node version: $(node -v)"
echo "NPM version: $(npm -v)"
echo "PNPM version: $(pnpm -v)"

echo "🏃 Running GitLab Runner as ROOT..."

# 🔥 [CRITICAL CHANGE] Run as root user to fix permission errors
# Changed working directory to /root
exec gitlab-runner run --user=root --working-directory=/root
