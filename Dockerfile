FROM gitlab/gitlab-runner:ubuntu


RUN apt-get update \
 && apt-get install -y tree jq \
 && rm -rf /var/lib/apt/lists/*
    
WORKDIR /

COPY start.sh /start.sh
RUN chmod +x /start.sh


RUN ls -l | true
RUN cat /start.sh | true


RUN mkdir -p /etc/gitlab-runner

CMD ["/start.sh"]
