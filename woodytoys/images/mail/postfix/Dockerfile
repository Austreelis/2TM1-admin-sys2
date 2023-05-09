FROM ubuntu:latest

RUN apt-get update && \
apt-get install -y postfix\
                   telnet\
                   mutt

CMD ["/usr/sbin/postfix", "start-fg"]

