#!/bin/bash

killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.5; done
polybar mybar 2>&1 | tee -a /tmp/polybar.log 

