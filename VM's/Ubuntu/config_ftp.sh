sudo apt-get update 
sudo apt-get install vsftpd -y
sudo cp /vagrant/vsftpd.conf /etc
sudo service vsftpd restart
sudo sed -i 's/XKBLAYOUT="us"/XKBLAYOUT="ch"/g' /etc/default/locale
sudo ufw allow ssh
sudo ufw allow ftp
sudo ufw --force enable