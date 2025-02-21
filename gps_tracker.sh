#!/bin/bash

SERVER="http://<IP_VPS>:5000"

while true; do
    LOCATION=$(termux-location)
    LAT=$(echo $LOCATION | jq -r '.latitude')
    LONG=$(echo $LOCATION | jq -r '.longitude')
    curl -X POST -H "Content-Type: application/json" -d "{\"latitude\": \"$LAT\", \"longitude\": \"$LONG\"}" "$SERVER/upload"
    sleep 60
done
