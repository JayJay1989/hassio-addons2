FROM ghcr.io/home-assistant/amd64-base-debian:bookworm

RUN apt-get update && \
    apt-get install -y wireguard-tools iproute2 iptables curl && \
    apt-get clean

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD [ "/run.sh" ]
