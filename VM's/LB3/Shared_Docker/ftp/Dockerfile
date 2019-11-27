#Ubuntu Version
FROM ubuntu:16.04

#FTP installation
RUN sudo apt-get update
RUN sudo apt-get install vsftpd -y

# Konfiguration FTP
ADD /vagrant/ftp/vsftpd.conf /etc/vsftpd.conf

RUN sudo service vsftpd restart

EXPOSE 20
