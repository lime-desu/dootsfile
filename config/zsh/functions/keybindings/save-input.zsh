function save_input() {
  if (( $#BUFFER )); then
    stored_input=$BUFFER
    BUFFER=
    zle -M "Input saved successfully!"
  else
    if [[ -n "$stored_input" ]]; then
      BUFFER="$stored_input"
      zle end-of-line
    else
      zle -M "No saved input to restore!"
    fi
  fi
}

zle -N save_input                                             # Pressing Ctrl-q to store/restore input to BUFFER
bindkey '^Q' save_input                                       # Ctrl-q

function edit_saved_input() {
  if [[ -n "$stored_input" ]]; then
    BUFFER="$stored_input"
    zle edit-command-line
  else
    zle -M "No saved input found. Nothing to edit."
  fi
}
zle     -N      edit_saved_input                              # Paste then edit saved input
bindkey '^X^Q'  edit_saved_input                              # Ctrl-x + Ctrl-q

