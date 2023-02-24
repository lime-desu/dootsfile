fzf-ripgrep-widget() {
    bash ${DOOTS:-$HOME/.local}/scripts/fzf-rg-launcher.sh < "$TTY"
    zle redisplay
}

zle -N       fzf-ripgrep-widget
bindkey '^F' fzf-ripgrep-widget   #<Ctrl-F>
