#!/bin/bash

set -e


# Start Display
display_num=100
export DISPLAY=:"${display_num}"
Xvfb "${DISPLAY}" -screen 0 1024x768x24 &
pulseaudio -D --exit-idle-time=-1

# Wait for X11
file="/tmp/.X11-unix/X${display_num}"
for i in $(seq 1 10); do
  if [ -e "$file" ]; then
    break
  fi
  echo "Waiting for X to start (attempt $i/10)"
  sleep "$i"
done
if ! [ -e "$file" ]; then
  echo "Timed out waiting for X to start: $file was not created"
  exit 1
fi

exec "$@"