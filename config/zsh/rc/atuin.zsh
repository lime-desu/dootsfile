
eval "$(atuin init zsh)"

# (up-arrow-key) depends on terminal mode
bindkey '^[[A' _atuin_search_widget
bindkey '^[OA' _atuin_search_widget

# Alt-{Left,Right}
bindkey '^[[1;3D'       insert-cycledleft
bindkey '^[[1;3C'       insert-cycledright

