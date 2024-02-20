FROM alpine:3.19

COPY --from=crazymax/alpine-s6-dist:3.19 / /

RUN apk update \
    && apk add curl xz squid \
    && rm -rf /var/cache/apk/*

HEALTHCHECK --interval=60s --timeout=15s --start-period=180s \
            CMD curl -LSs 'https://api.ipify.org' || kill 1

COPY start-squid.sh /usr/local/bin/

RUN chmod +x  /usr/local/bin/start-squid.sh     

CMD ["/usr/local/bin/start-squid.sh"]
ENTRYPOINT ["/init"]