OMT_DIR="${XDG_DATA_HOME:=$HOME/.local/share}/oh-my-tmux"
omt_install() {
local tmux_conf="$HOME/.tmux.conf"
local omt_conf="${XDG_CONFIG_HOME:-$HOME/config}/tmux/tmux.conf"

  if [ ! -d "$OMT_DIR/.git" ]; then
      mkdir -p "$OMT_DIR"
      echo "${BLD}${BLU}Installing ${CYN}[Oh My Tmux]${RST} ..."
      git clone https://github.com/gpakosz/.tmux.git "$OMT_DIR"
      ln -s "$OMT_DIR/.tmux.conf" "$omt_conf"
    if [ -f "$tmux_conf" ]; then
      echo -e "\nExisting tmux configuration exist. (${tmux_conf})"
      echo "Backup/Remove if first in order for Oh My Tmux config to work"
    fi
    
    tmux source-file "$omt_conf"
  fi
}

omt_install

# to uninstall/remove
# rm -r $0MT_DIR
# rm ~/.config/tmux/tmux.conf*
# to update 
# git -C $OMT_DIR pull
