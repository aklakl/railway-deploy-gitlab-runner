FROM gitlab/gitlab-runner:alpine


RUN apk add --no-cache bash

WORKDIR /

COPY start.sh /start.sh
RUN chmod +x /start.sh


RUN mkdir -p /etc/gitlab-runner

CMD ["/start.sh"]
