expand_globalias() {
    if [[ $LBUFFER =~ '[A-Z0-9]+$' ]]; then
        zle _expand_alias
        zle expand-word
    fi
    zle self-insert
}
zle -N expand_globalias
bindkey " " expand_globalias # <Space key>

alias -g B='bat -fp'
alias -g G='| grep '
alias -g L='| $PAGER '
alias -g W='| wc'
alias -g C='| wc -l'
alias -g H='| head'
alias -g HN='| head -n'
alias -g T='| tail'
alias -g TN='| tail -n'
alias -g U='| uniq'
alias -g XA='| xargs'
alias -g X='chmod +x'
alias -g Y='| wl-copy -n'
alias -g P='| wl-paste -n'
alias -g NULL='> /dev/null 2>&1'
alias -g CUT="| cut -d' ' -f"
alias -g F="| awk '{print $}'"
alias -g UNIQ="| awk '!seen[\$1]++'"
