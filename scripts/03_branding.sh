#!/usr/bin bash
# mettre l'image dans asserts
# Script de configuration automatique du fond d'écran pour Trisquel Mini

IMAGE_PATH="/usr/share/backgrounds/mon_fond.jpg"

# On attend que PCManFM (le bureau) soit bien démarré
sleep 2

# Applique le fond d'écran
pcmanfm --set-wallpaper="$IMAGE_PATH" --wallpaper-mode=crop

