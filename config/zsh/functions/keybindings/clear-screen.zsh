clear-screen-and-scrollback() {
	echoti civis >"$TTY"
	printf '%b' '\e[H\e[2J' >"$TTY"
	(($+commands[wipe])) && wipe --duration 1250
	zle .reset-prompt
	zle -R
	printf '%b' '\e[3J' >"$TTY"
	echoti cnorm >"$TTY"
}

if [ "$TERM" != "xterm-kitty" ]; then
	zle -N clear-screen-and-scrollback
	bindkey '^L' clear-screen-and-scrollback
fi
