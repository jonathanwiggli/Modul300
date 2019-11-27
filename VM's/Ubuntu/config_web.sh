sudo apt-get update
sudo apt-get install apache2 -y
sudo sed -i 's/XKBLAYOUT="us"/XKBLAYOUT="ch"/g' /etc/default/locale
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw --force enable
