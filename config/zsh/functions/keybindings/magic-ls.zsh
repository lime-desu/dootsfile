# ls if the buffer is empty if not transform text to lowercase
function magic-ls () {
    if [[ -z "$BUFFER" ]]; then
        BUFFER="ls"
        zle accept-line
    else
        zle down-case-word
    fi
}
zle -N magic-ls                                             # Ls if the BUFFER is empty if not transform to lowercase
bindkey '^[l' magic-ls                                      # Alt-l

# ls automatically after cd and git status if on a git repo
function cd () {
  auto_ls() {
    if command_exist exa; then
      exa --all --icons --group-directories-first
    else
      ls -Fh --color=auto --group-directories-first
    fi
  }
    builtin cd "$@" 
    if [[ -d .git ]]; then
      git status; echo ""
      auto_ls
    else
      auto_ls
    fi
}
