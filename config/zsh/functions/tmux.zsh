OMT_DIR="${XDG_DATA_HOME:=$HOME/.local/share}/oh-my-tmux"
omt_install() {
    set -e
    if [ ! -d "$OMT_DIR" ]; then
        mkdir -p "$OMT_DIR"
        echo "${BLU}Installing ${BLD}${CYN}[Oh My Tmux]${RST} ..."
        git clone https://github.com/gpakosz/.tmux.git "$OMT_DIR"
        ln -sf "$OMT_DIR/.tmux.conf" "$HOME/.tmux.conf"
        echo -e "\nSymlinking ${BLD}${CYN}tmux dootsfile${RST} to $HOME..."
        ln -sf "${XDG_CONFIG_HOME:-$DOOTS/config}/tmux/tmux.conf.local" "$HOME/.tmux.conf.local"
        tmux source-file "$HOME/.tmux.conf"
    fi
}
omt_install

# to uninstall/remove
# rm -r $0MT_DIR
