fzf-locate-widget() {
  local selected
  if selected=$(locate / | fzf --prompt " Locate > " -q "$LBUFFER" \
    --bind 'alt-u:execute(sudo updatedb)' --header 'M-u: UpdateDB' \
    --color=fg:bold:blue --preview-window '<50(down,75%,border-top)'
    ); then
    LBUFFER=$selected
  fi
  zle reset-prompt
}
zle     -N    fzf-locate-widget
bindkey '^[i' fzf-locate-widget #<Alt-I>

