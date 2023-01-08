omz_install_custom_plugins() {
  local plugin_dir="${ZSH_CUSTOM:-$ZSH/custom}/plugins"
  for plugin in "$@"; do
    local plugin_name="${plugin##*/}"
    if [[ ! -d "$plugin_dir/$plugin_name" ]]; then
      echo "Installing $plugin_name plugin...";
      git clone --depth=1 "https://github.com/$plugin" "$plugin_dir/$plugin_name"
    fi
  done
}

# automatically install omz custom plugin if it doesn't exist
omz_install_custom_plugins \
  djui/alias-tips \
  wfxr/forgit \
  marlonrichert/zsh-autocomplete \
  hlissner/zsh-autopair \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-completions \
  zsh-users/zsh-syntax-highlighting

omz_update_custom_plugins() {
    red=$(tput setaf 1)
    grn=$(tput setaf 2)
    ylw=$(tput setaf 3)
    blu=$(tput setaf 4)
    rst=$(tput sgr0)
    bld=$(tput bold)
    omz update && echo ""
    printf "${blu}%s${rst}\n\n" "Updating custom plugins..."
    find "${ZSH_CUSTOM:-$ZSH/custom}" -type d -name ".git" | while read LINE; do
        plugin=${LINE:h}
        pushd -q "${plugin}"
        if git pull --rebase; then
            printf "%s${rst}\n" ${ylw}${bld}"${plugin:t}${rst} ${grn}has been updated and/or is at the current version.${rst}"
        else
            printf "%s${rst}\n" "${red}There was an error updating ${rst}${ylw}${bld}${plugin:t}.${rst}${red} Try again later or figure out what went wrong..."
        fi
        popd -q
    done
}
