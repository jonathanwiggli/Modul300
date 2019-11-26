sudo apt-get update 
sudo apt-get install vsftpd -y
echo 'ftp-user:user' | sudo chpasswd
sudo sed -i 's/XKBLAYOUT="us"/XKBLAYOUT="ch"/g' /etc/default/locale