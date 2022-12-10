#!/usr/bin/env bash
OMT_DIR="$HOME/Git/oh-my-tmux"
git clone https://github.com/gpakosz/.tmux.git "${OMT_DIR}"
ln -sf "${OMT_DIR}"/.tmux.conf "$HOME"/.tmux.conf

# ln -s $XDG_CONFIG_HOME/tmux/tmux.conf.local $HOME/.tmux.conf.local
# wip..
