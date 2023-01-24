OMT_DIR="${XDG_DATA_HOME:=$HOME/.local/share}/oh-my-tmux"
omt_install() {
local omt_doots="$OMT_DIR/.tmux.conf"
local tmux_doots="${XDG_CONFIG_HOME:-$HOME/.config}/tmux/tmux.conf.local"
    set -e
    if [ ! -d "$OMT_DIR/.git" ]; then
        mkdir -p "$OMT_DIR"
        echo "${BLD}${BLU}Installing ${CYN}[Oh My Tmux]${RST} ..."
        git clone https://github.com/gpakosz/.tmux.git "$OMT_DIR"
        if [ -f "$omt_doots" ] && [ -f "$tmux_doots" ]; then
            backup_and_symlink "$HOME/.tmux.conf" "$omt_doots"
            backup_and_symlink "$HOME/.tmux.conf.local" "$tmux_doots"
        fi
    tmux source-file "$HOME/.tmux.conf"
    fi
}

backup_and_symlink(){
    if [ -f "$1" ]; then
        mv -v "$1" "$1.bak"
        echo -e "Backing up ${BLU}$1...${RST}"
    fi
    ln -sf "$2" "$1"
    echo -e "Creating symlink for ${BLU}$1...${RST}"
}

omt_install

# to uninstall/remove
# rm -r $0MT_DIR
# rm ~/.tmux.conf*
# to update 
# git -C $OMT_DIR pull
