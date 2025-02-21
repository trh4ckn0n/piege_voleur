#!/bin/bash

SERVER="http://<IP_VPS>:5000"
VIDEO_FILE="$HOME/video.mp4"

termux-camera-record -c 0 -l 10 -o "$VIDEO_FILE"
curl -X POST -F "file=@$VIDEO_FILE" "$SERVER/upload"
rm "$VIDEO_FILE"
