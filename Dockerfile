FROM alpine:3.17
ARG S6_OVERLAY_VERSION=3.1.4.1

RUN apk update \
    && apk add curl xz-utils squid \
    && rm -rf /var/cache/apk/*

HEALTHCHECK --interval=60s --timeout=15s --start-period=180s \
             CMD curl -LSs 'https://api.ipify.org' || kill 1

COPY start-squid.sh /usr/local/bin/
RUN chmod +x  /usr/local/bin/start-squid.sh

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

ENTRYPOINT ["/init"]
CMD ["/usr/local/bin/start-squid.sh"]