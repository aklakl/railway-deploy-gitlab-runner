FROM gitlab/gitlab-runner:ubuntu

# Install basic dependencies and Node.js 20
# We pre-install pnpm here so you don't need to install it in every CI job
RUN apt-get update && apt-get install -y curl git bash tree jq \
 && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
 && apt-get install -y nodejs \
 && npm install -g pnpm \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /

# Enable Corepack and activate pnpm
RUN corepack enable \
 && corepack prepare pnpm@latest --activate

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Create configuration directory
RUN mkdir -p /etc/gitlab-runner

# 🔥 [CRITICAL ADDITION] Explicitly use root user
# This ensures the container starts with full permissions
USER root

CMD ["/start.sh"]
