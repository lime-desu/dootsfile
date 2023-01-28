function fzf-rg-widget() {
    bash ${DOOTS:-$HOME/.local}/bin/fzf-rg-launcher "$LBUFFER"
    zle redisplay
}

zle -N fzf-rg-widget
bindkey '^F' fzf-rg-widget
