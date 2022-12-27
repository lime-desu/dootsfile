# https://github.com/ohmyzsh/ohmyzsh/issues/5071
# ls if the buffer is empty if not transform text to lowercase

function _magic-ls () {
    if [[ -z "$BUFFER" ]]; then
        BUFFER="ls"
        zle accept-line
    else
        zle down-case-word
    fi
}
zle -N _magic-ls

bindkey '\el' _magic-ls
