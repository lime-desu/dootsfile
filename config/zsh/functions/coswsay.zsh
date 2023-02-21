if (( $+commands[cowsay] )); then
  function override_cmd_with_neocowsay {
    local cmd=$1
    shift
    if [[ ! "$*" =~ "--help" ]]; then
      if [[ "$cmd" == "mkdir" || "$cmd" == "rmdir" ]]; then
        command "$cmd" --parents --verbose "$@" | cowsay --rainbow --random --bold
      else
        command "$cmd" --interactive --verbose "$@" | cowsay --rainbow --random --bold
      fi
    else
      command "$cmd" "$@"
    fi
  }

  mv() {
    override_cmd_with_neocowsay "mv" "$@"
  }

  cp() {
    override_cmd_with_neocowsay "cp" "$@"
  }

  rm() {
    override_cmd_with_neocowsay "rm" "$@"
  }

  mkdir() {
    override_cmd_with_neocowsay "mkdir" "$@"
  }

  rmdir() {
    override_cmd_with_neocowsay "rmdir" "$@"
  }
fi
