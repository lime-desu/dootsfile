if (( $+commands[exa] )); then
  EXZA_CMD='exa'
elif (( $+commands[eza] )); then
  EXZA_CMD='eza'
fi

alias ls="$EXZA_CMD --group-directories-first"
alias ll="$EXZA_CMD --long --icons --git"
alias la="ll --all --header"
alias ld="ll --sort=date"
alias l="la"
alias lld="l --sort=date"
alias l.="ls --list-dirs .* --icons"

function tree() {
  if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "${BLD}${BLU}Usage: ${GRN}tree ${RST}[directory name] [level (default: 3)]"
    return 1
  fi

  if [ $# -gt 2 ]; then
    echo -e "${BLD}${RED}Error:${RST} Invalid number of arguments."
    return 1
  fi

  $EXZA_CMD --tree ${1:-} --icons --level=${2:-3}
}
