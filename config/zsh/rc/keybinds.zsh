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

