sudo apt-get update
sudo sudo apt install docker.io -y
cd /vagrant/apache
sudo docker build -t apache .
sudo docker run --rm -d -p 8080:80 -v `pwd`/web:/var/www/html --name apache apache
sudo sed -i 's/XKBLAYOUT="us"/XKBLAYOUT="ch"/g' /etc/default/locale