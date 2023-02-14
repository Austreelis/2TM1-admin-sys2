FROM ubuntu/bind9

# MAINTAINER instruction is deprecated
LABEL maintainers="Austreelis <dev@austreelis.net>"

# `named`'s log directory
RUN mkdir /var/log/named && chown -R bind /var/log/named

# Copy this after the rest to avoid invalidating unmodified layers
COPY named.conf /etc/bind/named.conf
COPY *.zone /etc/bind/

# Always start bind's resolver
#ENTRYPOINT ["/usr/local/bin/named" "-g"]

