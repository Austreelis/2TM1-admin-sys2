FROM ubuntu/bind9

LABEL maintainers="Austreelis <dev@austreelis.net>, Habibou Moulaye Zeini <h.moulayezeini@students.ephec.be>"

COPY named.conf /etc/bind

RUN mkdir /var/log/named && -R bind /var/log/named

EXPOSE 53/tcp
EXPOSE 53/udp

CMD ["named", "-g"]