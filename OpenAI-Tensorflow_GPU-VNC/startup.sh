#!/bin/bash

# Start Ratpoison on Background

ratpoison & > ~/.vnclogs/ratpoison.log

# Start Xterm
xterm &

# Start VNC Server
x11vnc --usepw --forever