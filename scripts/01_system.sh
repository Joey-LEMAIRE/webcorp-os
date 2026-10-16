#!/usr/bin bash

sudo apt update

# apache
sudo apt install apache2 libapache2-mpm-itk

# mariadb
sudo apt install mariadb-server mariadb-client
sudo mariadb-secure-installation

# php
sudo apt install libapache2-mod-php php-mysql

# 1. Demander à l'installateur d'inclure le paquet Restic
d-i pkgsel/include string restic

# 2. Configurer les scripts et l'automatisation à la toute fin de l'installation
ubiquity ubiquity/success_command string \
  in-target mkdir -p /etc/systemd/system/ ; \
  in-target sh -c 'echo "[Unit]\nDescription=Sauvegarde Restic\nAfter=network.target\n\n[Service]\nType=oneshot\nEnvironment=\"RESTIC_REPOSITORY=/mnt/sauvegardes\"\nEnvironment=\"RESTIC_PASSWORD=MonMotDePasseSecret\"\nExecStart=/usr/bin/restic backup /home" > /etc/systemd/system/restic-backup.service' ; \
  in-target sh -c 'echo "[Unit]\nDescription=Declencheur Restic\n\n[Timer]\nOnCalendar=daily\nPersistent=true\n\n[Install]\nWantedBy=timers.target" > /etc/systemd/system/restic-backup.timer' ; \
  in-target systemctl daemon-reload ; \
  in-target systemctl enable restic-backup.timer
