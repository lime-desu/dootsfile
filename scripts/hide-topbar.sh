#!/usr/bin/env bash

extension='hidetopbar@mathieu.bidon.ca'
if [[ $(gsettings get org.gnome.shell enabled-extensions) == *"$extension"* ]]; then
	gnome-extensions disable "$extension"
else
	gnome-extensions enable "$extension"
fi
