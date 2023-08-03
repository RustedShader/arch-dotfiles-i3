#! /bin/sh

killall dunst
dunst -conf $HOME/.config/dunst/dunstrc & 
echo "Dunst Launched !"
