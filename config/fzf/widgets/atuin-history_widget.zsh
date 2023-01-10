# use atuin history instead 
fzf-atuin-history-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  selected=( $(atuin history list --cmd-only | tac | awk '{ cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]+/, "", cmd); if (!seen[cmd]++) print $0 }' | bat --color=always --wrap never --language=sh --style=plain | 
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} ${FZF_DEFAULT_OPTS-} --scheme=history --bind=ctrl-r:toggle-sort,ctrl-z:ignore ${FZF_CTRL_R_OPTS-} --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )
  local ret=$?
  if [ -n "$selected" ]; then
    cmd=$selected[1,-1]
    if [ -n "$cmd" ]; then
      zle vi-fetch-history -n $cmd
    fi
  fi
  zle -U "$cmd"
  zle kill-buffer
  zle reset-prompt
  return $ret
}
zle      -N       fzf-atuin-history-widget
bindkey '^R'      fzf-atuin-history-widget
