#!/bin/bash

# Start Ratpoison on Background

ratpoison & > ~/.vnclogs/ratpoison.log

# Start VNC Server
x11vnc --usepw --forever