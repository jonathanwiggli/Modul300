### Modul300 Dokumentation Jonathan Wiggli

## LB2

# Software:
* Visual Studio Code
* BashGit
* VirtualBox
* Vagrant

# Lösung:
Mit einen befehle «vagrant up». Erstellen einer automatisierte Virtuelle Maschine mit Web Server und Webseite und eine automatisierte Virtuelle Maschine mit FTP Server der entsprechend automatisch konfiguriert ist.

	vagrant up

Die beiden VM's werden entsprechend in einem Vagrantfile erstellt.

# Hardware:
Im Vagrantfile sind die Informationen wie Disksize, Arbeitsspeicher und Anzahl CPU Cores definiert. 

	 #VM Provider and Specs
  	config.vm.provider "virtualbox" do |vb|
     		vb.memory = "2048"
     		vb.name = "WEB" 
		vb.cpus = "2"
		vb.gui = true
 	end
	
	#VM Disksize
	web.disksize.size = '10GB'

# Shared Folders:
Auf beiden VM's sind entsprechend Shared Folders konfiguriert um das arbeiten einfacher zu machen. Auf der WEB VM ist z.B. der Ordner
"/var/www/html" geshared, damit man den Inhalt der Webseite direkt lokal anpassen kann.
	
	#Sync Folder
	web.vm.synced_folder "./Shared_WEB", "/var/www/html"

# Netzwerk:
Auf beiden VM ist das private Netzwerk 192.168.1.0/24 definiert. Beide VM's erhalten entsprechend eine Fixe IP. Ausserdem werden entpsprechend gebrauchte Ports weitergeleitet.

	#VM Network
	web.vm.network "private_network", ip: "192.168.1.10"
	web.vm.network "forwarded_port", guest: 80, host: 8080

# Scripts:
Im Vagrantfile wird für beide VM's auf eine Externes Bash Script verwiesen welches die entsprechenden Commands nach der Installation ausführt. Das ganze hab ich ausgelagert um das Vagrantfile nicht unnübersichtlich zu machen.

	#Script
	web.vm.provision :shell, path: "config_web.sh"
	
	Inhalt:
	sudo apt-get update
	sudo apt-get install apache2 -y
	sudo sed -i 's/XKBLAYOUT="us"/XKBLAYOUT="ch"/g' /etc/default/locale


# Sicherheit:
In den Shell Scripts für die einzelnen VM’s werden die Firewall Regeln erstellt damit nur der benötigte Zugriff aktiviert werden.
Grundsätzlich werden auf beiden VM's durch die Firewall geblockt.  

Folgende Regeln sind auf der WEB VM konfiguriert:
	
	sudo ufw allow ssh
	sudo ufw allow http
	sudo ufw allow https
	

Folgende Regeln sind auf der FTP VM konfiguriert:
	
	sudo ufw allow ssh
	sudo ufw allow ftp


## LB3
In der LB3 werden die beiden Service (Apache & FTP) auf einer virtuellen Maschine innerhalb eines Containers mit Docker realisiert.

Für das ganze wurde ein neues Vagrantfile erstellt. Im neuen Vagrantfile wird nur eine VM mit dem Name Docker erstellt. Ausserdem werdem im neuen Vagrantfile mit folgendem Command die Images für Ubuntu 16.04 zur korrekten Funktion von Docker gezogen.

	d.pull_images "ubuntu:16.04"

# Shared Folder:
Im neuen Shared Folder werden für die Container die benötigten Dateien und Dockerfiles abgelegt.

	#Sync Folder
  	config.vm.synced_folder "./Shared_Docker", "/vagrant"

# Network:
Die neue Maschine erhält eine fixe IP: 192.168.1.50. Ausserdem werden die benötigten Ports auf die lokale Maschine weitergeleitet.

	#VM Network Settings
  	config.vm.network "private_network", ip:"192.168.1.50"
  	config.vm.network "forwarded_port", guest:8080, host:8080, auto_correct: true
  	config.vm.network "forwarded_port", guest:1020, host:1020, auto_correct: true

# Script:
Neu gibt es nur noch ein Bashscript. In diesem Bash Script wird Docker installiert. Ausserdem werden die Container mithilfe Docker erstellt.

installation Docker
	
	sudo sudo apt install docker.io -y

z.B. Apache Container build
	
	cd /vagrant/apache
	sudo docker build -t apache .
	sudo docker run --rm -d -p 8080:80 -v `pwd`/web:/var/www/html --name apache apache
	
# Docker Files
Neu gibt es für jeden Container auch ein Dockerfile, in diesem wird definiert Was der Container installieren muss und so weiter.

Docker File apache:

	#Ubuntu Version
	FROM ubuntu:16.04
	
	#Apache installation
	RUN apt-get update
	RUN apt-get -q -y install apache2 

	# Konfiguration Apache
	ENV APACHE_RUN_USER www-data
	ENV APACHE_RUN_GROUP www-data
	ENV APACHE_LOG_DIR /var/log/apache2

	RUN mkdir -p /var/lock/apache2 /var/run/apache2

	EXPOSE 80

	VOLUME /var/www/html

	CMD /bin/bash -c "source /etc/apache2/envvars && exec /usr/sbin/apache2 -DFOREGROUND"

Docker File FTP:

	#Ubuntu Version
	FROM ubuntu:16.04

	#FTP installation
	RUN apt-get update
	RUN apt-get install vsftpd -y

	# Konfiguration FTP

	VOLUME /etc/vsftpd

	RUN service vsftpd restart

	EXPOSE 20



