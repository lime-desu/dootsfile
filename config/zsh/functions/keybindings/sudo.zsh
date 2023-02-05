function insert_sudo() {
    BUFFER="sudo $BUFFER"
    zle end-of-line;
}
zle      -N     insert_sudo                                 # Insert sudo at the beggining of the line
bindkey '^[s'   insert_sudo                                 # Alt-s

function execute_sudo!!() {
  [[ -z $BUFFER ]] &&
    zle .up-history
    zle accept-line
  LBUFFER=" sudo $LBUFFER"
}
zle     -N      execute_sudo!!                              # Execute the previous run command with sudo (similar to: insert-sudo + enter)
bindkey '^[S'   execute_sudo!!                              # Alt-Shift-S

