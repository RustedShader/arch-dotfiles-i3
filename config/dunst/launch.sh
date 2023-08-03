#! /bin/sh

killall dunst && exec dunst -conf $HOME/.config/dunst/dunstrc && echo "Dunst Launched !"
