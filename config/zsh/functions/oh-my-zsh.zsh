omz_install_custom_plugins() {
  local plugin_dir="${ZSH_CUSTOM:-$ZSH/custom}/plugins"
  for plugin in "$@"; do
    local plugin_name="${plugin##*/}"
    if [[ ! -d "$plugin_dir/$plugin_name" ]]; then
      echo "Installing ${YLW}${BLD}$plugin_name${RST} plugin...";
      git clone --depth=1 "https://github.com/$plugin" "$plugin_dir/$plugin_name"
    fi
  done
}

# automatically install omz custom plugin if it doesn't exist
omz_install_custom_plugins \
  djui/alias-tips \
  wfxr/forgit \
  Bhupesh-V/ugit \
  marlonrichert/zsh-autocomplete \
  hlissner/zsh-autopair \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-completions \
  zsh-users/zsh-syntax-highlighting

omz_update_custom_plugins() {
    omz update && echo ""
    printf "${BLU}%s${RST}\n\n" "Updating custom plugins..."
    find "${ZSH_CUSTOM:-$ZSH/custom}" -type d -name ".git" | while read LINE; do
        plugin=${LINE:h}
        pushd -q "${plugin}"
        if git pull --rebase; then
            printf "%s${RST}\n" ${YLW}${BLD}"${plugin:t}${RST} ${GRN}has been updated and/or is at the current version.${RST}"
        else
            printf "%s${RST}\n" "${RED}There was an error updating ${RST}${YLW}${BLD}${plugin:t}.${RST}${RED} Try again later or figure out what went wrong..."
        fi
        popd -q
    done
}
