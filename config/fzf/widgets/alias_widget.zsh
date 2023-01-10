fzf-aliases-widget() {
  LBUFFER="$LBUFFER$(FZF_DEFAULT_COMMAND= 
  alias | sed 's/=/ --- /' | \
    awk -v blu=$(tput setaf 4) -v cyn=$(tput setaf 6) -v bld=$(tput bold) -v rst=$(tput sgr0) -F '---' \
      '{
        print bld cyn $1 rst blu "--" $2
      }' | \
    tr -d "'" | column -tl2 | \
    fzf --prompt=" Aliases > " \
        --preview 'echo {3..} | bat --color=always --plain --language=sh' \
        --preview-window 'up:4:nohidden:wrap' | cut -d' ' -f 1)"
  zle reset-prompt
}

zle -N          fzf-aliases-widget
bindkey '^[a'   fzf-aliases-widget #<Alt-A>
