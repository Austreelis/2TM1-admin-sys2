FROM ubuntu:latest

RUN apt-get update && \ 
    apt-get install -y dovecot-core\
    dovecot-imapd\
    telnet


CMD ["/usr/sbin/dovecot", "-F"]
