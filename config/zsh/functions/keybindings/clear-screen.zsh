clear-screen-and-scrollback() {
  if [[ "$TERM" == "xterm-kitty" ]]; then
    printf '%b' '\e[H\e[2J' >"$TTY"
  else
    echoti civis >"$TTY"
    printf '%b' '\e[3J' >"$TTY"
    echoti cnorm >"$TTY"
  fi

	(($+commands[wipe])) && wipe --duration 1250

  zle reset-prompt
  zle -R
}

zle -N clear-screen-and-scrollback
bindkey '^L' clear-screen-and-scrollback
