#!/usr/bin/env bash

panel="/org/gnome/shell/extensions/just-perfection/panel"
current_value=$(dconf read "$panel")
new_value=$([[ "$current_value" == "true" ]] && printf "false" || printf "true")

dconf write "$panel" "$new_value"
