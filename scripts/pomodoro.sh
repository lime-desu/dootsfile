#!/usr/bin/env bash

set -x
gnome-pomodoro --start-stop
state=$(gsettings get org.gnome.pomodoro.state timer-state-duration)

# need to kill flatpak ps so it doesn't open multiple instance on the status notifier
enable_safeEyes() { safeeyes --enable || flatpak kill io.github.slgobinath.SafeEyes && flatpak run io.github.slgobinath.SafeEyes --enable; }
disable_safeEyes() { safeeyes --disable || flatpak kill io.github.slgobinath.SafeEyes && flatpak run io.github.slgobinath.SafeEyes --disable; }

if [[ $state != "0.0" ]]; then
	lofi_ps=$(pgrep -xf "foot sh -c lofi")
	kill "$lofi_ps"
	enable_safeEyes
else
	# run in the bg so it can execute lofi
	(disable_safeEyes &)
	foot sh -c lofi
fi
