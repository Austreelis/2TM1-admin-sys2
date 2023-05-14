FROM ubuntu:latest

RUN apt-get update && \
apt-get install -y postfix\
                   dovecot-core\
                   dovecot-imapd\
		   telnet &&\
touch /var/log/postfix.log && \
touch /var/log/dovecot.log &&\
chown -R postfix /var/log/postfix.log &&\
chown -R dovecot /var/log/dovecot.log

#COPY ./dovecot.conf /etc/dovecot/
#COPY ./main.cf /etc/postfix/

EXPOSE 25 143

CMD ["/usr/sbin/postfix", "start-fg","&&","/usr/sbin/dovecot", "-F"]