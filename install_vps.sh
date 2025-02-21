#!/bin/bash

echo "[+] Mise à jour et installation de Flask..."
apt update && apt install python3 python3-pip ufw -y
pip3 install flask

echo "[+] Configuration du serveur..."
mkdir -p /var/www/html/voleur
cd /var/www/html/voleur

cat << EOF > server.py
from flask import Flask, request
import os

app = Flask(__name__)

UPLOAD_FOLDER = "/var/www/html/voleur/"
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

@app.route('/upload', methods=['POST'])
def upload():
    file = request.files['file']
    file.save(os.path.join(UPLOAD_FOLDER, file.filename))
    return "OK"

@app.route('/gps', methods=['POST'])
def gps():
    data = request.data.decode()
    with open(os.path.join(UPLOAD_FOLDER, "gps.txt"), "a") as f:
        f.write(data + "\n")
    return "OK"

@app.route('/alert', methods=['POST'])
def alert():
    with open(os.path.join(UPLOAD_FOLDER, "alert.txt"), "a") as f:
        f.write("[ALERTE] Le fichier leurre a été ouvert !\n")
    return "OK"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
EOF

echo "[+] Ouverture du port 8000..."
ufw allow 8000/tcp

echo "[+] Démarrage du serveur..."
nohup python3 /var/www/html/voleur/server.py > /dev/null 2>&1 &

echo "[+] Serveur prêt sur http://$(curl -s ifconfig.me):8000"
