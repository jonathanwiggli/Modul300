#Ubuntu Version
FROM ubuntu:16.04

#FTP installation
RUN apt-get update
RUN apt-get install vsftpd -y

# Konfiguration FTP

VOLUME /etc/vsftpd

RUN service vsftpd restart

EXPOSE 20
