FROM alpine:3.12

RUN apk update \
    && apk add squid \
    && apk add curl \
    && rm -rf /var/cache/apk/*

COPY start-squid.sh /usr/local/bin/
RUN chmod +x  /usr/local/bin/start-squid.sh

ENTRYPOINT ["/usr/local/bin/start-squid.sh"]
