#!/usr/bin/env bash

gnome-pomodoro --start-stop
state=$(gsettings get org.gnome.pomodoro.state timer-state-duration)
if [[ $state != "0.0" ]]; then
	safeeyes --enable
	lofi_ps=$(pgrep -xf "foot sh -c lofi")
	kill "$lofi_ps"
else
	safeeyes --disable
	foot sh -c lofi
fi
