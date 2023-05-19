#!/usr/bin/env bash

current_style=$(gsettings get org.gnome.desktop.interface color-scheme)
if [[ "$current_style" == "'prefer-dark'" ]]; then
	style="light"
elif [[ "$current_style" == "'prefer-light'" || "$current_style" == "'default'" ]]; then
	style="dark"
fi

ln -sfr "$HOME/.config/gtk-3.0/gtk-$style.css" "$HOME/.config/gtk-3.0/gtk.css"
ln -sfr "$HOME/.config/gtk-4.0/gtk-$style.css" "$HOME/.config/gtk-4.0/gtk.css"
gsettings set org.gnome.desktop.interface color-scheme "prefer-$style"
