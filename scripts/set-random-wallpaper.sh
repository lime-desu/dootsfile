#!/usr/bin/env bash

WALLPAPER_DIR=${HOME}/Pictures/Wallpapers/Random_Wallpapers
RANDOM_PICTURE=$(ls $WALLPAPER_DIR -1 | shuf -n 1)

# for gnome only
# then i rebind it on gnome-settings 'shift+super+w' for quick execution of the script
gsettings set org.gnome.desktop.background picture-uri-dark "file://$WALLPAPER_DIR/$RANDOM_PICTURE"

notify-send 'Wallpaper changed:' "$RANDOM_PICTURE"
