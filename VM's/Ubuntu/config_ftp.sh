sudo apt-get update 
sudo apt-get install vsftpd -y
sudo sed -i 's/XKBLAYOUT="us"/XKBLAYOUT="ch"/g' /etc/default/locale