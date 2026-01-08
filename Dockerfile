FROM gitlab/gitlab-runner:alpine


RUN apk add --no-cache bash

WORKDIR /

COPY start.sh /start.sh
RUN chmod +x /start.sh


RUN ls -l | true
RUN cat /start.sh | true


RUN mkdir -p /etc/gitlab-runner

CMD ["/start.sh"]
