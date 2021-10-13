#!/bin/bash

# Start Ratpoison on Background

ratpoison & 

# Start Xterm
xterm -e jupyter-lab --no-browser --port=8000 --ip=0.0.0.0 --allow-root &

# Start VNC Server
x11vnc --usepw --forever
