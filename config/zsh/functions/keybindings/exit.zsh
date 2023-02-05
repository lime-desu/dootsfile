# pressing CTRL-D will not close zsh 
# if there's a text filled this one fixes it

exit_zsh() {
    exit 
}

zle -N exit_zsh
bindkey '^D' exit_zsh
