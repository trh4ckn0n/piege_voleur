#!/bin/bash

pkg update -y && pkg upgrade -y
pkg install termux-api python wget curl -y

echo "[+] Installation terminée. Configure ton bot Telegram et exécute le script."
