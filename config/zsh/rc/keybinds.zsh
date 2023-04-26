# zsh-autocomplete - make tab go straight to the menu and cycle there
bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete

# fzf-tab-completion
bindkey '^[[27;5;9~' fzf_completion                         # Ctrl+Tab

# execute the command and don't clear it
bindkey '^[^M'              accept-and-hold                 # Alt+Enter

bindkey '^[[B'              down-line-or-beginning-search   # Down-Arrow 
bindkey '^[OB'              down-line-or-beginning-search

(( $+commands[atuin] )) && { eval "$(atuin init zsh --disable-ctrl-r)"; }

# dircycle
bindkey '^[[1;3D'           insert-cycledleft               # Alt+Left
bindkey '^[[1;3C'           insert-cycledright              # Alt+Right

function insert_cmd_sub {
    RBUFFER='$()'"$RBUFFER"
    ((CURSOR=CURSOR+2))
}
zle      -N   insert_cmd_sub                                 # Create command substitution `$()`
bindkey '^J'  insert_cmd_sub                                 # Ctrl-J

function edit_clipboard(){
    BUFFER="$(wl-paste)"
    zle edit-command-line
}
zle     -N      edit_clipboard                               # Similar to Ctrl-x + Ctrl-e but, paste the text then edit
bindkey '^X^V'  edit_clipboard                               # Ctrl-x + Ctrl-v

function git-status {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        git status
        zle redisplay
    fi
}
zle     -N    git-status                                    # Execute git status if inside on a git repository
bindkey '^[g' git-status                                    # Alt-g

function view_in_pager () {
    $SHELL -i -c "$(fc -ln -1) | $PAGER"
}
zle     -N    view_in_pager                                 # View the last executed command in pager
bindkey "^_" view_in_pager                                  # Ctrl-/

function rationalise_dot() {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+=/..
  else
    LBUFFER+=.
  fi
}
zle     -N    rationalise_dot                                 # Expands .. to ../..
bindkey '.'   rationalise_dot                                 # .
