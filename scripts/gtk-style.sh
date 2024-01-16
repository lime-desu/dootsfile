#!/usr/bin/env bash

SCRIPT_NAME=$(basename "$0" .sh)

show_notification() {
	NID_VAL="/tmp/$SCRIPT_NAME.nid"
	nid=$(cat "$NID_VAL" 2>/dev/null || echo 0)

	local title="$1" message="$2"
	change_notif=$(notify-send --print-id --replace-id "$nid" "$title" "$message")
	echo "$change_notif" >"$NID_VAL"
}

current_style=$(gsettings get org.gnome.desktop.interface color-scheme)
if [[ "$current_style" == "'prefer-dark'" ]]; then
	style="light"
	show_notification "$SCRIPT_NAME:" "Set to Light Mode"
elif [[ "$current_style" == "'prefer-light'" || "$current_style" == "'default'" ]]; then
	style="dark"
	show_notification "$SCRIPT_NAME:" "Set to Dark Mode"
fi

ln -sfr "$HOME/.config/gtk-3.0/gtk-$style.css" "$HOME/.config/gtk-3.0/gtk.css"
ln -sfr "$HOME/.config/gtk-4.0/gtk-$style.css" "$HOME/.config/gtk-4.0/gtk.css"
gsettings set org.gnome.desktop.interface color-scheme "prefer-$style"
