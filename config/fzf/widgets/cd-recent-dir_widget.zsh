fzf-cd-recent-dir-widget () {
  local dir
  print -rNC1 -- $dirstack |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --bind=ctrl-z:ignore ${FZF_DEFAULT_OPTS-} ${FZF_ALT_C_OPTS-}" $(__fzfcmd) +m \
    --color=fg:bold:blue --query=${LBUFFER} --read0 --print0 |
    IFS= read -rd '' dir 
    if [[ -n $dir ]]; then
        BUFFER=" builtin cd -- $dir"
        zle accept-line
    fi
  zle reset-prompt
}

zle -N fzf-cd-recent-dir-widget
bindkey '^[C' fzf-cd-recent-dir-widget #<Alt-Shift-C>
