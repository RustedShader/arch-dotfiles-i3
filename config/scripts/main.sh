#! /bin/sh

wallpaper=$(ls $HOME/.config/scripts/active_wallpaper | sed -n 1\p)
wal -i $HOME/.config/scripts/active_wallpaper/$wallpaper && feh --bg-scale $HOME/.config/scripts/active_wallpaper/$wallpaper && cp $HOME/.cache/wal/colors-rofi-dark.rasi $HOME/.config/rofi ; echo "ROFI Config Exported !" && cp $HOME/.cache/wal/dunstrc $HOME/.config/dunst/dunstrc ; echo "Dunstrc exported !" && notify-send "Theme Chaged & Configs Updated !"


