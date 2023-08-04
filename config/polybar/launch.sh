#!/bin/bash

killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.5; done
polybar -conf $HOME/.config/polybar/config.ini | tee -a /tmp/polybar.log 

