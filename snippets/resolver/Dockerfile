FROM ubuntu/bind9

LABEL maintainers="Austreelis <dev@austreelis.net>, Habibou Moulaye Zeini <h.moulayezeini@students.ephec.be>"

RUN mkdir /var/log/named && chown -R bind /var/log/named

COPY named.conf /etc/bind
