#Ubuntu Version
FROM ubuntu:16.04

#FTP installation
RUN apt-get update
RUN apt-get install vsftpd -y

# Konfiguration FTP
COPY /vagrant/ftp/vsftpd.conf /etc/vsftpd.conf

RUN service vsftpd restart

EXPOSE 20
