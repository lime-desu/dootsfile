#!/usr/bin/env bash

RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
INITIAL_QUERY="${*:-}"
IFS=':' read -ra selected < <(
  FZF_DEFAULT_COMMAND="$RG_PREFIX $(printf %q "$INITIAL_QUERY")" \
  fzf --ansi \
      --color "hl:-1:underline,hl+:-1:underline:reverse" \
      --disabled --query "$INITIAL_QUERY" \
      --bind "change:reload:sleep 0.1 && $RG_PREFIX {q} || true" \
      --bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(fzf > )+enable-search+clear-query+rebind(ctrl-r)" \
      --bind "ctrl-r:unbind(ctrl-r)+change-prompt(rg > )+disable-search+reload($RG_PREFIX {q} || true)+rebind(change,ctrl-f)" \
      --prompt 'rg > ' \
      --delimiter : \
      --header ' Ctrl-r ripgrep mode | Ctrl-f fzf mode ' \
      --preview 'bat --color=always {1} --highlight-line {2}' \
      --preview-window 'nohidden,<60(nohidden,up,60%,border-bottom,+{2}+3/3,~3)'
)
[ -n "${selected[0]}" ] && ${EDITOR:-vim} "${selected[0]}" "+${selected[1]}"
