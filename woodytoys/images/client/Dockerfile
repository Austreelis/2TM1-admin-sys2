FROM ubuntu:latest

# MAINTAINER instruction is deprecated
LABEL maintainers="Austreelis <dev@austreelis.net>"

RUN set -eux; \
  apt update; \
  apt install -y --no-install-recommends \
    curl \
    bind9-dnsutils \
    iputils-ping \
    iproute2

