sudo apt-get update 
sudo apt-get install vsftpd -y
sudo useradd ftp-user -d /home/FTP -m 
echo 'ftp-user:user' | sudo chpasswd
sudo sed -i 's/XKBLAYOUT="us"/XKBLAYOUT="ch"/g' /etc/default/locale