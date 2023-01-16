# set xdg base directory
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
# doots directory
export DOOTS="$HOME/Git/Local/dootsfile"
# default editor
export {EDITOR,VISUAL}="nvim"

# atuin
export ATUIN_NOBIND="true"
# eval "$(atuin init zsh)"
# bash
export HISTFILE="${XDG_STATE_HOME}"/bash/history
# bat
export BAT_THEME="Catppuccin-mocha"
# less (pager) 
export LESS_TERMCAP_mb=$'\E[1;32m'
export LESS_TERMCAP_md=$'\E[01;34m' LESS_TERMCAP_me=$'\E[1m' GROFF_NO_SGR=1
export LESS_TERMCAP_us=$'\E[04;36m' LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m' LESS_TERMCAP_so=$'\E[01;31m'
# man (use less as man pager for now)
export MANPAGER="less -R --use-color -Dd+b -Du+c"
# export MANPAGER="sh -c 'col -bx | bat -l man -p --theme=Monokai\ Extended'" # bat as manpager
# libice
export ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority 
# mozilla firefox
export MOZ_ENABLE_WAYLAND=1 firefox
export MOZ_USE_XINPUT=1
# nb
export NB_DIR="$XDG_DATA_HOME/nb"
export NBRC_PATH="$XDG_CONFIG_HOME/nbrc"
# ripgrep
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgreprc"
# rust
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
# zsh
export ZDOTDIR="$HOME"/.config/zsh
export ZSH="$XDG_DATA_HOME"/oh-my-zsh 
export HISTFILE="$XDG_STATE_HOME"/zsh/history
export ZSH_PLUGINS_ALIAS_TIPS_EXCLUDES="_ sudo ll g B X"
# wget
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'
# paths
typeset -U
paths=(
    "$HOME/.local/bin"
    "$CARGO_HOME/bin"
)

for dir in "${paths[@]}"; do
    [[ -d $dir ]] && path+=$dir
done

