# https://github.com/ohmyzsh/ohmyzsh/issues/5071
# ls if the buffer is empty if not transform text to lowercase
function magic-ls () {
    if [[ -z "$BUFFER" ]]; then
        BUFFER="ls"
        zle accept-line
    else
        zle down-case-word
    fi
}
zle -N _magic-ls

bindkey '\el' magic-ls

# ls automatically after cd
function cd-ls() {
    emulate -L zsh
    exa --all --icons --group-directories-first
}
chpwd_functions=(${chpwd_functions[@]} "cd-ls")
