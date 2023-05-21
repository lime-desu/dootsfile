(( $+commands[exa] )) && {
  alias \
      ls='exa --group-directories-first' \
      ll='ls --long --icons --git' \
      la='ll --all --header' \
      ld='ll --sort=date' \
      l='la' \
      lld='l --sort=date' \
      l.='ls --list-dirs .* --icons' \
  
  function tree() {
    [ "$1" = "-h" ] || [ "$1" = "--help" ] && {
      echo "${BLD}${BLU}Usage: ${GRN}tree ${RST}[directory name] [level (default: 3)]";
      return 1;
    }
    [ $# -gt 2 ] && {
      echo -e "${BLD}${RED}Error:${RST} Invalid number of arguments.";
      return 1;
    }
    exa --tree ${1:-} --icons --level=${2:-3}
  }
}

