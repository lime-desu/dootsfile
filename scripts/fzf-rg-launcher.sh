#!/usr/bin/env bash

RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
INITIAL_QUERY="${*:-}"

version=$(fzf --version | head -n1 | awk '{print $1}')

fzf_options=(
  --ansi
  --color "hl:-1:underline,hl+:-1:underline:reverse"
  --disabled --query "$INITIAL_QUERY"
  --bind "change:reload:sleep 0.1 && $RG_PREFIX {q} || true"
  --prompt '  ripgrep > '
  --delimiter :
  --header 'Ctrl-r ripgrep mode | Ctrl-f fzf mode '
  --preview 'bat --color=always {1} --highlight-line {2}'
  --preview-window 'nohidden,<60(nohidden,up,60%,border-bottom,+{2}+3/3,~3)'
)

if [[ "${version}" < "0.37.0" ]]; then
  IFS=':' read -ra selected < <(
    FZF_DEFAULT_COMMAND="$RG_PREFIX $(printf %q "$INITIAL_QUERY")" fzf "${fzf_options[@]}" \
      --bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(  fzf > )+enable-search+clear-query+rebind(ctrl-r)" \
      --bind "ctrl-r:unbind(ctrl-r)+change-prompt(  ripgrep > )+disable-search+reload($RG_PREFIX {q} || true)+rebind(change,ctrl-f)" \
  )
[ -n "${selected[0]}" ] && ${EDITOR:-vim} "${selected[0]}" "+${selected[1]}"

else
  # use this if version >= 38
  rm -f /tmp/rg-fzf-{r,f}
    FZF_DEFAULT_COMMAND="$RG_PREFIX $(printf %q "$INITIAL_QUERY")" fzf "${fzf_options[@]}" \
      --bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(  fzf > )+enable-search+rebind(ctrl-r)+transform-query(echo {q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f)" \
      --bind "ctrl-r:unbind(ctrl-r)+change-prompt(  ripgrep > )+disable-search+reload($RG_PREFIX {q} || true)+rebind(change,ctrl-f)+transform-query(echo {q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r)" \
      --bind "start:unbind(ctrl-r)" \
      --bind "enter:become(${EDITOR:-vim} {1} +{2})"
fi
