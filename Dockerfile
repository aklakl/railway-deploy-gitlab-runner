FROM gitlab/gitlab-runner:alpine

# Make sure runner folder existing
RUN mkdir -p /etc/gitlab-runner

CMD ["gitlab-runner", "run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]
