#!/usr/bin/env bash

dnd="org.gnome.desktop.notifications"
current_value=$(gsettings get "$dnd" show-banners)
new_value=$([[ "$current_value" == "true" ]] && printf "false" || printf "true")

gsettings set "$dnd" show-banners "$new_value"
