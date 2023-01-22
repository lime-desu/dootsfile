fzf-man-widget() {
  batman="man {1} | col -bx | bat --language=man --plain --color always --theme=\"Monokai Extended\""
   man -k . | sort \
   | awk -v CYN=${CYN} -v BLU=${BLU} -v RES=${RES} -v BLD=${BLD} '{ $1=CYN BLD $1; $2=RES BLU;} 1' \
   | fzf  \
      -q "$LBUFFER" \
      --ansi \
      --tiebreak=begin \
      --prompt=' Man > '  \
      --header="M-u: update mandb | M-t: tl;dr | M-c: cheat.sh | M:m manual " \
      --preview-window '50%,rounded,<50(down,80%,border-up)' \
      --preview "${batman}" \
      --bind "enter:execute(man {1})" \
      --bind "alt-c:+change-preview(curl -s cht.sh/{1})+change-prompt(ﯽ Cheat > )" \
      --bind "alt-m:+change-preview(${batman})+change-prompt( Man > )" \
      --bind "alt-u:execute(sudo mandb && echo -e '\nUpdating tl;dr cache...';tldr --update)" \
      --bind "alt-t:+change-preview(tldr --color=always {1})+change-prompt(ﳁ TLDR > )"
  zle reset-prompt
}
zle     -N          fzf-man-widget
bindkey '^[h'       fzf-man-widget
