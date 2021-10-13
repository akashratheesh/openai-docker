#!/bin/bash

# Start Ratpoison on Background

ratpoison & 

# Start Xterm
xterm &

# Start VNC Server
x11vnc --usepw --forever
