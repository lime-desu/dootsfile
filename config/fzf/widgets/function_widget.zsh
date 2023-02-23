fzf-functions-widget() {
  LBUFFER="$LBUFFER$(FZF_DEFAULT_COMMAND=
  # ignore functions starting with "_ . +"
  print -l ${(ok)functions[(I)[^_.+]*]} | \
    fzf -q "$LBUFFER" --color=fg:bold:cyan \
        --prompt=" Functions > "
  )"
  zle reset-prompt
}

zle -N          fzf-functions-widget
bindkey '^[f'   fzf-functions-widget #<Alt-F>
