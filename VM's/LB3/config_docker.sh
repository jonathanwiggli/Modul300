sudo apt-get update
sudo sudo apt install docker.io -y
cd /vagrant/apache
sudo docker build -t apache .
sudo docker run --rm -d -p 8080:80 -v `pwd`/web:/var/www/html --name apache apache
cd /vagrant/ftp
sudo docker build -t ftp .
sudo docker run --rm -d -p 1020:20 -v /conf:/etc/vsftpd --name ftp ftp
sudo sed -i 's/XKBLAYOUT="us"/XKBLAYOUT="ch"/g' /etc/default/locale