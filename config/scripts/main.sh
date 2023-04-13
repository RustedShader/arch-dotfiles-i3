#! /bin/sh

wallpaper=$(cat $HOME/.config/scripts/wallpaper.txt | tail -n 1)
wal -i $HOME/wallpaper/$wallpaper
feh --bg-scale $HOME/wallpaper/$wallpaper
$HOME/.config/scripts/./rofi_pywal.sh
$HOME/.config/scripts/./alacritty_pywal.sh
$HOME/.config/scripts/./dunst_pywal.sh
#Dunst
exec $HOME/.config/dunst/./launch.sh &
#Polybar
#$HOME/.config/polybar/./launch.sh &
#Picom 
exec $HOME/.config/picom/./launch.sh &

