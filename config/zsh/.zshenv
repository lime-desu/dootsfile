export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export VISUAL=nvim
export EDITOR="$VISUAL"

export DOOTS=$HOME/Git/Local/dootfiles
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$CARGO_HOME/bin/

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export HISTFILE="${XDG_STATE_HOME}"/bash/history
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

export NB_DIR="$XDG_DATA_HOME/nb"
export NBRC_PATH="$XDG_CONFIG_HOME/nbrc"

export ZDOTDIR="$HOME"/.config/zsh
export ZSH="$XDG_DATA_HOME"/oh-my-zsh 
export HISTFILE="$XDG_STATE_HOME"/zsh/history

alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
