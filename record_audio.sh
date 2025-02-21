#!/bin/bash

SERVER="http://<IP_VPS>:5000"
AUDIO_FILE="$HOME/audio.mp3"

termux-microphone-record -d 10 -f "$AUDIO_FILE"
curl -X POST -F "file=@$AUDIO_FILE" "$SERVER/upload"
rm "$AUDIO_FILE"
