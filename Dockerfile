FROM ghcr.io/permify/permify:latest as base

FROM ubuntu:22.04
COPY --from=base /usr/local/bin/permify /permify
RUN chmod +x /permify
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["bash", "/entrypoint.sh"]