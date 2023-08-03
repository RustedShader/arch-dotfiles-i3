#! /bin/sh

wallpaper=$(ls $HOME/.config/scripts/active_wallpaper | sed -n 1\p)
wal -i $HOME/.config/scripts/active_wallpaper/$wallpaper && feh --bg-scale $HOME/.config/scripts/active_wallpaper/$wallpaper && cp $HOME/.cache/wal/colors-rofi-dark.rasi $HOME/.config/rofi && exec $HOME/.config/scripts/./alacritty_pywal.sh && cp $HOME/.cache/wal/dunstrc $HOME/.config/dunst/dunstrc && exec $HOME/.config/dunst/launch.sh && exec $HOME/.config/picom/./launch.sh && exec $HOME/.config/polybar/./launch.sh && notify-send "Theme Chaged & Configs Updated !"


