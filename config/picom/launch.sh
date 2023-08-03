#!/bin/sh

killall picom 
picom -b --animations --animation-window-mass 0.5 --animation-for-open-window fly-in --config $HOME/.config/picom/picom.conf && echo "Picom lauched..."
