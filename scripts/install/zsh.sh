#!/usr/bin/env bash

setup_zsh() {
	backup "$HOME/.zshenv"
	create "$HOME/.local/state/zsh/"
	symlink "$DOOTS/config/zsh/.zshenv" "$HOME"
	if [ "$SHELL" != "$(which zsh)" ]; then
		chsh -s "$(which zsh)"
	fi
}

setup_zsh
