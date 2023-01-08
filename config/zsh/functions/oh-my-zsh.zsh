# automatically install omz custom plugin if it doesn't exist
install_zsh_plugins() {
  local plugin_dir="${ZSH_CUSTOM:-$ZSH/custom}/plugins"
  for plugin in "$@"; do
    local plugin_name="${plugin##*/}"
    if [[ ! -d "$plugin_dir/$plugin_name" ]]; then
      echo "Installing $plugin_name plugin...";
      git clone --depth=1 "https://github.com/$plugin" "$plugin_dir/$plugin_name"
    fi
  done
}

install_zsh_plugins \
  djui/alias-tips \
  wfxr/forgit \
  marlonrichert/zsh-autocomplete \
  hlissner/zsh-autopair \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-completions \
  zsh-users/zsh-syntax-highlighting

