#!/usr/bin/env bash

if [[ -n $TERMUX_VERSION ]]; then
	[[ ! -d $HOME/.termux ]] && mkdir -p "$HOME"/.termux
	echo "Setting up Termux colorscheme and fonts..."
	curl -sSo ~/.termux/colors.properties https://raw.githubusercontent.com/catppuccin/termux/main/Mocha/colors.properties
	curl -sSo ~/.termux/font.ttf \
		https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf
	termux-reload-settings
fi
