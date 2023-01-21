# execute the command and don't clear it
bindkey '^[^M'              accept-and-hold                 # Alt+Enter

bindkey '^[[B'              down-line-or-beginning-search   # Down-Arrow 
bindkey '^[OB'              down-line-or-beginning-search

# atuin 
eval "$(atuin init zsh)"
bindkey '^[[A'              _atuin_search_widget            # Up-Arrow
bindkey '^[OA'              _atuin_search_widget

# dircycle
bindkey '^[[1;3D'           insert-cycledleft               # Alt+Left
bindkey '^[[1;3C'           insert-cycledright              # Alt+Right

# create command substitution `$()`
function insert_cmd_sub {
    RBUFFER='$()'"$RBUFFER"
    ((CURSOR=CURSOR+2))
}
zle -N insert_cmd_sub
bindkey '^J' insert_cmd_sub                                 # Ctrl+J

function edit_clipboard(){
    BUFFER="$(wl-paste)"
    zle edit-command-line
}
zle -N edit_clipboard
bindkey '^X^V' edit_clipboard                               # Ctrl+x + Ctrl+v

function git-status {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        git status
        zle redisplay
    fi
}
zle -N git-status
bindkey '^[g' git-status                                    # Alt+g
