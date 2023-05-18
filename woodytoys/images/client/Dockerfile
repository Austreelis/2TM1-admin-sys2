# FROM ubuntu:latest

# # MAINTAINER instruction is deprecated
# LABEL maintainers="Austreelis <dev@austreelis.net>"

# RUN set -eux; \
#   apt update; \
#   apt install -y --no-install-recommends \
#     curl \
#     bind9-dnsutils \
#     iputils-ping \
#     iproute2



FROM ubuntu:latest

# MAINTAINER instruction is deprecated
LABEL maintainers="Austreelis <dev@austreelis.net>"

RUN apt update
RUN apt install -y bind9-dnsutils iputils-ping telnet curl mutt

CMD ["tail", "-f", "/dev/null"]
