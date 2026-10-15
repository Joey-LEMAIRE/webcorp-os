#!/usr/bin bash
# mettre l'image dans asserts
# Script de configuration automatique du fond d'écran pour Trisquel Mini
IMAGE_PATH="/usr/share/backgrounds/mon_fond.jpg"
# On attend que PCManFM (le bureau) soit bien démarré
sleep 2
# Applique le fond d'écran
pcmanfm --set-wallpaper="$IMAGE_PATH" --wallpaper-mode=crop
cp ../assets/ autostart
# Modifie immédiatement la police système pour l'utilisateur actuel
gsettings set org.gnome.desktop.interface font-name 'Ubuntu 11'
# Modifie la police du titre des fenêtres dans le fichier de configuration Openbox
xmlstarlet ed -L -u "/openbox_config/theme/font[@place='ActiveWindow']/name" -v "Ubuntu" ~/.config/openbox/lxde-rc.xml
xmlstarlet ed -L -u "/openbox_config/theme/font[@place='ActiveWindow']/size" -v "11" ~/.config/openbox/lxde-rc.xml
# Recharge Openbox pour appliquer le changement immédiatement
openbox --reconfigure
#mettre la barre des taches en haut ?
sed -i 's/edge=bottom/edge=top/g' ~/.config/lxpanel/Trisquel-mini/panels/panel
#changer sa taille 
sed -i 's/height=[0-9]*/height=32/g' ~/.config/lxpanel/Trisquel-mini/panels/panel
# 1. Désactive le fond du thème système
sed -i 's/usebackground=[0-9]*/usebackground=0/g' ~/.config/lxpanel/Trisquel-mini/panels/panel
# 2. Configure la couleur Beige (Rouge=62965, Vert=59110, Bleu=52685)
sed -i 's/backgroundcolor=[0-9]*/backgroundcolor=4126322925/g' ~/.config/lxpanel/Trisquel-mini/panels/panel
# 3. Optionnel : Rendre opaque (255) ou légèrement transparent (ex: 220)
sed -i 's/backgroundalpha=[0-9]*/backgroundalpha=255/g' ~/.config/lxpanel/Trisquel-mini/panels/panel
# 4. Applique le changement immédiatement
lxpanelctl restart
