#!/bin/sh
# Wrapper script to force Zed to use X11
export DISPLAY=:0
exec /home/orre/.nix-profile/bin/zed "$@"
