## Vagrant Commands

### vagrant init
Holt das Vagrantfile einer Box.

    vagrant init [name [url]]

### vagrant up 
startet die aufsetzung mithilfe der Informationen des Vagrantfile
    
    vagrant up

### vagrant provision
Führt alles was im provision ist aus.

    vagrant provision
    
### vagrant destroy
Löscht die VM.

    vagrant destroy
    
### vagrant ssh
Mit dem Befehl kann man sich per SSH auf die VM verbinden. Bei mehreren VM's im gleichen Vagrantfile muss man noch den Namen spezifizieren. 

    vagratn ssh


## Docker Commands

### docker run
Ist der Befehl zum Starten neuer Container.
Der bei weitem komplexesten Befehl, er unterstützt eine lange Liste möglicher Argumente.

    docker run test

### docker rm
Entfernt einen oder mehrere Container. Gibt die Namen oder IDs erfolgreich gelöschter Container zurück.

    docker rm [name]

### docker start 
Startet den gewünschten Container.

    docker start [id]

### docker stop

    docker stop
    
## Git Commands

### git add
Fügt eine Datei für den nächsten Commit hinzu. (wird gestaged)

    git add
 
### git commit 
Neuer Commit wird erstellt für den push.

    git commit (-m für Nachricht) 
    
### git push
Die Dateien aus dem Commit werden auf das externe Repository gepushed.

    git push
    
### git pull
Dateien aus dem externen Repository werden auf das lokale gezogen.

    git pull
    
    
