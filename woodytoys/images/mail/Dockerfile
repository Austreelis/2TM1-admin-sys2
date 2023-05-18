FROM ubuntu:latest

RUN apt-get update && \
apt-get install -y postfix\
                   dovecot-core\
                   dovecot-imapd\
                   dovecot-pop3d \
		   net-tools\
                   telnet

#COPY ./dovecot.conf /etc/dovecot/
#COPY ./main.cf /etc/postfix/

#EXPOSE 25 143

CMD ["/usr/sbin/postfix", "start-fg","&&","/usr/sbin/dovecot", "-F"]
