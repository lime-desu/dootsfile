fzf-dictionary-widget() {
local dict wiki wikis gogl
dict="dict {}"
wiki="wiki {} > /dev/tty"
wweb="w3m https://en.wikipedia.org/wiki/{}"
gogl="w3m https://google.com/search?q=define\ {}"
  LBUFFER="$LBUFFER$(FZF_DEFAULT_COMMAND= cat /usr/share/dict/*words | sort | uniq -id | \
    fzf-tmux \
        -p60% \
        --layout=default \
        --header-first \
        --header="M-w: Wiki | M-d: Define | M-g: Google" \
        --color=fg:blue,fg+:blue,border:blue \
        --bind="alt-d:change-preview($dict)" \
        --bind="alt-w:execute($wiki)" \
        --bind="alt-g:execute($gogl)" \
        --prompt=" > " \
        --preview "$dict" \
        --preview-window='up,85%,border-bottom,wrap' | paste -sd" " -)"
  zle reset-prompt
}

zle     -N    fzf-dictionary-widget
bindkey '^[d' fzf-dictionary-widget #<Alt-D>
