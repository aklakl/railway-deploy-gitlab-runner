FROM gitlab/gitlab-runner:ubuntu


RUN apt-get update && apt-get install -y curl git bash tree jq \
 && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
 && apt-get install -y nodejs \
 && rm -rf /var/lib/apt/lists/*
    
WORKDIR /

COPY start.sh /start.sh
RUN chmod +x /start.sh


RUN ls -l | true
RUN cat /start.sh | true


RUN mkdir -p /etc/gitlab-runner

CMD ["/start.sh"]
