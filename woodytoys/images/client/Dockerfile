FROM ubuntu:latest

# MAINTAINER instruction is deprecated
LABEL maintainers="Austreelis <dev@austreelis.net>"

CMD ["tail", "-f", "/dev/null"]
RUN set -eux; \
  apt update; \
  apt install -y --no-install-recommends \
    curl \
    ca-certificates \
    bind9-dnsutils \
    iputils-ping \
    iproute2\
    nano\
    mutt\
    telnet \
    mysql-client
