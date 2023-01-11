omz_install_custom() {
  set -e
  local type=$1
  local omz_dir="${ZSH:-$HOME/.local/share/oh-my-zsh}"
  local custom_dir="${ZSH_CUSTOM:-$omz_dir/custom}/${type}s"
  local repos=("${@:2}")

  if [[ ! -d "$omz_dir" ]]; then
    echo "${BLU}Installing ${BLD}[Oh My Zsh]${RST} ..."
    git clone https://github.com/ohmyzsh/ohmyzsh.git $omz_dir
  fi

  for repo in "${repos[@]}"; do
    local name=${repo##*/}
    local dir="$custom_dir/$name"
    if [[ ! -d "$dir" ]]; then
      echo "${GRN}Installing ${BLD}${YLW}$name${RST} ${BLU}${type}...${RST}"
      git clone --depth=1 "https://github.com/$repo" "$dir"
    fi
  done
}

# Usage install_omz_cutom <type> <reponame>
omz_install_custom plugin \
    "djui/alias-tips" \
    "wfxr/forgit" \
    "Bhupesh-V/ugit" \
    "marlonrichert/zsh-autocomplete" \
    "hlissner/zsh-autopair" \
    "zsh-users/zsh-autosuggestions" \
    "zsh-users/zsh-completions" \
    "zsh-users/zsh-syntax-highlighting"

omz_install_custom theme "romkatv/powerlevel10k"

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
