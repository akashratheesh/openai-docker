#!/bin/bash

# Start Ratpoison on Background

ratpoison & 

# Start Xterm and Jupyter Lab
xterm jupyter-lab --port=8000 --ip=0.0.0.0 --allow_root &

# Start VNC Server
x11vnc --usepw --forever
