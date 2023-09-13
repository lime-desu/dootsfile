expand_globalias() {
    if [[ $LBUFFER =~ '[A-Z0-9]+$' ]]; then
        zle _expand_alias
    fi
    zle self-insert
}
zle -N expand_globalias
bindkey " " expand_globalias # <Space key>


alias -g C='cat'
alias -g B='bat -fp'
alias -g G='| grep -i'
alias -g J='| jq -C'
alias -g L='| $PAGER '
alias -g W='| wc -l'
alias -g H='| head'
alias -g HN='| head -n'
alias -g T='| tail'
alias -g TN='| tail -n'
alias -g U='| uniq'
alias -g S='| sort'
alias -g XA='| xargs'
alias -g X='chmod +x'
alias -g Y='| wl-copy -n'
alias -g P='| wl-paste -n'
alias -g NULL='> /dev/null 2>&1'
alias -g CUT="| cut -d' ' -f"
alias -g A="| awk '{print $1}'"
alias -g AU="| awk '!seen[\$1]++'"
alias -g LD='$HOME/Downloads/*(.om[1])' # latest download
alias -g ND='*(/om[1])'                 # newest directory
alias -g NF='*(.om[1])'                 # newest file
