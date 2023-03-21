FROM ubuntu:latest

RUN apt-get update && \
apt-get install -y postfix &&\
touch /var/log/postfix.log && \
chown -R postfix /var/log/postfix.log

COPY ./main.cf /etc/postfix/

EXPOSE 25 

CMD ["/usr/sbin/postfix", "start-fg"]