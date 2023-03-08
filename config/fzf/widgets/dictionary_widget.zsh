fzf-dictionary-widget() {
local _open_
case "$(uname -s)" in
  Darwin) _open_="open";;
  *) _open_="xdg-open";;
esac
  LBUFFER="$LBUFFER$(FZF_DEFAULT_COMMAND= cat /usr/share/dict/*words | sort | uniq -id | \
    fzf-tmux \
        -p75% \
        --layout=default \
        --header-first \
        --header="M-w: Wiki | M-g: Google" \
        --color=fg:blue,fg+:blue,border:blue,preview-label:bold:blue \
        --bind="alt-w:execute-silent(${_open_} 'https://en.wikipedia.org/wiki/{}')" \
        --bind="alt-g:execute-silent(${_open_} 'https://google.com/search?q=define {}')" \
        --prompt=" > " \
        --preview-label=' Definition ' \
        --preview "awk -f <(curl -Ls --compressed https://git.io/translate) -- {}" \
        --preview-window='nohidden,75%,wrap,<50(down,65%,border-top)' | paste -sd" " -)"
  zle reset-prompt
}

zle     -N    fzf-dictionary-widget
bindkey '^[d' fzf-dictionary-widget #<Alt-D>
