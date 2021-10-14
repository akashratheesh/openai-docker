#!/bin/bash

# Start Ratpoison on Background

ratpoison & 

# Start Xterm and Jupyter Lab
xterm &

# Start VNC Server
x11vnc --usepw --forever
