# Modul300

Software
•	Visual Studio Code
•	BashGit
•	VirtualBox
•	Vagrant

Lösung
Mit einen befehle «vagrant up». Erstellen einer automatisierte Virtuelle Maschine mit Web Server und Webseite und eine automatisierte Virtuelle Maschine mit FTP Server der entsprechend automatisch konfiguriert ist.

1.	Konfiguration Vagant File
2.	Vagrant.configure("2") do |config|
3.	  config.vm.define "WEB" do |web|
4.	    
5.	    #VM BOX Ubuntu 
6.	    web.vm.box = "ubuntu/xenial64"
7.	  
8.	    #VM Hostname
9.	    web.vm.hostname = "Ubuntu-WEB"
10.	
11.	    #Sync Folder
12.	    web.vm.synced_folder "./Shared_WEB", "/var/www/html"
13.	  
14.	    #VM Network
15.	    web.vm.network "private_network", ip: "192.168.1.10"
16.	    web.vm.network "forwarded_port", guest: 80, host: 8080
17.	
18.	    #Script
19.	    web.vm.provision :shell, path: "config_web.sh"
20.	    
21.	    #VM Disksize
22.	    web.disksize.size = '10GB'
23.	  
24.	    #VM Provider and Specs
25.	    web.vm.provider "virtualbox" do |vb|
26.	        vb.memory = "2048"
27.	        vb.name = "Ubuntu-WEB"
28.	        vb.cpus = "2"
29.	        vb.gui = true
30.	    end
31.	  end
32.	  
33.	  config.vm.define "FTP" do |ftp|
34.	    
35.	    #VM BOX Ubuntu 
36.	    ftp.vm.box = "ubuntu/xenial64"
37.	  
38.	    #VM Hostname
39.	    ftp.vm.hostname = "Ubuntu-ftp"
40.	
41.	    #Sync Folder
42.	    ftp.vm.synced_folder "./Shared_FTP", "/vagrant"
43.	  
44.	    #VM Network
45.	    ftp.vm.network "private_network", ip: "192.168.1.20"
46.	    ftp.vm.network "forwarded_port", guest: 20, host: 1420
47.	
48.	    #Script
49.	    ftp.vm.provision :shell, path: "config_ftp.sh"
50.	
51.	    #VM Disksize
52.	    ftp.disksize.size = '10GB'
53.	  
54.	    #VM Provider and Specs
55.	    ftp.vm.provider "virtualbox" do |vb|
56.	        vb.memory = "2048"
57.	        vb.name = "Ubuntu-ftp"
58.	        vb.cpus = "2"
59.	        vb.gui = true
60.	    end
61.	  end  
62.	
63.	 end

2. Konfiguration WEB WM (config_web.sh)
sudo apt-get update
sudo apt-get install apache2 -y
sudo sed -i 's/XKBLAYOUT="us"/XKBLAYOUT="ch"/g' /etc/default/locale
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw --force enable


3. Konfiguration FTP WM (config_ftp.sh)
sudo apt-get update 
sudo apt-get install vsftpd -y
sudo cp /vagrant/vsftpd.conf /etc
sudo service vsftpd restart
sudo sed -i 's/XKBLAYOUT="us"/XKBLAYOUT="ch"/g' /etc/default/locale
sudo ufw allow ssh
sudo ufw allow ftp
sudo ufw --force enable

Sicherheit:
In den Shell Scripts für die einzelnen VM’s werden die Firewall Regeln erstellt damit nur der benötigte Zugriff aktiviert werden.

