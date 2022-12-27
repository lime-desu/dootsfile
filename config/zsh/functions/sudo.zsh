insert-sudo() {
    zle beginning-of-line;
    zle -U "sudo ";
}

zle -N          insert-sudo
bindkey '^[s'   insert-sudo         # Alt+S

sudo!!() {
  [[ -z $BUFFER ]] &&
    zle .up-history
  LBUFFER="sudo $LBUFFER"
}
zle -N sudo!!
bindkey '^[S'   sudo!!              # Alt+Shift+S
