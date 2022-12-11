# set xdg base directory
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
# doots directory
export DOOTS="$HOME/Git/Local/dootfiles"
# default editor
export {EDITOR,VISUAL}="nvim"
# bash
export HISTFILE="${XDG_STATE_HOME}"/bash/history
# bat
export BAT_THEME="Catppuccin-macchiato"
# rust
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
# nb
export NB_DIR="$XDG_DATA_HOME/nb"
export NBRC_PATH="$XDG_CONFIG_HOME/nbrc"
# ripgrep
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep"
# zsh
export ZDOTDIR="$HOME"/.config/zsh
export ZSH="$XDG_DATA_HOME"/oh-my-zsh 
export HISTFILE="$XDG_STATE_HOME"/zsh/history
# wget
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
# paths
typeset -U
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$CARGO_HOME/bin
# not working breaks my shell (gitstatus failed to iniatialize: p10k)
# export path=(
# 	"$HOME/.local/bin"
# 	"$HOME/$CARGO_HOME/bin"
# 	"$PATH"
# )
