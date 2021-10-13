#!/bin/bash

# Start Ratpoison on Background

ratpoison & 

# Start Xterm
xterm jupyter-lab --port=8000 --ip=0.0.0.0 --allow_root &

# Start VNC Server
x11vnc --usepw --forever
