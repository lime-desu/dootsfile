if ! command -v exa &>/dev/null; then
    echo "Error: 'exa' command not found"
    return
fi

alias \
    ls='exa --group-directories-first' \
    ll='ls --long --icons --git' \
    la='ll --all --header' \
    l='la' \
    l.='ls --list-dirs .* --icons' \

function tree() {
  exa --tree --icons --level=${1:-3}
}

