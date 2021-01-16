FROM alpine:3.13

RUN apk update \
    && apk add squid \
    && apk add curl \
    && rm -rf /var/cache/apk/*

HEALTHCHECK --interval=60s --timeout=15s --start-period=180s \
             CMD curl -LSs 'https://api.ipify.org' || kill 1

COPY start-squid.sh /usr/local/bin/
RUN chmod +x  /usr/local/bin/start-squid.sh

ENTRYPOINT ["/usr/local/bin/start-squid.sh"]
