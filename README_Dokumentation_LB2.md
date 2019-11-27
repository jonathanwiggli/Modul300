# Modul300

Software
•	Visual Studio Code
•	BashGit
•	VirtualBox
•	Vagrant

Lösung
Mit einen befehle «vagrant up». Erstellen einer automatisierte Virtuelle Maschine mit Web Server und Webseite und eine automatisierte Virtuelle Maschine mit FTP Server der entsprechend automatisch konfiguriert ist.

1. Konfiguration Vagant File

Vagrant.configure("2") do |config|
  config.vm.define "WEB" do |web|
    
    #VM BOX Ubuntu 
    web.vm.box = "ubuntu/xenial64"
  
    #VM Hostname
    web.vm.hostname = "Ubuntu-WEB"
	
	    #Sync Folder
	    web.vm.synced_folder "./Shared_WEB", "/var/www/html"
	  
	    #VM Network
	    web.vm.network "private_network", ip: "192.168.1.10"
	    web.vm.network "forwarded_port", guest: 80, host: 8080
	
	    #Script
	    web.vm.provision :shell, path: "config_web.sh"
	    
	    #VM Disksize
	    web.disksize.size = '10GB'
	  
	    #VM Provider and Specs
	    web.vm.provider "virtualbox" do |vb|
	        vb.memory = "2048"
	        vb.name = "Ubuntu-WEB"
	        vb.cpus = "2"
	        vb.gui = true
	    end
	  end
	  
	  config.vm.define "FTP" do |ftp|
	    
	    #VM BOX Ubuntu 
	    ftp.vm.box = "ubuntu/xenial64"
	  
	    #VM Hostname
	    ftp.vm.hostname = "Ubuntu-ftp"
	
	    #Sync Folder
	    ftp.vm.synced_folder "./Shared_FTP", "/vagrant"
	  
	    #VM Network
	    ftp.vm.network "private_network", ip: "192.168.1.20"
	    ftp.vm.network "forwarded_port", guest: 20, host: 1420
	
	    #Script
	    ftp.vm.provision :shell, path: "config_ftp.sh"
	
	    #VM Disksize
	    ftp.disksize.size = '10GB'
	  
	    #VM Provider and Specs
	    ftp.vm.provider "virtualbox" do |vb|
	        vb.memory = "2048"
	        vb.name = "Ubuntu-ftp"
	        vb.cpus = "2"
	        vb.gui = true
	    end
	  end  
	
	 end

	2. Konfiguration WEB WM (config_web.sh)
	•	sudo apt-get update
	•	sudo apt-get install apache2 -y
	•	sudo sed -i 's/XKBLAYOUT="us"/XKBLAYOUT="ch"/g' /etc/default/locale
	•	sudo ufw allow ssh
	•	sudo ufw allow http
	•	sudo ufw allow https
	•	sudo ufw --force enable



	3. Konfiguration FTP WM (config_ftp.sh)
	•	sudo apt-get update 
	•	sudo apt-get install vsftpd -y
	•	sudo cp /vagrant/vsftpd.conf /etc
	•	sudo service vsftpd restart
	•	sudo sed -i 's/XKBLAYOUT="us"/XKBLAYOUT="ch"/g' /etc/default/locale
	•	sudo ufw allow ssh
	•	sudo ufw allow ftp
	•	sudo ufw --force enable

Sicherheit:
In den Shell Scripts für die einzelnen VM’s werden die Firewall Regeln erstellt damit nur der benötigte Zugriff aktiviert werden.

